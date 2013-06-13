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
package it.geosolutions.geobatch.destination;

import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration;
import it.geosolutions.geobatch.catalog.Identifiable;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.FileInputStream;
import java.io.IOException;

import junit.framework.TestCase;

import org.junit.Ignore;
import org.junit.Test;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class RoadArcTest extends TestCase {

	@Test  @Ignore
	public void testImportArcs() throws IOException {
		String input = "D:\\Develop\\GEOBATCH_CONFIG\\temp\\importBersagliVettoriali\\20130402-080846-028\\0_Ds2dsGeneratorService\\output.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		RoadArc arc = new RoadArc(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {
			
			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public String getId() {
				return "id";
			}
		}));
		
		arc.importArcs(cfg.getDataStore(), null, 1, false, false);
		
	}
	
	@Test  @Ignore
	public void testRemoveZeros() throws IOException {
		String input = "D:\\Develop\\arcsoutput.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		RoadArc arc = new RoadArc(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {
			
			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public String getId() {
				return "id";
			}
		}));
		
//		arc.removeZeros(cfg.getDataStore(), null, 1, false, false);
		
	}
	
	@Test  @Ignore
	public void testAggregateArcs() throws IOException {
		String input = "D:\\Develop\\GEOBATCH_CONFIG\\temp\\importBersagliVettoriali\\20130402-080846-028\\0_Ds2dsGeneratorService\\output.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		RoadArc arc = new RoadArc(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {
			
			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public String getId() {
				return "id";
			}
		}));
		
		arc.importArcs(cfg.getDataStore(), null, 2, false, false);
		
	}
	 
	@Test  @Ignore
	public void testAggregateGrid() throws IOException {
		String input = "D:\\Develop\\GEOBATCH_CONFIG\\temp\\importBersagliVettoriali\\20130402-080846-028\\0_Ds2dsGeneratorService\\output.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		RoadArc arc = new RoadArc(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {
			
			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public String getId() {
				return "id";
			}
		}));
		
		arc.importArcs(cfg.getDataStore(), null, 3, true, false);
		
	}
}
