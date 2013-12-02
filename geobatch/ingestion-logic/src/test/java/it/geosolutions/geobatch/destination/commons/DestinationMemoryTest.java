package it.geosolutions.geobatch.destination.commons;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import it.geosolutions.geobatch.destination.TestMetadataIngestionHandler;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

import org.apache.tools.ant.util.FileUtils;
import org.geotools.data.DataUtilities;
import org.geotools.data.Query;
import org.geotools.data.memory.MemoryDataStore;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.data.simple.SimpleFeatureSource;
import org.geotools.feature.SchemaException;
import org.geotools.util.logging.Logging;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class DestinationMemoryTest {

	private static final Logger LOGGER = LoggerFactory.getLogger(DestinationMemoryTest.class);

	protected MemoryDataStore dataStore;
	protected Map<String, SimpleFeatureType> model;
	protected MetadataIngestionHandler metadataHandler;

	static{
		try {
			Logging.ALL.setLoggerFactory("org.geotools.util.logging.Log4JLoggerFactory");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}
	}

	protected void initTestWithData(String[] strings) throws IOException, SchemaException {
		initTestDataStore();
		loadTestData(strings);
		initMetadata();		
	}

	private void initTestDataStore() throws IOException, SchemaException {
		dataStore = new MemoryDataStore();
		model = loadTestModel();
		for(SimpleFeatureType schema : model.values()) {
			dataStore.createSchema(schema);
		}
	}

	private void initMetadata() {
		metadataHandler = new TestMetadataIngestionHandler(dataStore);		
	}


	/**
	 * 
	 * @param dataStore
	 * @param model
	 * @param extraData
	 * @throws IOException
	 */
	private void loadTestData(String[] extraData) throws IOException {
		loadTestData(dataStore, model, "test_data");
		for(String data : extraData) {
			loadTestData(dataStore, model, data);
		}
	}

	/**
	 * @param string
	 * @param i
	 * @throws IOException 
	 */
	protected void checkFeature(String typeName, int expectedSize) throws IOException {		
		SimpleFeatureSource featureSource = dataStore.getFeatureSource(typeName);
		SimpleFeatureType schema = dataStore.getSchema(typeName);
		assertNotNull(schema);
		assertEquals(expectedSize, featureSource.getCount(new Query(typeName)));
		SimpleFeatureIterator iterator = featureSource.getFeatures().features();
		try {
			while(iterator.hasNext()) {
				SimpleFeature feature = iterator.next();
				assertNotNull(feature);
			}
		} finally {
			iterator.close();
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
	protected Map<String, SimpleFeatureType> loadTestModel() throws IOException, SchemaException {
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
}
