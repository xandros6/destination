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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geotools.data.DefaultTransaction;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.util.logging.Logging;

/**
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
			Formula formulaDescriptor = loadFormula(conn, formula, target);
			fillWithCriterias(conn, formula, formulaDescriptor);
			JSONObject result = new JSONObject();
			String[] targetsList;
			
			if(!isSimpleTarget(target) && !formulaDescriptor.aggregateTargets()) {								
				if(isAllNotHumanTargets(target)) {
					targetsList = notHumanTargetsList.split(",");					
				} else {
					targetsList = humanTargetsList.split(",");
				}
				
			} else {
				targetsList = new String[] {target +""};				
			}
			getRiskForAllTargets(conn, formulaDescriptor, materials, scenarios, entities, severeness, targetsList, result);		
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
	private void getRiskForAllTargets(Connection conn, 
			Formula formulaDescriptor, String materials, String scenarios,
			String entities, String severeness, String[] targets, JSONObject result) throws NumberFormatException, SQLException {
		JSONArray targetsArray = new JSONArray();
		
		for(String target : targets) {
			int targetId = Integer.parseInt(target);	
			JSONObject targetObj = new JSONObject();
			targetObj.accumulate("id", targetId);
			
			if(!formulaDescriptor.aggregateScenarios()) {										
					getRiskForAllScenarios(conn, formulaDescriptor,
							materials, scenarios.split(","), entities,
							severeness, targetId, targetObj);								
			} else {
				getRiskForAllScenarios(conn, formulaDescriptor,
						materials, new String[] {scenarios}, entities,
						severeness, targetId, targetObj);			
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
	private void getRiskForAllScenarios(Connection conn,
			Formula formulaDescriptor, String materials, String[] scenarios,
			String entities, String severeness, int targetId, JSONObject result) throws SQLException {
		JSONArray scenariosArray = new JSONArray();
		
		for(String scenario : scenarios) {			
			JSONObject scenarioObj = new JSONObject();
			scenarioObj.accumulate("id", scenario);			
			if(!formulaDescriptor.aggregateSevereness()) {
				getRiskForAllSevereness(conn, formulaDescriptor,
						materials, scenario, entities,
						severeness.split(","), targetId, scenarioObj);		
			} else {
				getRiskForAllSevereness(conn, formulaDescriptor,
						materials, scenario, entities,
						new String[] {severeness}, targetId, scenarioObj);
			}
			//fillRisk(scenarioObj, getRisk(conn, 0, formulaDescriptor, materials, scenario, entities, severeness, targetId));
			scenariosArray.add(scenarioObj);
		}
		result.accumulate("scenarios", scenariosArray);
		
	}
	
	private void getRiskForAllSevereness(Connection conn,
			Formula formulaDescriptor, String materials, String scenario,
			String entities, String[] severeness, int targetId, JSONObject result) throws SQLException {
		JSONArray severenessArray = new JSONArray();
		
		for(String sev : severeness) {			
			JSONObject severenessObj = new JSONObject();
			severenessObj.accumulate("id", sev);			
			
			fillRisk(severenessObj, getRisk(conn, 0, formulaDescriptor, materials, scenario, entities, sev, targetId));
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
