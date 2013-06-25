/*
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
import org.junit.Ignore;
import org.junit.Test;

/**
 * @author DamianoG
 *
 */
public class TargetPropertiesLoaderTest {

    public TargetPropertiesLoaderTest(){};
    
    @Test @Ignore
    public void testTargetLoading(){
        
        System.setProperty("EXTERNAL_PROP_DIR_PATH", "C:\\Users\\geosolutions\\Documents\\destination\\targets_raster\\tiled");
        
        
        TargetPropertiesLoader tpl = new TargetPropertiesLoader();
        
        Map mm = TargetPropertiesLoader.loadDistances();
        Properties p1 = tpl.getTargetURIs();
        Properties p2 = tpl.getTargetMapping();
        Properties p3 = tpl.getTargetZoneValues();
        Map<Integer, String> m1 = tpl.getTargetValuesZone();
        List<Integer> l1 = tpl.getAllCopSuoloValues();
        
        Assert.assertNotNull(mm);
        Assert.assertNotNull(p1);
        Assert.assertNotNull(p2);
        Assert.assertNotNull(p3);
        Assert.assertNotNull(m1);
        Assert.assertNotNull(l1);
    }
}
