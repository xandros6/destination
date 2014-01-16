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

import it.geosolutions.geobatch.destination.ingestion.ArcsIngestionProcess;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.ingestion.OriginalArcsIngestionProcess;
import it.geosolutions.geobatch.destination.ingestion.TargetIngestionProcess;
import it.geosolutions.geobatch.destination.streetuser.StreetUserComputation;
import it.geosolutions.geobatch.destination.vulnerability.RiskComputation;
import it.geosolutions.geobatch.destination.vulnerability.VulnerabilityComputation;
import it.geosolutions.geobatch.destination.zeroremoval.ZeroRemovalComputation;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import javax.media.jai.JAI;

import org.geotools.data.DataStoreFinder;
import org.geotools.jdbc.JDBCDataStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 * 
 */
public class RoadRunner{

    private static final Logger LOGGER = LoggerFactory.getLogger(RoadRunner.class);
    
    

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
        
        JDBCDataStore dataStore = null;        
        MetadataIngestionHandler metadataHandler = null;
        try {
        	
        	//String inputFeature = "RL_C_Grafo_20130918";
        	//String inputFeature = "AO_C_Grafo_20130704";
        	String inputFeature = "RP_C_Grafo_20140101_ORIG";
        	
        	dataStore = (JDBCDataStore)DataStoreFinder.getDataStore(datastoreParams);	        
	        metadataHandler = new MetadataIngestionHandler(dataStore);
	        /*OriginalArcsIngestionProcess arcIngestion = new OriginalArcsIngestionProcess(inputFeature,
	                new ProgressListenerForwarder(null), metadataHandler, dataStore, -1, -1);
	        arcIngestion.importArcs(null, false);*/
	        ArcsIngestionProcess arcIngestion = new ArcsIngestionProcess(inputFeature,
	                new ProgressListenerForwarder(null), metadataHandler, dataStore);
	        
	        arcIngestion.importArcs(null, 1, false, false, true, null);
	        
	        /*arcIngestion.importArcs(null, 2, false, false, null);
	        arcIngestion.importArcs(null, 3, false, false, null);
	        arcIngestion.importArcs(null, 3, true, false, "A");

            // Spalmatore
			ZeroRemovalComputation zeroComputation = new ZeroRemovalComputation(
					inputFeature, new ProgressListenerForwarder(null),
					metadataHandler, dataStore);
	        
	        
	        zeroComputation.removeZeros(null, 1, null);
	        zeroComputation.removeZeros(null, 2, null);
	        zeroComputation.removeZeros(null, 3, null);*/
	        
	        JAI.getDefaultInstance().getTileCache().setMemoryCapacity(1024*1024*1024);
	        
	        VulnerabilityComputation vulnerability = new VulnerabilityComputation(inputFeature, 
	        		new ProgressListenerForwarder(null), metadataHandler, dataStore);
	        
	        /*vulnerability.computeVulnerability(null, 1, "PURGE_INSERT", null);
	        vulnerability.computeVulnerability(null, 2, "PURGE_INSERT", null);
	        vulnerability.computeVulnerability(null, 3, "PURGE_INSERT", null);
			
	        RiskComputation riskComputation = new RiskComputation(
	        		inputFeature,
					new ProgressListenerForwarder(null),
					metadataHandler, dataStore);
	    	
	        
	        
	        riskComputation.prefetchRiskAtLevel(3, 1, 1, 26, 100, "1,2,3,4,5,6,7,8,9,10", "1,2,3,4,5,6,7,8,9,10,11", "0,1", "1,2,3,4,5", "fp_scen_centrale", "PURGE_INSERT", null);
	        riskComputation.prefetchRiskAtLevel(3, 2, 1, 26, 100, "1,2,3,4,5,6,7,8,9,10", "1,2,3,4,5,6,7,8,9,10,11", "0,1", "1,2,3,4,5", "fp_scen_centrale", "PURGE_INSERT", null);
	        riskComputation.prefetchRiskAtLevel(3, 3, 1, 29, 100, "1,2,3,4,5,6,7,8,9,10", "1,2,3,4,5,6,7,8,9,10,11", "0,1", "1,2,3,4,5", "fp_scen_centrale", "PURGE_INSERT", "B");
	        */
	        
	        StreetUserComputation streetUserComputation = new StreetUserComputation(inputFeature,
					new ProgressListenerForwarder(null),
					metadataHandler,
					dataStore);
	        
	        /*streetUserComputation.execute(1);
	       streetUserComputation.execute(2);
	        streetUserComputation.execute(3);*/
        } catch(Exception e) {
        	LOGGER.error(e.getMessage());
        } finally {
        	if(metadataHandler != null) {
        		metadataHandler.dispose();
        	}
        	
        	if(dataStore != null) {
        		dataStore.dispose();
        	}        	
        }
        
        
    }
}
