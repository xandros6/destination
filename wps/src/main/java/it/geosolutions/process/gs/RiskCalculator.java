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

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.collection.ListFeatureCollection;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.data.store.EmptyFeatureCollection;
import org.geotools.feature.NameImpl;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.util.logging.Logging;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;

import com.vividsolutions.jts.geom.MultiLineString;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "RiskCalculator", description = "Dynamically calculates risk on road arcs.")
public class RiskCalculator extends RiskCalculatorBase {
	private static final Logger LOGGER = Logging.getLogger(RiskCalculator.class);
	
	
	
	
	
	
	
	/**
	 * @param catalog
	 */
	public RiskCalculator(Catalog catalog) {
		super(catalog);		
	}

	@DescribeResult(description = "Risk calculus result")
	public SimpleFeatureCollection execute(
			@DescribeParameter(name = "features", description = "Input feature collection") SimpleFeatureCollection features,
			@DescribeParameter(name = "store", description = "risk data store name") String storeName,
			@DescribeParameter(name = "formula", description = "id of the formula to calculate") int formula,
			@DescribeParameter(name = "target", description = "id of the target/s to use in calculation") int target,
			@DescribeParameter(name = "materials", description = "ids of the materials to use in calculation") String materials,
			@DescribeParameter(name = "scenarios", description = "ids of the scenarios to use in calculation") String scenarios,
			@DescribeParameter(name = "entities", description = "ids of the entities to use in calculation") String entities,
			@DescribeParameter(name = "severeness", description = "ids of the severeness to use in calculation") String severeness
		) throws IOException, SQLException {
		
		DataStoreInfo dataStoreInfo = catalog.getDataStoreByName(storeName);
		if(dataStoreInfo == null) {
			throw new IOException("DataStore not found: " + storeName);
		}
		JDBCDataStore dataStore = (JDBCDataStore)dataStoreInfo.getDataStore(null);
		DefaultTransaction transaction = new DefaultTransaction();
		Connection conn = null;
		try {
			 conn = dataStore.getConnection(transaction);
			 
			// output FeatureType (risk)
			//  - id_geo_arco
			//  - geometria
			//  - rischio1
			//  - rischio2
			SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();									
			tb.add("id_geo_arco", features.getSchema().getDescriptor("id_geo_arco").getType().getBinding());
			tb.add("geometria", MultiLineString.class,features.getSchema().getGeometryDescriptor().getCoordinateReferenceSystem());
	        tb.add("rischio1", Double.class);			
	        tb.add("rischio2", Double.class);
	        tb.setName(new NameImpl(features.getSchema().getName().getNamespaceURI(), "risk"));	        
	        SimpleFeatureType ft = tb.buildFeatureType();
	        
	        // feature level (1, 2, 3)
	        int level = getLevel(features);	       
	        
	        Formula formulaDescriptor = loadFormula(conn, formula, target);
	        
	        if((!formulaDescriptor.hasGrid() && level == 3) || (!formulaDescriptor.hasNoGrid() && level < 3)) {
				// grid not supported -> empty feature
				return new EmptyFeatureCollection(ft);
	        } else {
	        	// iterator on source
	        	SimpleFeatureIterator iter = features.features();
	        	
	        	// result builder
		        SimpleFeatureBuilder fb = new SimpleFeatureBuilder(ft);
				ListFeatureCollection result = new ListFeatureCollection(ft);
				int count = 0;				
				Double[] risk = new Double[] { 0.0, 0.0 };
				
				if(!formulaDescriptor.useArcs()) {
					risk = getRisk(conn, level, formulaDescriptor, materials, scenarios, entities, severeness, target);
				}
				
				// iterate source features
				try {
					// we will calculate risk in batch of arcs
					// we store each feature of the batch in a map
					// indexed by id					
					Map<Number, SimpleFeature> temp = new HashMap<Number, SimpleFeature>();
					// ids will store the list of id of each batch
					// used to build risk query
					StringBuilder ids = new StringBuilder();
					
					while(iter.hasNext()) {
						SimpleFeature feature = iter.next();
						Number id = (Number)feature.getAttribute("id_geo_arco");
						fb.add(id);
						fb.add(feature.getDefaultGeometry());
						if(formulaDescriptor.takeFromSource()) {
							risk[0] = ((Number)feature.getAttribute("rischio1")).doubleValue();
							risk[1] = ((Number)feature.getAttribute("rischio2")).doubleValue();
						} 
						fb.add(risk[0]);
						fb.add(risk[1]);
						
						
						// calculate risk here only if it depends from arcs
						if(formulaDescriptor.useArcs()) {
							ids.append(","+id);
							temp.put(id.intValue(), fb.buildFeature(id + ""));
							count++;
							if(count % 10000 == 0) {
								getRisk(conn, level, formulaDescriptor, ids.toString()
										.substring(1), materials, scenarios,
										entities, severeness, target, temp);								
								result.addAll(temp.values());
								ids = new StringBuilder();
								temp = new HashMap<Number, SimpleFeature>();								
							}	
						} else {
							result.add(fb.buildFeature(id + ""));
						}
					}
					if(formulaDescriptor.useArcs() && ids.length() > 0) {
						getRisk(conn, level, formulaDescriptor, ids.toString()
								.substring(1), materials, scenarios, entities,
								severeness, target, temp);
					}
					result.addAll(temp.values());
				} finally {
					iter.close();
				}
				return result;
	        }
 			
		} finally {				
			transaction.close();
			if(conn != null) {
				conn.close();
			}
		}
		
	}

	/**
	 * Risk Calculator for formulas that depend on arcs.
	 * 
	 * @param conn
	 * @param formulaDescriptor
	 * @param substring
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param temp
	 * @throws SQLException 
	 */
	private void getRisk(Connection conn, int level, Formula formulaDescriptor,
			String ids, String materials, String scenarios,
			String entities, String severeness, int target, Map<Number, SimpleFeature> features) throws SQLException {
	
		String sql = formulaDescriptor.getSql();
		
		if(isSimpleTarget(target) || !formulaDescriptor.useTargets()) {
			getRisk(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio1", target + "", features);
		} else if(isAllHumanTargets(target)) {
			getRisk(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio1", "1,2,4,5,6,7", features);
		} else if(isAllNotHumanTargets(target)) {
			getRisk(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio1", "10,11,12,13,14,15,16", features);			
		} else if(isAllTargets(target)) {			
			getRisk(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio1", "1,2,4,5,6,7", features);
			getRisk(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio2", "10,11,12,13,14,15,16", features);
		}				
	}

	

	
	

	

	

	/**
	 * @param features
	 * @return
	 */
	private int getLevel(SimpleFeatureCollection features) {
		String typeName = features.getSchema().getTypeName();
		if(typeName.contains("1")) {
			return 1;
		}
		if(typeName.contains("2")) {
			return 2;
		}
		if(typeName.contains("3") || typeName.contains("grid")) {
			return 3;
		}
		return 0;
	}
}
