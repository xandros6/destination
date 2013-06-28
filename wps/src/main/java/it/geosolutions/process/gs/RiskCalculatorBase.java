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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.geoserver.catalog.Catalog;
import org.geotools.process.gs.GSProcess;
import org.opengis.feature.simple.SimpleFeature;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public abstract class RiskCalculatorBase implements GSProcess {
	
	/** notHumanTargetsList */
	protected static final String notHumanTargetsList = "10,11,12,13,14,15,16";
	/** humanTargetsList */
	protected static final String humanTargetsList = "1,2,4,5,6,7";

	class FormulaCriteria {
		private int id;
		private boolean required;
		private boolean aggregate;
		/**
		 * @param id
		 * @param required
		 * @param aggregate
		 */
		public FormulaCriteria(int id, boolean required, boolean aggregate) {
			super();
			this.id = id;
			this.required = required;
			this.aggregate = aggregate;
		}
		/**
		 * @return the required
		 */
		public boolean isRequired() {
			return required;
		}
		/**
		 * @return the aggregate
		 */
		public boolean isAggregate() {
			return aggregate;
		}
		
		
	}
	
	class Formula {
		private boolean grid = false;
		private boolean nogrid = true;
		private boolean arcs = false;
		private boolean targets = false;
		
		int[] humanTargets = new int[] {1,2,4,5,6,7};
		int[] notHumanTargets = new int[] {10,11,12,13,14,15,16};
		
		private String sql = "";
		
		Map<Integer, FormulaCriteria> criterias = new HashMap<Integer, FormulaCriteria>(); 
				
		Pattern searchConditionalSubFormulas = Pattern.compile("%formula\\(([0-9]+)(,[^)]+)?\\)%(\\*%bersaglio\\(([0-9]+)\\)%)?", Pattern.CASE_INSENSITIVE);		

		/**
		 * @param grid
		 */
		public Formula(String sql, boolean nogrid, boolean grid, boolean arcs, boolean targets) {
			super();
			
			this.sql = sql;
			this.grid = grid;
			this.nogrid = nogrid;
			this.arcs = arcs;
			this.targets = targets;
		}
		
		public boolean hasGrid() {
			return grid;
		}
		
		public boolean hasNoGrid() {
			return nogrid;
		}
		
		public boolean useArcs() {
			return arcs;
		}
		
		public boolean useTargets() {
			return targets;
		}
		
		public String getSql() {
			return sql;
		}
		
		public boolean takeFromSource() {
			return sql == null || sql.trim().equals("");
		}
		
		public Formula parse(Connection conn, int target) throws SQLException {
			if(sql != null) {
				Matcher m = searchConditionalSubFormulas.matcher(sql);
				while(m.find()) {				
					int formula = Integer.parseInt(m.group(1));
					String subFormula = loadFormula(conn, formula, target).sql;
					String[] params = new String[0];
					if(m.group(2) != null) {
						params = m.group(2).split(",");
					}
					
					String filter = m.group(3);
					boolean check = true;
					if(filter == null) {
						filter = "";
					}
					if(!filter.trim().equals("")) {
						int currentTarget = Integer.parseInt(m.group(4));
						check = (currentTarget == target) || 
								(isAllHumanTargets(target) && isIn(currentTarget, humanTargets)) || 
								(isAllNotHumanTargets(target) && isIn(currentTarget, notHumanTargets)) ||
								(isAllTargets(target) && (isIn(currentTarget, humanTargets) || isIn(currentTarget, notHumanTargets)));
					}
					if(check) {
						for(int count = 1; count < params.length; count+=2) {
							String varName = "%"+params[count]+"%";
							String varValue = params[count+1];
							subFormula = subFormula.replace(varName, varValue);
						}
						if(!filter.equals("")) {
							sql = sql.replace(m.group(0), "#" + subFormula + "#" + filter);
						} else {
							sql = sql.replace(m.group(0), subFormula);
						}
					} else {
						sql = sql.replace(m.group(0), "0");
					}
						/*String filterName = params[0];
						String filterValue = params[1];
						String defaultValue = params[2];
						for(int count = 3; count < params.length; count+=2) {
							String varName = "%"+params[count]+"%";
							String varValue = params[count+1];
							subFormula = subFormula.replace(varName, varValue);
						}
						boolean check = false;
						if(filterName.equalsIgnoreCase("1") || filterName.equalsIgnoreCase("true") ) {
							check = true;
						}
						if(filterName.equalsIgnoreCase("bersaglio")) {
							check = filterValue.startsWith("%") || Integer.parseInt(filterValue) == target;						
						}
						
						if(check) {
							sql = sql.replace(m.group(0), subFormula);
						} else {
							sql = sql.replace(m.group(0), defaultValue);
						}*/					
					
					
				}
				
			}
			return this;
		}

		/**
		 * @param currentTarget
		 * @param notHumanTargets2
		 * @return
		 */
		private boolean isIn(int currentTarget, int[] targets) {
			for(int count = 0;count<targets.length;count++) {
				if(targets[count] == currentTarget)
					return true;
			}
			return false;
		}

		/**
		 * @param idCriterio
		 * @param required
		 * @param aggregate
		 */
		public void addCriteria(int idCriterio, boolean required, boolean aggregate) {
			criterias.put(idCriterio, new FormulaCriteria(idCriterio, required, aggregate));			
		}

		/**
		 * @return
		 */
		public boolean aggregateTargets() {
			if (!useTargets()
					|| !(criterias.containsKey(4) || criterias.containsKey(5) || criterias
							.containsKey(6))) {
				return true;
			}
					
			return aggregateOn(4) || aggregateOn(5) || aggregateOn(6);
		}

		/**
		 * @return
		 */
		private boolean aggregateOn(int criteria) {
			return criterias.containsKey(criteria) && criterias.get(criteria).isAggregate();
		}

		/**
		 * @return
		 */
		public boolean aggregateScenarios() {			
			return aggregateOn(8);
		}

		/**
		 * @return
		 */
		public boolean aggregateSevereness() {
			return aggregateOn(9);
		}

		
	}	
	
	// GeoServer catalog, used to extract the DataStore used by the process
	protected Catalog catalog;
	
	/**
	 * @param catalog
	 */
	public RiskCalculatorBase(Catalog catalog) {
		super();
		this.catalog = catalog;
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
	protected Double[] getRisk(Connection conn, int level, Formula formulaDescriptor,
			String materials, String scenarios, String entities,
			String severeness, int target) throws SQLException {

		String sql = formulaDescriptor.getSql();
		if(!formulaDescriptor.takeFromSource()) {
			if(isSimpleTarget(target) || !formulaDescriptor.useTargets()) {
				return new Double[] {getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", target + "",
						null).doubleValue(), 0.0};
				
			} else if(isAllHumanTargets(target)) {
				return new Double[] {getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", humanTargetsList,
						null).doubleValue(), 0.0};
				
			} else if(isAllNotHumanTargets(target)) {
				return new Double[] {getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", notHumanTargetsList,
						null).doubleValue(), 0.0};				
			} else if(isAllTargets(target)) {
				return new Double[] {getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", humanTargetsList,
						null).doubleValue(),
						getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", notHumanTargetsList,
						null).doubleValue()};			
				
			}	
		}
		return new Double[] {0.0, 0.0};
	}
	
	/**
	 * @param double1
	 * @return
	 */
	protected Double fixDecimals(double number) {
		return Math.round(number * 1000) / 1000.0;
	}
	
	/**
	 * @param conn
	 * @param level
	 * @param formulaDescriptor
	 * @param ids
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param string
	 * @param string2
	 * @param features
	 * @throws SQLException 
	 */
	protected Number getRisk(Connection conn, int level, Formula formulaDescriptor,
			String ids, String materials, String scenarios, String entities,
			String severeness, String sql, String field, String targets,
			Map<Number, SimpleFeature> features) throws SQLException {
		sql = sql.replace("%id_bersaglio%", targets);
		sql = sql.replace("%id_sostanza%", materials);
		sql = sql.replace("%id_scenario%", scenarios);
		sql = sql.replace("%flg_lieve%", entities);
		sql = sql.replace("%id_geo_arco%", ids);
		sql = sql.replace("%id_gravita%", severeness);
		sql = sql.replace("%livello%", level+"");
		sql = sql.replace("siig_geo_ln_arco_3", "siig_geo_pl_arco_3");
		Pattern searchConditional = Pattern.compile("#(.*?)#\\*%bersaglio\\(([0-9]+)\\)%", Pattern.CASE_INSENSITIVE);
		Matcher m = searchConditional.matcher(sql);
		while(m.find()) {
			int target = Integer.parseInt(m.group(2));
			if(checkTarget(target, targets)) {
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
					risk = fixDecimals(rs.getDouble(2)) + (Double)features.get(id).getAttribute(field);
					features.get(id).setAttribute(field, risk);				
				} else {
					risk = fixDecimals(rs.getDouble(1));
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
	 * Loads formula data from metadata tables.
	 * 
	 * @param conn
	 * @param formula
	 * @return
	 * @throws SQLException 
	 */
	protected Formula loadFormula(Connection conn, int formula, int target) throws SQLException {
		String sql =  "select formula, flg_visibile, flg_i, flg_m ";
	       sql += "from siig_mtd_t_formula ";	       
	       sql += "where id_formula=?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, formula);		
			rs = stmt.executeQuery();			
			if(rs.next()) {
				return new Formula(rs.getString(1), rs.getInt(2) == 1 || rs.getInt(2) == 3, rs.getInt(2) == 2 || rs.getInt(2) == 3,
						rs.getInt(3) == 1, rs.getInt(4) == 1).parse(conn, target);				
			}
			return null;
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
	 * @param target
	 * @param targets
	 * @return
	 */
	protected boolean checkTarget(int target, String targets) {
		return (","+targets+",").contains(","+target+",");
	}
	
	/**
	 * @param target
	 * @return
	 */
	protected boolean isAllTargets(int target) {
		return target == 100;
	}

	/**
	 * @param target
	 * @return
	 */
	protected boolean isAllNotHumanTargets(int target) {
		return target == 99;
	}

	/**
	 * @param target
	 * @return
	 */
	protected boolean isAllHumanTargets(int target) {
		return target == 98;
	}

	/**
	 * Special targets are 98, 99, 100.
	 * Everything else is a simple target.
	 * 
	 * @param target
	 * @return
	 */
	protected boolean isSimpleTarget(int target) {
		return !isAllHumanTargets(target) && !isAllNotHumanTargets(target)
				&& !isAllTargets(target);
	}
}
