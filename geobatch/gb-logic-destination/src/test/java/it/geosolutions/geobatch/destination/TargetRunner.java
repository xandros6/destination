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
package it.geosolutions.geobatch.destination;

import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 * 
 */
public class TargetRunner{

    private static final Logger LOGGER = LoggerFactory.getLogger(TargetRunner.class);
    
    private class TargetThread implements Runnable {

        VectorTarget targetIngestion;
        Map<String, Serializable> datastoreParams;
        
        public TargetThread(VectorTarget targetIngestion, Map<String, Serializable> datastoreParams) {
            this.targetIngestion = targetIngestion;
            this.datastoreParams = datastoreParams;
        }

        @Override
        public void run() {
            try {
                targetIngestion.importTarget(datastoreParams, null, false);
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
        datastoreParams.put("host", "192.168.88.132");
        datastoreParams.put("Expose primary keys", "true");
        datastoreParams.put("user", "siig_p");
        datastoreParams.put("database", "destination_staging");
        
        VectorTarget targetIngestion1 = new VectorTarget("RP_BU-ACOMM_20130424_02",
                new ProgressListenerForwarder(null));
        VectorTarget targetIngestion2 = new VectorTarget("RP_BU-ASAN_20130424_02",
                new ProgressListenerForwarder(null));
        TargetRunner vtest = new TargetRunner();
        
        TargetThread vt1 = vtest.new TargetThread(targetIngestion1, datastoreParams);
        Thread t1 = new Thread(vt1);
        t1.start();
        
        TargetThread vt2 = vtest.new TargetThread(targetIngestion2, datastoreParams);
        Thread t2 = new Thread(vt2);
        t2.start();
    }
}
