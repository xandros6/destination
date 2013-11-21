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

//import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration;
import it.geosolutions.geobatch.destination.common.utils.SequenceManager;
import it.geosolutions.geobatch.destination.ingestion.ArcsIngestionProcess;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

import org.apache.tools.ant.util.FileUtils;
import org.geotools.data.DataUtilities;
import org.geotools.data.Query;
import org.geotools.data.memory.MemoryDataStore;
import org.geotools.feature.SchemaException;
import org.geotools.util.logging.Logging;
import org.junit.Before;
import org.junit.Test;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.junit.Assert.assertEquals;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class RoadArcTest {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RoadArcTest.class);
	private MemoryDataStore dataStore;
	private MetadataIngestionHandler metadataHandler;
	
	private static final String sampleInput = "BZ_C_Grafo_20130917";
	static{
		try {
			Logging.ALL.setLoggerFactory("org.geotools.util.logging.Log4JLoggerFactory");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}
	}
	
	@Before
	public void before() throws Exception { 
		
		dataStore = new MemoryDataStore();
		Map<String, SimpleFeatureType> model = loadTestModel();
		for(SimpleFeatureType schema : model.values()) {
			dataStore.createSchema(schema);
		}
		loadTestData(dataStore, model, new String[] {"arcs_test_data"});
		
		metadataHandler = new TestMetadataIngestionHandler(dataStore);
		
	}

	/**
	 * 
	 * @param dataStore
	 * @param model
	 * @param extraData
	 * @throws IOException
	 */
	private void loadTestData(MemoryDataStore dataStore,
			Map<String, SimpleFeatureType> model, String[] extraData) throws IOException {
		
		loadTestData(dataStore, model, "test_data");
		for(String data : extraData) {
			loadTestData(dataStore, model, data);
		}
	}

	/**
	 * 
	 * @param dataStore
	 * @param model
	 * @param name
	 * @throws IOException
	 */
	private void loadTestData(MemoryDataStore dataStore,
			Map<String, SimpleFeatureType> model, String name) throws IOException {
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("/" + name + ".txt")));
			String line = null;
			while((line = reader.readLine()) != null) {
				String typeName = line.substring(0, line.indexOf('='));
				String data = line.substring(line.indexOf('=') + 1);
				SimpleFeature feature = DataUtilities.createFeature(model.get(typeName), data);
				dataStore.addFeature(feature);
			}
		} finally {
			FileUtils.close(reader);			
		}
	}

	/**
	 * 
	 * @return
	 * @throws IOException
	 * @throws SchemaException
	 */
	private Map<String, SimpleFeatureType> loadTestModel() throws IOException, SchemaException {
		Map<String, SimpleFeatureType> model = new HashMap<String, SimpleFeatureType>();
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("/test_model.txt")));
			String line = null;
			while((line = reader.readLine()) != null) {
				String typeName = line.substring(0, line.indexOf('='));
				String typeSpec = line.substring(line.indexOf('=') + 1);
				model.put(typeName, DataUtilities.createType(typeName, typeSpec));
			}
		} finally {
			FileUtils.close(reader);			
		}
		return model;
	};
	
	@Test
	public void testLevel1() throws IOException {
        ArcsIngestionProcess arcIngestion = createProcess();
        
        arcIngestion.importArcs(null, 1, false, false, null);
        
        checkFeature("siig_geo_ln_arco_1", 3);
        checkFeature("siig_r_tipovei_geoarco1", 6);
        checkFeature("siig_r_arco_1_dissesto", 6);
        checkFeature("siig_r_arco_1_scen_tipobers", 39);
        checkFeature("siig_r_arco_1_sostanza", 30);
	}
	
	@Test
	public void testLevel2() throws IOException {
        ArcsIngestionProcess arcIngestion = createProcess();
        
        arcIngestion.importArcs(null, 2, false, false, null);
        
        checkFeature("siig_geo_ln_arco_2", 2);
        checkFeature("siig_r_tipovei_geoarco2", 4);
        checkFeature("siig_r_arco_2_dissesto", 6);
        checkFeature("siig_r_arco_2_scen_tipobers", 26);
        checkFeature("siig_r_arco_2_sostanza", 20); 
	}
	
	@Test
	public void testLevel3() throws IOException {
        ArcsIngestionProcess arcIngestion = createProcess();
        
        arcIngestion.importArcs(null, 3, false, false, null);
        
        checkFeature("siig_geo_ln_arco_3", 1);
        checkFeature("siig_r_tipovei_geoarco3", 2);
        checkFeature("siig_r_arco_3_dissesto", 0);
        checkFeature("siig_r_arco_3_scen_tipobers", 0);
        checkFeature("siig_r_arco_3_sostanza", 0); 
	}
	
	@Test
	public void testGridLevel3() throws IOException {
        ArcsIngestionProcess arcIngestion = createProcess();
        
        arcIngestion.importArcs(null, 3, true, false, null);
        
        checkFeature("siig_geo_pl_arco_3", 1);
        checkFeature("siig_r_tipovei_geoarco3", 0);
        checkFeature("siig_r_arco_3_dissesto", 3);
        checkFeature("siig_r_arco_3_scen_tipobers", 13);
        checkFeature("siig_r_arco_3_sostanza", 10); 
	}

	/**
	 * @param string
	 * @param i
	 * @throws IOException 
	 */
	private void checkFeature(String typeName, int expectedSize) throws IOException {
		assertEquals(expectedSize, dataStore.getFeatureSource(typeName).getCount(new Query(typeName)));
	}

	/**
	 * @return
	 */
	private ArcsIngestionProcess createProcess() {
		ArcsIngestionProcess process = new ArcsIngestionProcess(sampleInput,
                new ProgressListenerForwarder(null), metadataHandler, dataStore);
		process.setSequenceManager(new SequenceManager(dataStore, "") {
			int value = 1;
			@Override
			public long retrieveValue() throws IOException {
				return value++;
			}
			
		});
		return process;
	}
	
/*
	@Test  @Ignore
	public void testImportArcs() throws IOException {
		String input = "D:\\Develop\\GEOBATCH_CONFIG\\temp\\importBersagliVettoriali\\20130402-080846-028\\0_Ds2dsGeneratorService\\output.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		ArcsIngestionProcess arc = new ArcsIngestionProcess(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {
			
			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public String getId() {
				return "id";
			}
		}));
		
		arc.importArcs(cfg.getDataStore(), null, 1, false, false, null);
		
	}
	
	@Test  @Ignore
	public void testRemoveZeros() throws IOException {
		String input = "D:\\Develop\\arcsoutput.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		ArcsIngestionProcess arc = new ArcsIngestionProcess(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {
			
			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public String getId() {
				return "id";
			}
		}));
		
//		arc.removeZeros(cfg.getDataStore(), null, 1, false, false);
		
	}
	
	@Test  @Ignore
	public void testAggregateArcs() throws IOException {
		String input = "D:\\Develop\\GEOBATCH_CONFIG\\temp\\importBersagliVettoriali\\20130402-080846-028\\0_Ds2dsGeneratorService\\output.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		ArcsIngestionProcess arc = new ArcsIngestionProcess(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {
			
			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public String getId() {
				return "id";
			}
		}));
		
		arc.importArcs(cfg.getDataStore(), null, 2, false, false, null);
		
	}
	 
	@Test  @Ignore
	public void testAggregateGrid() throws IOException {
		String input = "D:\\Develop\\GEOBATCH_CONFIG\\temp\\importBersagliVettoriali\\20130402-080846-028\\0_Ds2dsGeneratorService\\output.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		ArcsIngestionProcess arc = new ArcsIngestionProcess(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {
			
			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public String getId() {
				return "id";
			}
		}));
		
		arc.importArcs(cfg.getDataStore(), null, 3, true, false, null);
		
	}*/
}
