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
package it.geosolutions.geobatch.destination;

import it.geosolutions.geobatch.destination.commons.PostgisOnlineTestCase;
import it.geosolutions.geobatch.destination.zeroremoval.ZeroRemovalComputation;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.geotools.data.DataUtilities;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.jdbc.JDBCDataStoreFactory;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;

/**
 * @author DamianoG
 * 
 */
public class ZeroRemovalTest extends PostgisOnlineTestCase{

    @Before
    public void before() throws Exception{
        setOriginTable("siig_geo_ln_arco_1");
        testTable = "siig_geo_ln_arcoo_1";
        super.before();
    }
    
    @Test
    public void testZeroRemovalProcess() throws IOException {
        ZeroRemovalComputation vulnerabilityComputation = new ZeroRemovalComputation(super.testTable, new ProgressListenerForwarder(null));
        Map<String, Serializable> datastoreParams = new HashMap<String, Serializable>();
        datastoreParams.put(JDBCDataStoreFactory.DBTYPE.key, "postgis");
        datastoreParams.put(JDBCDataStoreFactory.HOST.key, getFixture().getProperty("pg_host"));
        datastoreParams.put(JDBCDataStoreFactory.PORT.key, getFixture().getProperty("pg_port"));
        datastoreParams.put(JDBCDataStoreFactory.SCHEMA.key, getFixture().getProperty("pg_schema"));
        datastoreParams.put(JDBCDataStoreFactory.DATABASE.key, getFixture().getProperty("pg_database"));
        datastoreParams.put(JDBCDataStoreFactory.USER.key, getFixture().getProperty("pg_user"));
        datastoreParams.put(JDBCDataStoreFactory.PASSWD.key, getFixture().getProperty("pg_password"));
        vulnerabilityComputation.removeZeros(datastoreParams, null, 1, 1);
        System.out.println("");
    }

    @Override
    protected SimpleFeatureType getTmpTable() throws IOException{
        if(originTable == null){
            Assert.fail("You must setup the origin table to copy, call the method setOriginTable(tableName) where tableName is an existing table into the schema");
        }
        SimpleFeatureType schema = (SimpleFeatureType) dataStore.getSchema(originTable);
        SimpleFeatureTypeBuilder sftb = new SimpleFeatureTypeBuilder();
        sftb.setName(testTable);
        sftb.add("id_geo_arco", Integer.class);
        sftb.addAll(schema.getAttributeDescriptors());
        return sftb.buildFeatureType();
    }
    
    @Override
    protected void loadFeature(OutputObject objOut) throws IOException{
        List<SimpleFeature> list = new ArrayList<SimpleFeature>();
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid1=1|1|0|0|0|0|0|1|0|1|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid2=2|2|0|0|0|0|0|1|0|1|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid3=3|3|0|0|0|0|0|1|0|1|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid4=4|4|0|0|0|0|0|1|0|1|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid5=5|5|0|0|0|0|0|1|0|1|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid6=6|0|0|0|0|0|0|1|0|1|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid7=7|7|0|0|0|0|0|1|0|1|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid8=8|0|0|0|0|0|0|1|0|20|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid8=9|0|0|0|0|0|0|20|0|0|0|0"));
        SimpleFeatureCollection sfc = DataUtilities.collection(list);
        objOut.getWriter().addFeatures(sfc);
    }
    
    @Override
    protected String getFixtureId() {
        return "destination";
    }
}
