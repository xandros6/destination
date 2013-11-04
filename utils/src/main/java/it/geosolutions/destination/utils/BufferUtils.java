package it.geosolutions.destination.utils;



import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.NoSuchElementException;

import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.feature.AttributeTypeBuilder;
import org.geotools.feature.NameImpl;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.feature.type.GeometryTypeImpl;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.process.feature.gs.SimpleProcessingCollection;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.feature.type.AttributeDescriptor;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryCollection;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.MultiPolygon;
import com.vividsolutions.jts.simplify.TopologyPreservingSimplifier;

/**
 * Utility methods for buffer building.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class BufferUtils {
	
	/**
     * Wrapper that will trigger the buffer computation as features are requested
     */
    static class BufferedFeatureCollection extends SimpleProcessingCollection {

    	// list of distances for the N buffers to calculate
        List<Double> distance;                
        // list of attribute names for the N buffers to calculate
        List<String> distanceName;
        // input feature collection on which to calculate the N buffers        
        SimpleFeatureCollection inputFeatureCollection;
        // name of the output featuretype
        String outputName;
        
        boolean split = false;
                

        public BufferedFeatureCollection(SimpleFeatureCollection delegate,
                List<Double> distance, List<String> distanceName, boolean split,
                String outputName) {
            this.distance = distance;
            this.distanceName = distanceName;
            this.inputFeatureCollection = delegate;            
            this.split = split;
            this.outputName = outputName;
        }

        @Override
        public SimpleFeatureIterator features() {
			return new BufferedFeatureIterator(inputFeatureCollection,
					this.distance.toArray(new Double[] {}),
					this.distanceName.toArray(new String[] {}), 
					split, getSchema());
        }

        /**
         * Generate output bounds, expanding the input envelope
         * by the max buffer distance to calculate.
         */
        @Override
        public ReferencedEnvelope getBounds() {        
            ReferencedEnvelope re = inputFeatureCollection.getBounds();
            double max = 0.0;
            for(double dist : distance) {
                if(dist > max)
                    max = dist;
                
            }
            re.expandBy(max);
            return re;       
        }

        /**
         * Builds output Feature schema, composed of N geometries (for the N distances)
         * and N distance attributes.
         * 
         */
        @Override
        protected SimpleFeatureType buildTargetFeatureType() {
            // create schema
            SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
            for (AttributeDescriptor descriptor : inputFeatureCollection.getSchema().getAttributeDescriptors()) {
            	// skips not geometry attributes
                if (!(descriptor.getType() instanceof GeometryTypeImpl)
                        || (!inputFeatureCollection.getSchema().getGeometryDescriptor().equals(descriptor))) {                    
                } else {
                	if(split) {
                		// only one geometry
                		String geometryName = descriptor.getLocalName();
                		tb.add(descriptor.getLocalName(), MultiPolygon.class, inputFeatureCollection.getSchema().getCoordinateReferenceSystem());
                		tb.setDefaultGeometry(geometryName);
                	} else {
	                    // creates a geometry for each specified distance
	                    // the first one has the same name of the original feature
	                    // geometry; the other ones have a number postfix, starting from 2 (geometry, geometry2, ..., geometryN)                    
	                    for(int i = 0; i<distance.size();i++) {                                                
	                        String geometryName = descriptor.getLocalName();
	                        if(i>0) {
	                            geometryName += (i+1);
	                        }                                                                       
	                        tb.add(geometryName, MultiPolygon.class, inputFeatureCollection.getSchema().getCoordinateReferenceSystem());
	                        if(tb.getDefaultGeometry() == null) {
	                            tb.setDefaultGeometry(geometryName);
	                        }
	                    }
                	}
                }
            }
            if(split) {
            	// distance
            	AttributeTypeBuilder builder = new AttributeTypeBuilder();
                builder.setBinding(Double.class);
                AttributeDescriptor attributeDescriptor = builder.buildDescriptor("distance", builder.buildType());
                tb.add(attributeDescriptor);
                // description
                builder.setBinding(String.class);
                attributeDescriptor = builder.buildDescriptor("description", builder.buildType());
                tb.add(attributeDescriptor);
            } else {
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
            }
            
            // copies cfg from original feature (description, crs, name)
            tb.setDescription(inputFeatureCollection.getSchema().getDescription());
            tb.setCRS(inputFeatureCollection.getSchema().getCoordinateReferenceSystem());
            tb.setName(outputName == null ? inputFeatureCollection.getSchema().getName() : new NameImpl(outputName));
            return tb.buildFeatureType();
        }
        
        @Override
        public int size() {
        	if(split) {
        		return inputFeatureCollection.size() > 0 ? distanceName.size() : 0;
        	} else {
	            // the output feature is aggregated, so it can have 0 or 1 items
	            return inputFeatureCollection.size() > 0 ? 1 : 0;
        	}
        }

      
    }

    /**
     * Creates Buffers as we scroll over the collection
     */
    static class BufferedFeatureIterator implements SimpleFeatureIterator {
    	// input features iterator    	
        SimpleFeatureIterator inputIterator;
        
        // list of distances to calculate
        Double[] distance;        
        
        // list of distance descriptions to calculate
        String[] distanceDescriptions;
        
        boolean split = false;
        
        GeometryFactory geometryFactory = new GeometryFactory();
        
        int currentId;

        SimpleFeatureBuilder fb;

        SimpleFeature next;
        
        List<SimpleFeature> features = null;
        
        int currentDistance = 0;

		public BufferedFeatureIterator(SimpleFeatureCollection inputFeatures,
				Double[] distance, String[] distanceDescriptions,
				boolean split, SimpleFeatureType schema) {
			this.inputIterator = inputFeatures.features();
			this.distance = distance;
			this.distanceDescriptions = distanceDescriptions;
			this.split = split;			
			fb = new SimpleFeatureBuilder(schema);
			
		}

        public void close() {
            inputIterator.close();
        }

        public boolean hasNext() {
            if(next != null) {
                return true;
            }
            Geometry simplified = null;
            if(features != null || inputIterator.hasNext()) {    
            	if(features == null || !split) { 
	            	// aggregates input geometries into one before buffering
	                List<Geometry> geometries = new ArrayList<Geometry>();
	                while(inputIterator.hasNext()) {
	                    SimpleFeature f = inputIterator.next();
	                    Geometry geometry = (Geometry)f.getDefaultGeometry();
	                    if(geometry != null) {
	                        geometries.add(geometry);
	                    }                                       
	                }
	                GeometryCollection aggregate = geometryFactory.createGeometryCollection(geometries.toArray(new Geometry[] {}));
	                // simplify aggregated geometry
	                TopologyPreservingSimplifier simplifier = new TopologyPreservingSimplifier(aggregate);
	                simplifier.setDistanceTolerance(5);
	                simplified = simplifier.getResultGeometry();
            	}
                if(split) {
                	if(features == null) {
                		features = new ArrayList<SimpleFeature>();
                		 // iterates through distances to create buffers
    	                // take track of previous results for optimizations
    	                // distance are assumed ordered
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
    	                    fb.add(distance[i]);
    	                    fb.add(distanceDescriptions[i]);
    	                    features.add(fb.buildFeature("" + currentId));
    	                    currentId++;
    	                    fb.reset();
    	                }    	                
                	}
                	if(currentDistance < distance.length) {
                		next = features.get(currentDistance++);
            			return true;
            		}                	
                } else {
	                // iterates through distances to create buffers
	                // take track of previous results for optimizations
	                // distance are assumed ordered
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
	                
	                // add distance attributes
	                for(int i=0;i<distance.length;i++) {
	                    fb.add(distance[i]);
	                }                
	                
	                next = fb.buildFeature("" + currentId);
	                currentId++;
	                fb.reset();
	                return true;
                }
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
	
    /**
     * Creates a buffer by iterations of "step" distances.
     * It grows geometry by step distance, until a distance buffer is reached.
     * This optimize buffer creation speed.
     * 
     * @param geometry geometry to be buffered
     * @param distance final buffer size
     * @param step iteration size (50 seems a good choice)
     * @return
     */
    public static Geometry iterativeBuffer(Geometry geometry, Double distance, int step) {
        while(distance > 0) {
            geometry = geometry.buffer(Math.min(distance, step));
            distance = distance - step;
        }
        
        return geometry;
    }
    
    /**
     * Creates a set of buffers, aggregating the input features geometries and
     * generating a buffer for any given distance value.
     * 
     * @param features
     * @param distance
     * @param distanceName
     * @param distances
     * @param distanceNames
     * @param split
     * @return
     */
    public static SimpleFeatureCollection createMultipleBuffer(
            SimpleFeatureCollection features,            
            Double[] distances,
            String[] distanceNames,
            boolean split
            ) {
    	
        
		return createMultipleBuffer(features,
				distances, distanceNames, split, null);
    } 
    
    /**
     * Creates a set of buffers, aggregating the input features geometries and
     * generating a buffer for any given distance value.
     * 
     * @param features
     * @param distance
     * @param distanceName
     * @param distances
     * @param distanceNames
     * @param split
     * @return
     */
    public static SimpleFeatureCollection createMultipleBuffer(
            SimpleFeatureCollection features,            
            Double[] distances,
            String[] distanceNames,
            boolean split,
            String outputName
            ) {
    	
        
		return new BufferedFeatureCollection(features,
				Arrays.asList(distances), Arrays.asList(distanceNames), split, outputName);
    } 
    
    /**
     * Creates a set of buffers, aggregating the input features geometries and
     * generating a buffer for any given distance value.
     * 
     * @param features
     * @param distance
     * @param distanceName
     * @param distances
     * @param distanceNames
     * @param split
     * @return
     */
    public static SimpleFeatureCollection createMultipleBuffer(
            SimpleFeatureCollection features,            
            Double[] distances,
            String[] distanceNames
            ) {
    	
        
        return createMultipleBuffer(features, distances, distanceNames, false);
    } 

}
