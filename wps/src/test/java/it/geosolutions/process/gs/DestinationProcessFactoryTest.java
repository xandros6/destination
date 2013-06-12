/*
 *    GeoTools - The Open Source Java GIS Toolkit
 *    http://geotools.org
 *
 *    (C) 2011, Open Source Geospatial Foundation (OSGeo)
 *    (C) 2001-2007 TOPP - www.openplans.org.
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

import static org.junit.Assert.assertNotNull;

import org.geotools.data.simple.SimpleFeatureSource;
import org.geotools.feature.NameImpl;
import org.geotools.process.Process;
import org.geotools.process.Processors;
import org.junit.Test;

/**
 * 
 *
 * @source $URL$
 */
public class DestinationProcessFactoryTest {

    
    
    @Test
    public void testMultipleBuffer() throws Exception {       
                
        NameImpl name = new NameImpl("ds","MultipleBuffer");
        Process process = Processors.createProcess( name );
        assertNotNull("MultipleBufferProcess not found", process);
        
    }
    
}
