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
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.jdbc.JDBCDataStore;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.filter.FilterFactory2;
import org.vfny.geoserver.global.GeoserverDataDirectory;



/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public abstract class RiskCalculatorTest extends TestCase {
	
	Catalog catalog;
	RiskCalculator riskCalculator;
	JDBCDataStore dataStore;
	FilterFactory2 ff = CommonFactoryFinder.getFilterFactory2();
	
	String dataStoreName = System.getProperty("GS_DS_NAME");
	
	public void setUp() throws IOException {
		String dataDirPath = System.getProperty("GS_TEST_DATA_DIR");
		
		if(dataDirPath != null) {
			catalog = new CatalogImpl();
			
			GeoServerResourceLoader resourceLoader = new GeoServerResourceLoader(
					new File(dataDirPath));
			GeoserverDataDirectory.setResourceLoader(resourceLoader);
			DefaultGeoServerLoader loader = new DefaultGeoServerLoader(resourceLoader);
			catalog = (Catalog)loader.postProcessBeforeInitialization(catalog, "catalog");
			if(catalog != null) {
				riskCalculator = new RiskCalculator(catalog);	
				
				DataStoreInfo dataStoreInfo = catalog.getDataStoreByName(dataStoreName);
				dataStore = (JDBCDataStore)dataStoreInfo.getDataStore(null);
			}
		}
	}
	
	public void tearDown() {
		if(dataStore != null) {
			dataStore.dispose();
		}
	}
	
	public void aatestFormulaCffSimpleTarget() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null, 2,
						1, "", "", "", "").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					assertEquals(0.3, feature.getAttribute("rischio1"));
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
	
	public void aatestFormulaCffHuman() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null, 2, 98, "", "", "", "").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					assertEquals(0.3, feature.getAttribute("rischio1"));
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
	
	public void aatestFormulaCffAll() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null, 2, 100, "", "", "", "").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					assertEquals(0.3, feature.getAttribute("rischio1"));
					assertEquals(0.0, feature.getAttribute("rischio2"));
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
	
	public void aatestFormulaPadr() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null, 20, 0, "9", "", "", "").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertEquals(1.0, feature.getAttribute("rischio1"));
					assertEquals(0.0, feature.getAttribute("rischio2"));
					assertNotNull(feature);
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
	
	public void testFormulaPis() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null, 22, 0, "", "", "", "").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();					
					assertNotNull(feature);
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
	
	public void cctestFormulaPis() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null, 22, 0, "", "", "", "").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
	
	public void ddtestFormulaPsc() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null, 16, 0, "1,4", "4,5", "0,1", "").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
	
	public void eetestFormulaSantropica() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null,  36, 1, "", "4,5", "", "1,2,3,4").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
	
	public void fftestFormulaSambientale() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null,  37, 10, "", "4,5", "", "5").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
	
	public void aatestFormulaE() throws IOException, SQLException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = dataStore.getFeatureSource("siig_geo_ln_arco_2").getFeatures();//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null, 32, 1, "9", "4,5", "0,1", "1,2,3,4").features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					count++;
				}
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}
}
