package it.geosolutions.process.gs;

import com.vividsolutions.jts.geom.Geometry;

/**
 * Utility methods for buffer building.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class BufferUtils {
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

}
