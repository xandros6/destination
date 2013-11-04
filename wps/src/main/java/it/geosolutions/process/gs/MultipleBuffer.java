/*
 *    GeoTools - The Open Source Java GIS Toolkit
 *    http://geotools.org
 *
 *    (C) 2011, Open Source Geospatial Foundation (OSGeo)
 *    (C) 2008-2011 TOPP - www.openplans.org.
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

import it.geosolutions.destination.utils.BufferUtils;

import java.util.ArrayList;
import java.util.List;

import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.process.gs.GSProcess;

/**
 * Buffers a feature collection one or more times, using a certain distance or
 * set of distances.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "MultipleBuffer", description = "Buffers features by N different distances value supplied as parameters.")
public class MultipleBuffer implements GSProcess {

    @DescribeResult(description = "Buffered feature collection")
    public SimpleFeatureCollection execute(
            @DescribeParameter(name = "features", description = "Input feature collection") SimpleFeatureCollection features,
            @DescribeParameter(name = "distance", description = "Fixed value to use for the buffer distance", min=0, max=1) Double distance,
            @DescribeParameter(name = "distanceName", description = "Names of the output attributes for distance", min=0, max=1) String distanceName,
            @DescribeParameter(name = "distances", description = "Array of fixed values to use for the buffer distances", min=0) Double[] distances,
            @DescribeParameter(name = "distanceNames", description = "Names of the output attributes for distance", min=0) String[] distanceNames,
            @DescribeParameter(name = "split", description = "Split each distance on a different feature", min=0, max=1) Boolean split,
            @DescribeParameter(name = "outputName", description = "Optional output feature name", min=0, max=1) String outputName) {
    
    	if(split == null) {
    		split = false;
    	}
        if (distance == null && distances == null) {
            throw new IllegalArgumentException("Buffer distance(s) was not specified");
        }
    
        // creates a list of buffer distances from the distance and distances parameters        
        List<Double> bufferDistances = new ArrayList<Double>(); 
        if(distance != null) {
            bufferDistances.add(distance);
        }
        if(distances != null) {
            for(Double dist : distances) {
                bufferDistances.add(dist);
            }
        }
        // creates a list of buffer distance names from the distanceName and distanceNames parameters
        List<String> bufferDistanceNames = new ArrayList<String>(); 
        if(distanceName != null) {
            bufferDistanceNames.add(distanceName);
        }
        if(distanceNames != null) {
            for(String distName : distanceNames) {
                bufferDistanceNames.add(distName);
            }
        }
		return BufferUtils.createMultipleBuffer(features, bufferDistances
				.toArray(new Double[bufferDistances.size()]),
				bufferDistanceNames.toArray(new String[bufferDistanceNames
						.size()]), split.booleanValue(), outputName);
        
    }
    
    

}
