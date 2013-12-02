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
import org.geotools.data.DataUtilities;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.feature.SchemaException;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.process.ProcessException;
import org.junit.After;
import org.junit.Before;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.filter.FilterFactory2;
import org.vfny.geoserver.global.GeoserverDataDirectory;



/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class RiskCalculatorTest extends TestCase {
	
	/** SIMULATION_PROCESSING */
	private static final int SIMULATION_PROCESSING = 3;
	/** FP_SCEN_CENTRALE */
	private static final String FP_SCEN_CENTRALE = "fp_scen_centrale";
	/** ALL_SEVERENESS */
	private static final String ALL_SEVERENESS = "1,2,3,4,5";
	/** ALL_ENTITIES */
	private static final String ALL_ENTITIES = "0,1";
	/** ALL_SCENARIOS */
	private static final String ALL_SCENARIOS = "1,2,3,4,5,6,7,8,9,10,11";
	/** ALL_MATERIALS */
	private static final String ALL_MATERIALS = "1,2,3,4,5,6,7,8,9,10";
	/** ALL_TARGETS */
	private static final int ALL_TARGETS = 100;
	/** STANDARD_PROCESSING */
	private static final int STANDARD_PROCESSING = 1;
	Catalog catalog;
	RiskCalculator riskCalculator;
	JDBCDataStore dataStore;
	FilterFactory2 ff = CommonFactoryFinder.getFilterFactory2();
	
	String dataStoreName = System.getProperty("GS_DS_NAME");
	SimpleFeatureType inputType;
	
	@Before
	public void setUp() throws IOException, SchemaException {
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
	
	@After
	public void tearDown() {
		if(dataStore != null) {
			dataStore.dispose();
		}
	}
	
	private void createInputType(int level) throws SchemaException {
		inputType = DataUtilities.createType("siig_geo_ln_arco_" + level,"id_geo_arco:Integer,nr_incidenti:Integer,nr_incidenti_elab:Double,nr_corsie:Integer,lunghezza:Integer,nr_bers_umani_strada:Integer,id_tematico_shape:Integer,fk_partner:String,geometria:Geometry:32632,id_origine:Integer,flg_nr_corsie:String,flg_nr_incidenti:String");
	}
	
	public void testNullInputFeature() throws IOException, SQLException {
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			boolean exception = false;
			try {
				riskCalculator.execute(null,
						dataStoreName, null, null, null, STANDARD_PROCESSING, /* cff */
						2, ALL_TARGETS, ALL_MATERIALS, ALL_SCENARIOS,
						ALL_ENTITIES, ALL_SEVERENESS, FP_SCEN_CENTRALE, null,
						null, null, null, null, null, null, false);
			} catch (ProcessException e) {
				exception = true;
			}
			assertTrue(exception);
		}
	}
	
	public void testNotExistingFormula() throws IOException, SQLException, SchemaException {
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			boolean exception = false;
			try {
				riskCalculator.execute(getSampleData(1, 1),
						dataStoreName, null, null, null, STANDARD_PROCESSING, 
						1000, ALL_TARGETS, ALL_MATERIALS, ALL_SCENARIOS,
						ALL_ENTITIES, ALL_SEVERENESS, FP_SCEN_CENTRALE, null,
						null, null, null, null, null, null, false);
			} catch (ProcessException e) {
				exception = true;
			}
			assertTrue(exception);
		}
	}
	
	public void testSimpleFormula() throws IOException, SQLException, SchemaException {
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(getSampleData(1, 1),
						dataStoreName, null, null, null, STANDARD_PROCESSING, /* cff */
						2, ALL_TARGETS, ALL_MATERIALS, ALL_SCENARIOS,
						ALL_ENTITIES, ALL_SEVERENESS, FP_SCEN_CENTRALE, null,
						null, null, null, null, null, null, false).features();
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
			assertTrue(count == 1);
			
		}
	}
	
	public void testESimulationWithChangedTargets() throws IOException, SQLException, SchemaException {
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(getSampleData(1, 1),
						dataStoreName, null, null, null, SIMULATION_PROCESSING, /* E */
						32, ALL_TARGETS, ALL_MATERIALS, ALL_SCENARIOS,
						ALL_ENTITIES, ALL_SEVERENESS, FP_SCEN_CENTRALE, "1,3000.2,POLYGON((1 1,5 1,5 5,1 5,1 1))",
						null, null, null, null, "8,25,125,250,500,780", null, false).features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					Double rischio = (Double)feature.getAttribute("rischio1");
					assertTrue(rischio >= 3000.2); 
					count++;
				}			
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count == 1);
			
		}
	}
	
	public void testESimulationWithRemovedTargets() throws IOException, SQLException, SchemaException {
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(getSampleData(1, 1),
						dataStoreName, null, null, null, SIMULATION_PROCESSING, /* E */
						32, ALL_TARGETS, ALL_MATERIALS, ALL_SCENARIOS,
						ALL_ENTITIES, ALL_SEVERENESS, FP_SCEN_CENTRALE, "-1,3000.2,POLYGON((1 1,5 1,5 5,1 5,1 1))",
						null, null, null, null, "8,25,125,250,500,780", null, false).features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					Double rischio = (Double)feature.getAttribute("rischio1");
					assertTrue(rischio >= 3000.2); 
					count++;
				}			
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count == 1);
			
		}
	}
	
	public void testFormula14SimulationWithChangedTargets() throws IOException, SQLException, SchemaException {
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(getSampleData(1, 1),
						dataStoreName, null, null, null, SIMULATION_PROCESSING, /* Magnitudo Ambientale */
						14, ALL_TARGETS, ALL_MATERIALS, "1",
						ALL_ENTITIES, ALL_SEVERENESS, FP_SCEN_CENTRALE, "13,3000.2,POLYGON((1 1,5 1,5 5,1 5,1 1))",
						null, null, null, null, "8,25,125,250,500,780", null, false).features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					Double rischio = (Double)feature.getAttribute("rischio1");
					assertNotNull(rischio); 
					count++;
				}			
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count == 1);
			
		}
	}
	
	public void testFormula13SimulationWithChangedTargets() throws IOException, SQLException, SchemaException {
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(getSampleData(1, 1),
						dataStoreName, null, null, null, SIMULATION_PROCESSING, /* Magnitudo Antropica */
						13, ALL_TARGETS, ALL_MATERIALS, "1",
						ALL_ENTITIES, ALL_SEVERENESS, FP_SCEN_CENTRALE, "1,3000.2,POLYGON((1 1,5 1,5 5,1 5,1 1))",
						null, null, null, null, "8,25,125,250,500,780", null, false).features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					Double rischio = (Double)feature.getAttribute("rischio1");
					assertNotNull(rischio); 
					count++;
				}			
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count == 1);
			
		}
	}
	/*public void test1() throws IOException, SQLException, SchemaException {
		
		if(riskCalculator != null && dataStoreName != null && dataStore != null) {
			
			SimpleFeatureCollection featColl = getSampleData(1, 1);//ff.less(ff.property("id_geo_arco"), ff.literal(1000)));
			
			int count = 0;
			SimpleFeatureIterator iter = null;
			try {
				iter = riskCalculator.execute(featColl, dataStoreName, null, null, null, 32, 1, 1, "9", "4,5", "0,1", "1,2,3,4", "", null, null, null, null, null).features();
				while(iter.hasNext()) {
					SimpleFeature feature = iter.next();
					assertNotNull(feature);
					count++;
				}
			} catch(ProcessException e) {
			} finally {
				if(iter != null) {
					iter.close();
				}
			}
			assertTrue(count > 0);
			
		}
	}*/

	/**
	 * @param i
	 * @param j
	 * @return
	 * @throws SchemaException 
	 */
	private SimpleFeatureCollection getSampleData(int level, int numOfFeatures) throws SchemaException {
		
		createInputType(level);
		
		SimpleFeature[] features = new SimpleFeature[numOfFeatures];
		for(int count = 0; count < numOfFeatures; count++) {
			int id = count+1;
			features[count] = DataUtilities.createFeature(inputType, id + "=" + id + "|1|0.8|2|100|0|1|1|LINESTRING(1 2,3 4,5 6)|1|S|S");
		}
		return DataUtilities.collection(features);		
	}
}
