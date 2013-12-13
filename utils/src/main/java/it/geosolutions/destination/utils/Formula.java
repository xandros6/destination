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
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */


public class Formula {
	private boolean grid = false;
	private boolean nogrid = true;
	private boolean arcs = false;
	private boolean targets = false;
	
	int[] humanTargets = new int[] {1,2,4,5,6,7,8,9};
	int[] notHumanTargets = new int[] {10,11,12,13,14,15,16};
	
	private String sql = "";
	
	Map<Integer, FormulaCriteria> criterias = new HashMap<Integer, FormulaCriteria>(); 
			
	Pattern searchFormulas = Pattern.compile("%formula\\(([0-9]+)(,[^)]+)?\\)%(\\*%([a-zA-Z]+)\\(([0-9]+)\\)%)?", Pattern.CASE_INSENSITIVE);			

	String description = "";
	
	/**
	 * @param grid
	 */
	public Formula(String sql, String description, boolean nogrid, boolean grid, boolean arcs, boolean targets) {
		super();
		
		this.sql = sql;
		this.description = description;
		this.grid = grid;
		this.nogrid = nogrid;
		this.arcs = arcs;
		this.targets = targets;
	}
	
	
	
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
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
	
	public static Formula load(Connection conn, int processing, int formula, int target) throws SQLException {
		return Formula.load(conn, processing, formula, target, "it");
	}
	
	/**
	 * Loads formula data from metadata tables.
	 * 
	 * @param conn
	 * @param formula
	 * @return
	 * @throws SQLException 
	 */
	public static Formula load(Connection conn, int processing, int formula, int target, String language) throws SQLException {
		String sql =  "select formula, flg_visibile, ";
		   sql += " coalesce((select flg_obbligatorio+1 from siig_mtd_r_formula_criterio where id_formula=siig_mtd_t_formula.id_formula and id_criterio=1),0) as flg_i, ";
		   sql += " coalesce((select flg_obbligatorio+1 from siig_mtd_r_formula_criterio where id_formula=siig_mtd_t_formula.id_formula and id_criterio=4),0) as flg_m_1, ";
		   sql += " coalesce((select flg_obbligatorio+1 from siig_mtd_r_formula_criterio where id_formula=siig_mtd_t_formula.id_formula and id_criterio=5),0) as flg_m_2, ";
		   sql += " coalesce((select flg_obbligatorio+1 from siig_mtd_r_formula_criterio where id_formula=siig_mtd_t_formula.id_formula and id_criterio=6),0) as flg_m_3, ";
		   sql += " descrizione_"+language+" as description ";
	       sql += "from siig_mtd_t_formula ";	       
	       sql += "where id_formula=?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, formula);		
			rs = stmt.executeQuery();			
			if(rs.next()) {
				return new Formula(rs.getString(1), rs.getString(7), rs.getInt(2) == 1 || rs.getInt(2) == 3, rs.getInt(2) == 2 || rs.getInt(2) == 3,
						rs.getInt(3) > 0, rs.getInt(4) > 0 || rs.getInt(5) > 0 || rs.getInt(6) > 0).parse(conn, target, processing);				
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
	
	public Formula parse(Connection conn, int target, int processing) throws SQLException {
		if(sql != null) {
			Matcher m = searchFormulas.matcher(sql);
			while(m.find()) {				
				int formula = Integer.parseInt(m.group(1));
				String subFormula = load(conn, processing, formula, target).sql;
				String[] params = new String[0];
				if(m.group(2) != null) {
					params = m.group(2).split(",");
				}
				
				String filter = m.group(3);
				boolean check = true;
				if(filter == null) {
					filter = "";
				}
				
				String defaultFilterValue = "";
				if(!filter.trim().equals("")) {
					String filterType = m.group(4).toLowerCase();
					if(filterType.equals("bersaglio")) {
						int currentTarget = Integer.parseInt(m.group(5));
						check = (currentTarget == target) || 
								(FormulaUtils.isAllHumanTargets(target) && isIn(currentTarget, humanTargets)) || 
								(FormulaUtils.isAllNotHumanTargets(target) && isIn(currentTarget, notHumanTargets)) ||
								(FormulaUtils.isAllTargets(target) && (isIn(currentTarget, humanTargets) || isIn(currentTarget, notHumanTargets)));
						
						defaultFilterValue = "0";
					}
					if(filterType.equals("elaborazione")) {
						int currentProcessing = Integer.parseInt(m.group(5));
						check = (currentProcessing == processing);
						
						defaultFilterValue = "1";
					}
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
					sql = sql.replace(m.group(0), defaultFilterValue);
				}													
				
			}
			
			 /*m = searchProcessingConditionalFormulas.matcher(sql);
				while(m.find()) {				
					int formula = Integer.parseInt(m.group(1));
					String subFormula = load(conn, processing, formula, target).sql;
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
						int currentProcessing = Integer.parseInt(m.group(4));
						check = (currentProcessing == processing);
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
					
				}*/
			
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