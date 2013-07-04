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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Logger;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geotools.data.DataStoreFinder;
import org.geotools.data.DefaultTransaction;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.util.logging.Logging;

/**
 * WPS Process for no roads depending formula calculations.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "RiskCalculatorSimple", description = "Dynamically calculates risk not depending road arcs.")
public class RiskCalculatorSimple extends RiskCalculatorBase {
	private static final Logger LOGGER = Logging.getLogger(RiskCalculatorSimple.class);

	/**
	 * @param catalog
	 */
	public RiskCalculatorSimple(Catalog catalog) {
		super(catalog);		
	}
	
	@DescribeResult(description = "Risk calculus result")
	public String execute(			
			@DescribeParameter(name = "store", description = "risk data store name") String storeName,
			@DescribeParameter(name = "batch", description = "batch calculus size", min = 0) Integer batch,
			@DescribeParameter(name = "precision", description = "output value precision (decimals)", min = 0) Integer precision,
			@DescribeParameter(name = "connection", description = "risk database connection params", min = 0) Map<String, String> connectionParams,
			@DescribeParameter(name = "formula", description = "id of the formula to calculate") int formula,
			@DescribeParameter(name = "target", description = "id of the target/s to use in calculation") int target,
			@DescribeParameter(name = "materials", description = "ids of the materials to use in calculation") String materials,
			@DescribeParameter(name = "scenarios", description = "ids of the scenarios to use in calculation") String scenarios,
			@DescribeParameter(name = "entities", description = "ids of the entities to use in calculation") String entities,
			@DescribeParameter(name = "severeness", description = "ids of the severeness to use in calculation") String severeness
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
			dataStore = (JDBCDataStore)DataStoreFinder.getDataStore(connectionParams);
		} else {
			throw new IOException(
					"DataStore connection not configured, either catalog, storeName or connectionParams are not available");
		}
		
		if(batch == null) {
			batch = 10000;
		}
		if(precision == null) {
			precision = 3;
		}
		DefaultTransaction transaction = new DefaultTransaction();
		Connection conn = null;
		try {
			conn = dataStore.getConnection(transaction);
			Formula formulaDescriptor = Formula.load(conn, formula, target);
			fillWithCriterias(conn, formula, formulaDescriptor);
			JSONObject result = new JSONObject();
			String[] targetsList;
			
			if(!FormulaUtils.isSimpleTarget(target) && !formulaDescriptor.aggregateTargets()) {								
				if(FormulaUtils.isAllNotHumanTargets(target)) {
					targetsList = FormulaUtils.notHumanTargetsList.split(",");					
				} else {
					targetsList = FormulaUtils.humanTargetsList.split(",");
				}
				
			} else {
				targetsList = new String[] {target +""};				
			}
			calculateFormulaForAllTargets(conn, formulaDescriptor, materials, scenarios, entities, severeness, targetsList, result, precision);		
			return result.toString();
		} finally {				
			transaction.close();
			if(conn != null) {
				conn.close();
			}
		}
	}

	/**
	 * @param result
	 * @param risk
	 */
	private void fillRisk(JSONObject result, Double[] risk) {
		JSONArray riskArray = new JSONArray();
		for(double riskVal : risk) {
			riskArray.add(riskVal);
		}
		result.accumulate("risk", riskArray);		
	}

	/**
	 * @param conn
	 * @param formulaDescriptor
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param targetsList
	 * @throws SQLException 
	 * @throws NumberFormatException 
	 */
	private void calculateFormulaForAllTargets(Connection conn, 
			Formula formulaDescriptor, String materials, String scenarios,
			String entities, String severeness, String[] targets, JSONObject result, int precision) throws NumberFormatException, SQLException {
		JSONArray targetsArray = new JSONArray();
		
		for(String target : targets) {
			int targetId = Integer.parseInt(target);	
			JSONObject targetObj = new JSONObject();
			targetObj.accumulate("id", targetId);
			
			if(!formulaDescriptor.aggregateScenarios()) {										
					calculateFormulaForAllScenarios(conn, formulaDescriptor,
							materials, scenarios.split(","), entities,
							severeness, targetId, targetObj, precision);								
			} else {
				calculateFormulaForAllScenarios(conn, formulaDescriptor,
						materials, new String[] {scenarios}, entities,
						severeness, targetId, targetObj, precision);			
				//fillRisk(targetObj, getRisk(conn, 0, formulaDescriptor, materials, scenarios, entities, severeness, targetId));
			}
			targetsArray.add(targetObj);
		}
		result.accumulate("targets", targetsArray);
		
	}

	/**
	 * @param conn
	 * @param formulaDescriptor
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param targetId
	 * @return
	 * @throws SQLException 
	 */
	private void calculateFormulaForAllScenarios(Connection conn,
			Formula formulaDescriptor, String materials, String[] scenarios,
			String entities, String severeness, int targetId, JSONObject result, int precision) throws SQLException {
		JSONArray scenariosArray = new JSONArray();
		
		for(String scenario : scenarios) {			
			JSONObject scenarioObj = new JSONObject();
			scenarioObj.accumulate("id", scenario);			
			if(!formulaDescriptor.aggregateSevereness()) {
				calculateFormulaAllSevereness(conn, formulaDescriptor,
						materials, scenario, entities,
						severeness.split(","), targetId, scenarioObj, precision);		
			} else {
				calculateFormulaAllSevereness(conn, formulaDescriptor,
						materials, scenario, entities,
						new String[] {severeness}, targetId, scenarioObj, precision);
			}
			//fillRisk(scenarioObj, getRisk(conn, 0, formulaDescriptor, materials, scenario, entities, severeness, targetId));
			scenariosArray.add(scenarioObj);
		}
		result.accumulate("scenarios", scenariosArray);
		
	}
	
	private void calculateFormulaAllSevereness(Connection conn,
			Formula formulaDescriptor, String materials, String scenario,
			String entities, String[] severeness, int targetId, JSONObject result, int precision) throws SQLException {
		JSONArray severenessArray = new JSONArray();
		
		for(String sev : severeness) {			
			JSONObject severenessObj = new JSONObject();
			severenessObj.accumulate("id", sev);			
			
			fillRisk(severenessObj, FormulaUtils.calculateFormulaValues(conn, 0, formulaDescriptor, materials, scenario, entities, sev, targetId, precision));
			severenessArray.add(severenessObj);
		}
		result.accumulate("severeness", severenessArray);
		
	}

	/**
	 * @param conn
	 * @param formulaDescriptor
	 * @throws SQLException 
	 */
	private void fillWithCriterias(Connection conn, int formula, Formula formulaDescriptor) throws SQLException {		
		String sql =  "select id_criterio, flg_obbligatorio, flg_aggregabile ";
	       sql += "from siig_mtd_r_formula_criterio ";	       
	       sql += "where id_formula=?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, formula);		
			rs = stmt.executeQuery();			
			while(rs.next()) {
				formulaDescriptor.addCriteria(rs.getInt(1), rs.getInt(2) == 1, rs.getInt(3) == 1);								
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
	
}
