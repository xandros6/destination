/*
 *    GeoTools - The Open Source Java GIS Toolkit
 *    http://geotools.org
 *
 *    (C) 2002-2011, Open Source Geospatial Foundation (OSGeo)
 *
 *    This library is free software; you can redistribute it and/or
 *    modify it under the terms of the GNU Lesser General Public
 *    License as published by the Free Software Foundation;
 *    version 2.1 of the License.
 *
 *    This library is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *    Lesser General Public License for more details.
 */
package it.geosolutions.geobatch.destination.action;

import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.ingestion.TargetIngestionProcess;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.geotools.data.DataStoreFinder;
import org.geotools.jdbc.JDBCDataStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 * 
 */
public class TargetRunner{

    private static final Logger LOGGER = LoggerFactory.getLogger(TargetRunner.class);
    
    private class TargetThread implements Runnable {

        TargetIngestionProcess targetIngestion;        
        
        public TargetThread(TargetIngestionProcess targetIngestion) {
            this.targetIngestion = targetIngestion;            
        }

        @Override
        public void run() {
            try {
                targetIngestion.importTarget(null, false);
            } catch (IOException e) {
                LOGGER.error(e.getMessage(), e);
            }
        }
    }

    public static void main(String [] args) {
        Map<String, Serializable> datastoreParams = new HashMap<String, Serializable>();
        datastoreParams.put("port", 5432);
        datastoreParams.put("schema", "siig_p");
        datastoreParams.put("passwd", "siig_p");
        datastoreParams.put("dbtype", "postgis");
        datastoreParams.put("host", "192.168.1.31");
        datastoreParams.put("Expose primary keys", "true");
        datastoreParams.put("user", "siig_p");
        datastoreParams.put("database", "destination_staging");
        
        JDBCDataStore dataStore1 = null;
        JDBCDataStore dataStore2 = null;
        MetadataIngestionHandler metadataHandler1 = null;
        MetadataIngestionHandler metadataHandler2 = null;
        try {
        	dataStore1 = (JDBCDataStore)DataStoreFinder.getDataStore(datastoreParams);
	        //dataStore2 = (JDBCDataStore)DataStoreFinder.getDataStore(datastoreParams);
	        metadataHandler1 = new MetadataIngestionHandler(dataStore1);
	        //metadataHandler2 = new MetadataIngestionHandler(dataStore2);
	        
	        TargetIngestionProcess targetIngestion1 = new TargetIngestionProcess("RL_BNU-ABOSC_C_20130909_02",
	                new ProgressListenerForwarder(null), metadataHandler1, dataStore1);
	        /*TargetIngestionProcess targetIngestion2 = new TargetIngestionProcess("RL_BU-ASAN_C_20130624_02",
	                new ProgressListenerForwarder(null), metadataHandler2, dataStore2);*/
	        TargetRunner vtest = new TargetRunner();
	        
	        TargetThread vt1 = vtest.new TargetThread(targetIngestion1);
	        Thread t1 = new Thread(vt1);
	        t1.start();
	        
	        /*TargetThread vt2 = vtest.new TargetThread(targetIngestion2);
	        Thread t2 = new Thread(vt2);
	        t2.start();*/
	        
	        t1.join();
	        //t2.join();
        } catch(Exception e) {
        	LOGGER.error(e.getMessage());
        } finally {
        	if(metadataHandler1 != null) {
        		metadataHandler1.dispose();
        	}
        	if(metadataHandler2 != null) {
        		metadataHandler1.dispose();
        	}
        	
        	if(dataStore1 != null) {
        		dataStore1.dispose();
        	}
        	if(dataStore2 != null) {
        		dataStore2.dispose();
        	}
        }
    }
}
