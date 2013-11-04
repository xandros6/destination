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

import java.io.File;
import java.io.IOException;
import java.util.List;

import junit.framework.TestCase;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.CoverageInfo;
import org.geoserver.catalog.impl.CatalogImpl;
import org.geoserver.config.DefaultGeoServerLoader;
import org.geoserver.platform.GeoServerResourceLoader;
import org.geotools.coverage.grid.GridCoverage2D;
import org.geotools.coverage.processing.Operations;
import org.geotools.feature.SchemaException;
import org.geotools.process.raster.gs.AddCoveragesProcess;
import org.geotools.referencing.CRS;
import org.geotools.renderer.lite.gridcoverage2d.GridCoverageRenderer;
import org.geotools.util.DefaultProgressListener;
import org.junit.Before;
import org.opengis.coverage.grid.GridCoverageReader;
import org.opengis.parameter.GeneralParameterDescriptor;
import org.opengis.parameter.GeneralParameterValue;
import org.opengis.parameter.ParameterValueGroup;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.vfny.geoserver.global.GeoserverDataDirectory;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class AddCoveragesTest extends TestCase {
	
	Catalog catalog;
	
	@Before
	public void setUp() throws IOException, SchemaException {
		String dataDirPath = System.getProperty("GS_TEST_DATA_DIR");
		
		if(dataDirPath != null) {
			catalog = new CatalogImpl();
			
			GeoServerResourceLoader resourceLoader = new GeoServerResourceLoader(
					new File(dataDirPath));
			GeoserverDataDirectory.setResourceLoader(resourceLoader);
			DefaultGeoServerLoader loader = new DefaultGeoServerLoader(resourceLoader);
			catalog = (Catalog)loader.postProcessBeforeInitialization(catalog, "catalog");
			
			/*if(catalog != null) {
				riskCalculator = new RiskCalculator(catalog);	
				
				DataStoreInfo dataStoreInfo = catalog.getDataStoreByName(dataStoreName);
				dataStore = (JDBCDataStore)dataStoreInfo.getDataStore(null);
			}*/
			
			
		}
	}
	
	public void testAdding() throws IOException {
		if(catalog != null) {			
			
			AddCoveragesProcess process = new AddCoveragesProcess();
			
			CoverageInfo ci = catalog.getCoverageByName("aree_protette_mosaic");
			
			GridCoverageReader reader = ci.getGridCoverageReader(null, null);
	        final ParameterValueGroup readParametersDescriptor = reader.getFormat().getReadParameters();
	        final List<GeneralParameterDescriptor> parameterDescriptors = readParametersDescriptor
	                .getDescriptor().descriptors();
	        GeneralParameterValue[] params = new GeneralParameterValue[0];
	        GridCoverage2D coverage1 = (GridCoverage2D) reader.read(params);
	        
	        ci = catalog.getCoverageByName("acque_sotterranee_mosaic");
			
			reader = ci.getGridCoverageReader(null, null);
	        
	        GridCoverage2D coverage2 = (GridCoverage2D) reader.read(params);
			
	        //GridCoverage2D transformed = (GridCoverage2D) Operations.DEFAULT.resample(coverage1,coverage2.getGridGeometry().getEnvelope(), Interpolation.getInstance(Interpolation.INTERP_NEAREST));
	        
	        
			GridCoverage2D result = process.execute(coverage1, coverage2, new DefaultProgressListener());
			
			System.out.println(result);
			
			/*final File output = new File("d:\\added.tif");
	        GeoTiffWriter writer = new GeoTiffWriter(output);
	        
	        
	        
	        writer.write(result,null);
	        writer.dispose();
	        result.dispose(true);*/
		}
	}
}
