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

import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.process.gs.GSProcess;
import org.vfny.geoserver.global.GeoserverDataDirectory;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "DestinationRemoveDownload", description = "Remove a download from download folder.")
public class DestinationRemoveDownload implements GSProcess {
	
	private String downloadFolder;
	
	public DestinationRemoveDownload() {
		downloadFolder = GeoserverDataDirectory.getGeoserverDataDirectory()
				.getAbsolutePath()
				+ File.separator
				+ "www"
				+ File.separator
				+ "downloads";
	}
	
	@DescribeResult(description = "remove download result")
	public Boolean execute(
			@DescribeParameter(name = "url", description = "download url") String url
			
		)  {
		if(url.endsWith("\"")) {
			url = url.substring(0, url.length() -1);
		}
		url = url.substring(url.lastIndexOf('/')+1);
		File file = new File(downloadFolder + File.separator + url);
		if(file.exists()) {
			file.delete();
			return true;
		}
		return false;
	}
}
