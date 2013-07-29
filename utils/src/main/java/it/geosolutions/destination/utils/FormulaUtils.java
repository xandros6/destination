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
import java.util.List;
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
	
	private static Pattern searchTargetConditional = Pattern.compile("#(.*?)#\\*%bersaglio\\(([0-9]+)\\)%", Pattern.CASE_INSENSITIVE);
	private static Pattern searchProcessingConditional = Pattern.compile("#(.*?)#\\*%elaborazione\\(([0-9]+)\\)%", Pattern.CASE_INSENSITIVE);
	
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
	public static void calculateFormulaValues(Connection conn, int level, int processing,
			Formula formulaDescriptor, String ids, String fk_partner, String materials,
			String scenarios, String entities, String severeness, String fpfield, int target,
			Map<Number, SimpleFeature> features, int precision)
			throws SQLException {
	
		String sql = formulaDescriptor.getSql();
		
		if(isSimpleTarget(target) || !formulaDescriptor.useTargets()) {
			calculateFormulaValues(conn, level, processing, formulaDescriptor, ids, fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio1", target + "", null, features, precision, null, null, null, null);
		} else if(isAllHumanTargets(target)) {
			calculateFormulaValues(conn, level, processing, formulaDescriptor, ids, fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio1", "1,2,4,5,6,7", null, features, precision, null, null, null, null);
		} else if(isAllNotHumanTargets(target)) {
			calculateFormulaValues(conn, level, processing, formulaDescriptor, ids, fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio1", "10,11,12,13,14,15,16", null, features, precision, null, null, null, null);			
		} else if(isAllTargets(target)) {			
			calculateFormulaValues(conn, level, processing, formulaDescriptor, ids, fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio1", "1,2,4,5,6,7", null, features, precision, null, null, null, null);
			calculateFormulaValues(conn, level, processing, formulaDescriptor, ids, fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio2", "10,11,12,13,14,15,16", null, features, precision, null, null, null, null);
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
	public static Double[] calculateFormulaValues(Connection conn, int level, int processing, Formula formulaDescriptor,
			String fk_partner, String materials, String scenarios, String entities,
			String severeness, String fpfield, int target, String deletedTargets, int precision) throws SQLException {

		String sql = formulaDescriptor.getSql();
		if(!formulaDescriptor.takeFromSource()) {
			if(isSimpleTarget(target) || !formulaDescriptor.useTargets()) {
				return new Double[] {calculateFormulaValues(conn, level, processing, formulaDescriptor,
						"", fk_partner, materials, scenarios, entities,
						severeness, fpfield, sql, "", target + "", deletedTargets,
						null, precision, null, null, null, null).doubleValue(), 0.0};
				
			} else if(isAllHumanTargets(target)) {
				return new Double[] {calculateFormulaValues(conn, level, processing, formulaDescriptor,
						"", fk_partner, materials, scenarios, entities,
						severeness, fpfield, sql, "", humanTargetsList, deletedTargets,
						null, precision, null, null, null, null).doubleValue(), 0.0};
				
			} else if(isAllNotHumanTargets(target)) {
				return new Double[] {calculateFormulaValues(conn, level, processing, formulaDescriptor,
						"", fk_partner, materials, scenarios, entities,
						severeness, fpfield, sql, "", notHumanTargetsList, deletedTargets,
						null, precision, null, null, null, null).doubleValue(), 0.0};				
			} else if(isAllTargets(target)) {
				return new Double[] {calculateFormulaValues(conn, level, processing, formulaDescriptor,
						"", fk_partner, materials, scenarios, entities,
						severeness, fpfield, sql, "", humanTargetsList, deletedTargets,
						null, precision, null, null, null, null).doubleValue(),
						calculateFormulaValues(conn, level, processing, formulaDescriptor,
						"", fk_partner, materials, scenarios, entities,
						severeness, fpfield, sql, "", notHumanTargetsList, deletedTargets,
						null, precision, null, null, null, null).doubleValue()};			
				
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
	 * @param cff 
	 * @param psc 
	 * @return
	 * @throws SQLException
	 */
	public static Number calculateFormulaValues(Connection conn, int level, int processing, Formula formulaDescriptor,
			String ids, String fk_partner, String materials, String scenarios, String entities,
			String severeness, String fpfield, String sql, String field, String targets, String deletedTargets,
			Map<Number, SimpleFeature> features, int precision, 
			List<String> cff,  // optional List of csv "id_bersaglo,cff" values to use on the simulation
			List<String> psc,  // optional List of csv id_sostanza,psc values to use on the simulation
			List<String> padr, // optional List of csv id_sostanza,padr values to use on the simulation
			List<String> pis   // optional List of csv id_geo_arco,pis values to use on the simulation
	) throws SQLException {
		// replace input placemarks

		// ----- SIMULATION STUFF
		// -- Cff
		/**
		 * select id_geo_arco,avg(cff) 
  		 * from (select id_geo_arco,id_bersaglio,fk_partner,cff from siig_r_arco_%livello%_scen_tipobers 
 		 * where id_geo_arco in (%id_geo_arco%) and id_bersaglio in (%id_bersaglio%) %cff%)) x group by id_geo_arco
		 */
		if (cff == null || cff.size() == 0)
		{
			sql = sql.replace("%cff%", "");
		}
		else
		{
			/**
			 * -- Example
			 * select id_geo_arco,avg(cff) 
			 * from 
			 * (
			 *   select id_geo_arco,id_bersaglio,fk_partner,cff from siig_r_arco_1_scen_tipobers where id_geo_arco in (1,2,3,4,5) and id_bersaglio in (1,2,4,5,6,7)
			 *   union all
			 *   select 1 as id_geo_arco, 10001 as id_bersaglio, '1' as fk_partner, 0.8 as cff
			 *   union all
			 *   select 2 as id_geo_arco, 10001 as id_bersaglio, '1' as fk_partner, 0.8 as cff
			 * ) x
			 * group by id_geo_arco
			 */
			StringBuilder cff_union_adds = new StringBuilder();
			for (String customCff : cff)
			{
				if (customCff.length() > 0 && customCff.split(",").length > 1)
				{
					final String custom_id_bersaglio = customCff.split(",")[0];
					final String custom_cff          = customCff.split(",")[1];
					
					cff_union_adds.append(" ")
					              .append("union all select ")
					              .append(ids)
					              .append(" as id_geo_arco, ")
					              .append(10000 + Integer.parseInt(custom_id_bersaglio))
					              .append(" as id_bersaglio, ")
					              .append("'").append(fk_partner).append("'")
					              .append(" as fk_partner, ")
					              .append(custom_cff)
					              .append(" as cff");
					
					deletedTargets = deletedTargets==null?custom_id_bersaglio:deletedTargets+(deletedTargets.length()>0?",":"")+custom_id_bersaglio;
				}
			}
			sql = sql.replace("%cff%", cff_union_adds.toString());
		}

		// -- Psc
		/**
		 * select sum(psc) 
		 * from
		 * (
		 *  select id_sostanza,psc from siig_r_scenario_sostanza where id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%)
		 *  %psc%
		 * ) x
		 */
		String deletedMaterials = null;
		if (psc == null || psc.size() == 0)
		{
			sql = sql.replace("%psc%", "");
		}
		else
		{
			/**
			 * -- Example
			 * select sum(psc) 
			 * from 
			 * (
			 *   select id_sostanza,psc from siig_r_scenario_sostanza where id_scenario in (1,3,7,8) and id_sostanza in (1,2,3,7,8,9) and flg_lieve in (0,1)
			 *   union all
			 *   select 4 as id_sostanza, 0.3 as psc
			 * ) x
			 */
			StringBuilder psc_union_adds = new StringBuilder();
			for (String customPsc : psc)
			{
				if (customPsc.length() > 0 && customPsc.split(",").length > 1)
				{
					final String custom_id_sostanza = customPsc.split(",")[0];
					final String custom_psc         = customPsc.split(",")[1];
					
					psc_union_adds.append(" ")
					              .append("union all select ")
					              .append(ids)
					              .append(" as id_geo_arco, ")
					              .append(10000 + Integer.parseInt(custom_id_sostanza))
					              .append(" as id_sostanza, ")
					              .append(custom_psc)
					              .append(" as psc");
					
					deletedMaterials = deletedMaterials==null?custom_id_sostanza:deletedMaterials+(deletedMaterials.length()>0?",":"")+custom_id_sostanza;
				}
			}
			sql = sql.replace("%psc%", psc_union_adds.toString());
		}

		// -- Padr
		/**
		 * select id_geo_arco,%padr% as padr from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %id_sostanza%
		 */
		if (padr == null || padr.size() == 0)
		{
			sql = sql.replace("%padr%", "padr");
		}
		else if (padr.size() == 1)
		{
			sql = sql.replace("%padr%", padr.get(0) + " as padr");
		}
		else
		{
			/**
			 * -- Example
			 * select id_geo_arco,0.6 as padr from siig_r_arco_1_sostanza where id_geo_arco in (1,2,3,4,5) and id_sostanza = 1
			 */
			for (String customPadr : padr)
			{
				if (customPadr.length() > 0 && customPadr.split(",").length > 1)
				{
					final String custom_id_sostanza = customPadr.split(",")[0];
					final String custom_padr        = customPadr.split(",")[1];

					sql = sql.replace(
			"select id_geo_arco,%padr% from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %id_sostanza%", 
			"select id_geo_arco,"+custom_padr+" as padr from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = "+custom_id_sostanza);
				}
			}
		}
		
		// -- Pis
		/**
  		 * select *
  		 * from
  		 *  (
  		 * 	  select id_geo_arco,%formula(117)% from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco
  		 * 	  %pis%
  		 *  ) x
		 */
		String deletedArcs = null;
		if (pis == null || pis.size() == 0)
		{
			sql = sql.replace("%pis%", "");
		}
		else
		{
			/**
			 * -- Example
			 * select *
			 *  from
			 *  (
			 * 	  select id_geo_arco,nr_incidenti_elab/lunghezza*1000 from siig_geo_ln_arco_1 where id_geo_arco in (1,2,3,4,5) group by id_geo_arco
			 * 	  union all
			 * 	  select id_geo_arco,55 from siig_geo_ln_arco_1 where id_geo_arco in (6) 
			 *  ) x
			 */
			StringBuilder pis_union_adds = new StringBuilder();
			for (String customPis : pis)
			{
				if (customPis.length() > 0 && customPis.split(",").length > 1)
				{
					final String custom_id_arco  = customPis.split(",")[0];
					final String custom_pis      = customPis.split(",")[1];
					
					pis_union_adds.append(" ")
					              .append("union all select id_geo_arco,")
					              .append(custom_pis)
					              .append(" from siig_geo_ln_arco_%livello% where id_geo_arco in ("+custom_id_arco+")");
					
					deletedArcs = deletedArcs==null?custom_id_arco:deletedArcs+(deletedArcs.length()>0?",":"")+custom_id_arco;
				}
			}
			sql = sql.replace("%pis%", pis_union_adds.toString());
		}
		
		// ----- CLEANUP TARGETS
		if (targets != null && deletedTargets != null)
		{
			String[] sourceTargets = targets.split(",");
			String[] targetsToRemove = deletedTargets.split(",");
			targets = "";
			for (String target : sourceTargets)
			{
				boolean skip = false;
				for (String targetToRemove : targetsToRemove)
				{
					if (target.equals(targetToRemove)) {skip = true; break;}
				}
				
				if(!skip) targets += target + ",";
			}
			targets = targets.substring(0, targets.length()-1);
		}
		
		// ----- CLEANUP MATERIALS
		if (materials != null && deletedMaterials != null)
		{
			String[] sourceMaterials   = materials.split(",");
			String[] materialsToRemove = deletedMaterials.split(",");
			materials = "";
			for (String material : sourceMaterials)
			{
				boolean skip = false;
				for (String materialToRemove : materialsToRemove)
				{
					if (material.equals(materialToRemove)) {skip = true; break;}
				}
				
				if(!skip) materials += material + ",";
			}
			materials = materials.substring(0, materials.length()-1);
		}

		// ----- CLEANUP ARCS
		if (ids != null && deletedArcs != null)
		{
			String[] sourceGeoArcs   = ids.split(",");
			String[] geoArcsToRemove = deletedArcs.split(",");
			ids = "";
			for (String geoArc : sourceGeoArcs)
			{
				boolean skip = false;
				for (String geoArcToRemove : geoArcsToRemove)
				{
					if (geoArc.equals(geoArcToRemove)) {skip = true; break;}
				}
				
				if(!skip) ids += ids + ",";
			}
			ids = ids.substring(0, ids.length()-1);
		}

		sql = sql.replace("%id_bersaglio%", targets);
		sql = sql.replace("%id_sostanza%", materials);
		sql = sql.replace("%id_scenario%", scenarios);
		sql = sql.replace("%flg_lieve%", entities);
		sql = sql.replace("%fp_field%", fpfield);
		sql = sql.replace("%id_geo_arco%", ids);
		sql = sql.replace("%id_gravita%", severeness);
		sql = sql.replace("%livello%", level+"");
		// replace aggregated level
		sql = sql.replace("siig_geo_ln_arco_3", "siig_geo_pl_arco_3");
		// replace conditional params
		
		Matcher m = searchTargetConditional.matcher(sql);
		while(m.find()) {
			int target = Integer.parseInt(m.group(2));
			if(FormulaUtils.checkTarget(target, targets)) {
				sql = sql.replace(m.group(0), m.group(1));
			} else {
				sql = sql.replace(m.group(0), "0");
			}
			
		}
		
		m = searchProcessingConditional.matcher(sql);
		while(m.find()) {
			int currentProcessing = Integer.parseInt(m.group(2));
			if(currentProcessing == processing) {
				sql = sql.replace(m.group(0), m.group(1));
			} else {
				sql = sql.replace(m.group(0), "1");
			}
			
		}
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();	
			Number risk = 0.0;
			while(rs.next()) {
				
				if(features != null) {
					// accumulate
					Number id = rs.getInt(1);
					risk = fixDecimals(rs.getDouble(2), precision) + (features.get(id).getAttribute(field) != null ? (Double)features.get(id).getAttribute(field) : 0.0);
					features.get(id).setAttribute(field, risk);				
				} else {
					risk = fixDecimals(rs.getDouble(1), precision);
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
	 * Similar to the original method calculateForumaValues, allows to specify some custom values.
	 * It assumes the computation to be done on a single arc.
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
	 * @param cff 
	 * @param psc 
	 * @throws SQLException
	 */
	public static void calculateSimulationFormulaValuesOnSingleArc(Connection conn, int level, int processing,
			Formula formulaDescriptor, int id_geo_arco, String fk_partner, String materials,
			String scenarios, String entities, String severeness, String fpfield, int target,
			String deletedTargets, Map<Number, SimpleFeature> features, int precision, 
			List<String> cff, List<String> psc, List<String> padr, List<String> pis)
			throws SQLException {
	
		String sql = formulaDescriptor.getSql();
		
		if(isSimpleTarget(target) || !formulaDescriptor.useTargets()) {
			calculateFormulaValues(conn, level, processing, formulaDescriptor, id_geo_arco+"", fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio1", target + "", deletedTargets, features, precision,
					cff, psc, padr, pis);
		} else if(isAllHumanTargets(target)) {
			calculateFormulaValues(conn, level, processing, formulaDescriptor, id_geo_arco+"", fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio1", "1,2,4,5,6,7", deletedTargets, features, precision,
					cff, psc, padr, pis);
		} else if(isAllNotHumanTargets(target)) {
			calculateFormulaValues(conn, level, processing, formulaDescriptor, id_geo_arco+"", fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio1", "10,11,12,13,14,15,16", deletedTargets, features, precision,
					cff, psc, padr, pis);			
		} else if(isAllTargets(target)) {			
			calculateFormulaValues(conn, level, processing, formulaDescriptor, id_geo_arco+"", fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio1", "1,2,4,5,6,7", deletedTargets, features, precision,
					cff, psc, padr, pis);
			calculateFormulaValues(conn, level, processing, formulaDescriptor, id_geo_arco+"", fk_partner, materials, scenarios,
					entities, severeness, fpfield, sql, "rischio2", "10,11,12,13,14,15,16", deletedTargets, features, precision,
					cff, psc, padr, pis);
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
