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

import it.geosolutions.destination.utils.BufferUtils;
import it.geosolutions.destination.utils.Formula;
import it.geosolutions.destination.utils.FormulaUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.geotools.process.ProcessException;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.util.logging.Logging;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.MultiLineString;
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;

/**
 * WPS Process for roads depending formula calculations.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "RiskCalculator", description = "Dynamically calculates risk on road arcs.")
public class RiskCalculator extends RiskCalculatorBase {
	private static final Logger LOGGER = Logging.getLogger(RiskCalculator.class);	
	private static final WKTReader wktReader = new WKTReader();
	/**
	 * @param catalog
	 */
	public RiskCalculator(Catalog catalog) {
		super(catalog);		
	}

	public static class TargetInfo {
		private int id;
		private int type;
		private Geometry geometry;
		private double value;
		private double area = -1.0;
		private boolean removed = false;
		/**
		 * @param type
		 * @param geometry
		 * @param value
		 */
		public TargetInfo(int type, Geometry geometry, double value) {
			super();
			this.type = Math.abs(type);
			this.geometry = geometry;
			this.value = value;
			if(type < 0) {
				removed = true;
			}
		}
		
		public TargetInfo(int id, int type, Geometry geometry, double value) {
			super();
			this.id = id;
			this.type = Math.abs(type);
			this.geometry = geometry;
			this.value = value;
			if(type < 0) {
				removed = true;
			}
		}
		
		/**
		 * @return the id
		 */
		public int getId() {
			return id;
		}

		/**
		 * @param id the id to set
		 */
		public void setId(int id) {
			this.id = id;
		}



		/**
		 * @return the type
		 */
		public int getType() {
			return type;
		}
		/**
		 * @return the geometry
		 */
		public Geometry getGeometry() {
			return geometry;
		}
		/**
		 * @return the value
		 */
		public double getValue() {
			return value;
		}
		
		public double getArea() {
			if(area == -1.0 && geometry != null) {
				area = geometry.getArea();
			}
			return area;
		}
		
		public boolean isHuman() {
			return FormulaUtils.checkTarget(type, FormulaUtils.humanTargetsList);
		}
		
		public boolean isRemoved() {
			return removed;
		}
		
		public boolean isNew() {
			return id == 0;
		}
	}
	
	@DescribeResult(description = "Risk calculus result")
	public SimpleFeatureCollection execute(
			@DescribeParameter(name = "features", description = "Input feature collection") SimpleFeatureCollection features,
			@DescribeParameter(name = "store", description = "risk data store name", min = 0) String storeName,
			@DescribeParameter(name = "batch", description = "batch calculus size", min = 0) Integer batch,
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
			@DescribeParameter(name = "changedTargets", description = "optional field containing csv list of targets to be removed, added, changed or an id for the ProcessingRepository storing the same data", min = 0) String changedTargets,			
			
			@DescribeParameter(name = "cff", description = "optional List (_ delimited) of csv id_geo_arco,id_bersaglo,cff values to use on the simulation", min = 0) String cff,
			@DescribeParameter(name = "psc", description = "optional List (_ delimited) of csv id_sostanza,psc values to use on the simulation", min = 0) String psc,
			@DescribeParameter(name = "padr", description = "optional List (_ delimited) of csv id_geo_arco,id_sostanza,padr values to use on the simulation", min = 0) String padr,
			@DescribeParameter(name = "pis", description = "optional List (_ delimited) of csv id_geo_arco,pis values to use on the simulation", min = 0) String pis,
			@DescribeParameter(name = "distances", description = "optional list of distances for the simulation processing", min = 0) String distances,
			
			@DescribeParameter(name = "damageArea", description = "optional field containing damage area geometry or an id for the ProcessingRepository storing the same data", min = 0) String damageArea

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
		
		if(features == null) {
			throw new ProcessException("Missing input feature");
		}
		
		if(processing == 3) {
			
			List<String> pscs = new ArrayList<String>();
			if(psc != null) {
				pscs =Arrays.asList(psc.split("_"));
			}
			Map<Integer, Map<Integer, Double>> padrs = new HashMap<Integer, Map<Integer, Double>>();
			if(padr != null && !padr.equals("")) {
				loadSimulationMultipleValues(padrs, padr);
			}
			Map<Integer, Map<Integer, Double>> cffs = new HashMap<Integer, Map<Integer, Double>>();
			if(cff != null && !cff.equals("")) {
				loadSimulationMultipleValues(cffs, cff);
			}
			Map<Integer, Double> piss = new HashMap<Integer, Double>();
			if(pis != null && !pis.equals("")) {
				loadSimulationPis(piss, pis);				
			}
			List<TargetInfo> simulationTargets = new ArrayList<TargetInfo>();
			if(changedTargets != null && !changedTargets.equals("")) {
				try {
					loadSimulationTargets(dataStore, simulationTargets, changedTargets);
				} catch (ParseException e) {
					throw new ProcessException("Error reading targets WKT", e);
				}				
			}
			List<Integer> distancesList = new ArrayList<Integer>();
			if(distances != null && !distances.equals("")) {
				loadDistances(distancesList, distances);
			}
			return calculateRisk(features, dataStore, storeName, precision, connectionParams,
					processing, formula, target, materials, scenarios,
					entities, severeness, fpfield, 1, true, null, null, simulationTargets, cffs, pscs,
					padrs, piss, distancesList);
		} else if(processing == 4){
			try {
				Geometry damageAreaGeometry = loadDamageArea(dataStore, damageArea);
				Map<Integer, Double> damageValues = calculateDamageValues(dataStore, damageAreaGeometry, target);
				return calculateRisk(features, dataStore, storeName, precision, connectionParams,
						processing, formula, target, materials, scenarios,
						entities, severeness, fpfield, 1, false, damageAreaGeometry, damageValues, null, null, null,
						null, null, null);
			} catch (ParseException e) {
				throw new ProcessException("Error reading targets WKT", e);
			}
			
		} else {
	
			if(batch == null) {
				batch = 10000;
			}
			
			return calculateRisk(features, dataStore, storeName, precision, connectionParams,
					processing, formula, target, materials, scenarios,
					entities, severeness, fpfield, batch, false, null, null, null, null, null,
					null, null, null);
						
		}
		
	}

	/**
	 * @param dataStore
	 * @param damageArea
	 * @param target
	 * @return
	 * @throws IOException 
	 * @throws SQLException 
	 */
	public static Map<Integer, Double> calculateDamageValues(
			JDBCDataStore dataStore, Geometry damageArea, int target) throws IOException, SQLException {
		String wkt = damageArea.toText();
		DefaultTransaction transaction = new DefaultTransaction();
		Connection conn = null;
		Map<Integer, Double> damageValues = new HashMap<Integer, Double>();
		try {
			 conn = dataStore.getConnection(transaction);
			 
			 if(FormulaUtils.isSimpleTarget(target)) {
				 if(FormulaUtils.checkTarget(target, FormulaUtils.humanTargetsList)) {
					 addDamageValuesByField(damageValues, conn, target + "", wkt);
				 } else {
					 addDamageValuesByArea(damageValues, conn, target + "", wkt);
				 }
				 
			 } else if(FormulaUtils.isAllHumanTargets(target)) {
				 addDamageValuesByField(damageValues, conn, FormulaUtils.humanTargetsList, wkt);
			 } else if(FormulaUtils.isAllNotHumanTargets(target)) {
				 addDamageValuesByArea(damageValues, conn, FormulaUtils.notHumanTargetsList, wkt);
			 } else {
				 addDamageValuesByField(damageValues, conn, FormulaUtils.humanTargetsList, wkt);
				 addDamageValuesByArea(damageValues, conn, FormulaUtils.notHumanTargetsList, wkt);
			 }
			 
			 return damageValues;
		} catch(SQLException e) {
			throw new ProcessException(e);
		} finally {
			transaction.close();
			if(conn != null) {
				conn.close();
			}
		}
	}

	/**
	 * @param damageValues
	 * @param conn
	 * @param strings
	 * @throws SQLException 
	 */
	private static void addDamageValuesByArea(
			Map<Integer, Double> damageValues, Connection conn,
			String targets, String wkt) throws SQLException {
		
		String sql = "select id_bersaglio,ST_Area(ST_Intersection(geometria,ST_GeomFromText('" + wkt + "','32632'))) from v_geo_bersagli_ambientali where st_intersects(geometria,ST_GeomFromText('" + wkt + "','32632')) and id_bersaglio in(" + targets + ")";
		
		addDamageValue(damageValues, conn, sql);
	}

	/**
	 * @param damageValues
	 * @param conn
	 * @param sql
	 * @throws SQLException
	 */
	private static void addDamageValue(Map<Integer, Double> damageValues,
			Connection conn, String sql) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();				
			while(rs.next()) {
				Integer idBersaglio = rs.getInt(1);
				Double value = rs.getDouble(2);
				if(damageValues.containsKey(idBersaglio)) {
					Double oldValue = damageValues.get(idBersaglio);
					damageValues.put(idBersaglio, oldValue + value);
				} else {
					damageValues.put(idBersaglio, value);
				}
			}
			
		} finally {
			if(rs != null) {
				rs.close();				
			}
			if(stmt != null) {
				stmt.close();
			}
			
		}
	}

	/**
	 * @param damageValues
	 * @param conn
	 * @param strings
	 * @throws SQLException 
	 */
	private static void addDamageValuesByField(
			Map<Integer, Double> damageValues, Connection conn,
			String targets, String wkt) throws SQLException {
		String sql = "select id_bersaglio,umani from v_geo_bersagli_umani where st_intersects(geometria,ST_GeomFromText('" + wkt + "','32632')) and id_bersaglio in(" + targets + ")";
		
		addDamageValue(damageValues, conn, sql);
	}

	/**
	 * @param dataStore
	 * @param damageArea
	 * @return
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws ParseException 
	 */
	private Geometry loadDamageArea(JDBCDataStore dataStore, String damageArea) throws IOException, SQLException, ParseException {
		if(damageArea.matches("^[0-9]+$")) {
			int id = Integer.parseInt(damageArea);
			damageArea = ProcessingRepository.loadData(dataStore, -1, id);
		} 
		return wktReader.read(damageArea);		
	}

	/**
	 * @param distancesList
	 * @param distances
	 */
	private void loadDistances(List<Integer> distancesList, String distances) {
		for(String distance : distances.split(",")) {
			distancesList.add(Integer.parseInt(distance));
		}
	}

	/**
	 * @param simulationTargets
	 * @param changedTargets
	 * @throws ParseException 
	 * @throws SQLException 
	 * @throws IOException 
	 */
	public static void loadSimulationTargets(
			JDBCDataStore dataStore,
			List<TargetInfo> valuesMap,
			String valuesList) throws ParseException, IOException, SQLException {
		if(valuesList.matches("^[0-9]+$")) {
			int id = Integer.parseInt(valuesList);
			valuesList = ProcessingRepository.loadData(dataStore, -1, id);
		} 
		for(String record : valuesList.split("_")) {
			String[] parts = record.split(",");
			int id = Integer.parseInt(parts[0]);
			double value = Double.parseDouble(parts[1]);
			String geometry = parts[2];
			for(int count = 3; count< parts.length; count++) {
				geometry += ","+parts[count];
			}
			if(geometry != null && !geometry.equals("")) {
				valuesMap.add(new TargetInfo(id,wktReader.read(geometry),value));
			}
		}	
		  
	}

	/**
	 * @param padrs
	 * @param padr
	 */
	private void loadSimulationMultipleValues(Map<Integer, Map<Integer, Double>> valuesMap,
			String valuesList) {
		for(String record : valuesList.split("_")) {
			String[] parts = record.split(",");
			int id = Integer.parseInt(parts[0]);
			int subid = Integer.parseInt(parts[1]);
			double value = Double.parseDouble(parts[2]);
			Map<Integer, Double> values = valuesMap.get(id);
			if(values == null) {
				values = new HashMap<Integer, Double>();
				valuesMap.put(id, values);
			}
			values.put(subid, value);
		}	
	}

	/**
	 * @param pis
	 * @param pis2
	 */
	private void loadSimulationPis(Map <Integer, Double> piss, String pis) {
		for(String record : pis.split("_")) {
			String[] parts = record.split(",");
			int id = Integer.parseInt(parts[0]);
			double value = Double.parseDouble(parts[1]);
			piss.put(id, value);
		}		
	}

	private SimpleFeatureCollection calculateRisk(	
			SimpleFeatureCollection features,
			JDBCDataStore dataStore,
			String storeName,
			Integer precision,
			String connectionParams,
			int processing,
			int formula,
			int target,
			String materials,
			String scenarios,
			String entities,
			String severeness,
			String fpfield,
			int batch,
			boolean simulation,
			Geometry damageArea,
			Map<Integer, Double> damageValues,
			List<TargetInfo> changedTargets,
			Map<Integer, Map<Integer, Double>> cffs,
			List<String> psc,
			Map<Integer, Map<Integer, Double>> padrs,
			Map<Integer, Double> piss,
			List<Integer> distances
		) throws IOException, SQLException {
		
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
	        
	        if(formulaDescriptor == null) {
	        	throw new ProcessException("Unable to load formula " + formula);
	        }
	        
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
				int count = 0;
				Double[] risk = new Double[] { 0.0, 0.0 };
				
				// iterate source features
				try {
					// we will calculate risk in batch of arcs
					// we store each feature of the batch in a map
					// indexed by id					
					Map<Number, SimpleFeature> temp = new HashMap<Number, SimpleFeature>();
					StringBuilder ids = new StringBuilder();
					String fk_partner = null;
					
					while(iter.hasNext()) {
						SimpleFeature feature = iter.next();
						Number id = (Number)feature.getAttribute("id_geo_arco");
						fk_partner = (String)feature.getAttribute("fk_partner");
						fb.add(id);
						fb.add(feature.getDefaultGeometry());
						if(formulaDescriptor.takeFromSource()) {
							risk[0] = ((Number)feature.getAttribute("rischio1")).doubleValue();
							risk[1] = ((Number)feature.getAttribute("rischio2")).doubleValue();
						} 
						fb.add(risk[0]);
						fb.add(risk[1]);
												
						temp.put(id.intValue(), fb.buildFeature(id + ""));						
							
						if(simulation) {
							Double pis = piss.get(id.intValue());
							Map<Integer, Double> padr = padrs.get(id.intValue()); 
							Map<Integer, Double> cff = cffs.get(id.intValue());
							
							Map<Integer, Map<Integer, Double>> simulationTargets  = new HashMap<Integer, Map<Integer, Double>>();
							
							
							if(!changedTargets.isEmpty()) {
								for(int distance : distances) {
									Geometry buffer = BufferUtils.iterativeBuffer((Geometry)feature.getDefaultGeometry(), (double)distance, 100);
									for(TargetInfo targetInfo : changedTargets) {
										if(targetInfo.getGeometry() != null) {
											Geometry intersection = buffer.intersection(targetInfo.getGeometry());
											if(intersection != null && intersection.getArea()>0) {
												Map<Integer, Double> distancesMap = simulationTargets.get(targetInfo.getType());
												if(distancesMap == null) {
													distancesMap = new HashMap<Integer, Double>();
													simulationTargets.put(targetInfo.getType(), distancesMap);
												}
												double value = 0.0;
												if(targetInfo.isHuman()) {
													value = intersection.getArea() / targetInfo.getGeometry().getArea() * targetInfo.getValue();
												} else {
													value = intersection.getArea();
												}
												if(targetInfo.isRemoved()) {
													value = - value;
												}
												distancesMap.put(distance, value);
											}
										}
									}
								}
							}
							
							FormulaUtils.calculateSimulationFormulaValuesOnSingleArc(
									conn, level, processing, formulaDescriptor, id.intValue(), fk_partner,
									materials, scenarios, entities, severeness, fpfield, target, simulationTargets, 
									temp, precision,
									cff, psc, padr, pis, null);
							
							result.addAll(temp.values());
							temp = new HashMap<Number, SimpleFeature>();	
						} else if(damageArea != null){
							Geometry arcGeometry = (Geometry)feature.getDefaultGeometry();
							if(arcGeometry != null && arcGeometry.intersects(damageArea)) {
								FormulaUtils.calculateSimulationFormulaValuesOnSingleArc(
										conn, level, processing, formulaDescriptor, id.intValue(), fk_partner,
										materials, scenarios, entities, severeness, fpfield, target, null, 
										temp, precision,
										null, null, null, null, damageValues);
								result.addAll(temp.values());								
							}
							temp = new HashMap<Number, SimpleFeature>();
						} else {							
							ids.append(","+id);
							count++;
							// calculate batch items a time 
							if(count % batch == 0) {
								LOGGER.info("Calculated " + count + " values");
								FormulaUtils.calculateFormulaValues(conn, level, processing, formulaDescriptor, ids.toString()
										.substring(1), fk_partner, materials, scenarios,
										entities, severeness, fpfield, target, temp, precision);								
								result.addAll(temp.values());
								ids = new StringBuilder();
								temp = new HashMap<Number, SimpleFeature>();								
							}
						}
													
					}
					
					// final calculus for remaining items not in batch size
					LOGGER.info("Calculating remaining items");
					if(ids.length() > 0) {
						FormulaUtils.calculateFormulaValues(conn, level, processing, formulaDescriptor, ids.toString()
								.substring(1), fk_partner, materials, scenarios, entities,
								severeness, fpfield, target, temp, precision);
					}					
					result.addAll(temp.values());
					
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
