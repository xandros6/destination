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

import it.geosolutions.destination.utils.Formula;
import it.geosolutions.destination.utils.FormulaUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geotools.data.DataStoreFinder;
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
 * WPS Process for roads depending formula calculations.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "RiskSimulator", description = "Dynamically calculates risk on road arcs.")
public class RiskSimulator extends RiskCalculatorBase {
	private static final Logger LOGGER = Logging.getLogger(RiskSimulator.class);	
	
	/**
	 * @param catalog
	 */
	public RiskSimulator(Catalog catalog) {
		super(catalog);		
	}

	@DescribeResult(description = "Risk calculus result")
	public SimpleFeatureCollection execute(	
			@DescribeParameter(name = "features", description = "Input feature collection") SimpleFeatureCollection features,
			@DescribeParameter(name = "store", description = "risk data store name", min = 0) String storeName,
			@DescribeParameter(name = "precision", description = "output value precision (decimals)", min = 0) Integer precision,
			@DescribeParameter(name = "connection", description = "risk database connection params", min = 0) String connectionParams,
			@DescribeParameter(name = "processing", description = "id of the processing type") int processing,
			@DescribeParameter(name = "formula", description = "id of the formula to calculate") int formula,
			@DescribeParameter(name = "target", description = "id of the target/s to use in calculation") int target,
			@DescribeParameter(name = "materials", description = "ids of the materials to use in calculation") String materials,
			@DescribeParameter(name = "scenarios", description = "ids of the scenarios to use in calculation") String scenarios,
			@DescribeParameter(name = "entities", description = "ids of the entities to use in calculation") String entities,
			@DescribeParameter(name = "severeness", description = "ids of the severeness to use in calculation") String severeness,
			@DescribeParameter(name = "fp", description = "fields to use for fp calculation", min = 0) String fpfield,
			
			@DescribeParameter(name = "deletedTargets", description = "optional field containing csv list of targets to be removed", min = 0) String deletedTargets,
			
			@DescribeParameter(name = "cff", description = "optional List of csv id_bersaglo,cff values to use on the simulation", min = 0) List<String> cff,
			@DescribeParameter(name = "psc", description = "optional List of csv id_sostanza,psc values to use on the simulation", min = 0) List<String> psc,
			@DescribeParameter(name = "padr", description = "optional List of csv id_sostanza,padr values to use on the simulation", min = 0) List<String> padr,
			@DescribeParameter(name = "pis", description = "optional List of csv id_geo_arco,pis values to use on the simulation", min = 0) List<String> pis

		) throws IOException, SQLException {
		
		// building DataStore connection using Catalog/storeName or connection input parameters
		JDBCDataStore dataStore = null;
		if(catalog != null && storeName != null) {
			LOGGER.info("Loading DataStore " + storeName + " from Catalog");
			DataStoreInfo dataStoreInfo = catalog.getDataStoreByName(storeName);
			if(dataStoreInfo == null) {
				LOGGER.severe("DataStore not found");
				throw new IOException("DataStore not found: " + storeName);
			}
			dataStore = (JDBCDataStore)dataStoreInfo.getDataStore(null);
		} else if(connectionParams != null) {
			dataStore = (JDBCDataStore)DataStoreFinder.getDataStore(getConnectionParameters(connectionParams));
		} else {
			throw new IOException(
					"DataStore connection not configured, either catalog, storeName or connectionParams are not available");
		}
		
		if(precision == null) {
			precision = 3;
		}
		
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
	        // fake layer name (risk) used for WPS output. Layer risk must be defined in GeoServer
	        // catalog
	        tb.setName(new NameImpl(features.getSchema().getName().getNamespaceURI(), "risk"));	        
	        SimpleFeatureType ft = tb.buildFeatureType();
	        
	        // feature level (1, 2, 3)
	        int level = FormulaUtils.getLevel(features);	       
	        
	        LOGGER.info("Doing calculus for level " + level);
	        
	        Formula formulaDescriptor = Formula.load(conn, processing, formula, target);
	        
			if ((!formulaDescriptor.hasGrid() && level == 3)
					|| (!formulaDescriptor.hasNoGrid() && level < 3)) {
	        	LOGGER.info("Formula not supported on this level, returning empty collection");				
				return new EmptyFeatureCollection(ft);
	        } else {
	        	// iterator on source
	        	SimpleFeatureIterator iter = features.features();
	        	
	        	// result builder
		        SimpleFeatureBuilder fb = new SimpleFeatureBuilder(ft);
				ListFeatureCollection result = new ListFeatureCollection(ft);
				Double[] risk = new Double[] { 0.0, 0.0 };
				
				/*if(!formulaDescriptor.useArcs()) {
					risk = getRisk(conn, level, formulaDescriptor, materials, scenarios, entities, severeness, target);
				}*/
				
				// iterate source features
				try {
					// we will calculate risk in batch of arcs
					// we store each feature of the batch in a map
					// indexed by id					
					Map<Number, SimpleFeature> temp = new HashMap<Number, SimpleFeature>();
					
					while(iter.hasNext()) {
						SimpleFeature feature = iter.next();
						Number id = (Number)feature.getAttribute("id_geo_arco");
						String fk_partner = (String)feature.getAttribute("fk_partner");
						fb.add(id);
						fb.add(feature.getDefaultGeometry());
						if(formulaDescriptor.takeFromSource()) {
							risk[0] = ((Number)feature.getAttribute("rischio1")).doubleValue();
							risk[1] = ((Number)feature.getAttribute("rischio2")).doubleValue();
						} 
						fb.add(risk[0]);
						fb.add(risk[1]);
						
						// calculate risk here only if it depends from arcs
						temp.put(id.intValue(), fb.buildFeature(id + ""));
						FormulaUtils.calculateSimulationFormulaValuesOnSingleArc(
								conn, level, processing, formulaDescriptor, id.intValue(), fk_partner,
								materials, scenarios, entities, severeness, fpfield, target, null, 
								temp, precision,
								null, psc, null, null, null, false);								
						result.addAll(temp.values());
						temp = new HashMap<Number, SimpleFeature>();								
					}
					LOGGER.info("Calculated " + result.size() + " values");
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

}
