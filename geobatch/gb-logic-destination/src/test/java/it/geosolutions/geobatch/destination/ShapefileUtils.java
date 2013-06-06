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
package it.geosolutions.geobatch.destination;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import org.geotools.data.DefaultTransaction;
import org.geotools.data.FeatureSource;
import org.geotools.data.Transaction;
import org.geotools.data.collection.ListFeatureCollection;
import org.geotools.data.shapefile.ShapefileDataStore;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureSource;
import org.geotools.data.simple.SimpleFeatureStore;
import org.geotools.feature.DefaultFeatureCollections;
import org.geotools.feature.FeatureIterator;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author DamianoG
 *
 *      Utility class for create a reduced shapefile from another as origin, usefull for create fast test dataset 
 *      TODO Remove HardCoded path, check the all stream usage, externalize some parameters
 */
public class ShapefileUtils {

    private static final Logger LOGGER = LoggerFactory.getLogger(ShapefileUtils.class);
    private static final String URI_URL = "http://geo-solutions.it";
    
    public static void writeOnShapeFile(File shapeFile, SimpleFeatureCollection collection) 
    {
        if (shapeFile == null || collection == null || !shapeFile.canWrite()) 
        {

            throw new IllegalArgumentException(
                    "One or more input parameters are null or the file provided couldn't be read");
        }
        
        ShapefileDataStore newDataStore = null;
        Transaction transaction = null;
        SimpleFeatureStore featureStore = null;
        try 
        {
            newDataStore = new ShapefileDataStore(shapeFile.toURI().toURL());
            newDataStore.createSchema(collection.getSchema()); 
            transaction = new DefaultTransaction("create");
            String typeName = newDataStore.getTypeNames()[0];
            SimpleFeatureSource featureSource = newDataStore.getFeatureSource(typeName);
            featureStore = (SimpleFeatureStore) featureSource;
            featureStore.setTransaction(transaction);
            featureStore.addFeatures(collection);
            transaction.commit();
        }
        catch (IOException e) {
            
            LOGGER.error(e.getMessage(), e);
        }
        finally
        {
            if(newDataStore != null){
                
                newDataStore.dispose();
            }
            if(transaction != null){
               
                try{
                    
                    transaction.close();
                }
                catch (IOException e) {
                    
                    LOGGER.error(e.getMessage(), e);
                }

            }
            if(featureStore !=null){
                
                newDataStore.dispose();
            }
        }    
    }
    
    public static FeatureSource simpleFeatureCollectionByShp(String filename)
    {
        if (filename == null)
        {
            LOGGER.error("Shapefile name is null!");

            return null;
        }

        File shpfile = new File(filename);
        if (LOGGER.isTraceEnabled())
        {
            LOGGER.trace("ZSR: SimpleFeatureCollection: shpfile: " + shpfile);
            LOGGER.trace("ZSR: SimpleFeatureCollection: shpfile.getAbsolutePath(): " + shpfile.getAbsolutePath());
            LOGGER.trace("ZSR: SimpleFeatureCollection: shpfile.getName(): " + shpfile.getName());
        }
        if (!shpfile.exists() || !shpfile.canRead())
        {
            return null;
        }

        try
        {
            ShapefileDataStore store = new ShapefileDataStore(shpfile.toURI().toURL(), new URI(URI_URL), true, true, ShapefileDataStore.DEFAULT_STRING_CHARSET);
            //FeatureSource fs = 
            return store.getFeatureSource();
            //return (SimpleFeatureCollection) fs.getFeatures();
        }
        catch (Exception e1)
        {
            LOGGER.error("ZSR: error:", e1.getLocalizedMessage(), e1);

            return null;
        }

    }
    
    public static SimpleFeatureCollection reduceFeatures(FeatureSource fs, int maxFeatures) throws IOException{
        
        SimpleFeatureCollection sfc = new DefaultFeatureCollections().newCollection();
        FeatureIterator iter = fs.getFeatures().features();
        
        List<SimpleFeature> list = new ArrayList<SimpleFeature>();
        int i = 0;
        while(iter.hasNext() && i < maxFeatures){
            list.add((SimpleFeature) iter.next());
            i++;
        }
        iter.close();
        SimpleFeatureCollection collection = new ListFeatureCollection((SimpleFeatureType)fs.getFeatures().getSchema(), list);
        return collection;
    }
    
    public static void main(String [] args) throws IOException{
        
        String origFilename = "C:\\Users\\geosolutions\\Desktop\\grafo\\RP_C_Grafo_20130424.shp";
        File fOut = new File("C:\\Users\\geosolutions\\Desktop\\grafo\\outSimplifyed\\out.shp");
        
        writeOnShapeFile(fOut, reduceFeatures(simpleFeatureCollectionByShp(origFilename),200));
    }
    
}
