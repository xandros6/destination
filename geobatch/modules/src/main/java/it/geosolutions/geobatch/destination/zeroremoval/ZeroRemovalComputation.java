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
 * @author DamianoG
 * 
 */
public class ZeroRemovalComputation extends IngestionObject {

    private final static Logger LOGGER = LoggerFactory.getLogger(ZeroRemovalComputation.class);

    private static Pattern TYPE_NAME_PARTS = Pattern
            .compile("^([a-z]{4})_([a-z]{3})_([a-z]{2})_([a-z]{4})_([1-3]{1})");

    private static String GRID_TYPE_NAME = "siig_geo_grid";

    private static String GEO_TYPE_NAME = "siig_geo_ln_arco_X";

    private static String NR_INCIDENTI = "nr_incidenti";

    private static String LUNGHEZZA = "lunghezza";

    private static String GEOID = "id_geo_arco";

    private static String ID_ORIGIN = "id_origine";
    
    private static String PARTNER_FIELD = "fk_partner";

    public static Properties aggregation = new Properties();

    private static Map attributeMappings = null;

    private int partner;

    static {
        // load mappings from resources
        attributeMappings = (Map) readResourceFromXML("/roadarcs.xml");

        InputStream aggregationStream = null;
        try {
            aggregationStream = RoadArc.class.getResourceAsStream("/aggregation.properties");
            aggregation.load(aggregationStream);
        } catch (IOException e) {
            LOGGER.error("Unable to load configuration: " + e.getMessage(), e);
        } finally {
            try {
                if (aggregationStream != null) {
                    aggregationStream.close();
                }
            } catch (IOException e) {
                LOGGER.error(e.getMessage(), e);
            }
        }
    }

    /**
     * @param inputTypeName
     * @param listenerForwarder
     */
    public ZeroRemovalComputation(int partner, String inputTypeName,
            ProgressListenerForwarder listenerForwarder) {
        super(inputTypeName, listenerForwarder);
        this.partner = partner;
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
     * @param geoTypeName2
     * @param aggregationLevel
     * @return
     */
    private String getTypeName(String typeName, int aggregationLevel) {
        return typeName.replace("X", aggregationLevel + "");
    }

    /**
     * Imports the arcs feature from the original Feature to the SIIG arcs tables (in staging).
     * 
     * @param datastoreParams
     * @param crs
     * @throws IOException
     */
    public void removeZeros(Map<String, Serializable> datastoreParams,
            CoordinateReferenceSystem crs, int aggregationLevel, boolean onGrid, int partner_id)
            throws IOException {
        reset();

        double kinc = 1;
        if (isValid()) {
            JDBCDataStore dataStore = null;

            crs = checkCrs(crs);

            int process = -1;
            int trace = -1;

            int errors = 0;

            String processPhase = "C";

            try {
                dataStore = connectToDataStore(datastoreParams);

//                Ingestion.Process importData = getProcessData(dataStore);
//                process = importData.getId();
//                trace = importData.getMaxTrace();
//                errors = importData.getMaxError();

                // setup input reader
                createInputReader(dataStore, null, onGrid ? GRID_TYPE_NAME : null);

                // setup geo output object
                String geoName = getTypeName(GEO_TYPE_NAME, aggregationLevel);
                OutputObject geoObject = new OutputObject(dataStore, null, geoName, GEOID);

                setInputFilter(filterFactory.equals(filterFactory.property(PARTNER_FIELD),
                        filterFactory.literal(partner_id)));
                // get unique aggregation values
                Set<BigDecimal> aggregationValues = getAggregationBigValues(ID_ORIGIN);

                for (BigDecimal aggregationValue : aggregationValues) {
                    setInputFilter(filterFactory.and(filterFactory.equals(
                            filterFactory.property(ID_ORIGIN),
                            filterFactory.literal(aggregationValue)), filterFactory.equals(
                            filterFactory.property(PARTNER_FIELD),
                            filterFactory.literal(partner_id))));
                    int arcs = getImportCount();
                    Long incidenti = (Long) getSumOnInput(NR_INCIDENTI, new Long(0)).longValue();
                    if (incidenti != 0) {
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

                        Double avg = weightedSum / lunghezzaTotale;

                        Double inc = kinc * avg;
                        Double dec = inc * n / m;

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
