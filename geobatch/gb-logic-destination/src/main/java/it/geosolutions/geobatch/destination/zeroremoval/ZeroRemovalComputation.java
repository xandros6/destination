/*
 *  Copyright (C) 2007-2012 GeoSolutions S.A.S.
 *  http://www.geo-solutions.it
 *
 *  GPLv3 + Classpath exception
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package it.geosolutions.geobatch.destination.zeroremoval;

import it.geosolutions.geobatch.destination.Ingestion;
import it.geosolutions.geobatch.destination.IngestionObject;
import it.geosolutions.geobatch.destination.OutputObject;
import it.geosolutions.geobatch.destination.RoadArc;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.geotools.jdbc.JDBCDataStore;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.filter.Filter;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * This class implements the zero removal computation.
 * It uses as source and target the same table, one of the arc geometry tables (siig_geo_ln_arco_X) 
 * It is responsible for compute the NR_INCIDENTI_ELAB field starting from the values taken from NR_INCIDENTI
 * The process entry point is the method removeZeros that is called by the groovy script.
 * 
 * Due to some problems that the total risk formula has to manage arcs with a number of incident equals to 0
 * we want to calculate the field NR_INCIDENTI_ELAB from NR_INCIDENTI "spreading" the records with NR_INCIDENTI > 0 on those that have that value = 0
 * The total risk formula will use NR_INCIDENTI_ELAB instead of NR_INCIDENTI
 * 
 * The algorithm is this:
 * 
 *      given a road
 *              foreach arcs in road
 *                      if NR_INCIDENTI = 0
 *                              NR_INCIDENTI_ELAB = NR_INCIDENTI + (kInc * weightedAverage)
 *                      if NR_INCIDENTI > 0
 *                              NR_INCIDENTI_ELAB = NR_INCIDENTI - (kInc * weightedAverage * n / m)
 *      
 *       where:
 *                         kInc = a global correction factor (default is KINCR_DEFAULT_VALUE)
 *              weightedAverage = average of incidents weighted on arcs length
 *                            n = sum of the length of arcs with NR_INCIDENTI = 0
 *                            m = sum of the length of arcs with NR_INCIDENTI > 0                              
 * 
 * @author DamianoG
 * 
 */
public class ZeroRemovalComputation extends IngestionObject {

    private final static Logger LOGGER = LoggerFactory.getLogger(ZeroRemovalComputation.class);

    public static Pattern TYPE_NAME_PARTS = Pattern
            .compile("^([a-z]{4})_([a-z]{3})_([a-z]{2})_([a-z]{4})_([1-3]{1})");

    public static String GEO_TYPE_NAME = "siig_geo_ln_arco_X";
    private static final String NR_INCIDENTI = "nr_incidenti";
    private static final String LUNGHEZZA = "lunghezza";
    private static final String GEOID = "id_geo_arco";
    private static final String ID_ORIGIN = "id_origine";
    private static final String PARTNER_FIELD = "fk_partner";
    private static final double KINCR_DEFAULT_VALUE = .2;
    
    /**
     * A value that multiply all weightedAverage in order to avoid negative results
     */
    private double kInc;

    /**
     * 
     * @param kIncr
     * @param inputTypeName
     * @param listenerForwarder
     */
    public ZeroRemovalComputation(double kIncr, String inputTypeName,
            ProgressListenerForwarder listenerForwarder) {
        super(inputTypeName, listenerForwarder);
        this.kInc = kIncr;
    }
    
    /**
     * This constructor set the default value KINCR_DEFAULT_VALUE to kIncr field 
     * 
     * @param inputTypeName
     * @param listenerForwarder
     */
    public ZeroRemovalComputation(String inputTypeName,
            ProgressListenerForwarder listenerForwarder) {
        super(inputTypeName, listenerForwarder);
        this.kInc = KINCR_DEFAULT_VALUE;
    }

    @Override
    protected boolean parseTypeName(String typeName) {
        Matcher m = TYPE_NAME_PARTS.matcher(typeName);
        if (m.matches()) {
            return true;
        }
        return false;
    }

    /**
     * 
     * @param typeName
     * @param aggregationLevel
     * @return
     */
    private String getTypeName(String typeName, int aggregationLevel) {
        return typeName.replace("X", aggregationLevel + "");
    }

    /**
     * 
     * This method implements the zero removal startegy. see the class javadoc.
     * 
     * @param datastoreParams
     * @param crs
     * @param aggregationLevel
     * @param onGrid
     * @param partnerId
     * @throws IOException
     */
    public void removeZeros(Map<String, Serializable> datastoreParams,
            CoordinateReferenceSystem crs, int aggregationLevel, int partnerId)
            throws IOException {
        reset();

        if (isValid()) {
            JDBCDataStore dataStore = null;

            crs = checkCrs(crs);

            int process = -1;
            int trace = -1;

            int errors = 0;

            String processPhase = "C";

            try {
                dataStore = connectToDataStore(datastoreParams);

                // setup input reader
                createInputReader(dataStore, null, null);

                // setup geo output object
                String geoName = getTypeName(GEO_TYPE_NAME, aggregationLevel);
                OutputObject geoObject = new OutputObject(dataStore, null, geoName, GEOID);

                setInputFilter(filterFactory.equals(filterFactory.property(PARTNER_FIELD),
                        filterFactory.literal(partnerId)));
                // get unique aggregation values in order to identify the roads
                Set<BigDecimal> aggregationValues = getAggregationBigValues(ID_ORIGIN);

                for (BigDecimal aggregationValue : aggregationValues) {
                    //
                    // First of all filter all the arcs to a specified road and partner 
                    //
                    setInputFilter(filterFactory.and(filterFactory.equals(
                            filterFactory.property(ID_ORIGIN),
                            filterFactory.literal(aggregationValue)),
                            filterFactory.equals(filterFactory.property(PARTNER_FIELD),
                                    filterFactory.literal(partnerId))));
                    int arcs = getImportCount();
                    Long incidenti = (Long) getSumOnInput(NR_INCIDENTI, new Long(0)).longValue();
                    if (incidenti != 0) {
                        
                        //
                        // Calculate  weightedAverage, n, m for the current road 
                        //
                        Long lunghezzaTotale = (Long) getSumOnInput(LUNGHEZZA, new Long(0)).longValue();

                        Double weightedSum = 0.0;
                        int n = 0;
                        int m = 0;

                        SimpleFeature inputFeature = null;
                        try {
                            while ((inputFeature = readInput()) != null) {
                                int nrIncidenti = ((BigDecimal) inputFeature
                                        .getAttribute(NR_INCIDENTI)).intValue();
                                int lunghezza = ((BigDecimal) inputFeature.getAttribute(LUNGHEZZA))
                                        .intValue();
                                if (nrIncidenti == 0) {
                                    n += lunghezza;
                                } else {
                                    m += lunghezza;
                                }
                                weightedSum += (double) (nrIncidenti * lunghezza);
                            }
                            
                        } catch(Exception e){
                            LOGGER.error(e.getMessage(), e);
                        }
                        finally {
                            closeInputReader();
                        }

                        Double weightedAvg = weightedSum / lunghezzaTotale;

                        Double inc = kInc * weightedAvg;
                        Double dec = inc * n / m;
                        
                        //
                        // Then apply the incr or the decr to the arcs
                        //
                        try {
                            while ((inputFeature = readInput()) != null) {
                                int nrIncidenti = ((BigDecimal) inputFeature
                                        .getAttribute(NR_INCIDENTI)).intValue();
                                double newIncidenti = (double) nrIncidenti;
                                if (newIncidenti == 0) {
                                    newIncidenti += inc;
                                } else {
                                    newIncidenti -= dec;
                                }

                                updateIncidentalita(geoObject, inputFeature, newIncidenti);
                            }
                        } catch(Exception e){
                            LOGGER.error(e.getMessage(), e);
                        }
                        finally {
                            closeInputReader();
                        }

                    }

                }

            } catch (IOException e) {
                errors++;
                Ingestion
                        .logError(dataStore, trace, errors, "Error importing data", getError(e), 0);
                throw new IOException();
            } finally {
                if (process != -1) {
                    // close current process phase
                    Ingestion.closeProcessPhase(dataStore, process, processPhase);
                }

                if (dataStore != null) {
                    dataStore.dispose();
                }
            }
        }
    }

    /**
     * @param e
     * @return
     */
    private String getError(Exception e) {
        // TODO: human readble error
        Throwable t = e;
        while (t.getCause() != null) {
            t = t.getCause();
        }

        return t.getMessage().substring(0, Math.min(t.getMessage().length(), 1000));
    }

    /**
     * @param geoObject
     * @param inputFeature
     * @param newIncidenti
     * @throws IOException
     */
    private void updateIncidentalita(OutputObject geoObject, SimpleFeature inputFeature,
            double newIncidenti) throws IOException {
        Filter updateFilter = filterFactory.equals(filterFactory.property(GEOID),
                filterFactory.literal(inputFeature.getAttribute(GEOID)));
        geoObject.getWriter().modifyFeatures(
                geoObject.getSchema().getDescriptor("nr_incidenti_elab").getName(), newIncidenti,
                updateFilter);
    }
}
