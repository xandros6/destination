/*
 *  fra2015
 *  https://github.com/geosolutions-it/fra2015
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
package it.geosolutions.geobatch.destination.common;

import it.geosolutions.geobatch.destination.OutputObject;
import it.geosolutions.geobatch.destination.RoadArc;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.ListUtils;
import org.apache.commons.collections.map.MultiKeyMap;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.feature.FeatureCollection;
import org.geotools.feature.FeatureIterator;
import org.geotools.jdbc.JDBCDataStore;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.filter.Filter;
import org.opengis.filter.FilterFactory2;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author DamianoG
 * 
 */
public class FeatureLoaderUtils {

    private final static Logger LOGGER = LoggerFactory.getLogger(RoadArc.class);
    
    public final static String ID_ORIGINE = "id_origine";
    
    public static FilterFactory2 filterFactory = CommonFactoryFinder.getFilterFactory2();
    
    private static MultiKeyMap featureAttributesMap = new MultiKeyMap();

    public static List<String> loadFeatureAttributes(JDBCDataStore datastore, String featureTypeName,
            String attribute, boolean forceLoading){
        List<BigDecimal> list = loadFeatureAttributesInternal(datastore, featureTypeName,
                attribute, forceLoading);
        List<String> resultList = new ArrayList<String>();
        for(BigDecimal el : list){
            resultList.add(el.toString());
        }
        return resultList;
    }
    
    public static List<Double> loadFeatureAttributesInt(JDBCDataStore datastore, String featureTypeName,
            String attribute, boolean forceLoading){
        List<BigDecimal> list = loadFeatureAttributesInternal(datastore, featureTypeName,
                attribute, forceLoading);
        List<Double> resultList = new ArrayList<Double>();
        for(BigDecimal el : list){
            resultList.add(el.toBigInteger().doubleValue());
        }
        return resultList;
    }
    
    private static List<BigDecimal> loadFeatureAttributesInternal(JDBCDataStore datastore, String featureTypeName,
            String attribute, boolean forceLoading) {

        List<BigDecimal> attributes = (List<BigDecimal>) featureAttributesMap.get(featureTypeName,
                attribute);
        if (!forceLoading && attributes != null) {
            return ListUtils.unmodifiableList(attributes);
        }
        attributes = new ArrayList<BigDecimal>();
        FeatureIterator iter = null;
        Transaction transaction = null;
        try {
            transaction = new DefaultTransaction();
            OutputObject tipobersObject = new OutputObject(datastore, transaction, featureTypeName,
                    "");
            FeatureCollection<SimpleFeatureType, SimpleFeature> bersaglioCollection = tipobersObject
                    .getReader().getFeatures();
            iter = bersaglioCollection.features();

            while (iter.hasNext()) {
                SimpleFeature sf = (SimpleFeature) iter.next();
                // BigDecimal bd = (BigDecimal) sf.getAttribute("id_sostanza");
                BigDecimal bd = (BigDecimal) sf.getAttribute(attribute);
                attributes.add(bd);
            }
            featureAttributesMap.put(featureTypeName, attribute, attributes);
        } catch (IOException e) {
        } finally {
            if (iter != null) {
                iter.close();
            }
            if (transaction != null) {
                try {
                    transaction.close();
                } catch (IOException e) {
                    LOGGER.error(e.getMessage(), e);
                }
            }
        }
        return ListUtils.unmodifiableList(attributes);
    }

    public static FeatureIterator loadByIdOrig(JDBCDataStore datastore, Transaction transaction,
            String featureTypeName, int idOrig) {

        FeatureIterator iter = null;
        try {
            OutputObject arcoX = new OutputObject(datastore, transaction, featureTypeName, "");
            FeatureCollection<SimpleFeatureType, SimpleFeature> bersaglioCollection = null;

            
            Filter updateFilter = filterFactory.and(filterFactory.equals(
                    filterFactory.property("fk_partner"), filterFactory.literal(1)
            ),filterFactory.equals(
                    filterFactory.property("id_tematico_shape"), filterFactory.literal(1))
            );
            
            
            bersaglioCollection = arcoX.getReader()
                    .getFeatures(updateFilter);

            iter = bersaglioCollection.features();
        } catch (IOException e) {
            LOGGER.error(e.getMessage(), e);
        }
        return iter;
    }

}
