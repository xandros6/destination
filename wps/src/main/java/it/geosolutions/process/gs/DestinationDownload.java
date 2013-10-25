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
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.util.Collections;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.apache.commons.io.IOUtils;
import org.geoserver.catalog.Catalog;
import org.geoserver.wfs.response.ShapeZipOutputFormat;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.vfny.geoserver.global.GeoserverDataDirectory;

/**
 * 
 * WPS Process for risk analysis results download.
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "DestinationDownload", description = "Dynamically downloads calculated risk on road arcs.")
public class DestinationDownload extends RiskCalculatorBase {
	
	RiskCalculator riskCalculator;
	MultipleBuffer multipleBuffer;
	String downloadFolder;
	
	/**
	 * @param catalog
	 */
	public DestinationDownload(Catalog catalog) {
		super(catalog);
		riskCalculator = new RiskCalculator(catalog);
		multipleBuffer = new MultipleBuffer();
		downloadFolder = GeoserverDataDirectory.getGeoserverDataDirectory()
				.getAbsolutePath()
				+ File.separator
				+ "www"
				+ File.separator
				+ "downloads";
	}
	
	@DescribeResult(description = "Download Risk calculus result")
	public String execute(
			@DescribeParameter(name = "features", description = "Input feature collection") SimpleFeatureCollection features,
			@DescribeParameter(name = "store", description = "risk data store name", min = 0) String storeName,
			@DescribeParameter(name = "batch", description = "batch calculus size", min = 0) Integer batch,
			@DescribeParameter(name = "precision", description = "output value precision (decimals)", min = 0) Integer precision,
			@DescribeParameter(name = "connection", description = "risk database connection params", min = 0) String connectionParams,
			@DescribeParameter(name = "processing", description = "id of the processing type") int processing,
			@DescribeParameter(name = "formula", description = "id of the formula to calculate") int formula,
			@DescribeParameter(name = "target", description = "id of the target/s to use in calculation") int target,
			@DescribeParameter(name = "materials", description = "ids of the materials to use in calculation") String materials,
			@DescribeParameter(name = "scenarios", description = "ids of the scenarios to use in calculation") String scenarios,
			@DescribeParameter(name = "entities", description = "ids of the entities to use in calculation") String entities,
			@DescribeParameter(name = "severeness", description = "ids of the severeness to use in calculation") String severeness,
			@DescribeParameter(name = "fp", description = "fields to use for fp calculation", min = 0) String fpfield,			
			@DescribeParameter(name = "changedTargets", description = "optional field containing csv list of targets to be removed, added, changed or an id for the ProcessingRepository storing the same data", min = 0) String changedTargets,			
			
			@DescribeParameter(name = "cff", description = "optional List (_ delimited) of csv id_geo_arco,id_bersaglo,cff values to use on the simulation", min = 0) String cff,
			@DescribeParameter(name = "psc", description = "optional List (_ delimited) of csv id_sostanza,psc values to use on the simulation", min = 0) String psc,
			@DescribeParameter(name = "padr", description = "optional List (_ delimited) of csv id_geo_arco,id_sostanza,padr values to use on the simulation", min = 0) String padr,
			@DescribeParameter(name = "pis", description = "optional List (_ delimited) of csv id_geo_arco,pis values to use on the simulation", min = 0) String pis,
			@DescribeParameter(name = "distances", description = "list of distances for damage areas", min = 0) String distances,
			@DescribeParameter(name = "distanceNames", description = "optional list of distance names for damage areas", min = 0) String distanceNames,
			@DescribeParameter(name = "damageArea", description = "optional field containing damage area geometry or an id for the ProcessingRepository storing the same data", min = 0) String damageArea

		) throws IOException, SQLException {
		
		
		
		String riskFileName = createRiskShapefile(features, storeName, batch, precision,
				connectionParams, processing, formula, target, materials,
				scenarios, entities, severeness, fpfield, changedTargets, cff,
				psc, padr, pis, distances, damageArea);
		
		String damageFileName = createDamageAreasShapefile(features,
				storeName, distances,
				distanceNames,
				damageArea);
		
		return createFinalZipFile(new String[] {riskFileName, damageFileName});
		
	}

	/**
	 * @param strings
	 * @return
	 * @throws IOException 
	 */
	private String createFinalZipFile(String[] tempFiles) throws IOException {
		File tempDir = org.geoserver.data.util.IOUtils
				.createTempDirectory("download");
		for (String tempFile : tempFiles) {
			String tempFilePath = downloadFolder + File.separator + tempFile;
			unZip(tempFilePath, tempDir.getAbsolutePath());
			new File(tempFilePath).delete();
		}
		String fileName = UUID.randomUUID().toString() + ".zip";
		ZipOutputStream outZip = new ZipOutputStream(new FileOutputStream(
				downloadFolder + File.separator + fileName));
		org.geoserver.data.util.IOUtils.zipDirectory(tempDir, outZip, null);
		outZip.close();
		return fileName;
	}

	public void unZip(String zipFile, String outputFolder) throws IOException {

		byte[] buffer = new byte[1024];
		ZipInputStream zis = null;
		try {

			// create output directory is not exists
			File folder = new File(outputFolder);
			if (!folder.exists()) {
				folder.mkdirs();
			}

			// get the zip file content
			zis = new ZipInputStream(
					new FileInputStream(zipFile));
			// get the zipped file list entry
			ZipEntry ze = zis.getNextEntry();

			while (ze != null) {

				String fileName = ze.getName();
				File newFile = new File(outputFolder + File.separator
						+ fileName);

				// create all non exists folders
				// else you will hit FileNotFoundException for compressed folder
				new File(newFile.getParent()).mkdirs();

				FileOutputStream fos = null;
				try {
					fos = new FileOutputStream(newFile);
					
	
					int len;
					while ((len = zis.read(buffer)) > 0) {
						fos.write(buffer, 0, len);
					}
				} catch(IOException e) {
					throw e;
				} finally {
					if(fos != null) {
						fos.close();
					}					
				}
				ze = zis.getNextEntry();
			}

			zis.closeEntry();			

		} finally {
			if(zis != null) {
				zis.close();
			}
		}
	}
	
	/**
	 * @param features
	 * @param storeName
	 * @param batch
	 * @param precision
	 * @param connectionParams
	 * @param processing
	 * @param formula
	 * @param target
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param fpfield
	 * @param changedTargets
	 * @param cff
	 * @param psc
	 * @param padr
	 * @param pis
	 * @param distances
	 * @param damageArea
	 * @param fileName
	 * @throws IOException
	 * @throws SQLException
	 * @throws FileNotFoundException
	 */
	private String createRiskShapefile(SimpleFeatureCollection features,
			String storeName, Integer batch, Integer precision,
			String connectionParams, int processing, int formula, int target,
			String materials, String scenarios, String entities,
			String severeness, String fpfield, String changedTargets,
			String cff, String psc, String padr, String pis, String distances,
			String damageArea) throws IOException,
			SQLException, FileNotFoundException {
		
		String riskShapeFileName = UUID.randomUUID().toString() + ".zip";
		SimpleFeatureCollection fc = riskCalculator.execute(features, storeName, batch, precision, connectionParams, processing, formula, target, materials, scenarios, entities, severeness, fpfield, changedTargets, cff, psc, padr, pis, distances, damageArea);			
		
		return writeToShapeFile(riskShapeFileName, fc);
	}

	/**
	 * @param riskShapeFileName
	 * @param fc
	 * @param of
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	private String writeToShapeFile(String riskShapeFileName,
			SimpleFeatureCollection fc)
			throws FileNotFoundException, IOException {
		ShapeZipOutputFormat of = new ShapeZipOutputFormat(null, catalog, null);
		FileOutputStream os = null;
		try {			
			os = new FileOutputStream(downloadFolder + File.separator + riskShapeFileName);
	        of.write(Collections.singletonList(fc), Charset.forName("ISO-8859-1"), os, null);
	        return riskShapeFileName;
		} finally {
			if(os != null) {
				os.close();
			}
		}
		
	}	
	
	private String createDamageAreasShapefile(SimpleFeatureCollection features,
			String storeName, String distances,
			String distanceNames,
			String damageArea) throws IOException,
			SQLException, FileNotFoundException {
		
		String damageAreaShapeFileName = UUID.randomUUID().toString() + ".zip";
		String[] splittedDists = distances.split(",");
		Double[] dists = new Double[splittedDists.length];
		
		for(int count = 0; count < splittedDists.length; count++) {
			dists[count] = Double.parseDouble(splittedDists[count]);
		}
		SimpleFeatureCollection fc = multipleBuffer.execute(features, null, null, dists, distanceNames.split(","), true);
		
		return writeToShapeFile(damageAreaShapeFileName, fc);
	}	
}
