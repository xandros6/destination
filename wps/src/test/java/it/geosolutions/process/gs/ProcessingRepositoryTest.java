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
package it.geosolutions.process.gs;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import junit.framework.TestCase;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geoserver.catalog.impl.CatalogImpl;
import org.geoserver.config.DefaultGeoServerLoader;
import org.geoserver.platform.GeoServerResourceLoader;
import org.geotools.feature.SchemaException;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.process.ProcessException;
import org.vfny.geoserver.global.GeoserverDataDirectory;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class ProcessingRepositoryTest extends TestCase {
	
	/** keySearch */
	private static final String keyMatch = "[0-9]+";
	private static final Integer SAMPLE_USER = -1;
	private static final String SAMPLE_DATA = "my sample data";
	private static final String OTHER_DATA = "other data";
	private static final long CLEAN_ALL_DATA = -1;
	Catalog catalog;
	String dataStoreName = System.getProperty("GS_DS_NAME");
	JDBCDataStore dataStore;
	ProcessingRepository repository;
	
	public void setUp() throws IOException, SchemaException, SQLException {
		String dataDirPath = System.getProperty("GS_TEST_DATA_DIR");
		
		if(dataDirPath != null) {
			catalog = new CatalogImpl();
			
			GeoServerResourceLoader resourceLoader = new GeoServerResourceLoader(
					new File(dataDirPath));
			GeoserverDataDirectory.setResourceLoader(resourceLoader);
			DefaultGeoServerLoader loader = new DefaultGeoServerLoader(resourceLoader);
			catalog = (Catalog)loader.postProcessBeforeInitialization(catalog, "catalog");
			if(catalog != null) {
				repository = new ProcessingRepository(catalog);	
				
				DataStoreInfo dataStoreInfo = catalog.getDataStoreByName(dataStoreName);
				dataStore = (JDBCDataStore)dataStoreInfo.getDataStore(null);
				
				repository.cleanData(dataStore, SAMPLE_USER, CLEAN_ALL_DATA);
			}			
			
		}
	}
		
	public void tearDown() {
		if(dataStore != null) {
			dataStore.dispose();
		}
	}
	
	public void testSaveData() throws IOException, SQLException {
		if(repository != null && dataStoreName != null && dataStore != null) {			
			String result = repository.execute(dataStoreName, "save", SAMPLE_USER,
					null, SAMPLE_DATA, null);
			assertNotNull(result);
			assertTrue(result.matches(keyMatch));
		}
	}
	
	public void testSaveMoreData() throws IOException, SQLException {
		if(repository != null && dataStoreName != null && dataStore != null) {			
			String key1 = repository.execute(dataStoreName, "save", SAMPLE_USER,
					null, SAMPLE_DATA, null);
			
			String key2 = repository.execute(dataStoreName, "save", SAMPLE_USER,
					null, OTHER_DATA, null);
			
			assertFalse(key1.equals(key2));	
			
			assertEquals(SAMPLE_DATA, repository.execute(dataStoreName, "load", SAMPLE_USER,
					Integer.parseInt(key1), null, null));
			
			assertEquals(OTHER_DATA, repository.execute(dataStoreName, "load", SAMPLE_USER,
					Integer.parseInt(key2), null, null));
		}
	}
	
	public void testSaveIsPersistent() throws IOException, SQLException {
		if(repository != null && dataStoreName != null && dataStore != null) {			
			String key1 = repository.execute(dataStoreName, "save", SAMPLE_USER,
					null, SAMPLE_DATA, null);
			
			String key2 = repository.execute(dataStoreName, "save", SAMPLE_USER,
					null, OTHER_DATA, null);
			
			assertFalse(key1.equals(key2));	
			
			repository = new ProcessingRepository(catalog);	
			
			assertEquals(SAMPLE_DATA, repository.execute(dataStoreName, "load", SAMPLE_USER,
					Integer.parseInt(key1), null, null));
			
			assertEquals(OTHER_DATA, repository.execute(dataStoreName, "load", SAMPLE_USER,
					Integer.parseInt(key2), null, null));
		}
	}
	
	public void testLoadData() throws IOException, SQLException {
		if(repository != null && dataStoreName != null && dataStore != null) {			
			String result = repository.execute(dataStoreName, "save", SAMPLE_USER,
					null, SAMPLE_DATA, null);

			int dataid = Integer.parseInt(result);
			
			result = repository.execute(dataStoreName, "load", SAMPLE_USER,
					dataid, null, null);
			assertEquals(SAMPLE_DATA, result);
		}
	}
	
	public void testUnknownAction() throws IOException, SQLException {
		if(repository != null && dataStoreName != null && dataStore != null) {		
			boolean exception = false;
			try {
				repository.execute(dataStoreName, "UNKNOWN", SAMPLE_USER,
						null, null, null);
			} catch(ProcessException e) {
				exception = true;				
			}
			assertTrue(exception);
		}
	}
	
	public void testMissingDataStore() throws IOException, SQLException {
		if(repository != null && dataStoreName != null && dataStore != null) {		
			boolean exception = false;
			try {
				repository.execute(null, "load", SAMPLE_USER,
						null, null, null);
			} catch(ProcessException e) {
				exception = true;				
			}
			assertTrue(exception);
		}
	}
	
	public void testMissingUser() throws IOException, SQLException {
		if(repository != null && dataStoreName != null && dataStore != null) {		
			boolean exception = false;
			try {
				repository.execute(dataStoreName, "load", null,
						null, null, null);
			} catch(ProcessException e) {
				exception = true;				
			}
			assertTrue(exception);
		}
	}
	
	public void testMissingIdOnLoad() throws IOException, SQLException {
		if(repository != null && dataStoreName != null && dataStore != null) {		
			boolean exception = false;
			try {
				repository.execute(dataStoreName, "load", SAMPLE_USER,
						null, null, null);
			} catch(ProcessException e) {
				exception = true;				
			}
			assertTrue(exception);
		}
	}
	
	public void testMissingDataOnSave() throws IOException, SQLException {
		if(repository != null && dataStoreName != null && dataStore != null) {		
			boolean exception = false;
			try {
				repository.execute(dataStoreName, "save", SAMPLE_USER,
						null, null, null);
			} catch(ProcessException e) {
				exception = true;				
			}
			assertTrue(exception);
		}
	}
}
