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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

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
import org.geotools.process.gs.GSProcess;
import org.geotools.util.logging.Logging;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;

import com.vividsolutions.jts.geom.MultiLineString;



/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */

public class RiskCalculatorOld implements GSProcess {
	
	private static final Logger LOGGER = Logging.getLogger(RiskCalculatorOld.class);
	
	private Catalog catalog;
	
	static class FormulaChild {
		private int id;
		private String operator;
		/**
		 * @param id
		 * @param operator
		 */
		public FormulaChild(int id, String operator) {
			super();
			this.id = id;
			this.operator = operator;
		}
		/**
		 * @return the id
		 */
		public int getId() {
			return id;
		}
		/**
		 * @return the operator
		 */
		public String getOperator() {
			return operator;
		}
		
		
	}
	
	public RiskCalculatorOld(Catalog catalog) {
		this.catalog = catalog;
	}
	
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
		JDBCDataStore dataStore = (JDBCDataStore)dataStoreInfo.getDataStore(null);
		DefaultTransaction transaction = new DefaultTransaction();
		try {
			Connection conn = dataStore.getConnection(transaction);
			
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
			
	        // is formula supported on grid (level 3) ?
			boolean grid = hasGrid(conn, formula);
			int level = getLevel(features);
			if(!grid && level == 3) {
				// grid not supported -> empty feature
				return new EmptyFeatureCollection(ft);
			} else {
				String[] sql = getSqlQuery(conn, level, formula, target);				 				
				if(sql == null) {
					throw new IOException("Risk query cannot be built with the given parameters");
				}
				SimpleFeatureIterator iter = features.features();											
		        SimpleFeatureBuilder fb = new SimpleFeatureBuilder(ft);
				ListFeatureCollection result = new ListFeatureCollection(ft);
				int count = 0;				
				Double[] risk = new Double[] { 0.0, 0.0 };
				
				// is the query using arcs? if not we can optimize (same value for all arcs)
				boolean useArcs = isUsingArcs(conn, level, formula, target);
				if(!useArcs) {
					risk = getRisk(conn, sql, materials, scenarios, entities, severeness);
				}
				try {
					Map<Number, SimpleFeature> temp = new HashMap<Number, SimpleFeature>();
					StringBuilder ids = new StringBuilder();
					while(iter.hasNext()) {
						SimpleFeature feature = iter.next();
						Number id = (Number)feature.getAttribute("id_geo_arco");
						fb.add(id);
						fb.add(feature.getDefaultGeometry());
						fb.add(risk[0]);
						fb.add(risk[1]);
						ids.append(","+id);
						temp.put(id.intValue(), fb.buildFeature(id + ""));
						count++;
						if(count % 10000 == 0) {
							if(useArcs) {
								getRisk(conn, sql, ids.toString().substring(1), materials, scenarios, entities, severeness, temp);
							}
							result.addAll(temp.values());
							ids = new StringBuilder();
							temp = new HashMap<Number, SimpleFeature>();
							
						}				
					}
					if(useArcs && ids.length() > 0) {
						getRisk(conn, sql, ids.toString().substring(1), materials, scenarios, entities, severeness, temp);
					}
					result.addAll(temp.values());
				} finally {
					iter.close();
				}
				return result;
								
			}
		} finally {
			transaction.close();			
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
	/**
	 * @param conn
	 * @param formula
	 * @return
	 * @throws SQLException 
	 */
	private boolean hasGrid(Connection conn, int formula) throws SQLException {
		String sql =  "select flg_i_grid ";
	       sql += "from siig_mtd_t_formula ";	       
	       sql += "where id_formula=?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, formula);		
			rs = stmt.executeQuery();			
			if(rs.next()) {
				return rs.getInt(1) == 1;				
			}
			return false;
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
	 * @param conn
	 * @param level
	 * @param formula
	 * @param target
	 * @return
	 * @throws SQLException 
	 */
	private boolean isUsingArcs(Connection conn, int level, int formula,
			int target) throws SQLException {
		String sql =  "select flg_i ";
	       sql += "from siig_mtd_t_formula ";	       
	       sql += "where id_formula=?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, formula);		
			rs = stmt.executeQuery();			
			if(rs.next()) {
				return rs.getInt(1) == 1;				
			}
			return false;
		} finally {
			if(rs != null) {
				rs.close();				
			}
			if(stmt != null) {
				stmt.close();
			}
			
		}
		/*String sql =  "select def_select ";
	       sql += "from siig_mtd_r_formula_parametro ";
	       sql += "inner join siig_mtd_r_param_bers_arco on siig_mtd_r_formula_parametro.id_parametro=siig_mtd_r_param_bers_arco.id_parametro and id_arco=0 ";
	       sql += "where id_formula=? and (id_bersaglio=? or id_bersaglio=0)";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	try {
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, formula);
		stmt.setInt(2, target);
		rs = stmt.executeQuery();			
		if(rs.next()) {			
			return false;
		}
		return true;
	} finally {
		if(rs != null) {
			rs.close();				
		}
		if(stmt != null) {
			stmt.close();
		}
		
	}*/
	}
	/**
	 * @param conn
	 * @param sql
	 * @param materials
	 * @param scenarios
	 * @param severeness
	 * @return
	 * @throws SQLException 
	 */
	private Double[] getRisk(Connection conn, String[] sqls, String materials,
			String scenarios, String entities, String severeness) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Double[] result = new Double[] {0.0, 0.0};
		int count = 0;
		for(String sql : sqls) {
			try {
				
				if(sql.contains("id_sostanza") && !materials.equals("")) {
					sql = sql.replace("id_sostanza = ?", "id_sostanza in (" + materials + ")");
				}
				if(sql.contains("id_scenario") && !scenarios.equals("")) {
					sql = sql.replace("id_scenario = ?", "id_scenario in (" + scenarios + ")");
				}
				if(sql.contains("flg_lieve") && !entities.equals("")) {
					sql = sql.replace("flg_lieve = ?", "flg_lieve in (" + entities + ")");
				}
				
				if(sql.contains("id_gravita") && !severeness.equals("")) {
					sql = sql.replace("id_gravita = ?", "id_gravita in (" + severeness + ")");
				}
				stmt = conn.prepareStatement(sql);
							
				rs = stmt.executeQuery();
				Double risk = 0.0;
				while(rs.next()) {				
					risk += rs.getDouble(1);								
				}
				result[count++] = risk;
			} finally {
				if(rs != null) {
					rs.close();				
				}
				if(stmt != null) {
					stmt.close();
				}
				
			}
		}
		return result;
	}
	/**
	 * @param conn
	 * @param sql
	 * @param id
	 * @return
	 * @throws SQLException 
	 */
	private void getRisk(Connection conn, String[] sqls, String ids,
			String materials, String scenarios, String entities, String severeness, Map<Number, SimpleFeature> features)
			throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int count = 1;
		for(String sql : sqls) {
			String field = "rischio" + (count);
			try {
				boolean group = sql.startsWith("select avg");
				sql = sql.replaceAll("^select ","select id_geo_arco,");
				sql = sql.replace("id_geo_arco = ?", "id_geo_arco in (" + ids + ")");
				if(sql.contains("id_sostanza") && !materials.equals("")) {
					sql = sql.replaceAll("id_sostanza\\s*=\\s*\\?", "id_sostanza in (" + materials + ")");
				}
				if(sql.contains("id_scenario") && !scenarios.equals("")) {
					sql = sql.replace("id_scenario = ?", "id_scenario in (" + scenarios + ")");
				}
				if(sql.contains("flg_lieve") && !entities.equals("")) {
					sql = sql.replace("flg_lieve = ?", "flg_lieve in (" + entities + ")");
				}
				
				if(sql.contains("id_gravita") && !severeness.equals("")) {
					sql = sql.replace("id_gravita = ?", "id_gravita in (" + severeness + ")");
				}
				if(group) {
					sql += " group by id_geo_arco";
				}
				stmt = conn.prepareStatement(sql);
							
				rs = stmt.executeQuery();
				
				while(rs.next()) {
					Number id = rs.getInt(1);
					Number risk = rs.getDouble(2) + (Double)features.get(id).getAttribute(field);
					features.get(id).setAttribute(field, risk);
					
				}
				
			} finally {
				if(rs != null) {
					rs.close();				
				}
				if(stmt != null) {
					stmt.close();
				}
				
			}
			count++;
		}
	}
	/**
	 * @param conn
	 * @param formula
	 * @return
	 * @throws SQLException 
	 */
	private String[] getSqlQuery(Connection conn, int level, int formula, int target) throws SQLException {
		List<FormulaChild> childs = getChilds(conn, formula);
		if(childs.size() == 0) {
			return getSimpleSql(conn, level, formula, target);
		} else {
			/*String sql = "";
			String operator = null;
			for(FormulaChild child : childs) {
				String newSql = getSqlQuery(conn, level, child.getId(), target);
				if(operator != null && newSql != null && !sql.equals("")) {
					sql += operator;				
				}
				if(newSql != null) {
					sql += newSql;
				}
				operator = child.getOperator();				
			}
			return sql;*/
			return null;
		}
		
	}
	/**
	 * @param formula
	 * @return
	 * @throws SQLException 
	 */
	private List<FormulaChild> getChilds(Connection conn, int formula) throws SQLException {
		List<FormulaChild> childs = new ArrayList<FormulaChild>();
		String sql =  "select id_formula_figlio,operatore ";
	       sql += "from siig_mtd_r_formula_formula ";	       
	       sql += "where id_formula=? order by progressivo_formula";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, formula);		
			rs = stmt.executeQuery();			
			while(rs.next()) {
				childs.add(new FormulaChild(rs.getInt(1), rs.getString(2)));
			}
			return childs;
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
	 * @param conn
	 * @param level
	 * @param formula
	 * @param target
	 * @return
	 * @throws SQLException
	 */
	private String[] getSimpleSql(Connection conn, int level, int formula,
			int target) throws SQLException {
		int[] bersagli;
		if(target == 100) {
			bersagli = new int[] {98, 99};
		} else {
			bersagli = new int[] {target};
		}
		List<String> result = new ArrayList<String>();
		for(int count = 0; count<bersagli.length; count++) {
			String sql =  "select def_select ";
			       sql += "from siig_mtd_r_formula_parametro ";
			       sql += "inner join siig_mtd_r_param_bers_arco on siig_mtd_r_formula_parametro.id_parametro=siig_mtd_r_param_bers_arco.id_parametro and (id_arco=" + level + " or id_arco=0) ";
			       sql += "where id_formula=? and (id_bersaglio=? or id_bersaglio=0)";
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, formula);
				stmt.setInt(2, bersagli[count]);
				rs = stmt.executeQuery();			
				if(rs.next()) {
					/*String mainTableName = "siig_geo_ln_arco_" + level;
					String riskSql = rs.getString(1).replace("id_geo_arco = %", "id_geo_arco = "+mainTableName + ".id_geo_arco");
					return "select id_geo_arco, ("+riskSql+") as rischio, geometria from " + mainTableName;*/
					result.add(rs.getString(1).replace("%", "?"));
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
		return result.toArray(new String[] {});
	}
}
