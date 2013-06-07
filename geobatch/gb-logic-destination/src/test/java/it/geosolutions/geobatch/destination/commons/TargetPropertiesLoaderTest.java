/*
 *  https://github.com/geosolutions-it/fra2015
 *  Copyright (C) 2007-2012 GeoSolutions S.A.S.
 *  http://www.geo-solutions.it
 *
 *  GPLv3 + Classpath exception
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package it.geosolutions.geobatch.destination.commons;

import it.geosolutions.geobatch.destination.vulnerability.TargetPropertiesLoader;

import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.junit.Assert;
import org.junit.Test;

/**
 * @author DamianoG
 *
 */
public class TargetPropertiesLoaderTest extends Assert{

    @Test
    public void testTargetLoading(){
        
        System.setProperty("EXTERNAL_PROP_DIR_PATH", "C:\\Users\\geosolutions\\Documents\\destination\\targets_raster\\tiled");
        
        
        TargetPropertiesLoader tpl = new TargetPropertiesLoader();
        
        Map mm = TargetPropertiesLoader.loadDistances();
        Properties p1 = tpl.getTargetURIs();
        Properties p2 = tpl.getTargetMapping();
        Properties p3 = tpl.getTargetZoneValues();
        Map<Integer, String> m1 = tpl.getTargetValuesZone();
        List<Integer> l1 = tpl.getAllCopSuoloValues();
        
        assertNotNull(mm);
        assertNotNull(p1);
        assertNotNull(p2);
        assertNotNull(p3);
        assertNotNull(m1);
        assertNotNull(l1);
    }
}
