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

import junit.framework.TestCase;

import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.feature.DefaultFeatureCollection;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.filter.FilterFactory;

import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.LinearRing;
import com.vividsolutions.jts.geom.PrecisionModel;

public class MultipleBufferTest extends TestCase {

    FilterFactory ff = CommonFactoryFinder.getFilterFactory(null);

    public void testExecutePoint() throws Exception {
        SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
        tb.setName("featureType");
        tb.add("geometry", Geometry.class);
        tb.add("integer", Integer.class);

        GeometryFactory gf = new GeometryFactory();
        SimpleFeatureBuilder b = new SimpleFeatureBuilder(tb.buildFeatureType());

        DefaultFeatureCollection features = new DefaultFeatureCollection(null, b.getFeatureType());
        for (int i = 0; i < 2; i++) {
            b.add(gf.createPoint(new Coordinate(i, i)));
            b.add(i);
            features.add(b.buildFeature(i + ""));
        }
        Double[] distance = new Double[] {200.0,300.0,400.0,500.0};
        MultipleBuffer process = new MultipleBuffer();
		SimpleFeatureCollection output = process.execute(features, null, null,
				distance, new String[] { "distance1", "distance2", "distance3",
						"distance4" }, null, null);
        assertEquals(1, output.size());

        SimpleFeatureIterator iterator = output.features();
        for (int numFeatures = 0; numFeatures < 1; numFeatures++) {            
            SimpleFeature sf = iterator.next();
            assertNotNull(sf);            
            assertNotNull(sf.getDefaultGeometry());
            assertNotNull(sf.getAttribute("geometry"));
            assertNotNull(sf.getAttribute("geometry2"));
            assertEquals(200.0, sf.getAttribute("distance1"));
        }
        
        assertEquals(new ReferencedEnvelope(-500, 501, -500, 501, null), output.getBounds());
        assertEquals(1, output.size());
    }

    public void testExecuteLineString() throws Exception {
        SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
        tb.setName("featureType");
        tb.add("geometry", Geometry.class);
        tb.add("integer", Integer.class);

        GeometryFactory gf = new GeometryFactory();
        SimpleFeatureBuilder b = new SimpleFeatureBuilder(tb.buildFeatureType());

        DefaultFeatureCollection features = new DefaultFeatureCollection(null, b.getFeatureType());
        for (int numFeatures = 0; numFeatures < 5; numFeatures++) {
            Coordinate array[] = new Coordinate[4];
            int j = 0;
            for (int i = 0 + numFeatures; i < 4 + numFeatures; i++) {
                array[j] = new Coordinate(i, i);
                j++;
            }
            b.add(gf.createLineString(array));
            b.add(0);
            features.add(b.buildFeature(numFeatures + ""));
        }
        Double[] distance = new Double[] {200.0,300.0,400.0,500.0};
        MultipleBuffer process = new MultipleBuffer();
		SimpleFeatureCollection output = process.execute(features, null, null,
				distance, new String[] { "distance1", "distance2", "distance3",
						"distance4" }, null, null);
        assertEquals(1, output.size());
                
        SimpleFeatureIterator iterator = output.features();
        for (int numFeatures = 0; numFeatures < 1; numFeatures++) {            
            SimpleFeature sf = iterator.next();
            assertNotNull(sf);            
            assertNotNull(sf.getDefaultGeometry());
            assertNotNull(sf.getAttribute("geometry"));            
            assertNotNull(sf.getAttribute("geometry2"));
            assertEquals(200.0, sf.getAttribute("distance1"));
        }
        
        assertEquals(new ReferencedEnvelope(-500, 507, -500, 507, null), output.getBounds());
        assertEquals(1, output.size());
    }
    
    public void testOutputName() throws Exception {
        SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
        tb.setName("featureType");
        tb.add("geometry", Geometry.class);
        tb.add("integer", Integer.class);

        GeometryFactory gf = new GeometryFactory();
        SimpleFeatureBuilder b = new SimpleFeatureBuilder(tb.buildFeatureType());

        DefaultFeatureCollection features = new DefaultFeatureCollection(null, b.getFeatureType());
        for (int numFeatures = 0; numFeatures < 5; numFeatures++) {
            Coordinate array[] = new Coordinate[4];
            int j = 0;
            for (int i = 0 + numFeatures; i < 4 + numFeatures; i++) {
                array[j] = new Coordinate(i, i);
                j++;
            }
            b.add(gf.createLineString(array));
            b.add(0);
            features.add(b.buildFeature(numFeatures + ""));
        }
        Double[] distance = new Double[] {200.0,300.0,400.0,500.0};
        MultipleBuffer process = new MultipleBuffer();
		SimpleFeatureCollection output = process.execute(features, null, null,
				distance, new String[] { "distance1", "distance2", "distance3",
						"distance4" }, null, "dummy");
        assertEquals(1, output.size());
                
        SimpleFeatureIterator iterator = output.features();
        for (int numFeatures = 0; numFeatures < 1; numFeatures++) {            
            SimpleFeature sf = iterator.next();
            assertEquals("dummy", sf.getFeatureType().getName().getLocalPart());
        }
                
        assertEquals(1, output.size());
    }
    
    public void testSplitLineString() throws Exception {
        SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
        tb.setName("featureType");
        tb.add("geometry", Geometry.class);
        tb.add("integer", Integer.class);

        GeometryFactory gf = new GeometryFactory();
        SimpleFeatureBuilder b = new SimpleFeatureBuilder(tb.buildFeatureType());

        DefaultFeatureCollection features = new DefaultFeatureCollection(null, b.getFeatureType());
        for (int numFeatures = 0; numFeatures < 5; numFeatures++) {
            Coordinate array[] = new Coordinate[4];
            int j = 0;
            for (int i = 0 + numFeatures; i < 4 + numFeatures; i++) {
                array[j] = new Coordinate(i, i);
                j++;
            }
            b.add(gf.createLineString(array));
            b.add(0);
            features.add(b.buildFeature(numFeatures + ""));
        }
        Double[] distance = new Double[] {200.0,300.0,400.0,500.0};
        MultipleBuffer process = new MultipleBuffer();
        String[] distanceNames = new String[] {"distance1", "distance2", "distance3", "distance4"};
		SimpleFeatureCollection output = process.execute(features, null, null,
				distance, distanceNames, true, null);
        assertEquals(4, output.size());
                
        SimpleFeatureIterator iterator = output.features();
        for (int numFeatures = 0; numFeatures < 4; numFeatures++) {          	
            SimpleFeature sf = iterator.next();
            assertNotNull(sf);            
            assertNotNull(sf.getDefaultGeometry());
            assertNotNull(sf.getAttribute("geometry"));                        
            assertEquals(distance[numFeatures], sf.getAttribute("distance"));
            assertEquals(distanceNames[numFeatures], sf.getAttribute("description"));
        }
        
        
    }

    public void testExecutePolygon() throws Exception {
        SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
        tb.setName("featureType");
        tb.add("geometry", Geometry.class);
        tb.add("integer", Integer.class);

        GeometryFactory gf = new GeometryFactory();
        SimpleFeatureBuilder b = new SimpleFeatureBuilder(tb.buildFeatureType());

        DefaultFeatureCollection features = new DefaultFeatureCollection(null, b.getFeatureType());
        for (int numFeatures = 0; numFeatures < 5; numFeatures++) {
            Coordinate array[] = new Coordinate[4];
            int j = 0;
            for (int i = 0 + numFeatures; i < 3 + numFeatures; i++) {
                array[j] = new Coordinate(i, i);
                j++;
            }
            array[3] = new Coordinate(numFeatures, numFeatures);
            LinearRing shell = new LinearRing(array, new PrecisionModel(), 0);
            b.add(gf.createPolygon(shell, null));
            b.add(0);
            features.add(b.buildFeature(numFeatures + ""));
        }
        Double[] distance = new Double[] {200.0,300.0,400.0,500.0};
        MultipleBuffer process = new MultipleBuffer();
		SimpleFeatureCollection output = process.execute(features, null, null,
				distance, new String[] { "distance1", "distance2", "distance3",
						"distance4" }, null, null);
        assertEquals(1, output.size());
        
        SimpleFeatureIterator iterator = output.features();
        for (int numFeatures = 0; numFeatures < 1; numFeatures++) {            
            SimpleFeature sf = iterator.next();
            assertNotNull(sf);            
            assertNotNull(sf.getDefaultGeometry());
            assertNotNull(sf.getAttribute("geometry"));
            assertNotNull(sf.getAttribute("geometry2"));
            assertEquals(200.0, sf.getAttribute("distance1"));
        }
        
        assertEquals(new ReferencedEnvelope(-500, 506, -500, 506, null), output.getBounds());
        assertEquals(1, output.size());
    }
    
    public void testSingleDistance() throws Exception {
        SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
        tb.setName("featureType");
        tb.add("geometry", Geometry.class);
        tb.add("integer", Integer.class);

        GeometryFactory gf = new GeometryFactory();
        SimpleFeatureBuilder b = new SimpleFeatureBuilder(tb.buildFeatureType());

        DefaultFeatureCollection features = new DefaultFeatureCollection(null, b.getFeatureType());
        for (int i = 0; i < 2; i++) {
            b.add(gf.createPoint(new Coordinate(i, i)));
            b.add(i);
            features.add(b.buildFeature(i + ""));
        }
        
        MultipleBuffer process = new MultipleBuffer();
		SimpleFeatureCollection output = process.execute(features, 500.0,
				"distance1", null, null, null, null);
        assertEquals(1, output.size());

        SimpleFeatureIterator iterator = output.features();
        for (int numFeatures = 0; numFeatures < 1; numFeatures++) {            
            SimpleFeature sf = iterator.next();
            assertNotNull(sf);            
            assertNotNull(sf.getDefaultGeometry());
            assertNotNull(sf.getAttribute("geometry"));            
            assertEquals(500.0, sf.getAttribute("distance1"));
        }
        
        assertEquals(new ReferencedEnvelope(-500, 501, -500, 501, null), output.getBounds());
        assertEquals(1, output.size());
    }

   
}
