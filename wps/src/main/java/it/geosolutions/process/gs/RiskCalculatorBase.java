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
	 
	protected Double[] getRisk(Connection conn, int level, Formula formulaDescriptor,
			String materials, String scenarios, String entities,
			String severeness, int target) throws SQLException {

		String sql = formulaDescriptor.getSql();
		if(!formulaDescriptor.takeFromSource()) {
			if(FormulaUtils.isSimpleTarget(target) || !formulaDescriptor.useTargets()) {
				return new Double[] {getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", target + "",
						null).doubleValue(), 0.0};
				
			} else if(FormulaUtils.isAllHumanTargets(target)) {
				return new Double[] {getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", FormulaUtils.humanTargetsList,
						null).doubleValue(), 0.0};
				
			} else if(FormulaUtils.isAllNotHumanTargets(target)) {
				return new Double[] {getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", FormulaUtils.notHumanTargetsList,
						null).doubleValue(), 0.0};				
			} else if(FormulaUtils.isAllTargets(target)) {
				return new Double[] {getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", FormulaUtils.humanTargetsList,
						null).doubleValue(),
						getRisk(conn, level, formulaDescriptor,
						"", materials, scenarios, entities,
						severeness, sql, "", FormulaUtils.notHumanTargetsList,
						null).doubleValue()};			
				
			}	
		}
		return new Double[] {0.0, 0.0};
	}*/
	
	
	
	
	
	
	
	
}
