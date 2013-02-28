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
import org.opengis.feature.type.GeometryDescriptor;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryCollection;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.MultiPolygon;
import com.vividsolutions.jts.simplify.TopologyPreservingSimplifier;

/**
 * Buffers a feature collection using a certain distance
 * 
 * @author Mauro Bartolomeoli - GeoSolutions
 *
 * @source $URL$
 */
@DescribeProcess(title = "NotHumanBuffer", description = "Buffers features by a distance value supplied as a parameter.")
public class NotHumanBuffer implements GSProcess {
    @DescribeResult(description = "Buffered feature collection")
    public SimpleFeatureCollection execute(
            @DescribeParameter(name = "features", description = "Input feature collection") SimpleFeatureCollection features,
            @DescribeParameter(name = "distance", description = "Fixed value to use for the buffer distance") Double distance,
            @DescribeParameter(name = "distanceName", description = "Name of the output attribute for distance", min=0, max=1) String distanceName) {

        if (distance == null) {
            throw new IllegalArgumentException("Buffer distance was not specified");
        } 
        
        return new BufferedFeatureCollection(features, distance, distanceName);
    }

    /**
     * Wrapper that will trigger the buffer computation as features are requested
     */
    static class BufferedFeatureCollection extends SimpleProcessingCollection {

        Double distance;        
        
        String distanceName;
        
        SimpleFeatureCollection delegate;

        public BufferedFeatureCollection(SimpleFeatureCollection delegate,
                Double distance, String distanceName) {
            this.distance = distance;
            this.distanceName = distanceName;
            this.delegate = delegate;
            
        }

        @Override
        public SimpleFeatureIterator features() {
            return new BufferedFeatureIterator(delegate, this.distance, getSchema());
        }

        @Override
        public ReferencedEnvelope getBounds() {        
            ReferencedEnvelope re = delegate.getBounds();
            re.expandBy(distance);
            return re;       
        }

        @Override
        protected SimpleFeatureType buildTargetFeatureType() {
            // create schema
            SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
            for (AttributeDescriptor descriptor : delegate.getSchema().getAttributeDescriptors()) {
                if (!(descriptor.getType() instanceof GeometryTypeImpl)
                        || (!delegate.getSchema().getGeometryDescriptor().equals(descriptor))) {                    
                } else {
                    AttributeTypeBuilder builder = new AttributeTypeBuilder();
                    builder.setBinding(MultiPolygon.class);
                    AttributeDescriptor attributeDescriptor = builder.buildDescriptor(descriptor
                            .getLocalName(), builder.buildType());
                    tb.add(attributeDescriptor);
                    if(tb.getDefaultGeometry() == null) {
                        tb.setDefaultGeometry(descriptor.getLocalName());
                    }
                }
            }
            
            // distance attribute
            AttributeTypeBuilder builder = new AttributeTypeBuilder();
            builder.setBinding(Double.class);
            String name = this.distanceName == null ? "distance" : this.distanceName;
            AttributeDescriptor attributeDescriptor = builder.buildDescriptor(name, builder.buildType());
            tb.add(attributeDescriptor);
            
            tb.setDescription(delegate.getSchema().getDescription());
            tb.setCRS(delegate.getSchema().getCoordinateReferenceSystem());
            tb.setName(delegate.getSchema().getName());
            return tb.buildFeatureType();
        }
        
        @Override
        public int size() {
            return delegate.size() > 0 ? 1 : 0;
        }

      
    }

    /**
     * Buffers each feature as we scroll over the collection
     */
    static class BufferedFeatureIterator implements SimpleFeatureIterator {
        SimpleFeatureIterator delegate;

        SimpleFeatureCollection collection;

        Double distance;
        
        GeometryFactory geometryFactory = new GeometryFactory();
        
        int count;

        SimpleFeatureBuilder fb;

        SimpleFeature next;

        public BufferedFeatureIterator(SimpleFeatureCollection delegate, 
                Double distance, SimpleFeatureType schema) {
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
                for(AttributeDescriptor attr : fb.getFeatureType().getAttributeDescriptors()) {
                    if(attr instanceof GeometryDescriptor) {
                        TopologyPreservingSimplifier simplifier = new TopologyPreservingSimplifier(aggregate);
                        simplifier.setDistanceTolerance(5);
                        fb.add(simplifier.getResultGeometry().buffer(distance));
                    } else {
                        fb.add(distance);
                    }
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
