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
package it.geosolutions.destination.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.geotools.data.simple.SimpleFeatureCollection;
import org.opengis.feature.simple.SimpleFeature;

/**
 * Utility methods for risk formulas building.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class FormulaUtils {
	
	/** notHumanTargetsList */
	public static final String notHumanTargetsList = "10,11,12,13,14,15,16";
	/** humanTargetsList */
	public static final String humanTargetsList = "1,2,4,5,6,7";
	
	/**
	 * Checks that a given target is included in a comma delimited list.
	 * 
	 * @param target
	 * @param targets
	 * @return
	 */
	public static boolean checkTarget(int target, String targets) {
		return (","+targets+",").contains(","+target+",");
	}
	
	/**
	 * User chose "all targets".
	 * 
	 * @param target
	 * @return
	 */
	public static boolean isAllTargets(int target) {
		// TODO: find a better representation
		return target == 100;
	}

	/**
	 * User chose "all not human targets".
	 * 
	 * @param target
	 * @return
	 */
	public static boolean isAllNotHumanTargets(int target) {
		// TODO: find a better representation
		return target == 99;
	}

	/**
	 * User chose "all human targets".
	 * 
	 * @param target
	 * @return
	 */
	public static boolean isAllHumanTargets(int target) {
		// TODO: find a better representation
		return target == 98;
	}

	/**
	 * User chose a specific target.
	 * 
	 * @param target
	 * @return
	 */
	public static boolean isSimpleTarget(int target) {
		return !isAllHumanTargets(target) && !isAllNotHumanTargets(target)
				&& !isAllTargets(target);
	}
	
	/**
	 * Gets the current detail level from the input feature
	 * @param features
	 * @return
	 */
	public static int getLevel(SimpleFeatureCollection features) {
		String typeName = features.getSchema().getTypeName();
		if(typeName.contains("1")) {
			return 1;
		}
		if(typeName.contains("2")) {
			return 2;
		}
		// TODO: grid should not be useful anymore
		if(typeName.contains("3") || typeName.contains("grid")) {
			return 3;
		}
		return 0;
	}
	
	/**
	 * Calculates one or more formula values, for the given comma delimited id list.
	 * Translates the given target number into the final list of targets (taking into
	 * account groups of targets).
	 * When all targets are selected a couple of values is calculated (for humans and
	 * not humans targets), in all other cases, just one is enough.
	 * 
	 * @param conn
	 * @param level
	 * @param formulaDescriptor
	 * @param ids
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param target
	 * @param features
	 * @param precision
	 * @throws SQLException
	 */
	public static void calculateFormulaValues(Connection conn, int level,
			Formula formulaDescriptor, String ids, String materials,
			String scenarios, String entities, String severeness, int target,
			Map<Number, SimpleFeature> features, int precision)
			throws SQLException {
	
		String sql = formulaDescriptor.getSql();
		
		if(isSimpleTarget(target) || !formulaDescriptor.useTargets()) {
			calculateFormulaValues(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio1", target + "", features, precision);
		} else if(isAllHumanTargets(target)) {
			calculateFormulaValues(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio1", "1,2,4,5,6,7", features, precision);
		} else if(isAllNotHumanTargets(target)) {
			calculateFormulaValues(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio1", "10,11,12,13,14,15,16", features, precision);			
		} else if(isAllTargets(target)) {			
			calculateFormulaValues(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio1", "1,2,4,5,6,7", features, precision);
			calculateFormulaValues(conn, level, formulaDescriptor, ids, materials, scenarios,
					entities, severeness, sql, "rischio2", "10,11,12,13,14,15,16", features, precision);
		}				
	}
	
	/**
	 * Risk Calculator for formulas that don't depend on arcs.
	 * 
	 * @param conn
	 * @param formulaDescriptor
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param target
	 * @return
	 * @throws SQLException 
	 */
	public static Double[] calculateFormulaValues(Connection conn, int level, Formula formulaDescriptor,
			String materials, String scenarios, String entities,
			String severeness, int target, int precision) throws SQLException {

		String sql = formulaDescriptor.getSql();
		if(!formulaDescriptor.takeFromSource()) {
			if(isSimpleTarget(target) || !formulaDescriptor.useTargets()) {
				return new Double[] {calculateFormulaValues(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", target + "",
						null, precision).doubleValue(), 0.0};
				
			} else if(isAllHumanTargets(target)) {
				return new Double[] {calculateFormulaValues(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", humanTargetsList,
						null, precision).doubleValue(), 0.0};
				
			} else if(isAllNotHumanTargets(target)) {
				return new Double[] {calculateFormulaValues(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", notHumanTargetsList,
						null, precision).doubleValue(), 0.0};				
			} else if(isAllTargets(target)) {
				return new Double[] {calculateFormulaValues(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", humanTargetsList,
						null, precision).doubleValue(),
						calculateFormulaValues(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", notHumanTargetsList,
						null, precision).doubleValue()};			
				
			}	
		}
		return new Double[] {0.0, 0.0};
	}
	
	/**
	 * Calculates one or more formula values, for the given comma delimited id list.
	 * To do the calculus, launches a parametric SQL query (replacing placemarks with
	 * user chosen inputs).
	 * 
	 * @param conn
	 * @param level
	 * @param formulaDescriptor
	 * @param ids
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param sql
	 * @param field
	 * @param targets
	 * @param features
	 * @param precision
	 * @return
	 * @throws SQLException
	 */
	public static Number calculateFormulaValues(Connection conn, int level, Formula formulaDescriptor,
			String ids, String materials, String scenarios, String entities,
			String severeness, String sql, String field, String targets,
			Map<Number, SimpleFeature> features, int precision) throws SQLException {
		// replace input placemarks
		sql = sql.replace("%id_bersaglio%", targets);
		sql = sql.replace("%id_sostanza%", materials);
		sql = sql.replace("%id_scenario%", scenarios);
		sql = sql.replace("%flg_lieve%", entities);
		sql = sql.replace("%id_geo_arco%", ids);
		sql = sql.replace("%id_gravita%", severeness);
		sql = sql.replace("%livello%", level+"");
		// replace aggregated level
		sql = sql.replace("siig_geo_ln_arco_3", "siig_geo_pl_arco_3");
		// replace conditional params
		Pattern searchConditional = Pattern.compile("#(.*?)#\\*%bersaglio\\(([0-9]+)\\)%", Pattern.CASE_INSENSITIVE);
		Matcher m = searchConditional.matcher(sql);
		while(m.find()) {
			int target = Integer.parseInt(m.group(2));
			if(FormulaUtils.checkTarget(target, targets)) {
				sql = sql.replace(m.group(0), m.group(1));
			} else {
				sql = sql.replace(m.group(0), "0");
			}
			
		}
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();	
			Number risk = 0.0;
			while(rs.next()) {
				Number id = rs.getInt(1);
				if(features != null) {
					// accumulate
					risk = fixDecimals(rs.getDouble(2), precision) + (features.get(id).getAttribute(field) != null ? (Double)features.get(id).getAttribute(field) : 0.0);
					features.get(id).setAttribute(field, risk);				
				} else {
					risk = fixDecimals(rs.getDouble(2), precision);
				}
			}
			return risk;
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
	 * Rounds a number to the given decimals.
	 * 
	 * @param number
	 * @param numDecimals
	 * @return
	 */
	public static Double fixDecimals(double number , int numDecimals) {
		double pow = Math.pow(10, numDecimals);
		return Math.round(number * (int)pow) / pow;
	}
}
