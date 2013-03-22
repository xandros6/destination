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

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.feature.AttributeTypeBuilder;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.feature.type.GeometryTypeImpl;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.process.feature.gs.SimpleProcessingCollection;
import org.geotools.process.gs.GSProcess;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.feature.type.AttributeDescriptor;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryCollection;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.MultiPolygon;
import com.vividsolutions.jts.simplify.TopologyPreservingSimplifier;

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
            @DescribeParameter(name = "distanceNames", description = "Names of the output attributes for distance", min=0) String[] distanceNames) {
    
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
        
        return new BufferedFeatureCollection(features, bufferDistances, bufferDistanceNames);
    }
    
    /**
     * Wrapper that will trigger the buffer computation as features are requested
     */
    static class BufferedFeatureCollection extends SimpleProcessingCollection {

        List<Double> distance;        
        
        List<String> distanceName;
        
        SimpleFeatureCollection delegate;
                

        public BufferedFeatureCollection(SimpleFeatureCollection delegate,
                List<Double> distance, List<String> distanceName) {
            this.distance = distance;
            this.distanceName = distanceName;
            this.delegate = delegate;            
        }

        @Override
        public SimpleFeatureIterator features() {
            return new BufferedFeatureIterator(delegate, this.distance.toArray(new Double[] {}), getSchema());
        }

        @Override
        public ReferencedEnvelope getBounds() {        
            ReferencedEnvelope re = delegate.getBounds();
            double max = 0.0;
            for(double dist : distance) {
                if(dist > max)
                    max = dist;
                
            }
            re.expandBy(max);
            return re;       
        }

        @Override
        protected SimpleFeatureType buildTargetFeatureType() {
            // create schema
            SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
            for (AttributeDescriptor descriptor : delegate.getSchema().getAttributeDescriptors()) {
             // skips not geometry attributes
                if (!(descriptor.getType() instanceof GeometryTypeImpl)
                        || (!delegate.getSchema().getGeometryDescriptor().equals(descriptor))) {                    
                } else {
                    // creates a geometry for each specified distance
                    // the first one has the same name of the original feature
                    // geometry; the other ones have a number postfix, starting from 2 (geometry, geometry2, ..., geometryN)                    
                    for(int i = 0; i<distance.size();i++) {                                                
                        String geometryName = descriptor.getLocalName();
                        if(i>0) {
                            geometryName += (i+1);
                        }                                                                       
                        tb.add(geometryName, MultiPolygon.class, delegate.getSchema().getCoordinateReferenceSystem());
                        if(tb.getDefaultGeometry() == null) {
                            tb.setDefaultGeometry(geometryName);
                        }
                    }
                }
            }
            // creates an attribute for each specified distance
            // they are named distance1, ..., distanceN by default, if not overridden by
            // distanceName parameter    
            for(int i = 0; i<distance.size();i++) {                
                AttributeTypeBuilder builder = new AttributeTypeBuilder();
                builder.setBinding(Double.class);
                if(this.distanceName == null) {
                    this.distanceName = new ArrayList<String>();
                }
                String name = i<this.distanceName.size() ? this.distanceName.get(i) : "distance"+(i+1);
                AttributeDescriptor attributeDescriptor = builder.buildDescriptor(name, builder.buildType());
                tb.add(attributeDescriptor);
            }
            
            // copies cfg from original feature (description, crs, name)
            tb.setDescription(delegate.getSchema().getDescription());
            tb.setCRS(delegate.getSchema().getCoordinateReferenceSystem());
            tb.setName(delegate.getSchema().getName());
            return tb.buildFeatureType();
        }
        
        @Override
        public int size() {
            // the output feature is aggregated, so it can have 0 or 1 items
            return delegate.size() > 0 ? 1 : 0;
        }

      
    }

    /**
     * Creates Buffers as we scroll over the collection
     */
    static class BufferedFeatureIterator implements SimpleFeatureIterator {
        SimpleFeatureIterator delegate;

        SimpleFeatureCollection collection;

        Double[] distance;
        
        
        GeometryFactory geometryFactory = new GeometryFactory();
        
        int count;

        SimpleFeatureBuilder fb;

        SimpleFeature next;

        public BufferedFeatureIterator(SimpleFeatureCollection delegate, 
                Double[] distance,  SimpleFeatureType schema) {
            this.delegate = delegate.features();            
            this.distance = distance;
            this.collection = delegate;            
            
            fb = new SimpleFeatureBuilder(schema);
        }

        public void close() {
            delegate.close();
        }

        public boolean hasNext() {
            if(next != null) {
                return true;
            }
            if(delegate.hasNext()) {                                
                List<Geometry> geometries = new ArrayList<Geometry>();
                while(delegate.hasNext()) {
                    SimpleFeature f = delegate.next();
                    Geometry geometry = (Geometry)f.getDefaultGeometry();
                    if(geometry != null) {
                        geometries.add(geometry);
                    }                                       
                }
                GeometryCollection aggregate = geometryFactory.createGeometryCollection(geometries.toArray(new Geometry[] {}));
                TopologyPreservingSimplifier simplifier = new TopologyPreservingSimplifier(aggregate);
                simplifier.setDistanceTolerance(5);
                Geometry simplified = simplifier.getResultGeometry();
                Geometry buffered = null;
                Geometry previous = null;
                double previousDistance = 0.0;
                                                       
                for(int i=0;i<distance.length;i++) { 
                    if(distance[i] == 0) {
                        // no geometry for distance 0
                        buffered = null;
                    } else if(i==0) {                
                        // first not 0 buffer: we need to calculate the buffer, using iterative approach 
                        buffered = BufferUtils.iterativeBuffer(simplified, distance[i],50);
                        previousDistance = distance[i];
                    } else if(distance[i] == previousDistance) {
                        // we can use previous buffer, since we have the same distance
                        buffered = previous;                            
                    } else {
                        // we can grow the last calculated buffer (faster) by the distance difference
                        buffered = BufferUtils.iterativeBuffer(previous, distance[i] - previousDistance, 50);
                        previousDistance = distance[i];
                    }                                
                    if(buffered != null) {
                        previous = buffered;
                    }                        
                    
                    fb.add(buffered);
                }
                for(int i=0;i<distance.length;i++) {
                    fb.add(distance[i]);
                }
                
                
                next = fb.buildFeature("" + count);
                count++;
                fb.reset();
                return true;
            }
            next = null;
            return false;            
        }       

        

        public SimpleFeature next() throws NoSuchElementException {
            if (!hasNext()) {
                throw new NoSuchElementException("hasNext() returned false!");
            }
            SimpleFeature result = next;
            next = null;
            return result;
        }

    }

}
