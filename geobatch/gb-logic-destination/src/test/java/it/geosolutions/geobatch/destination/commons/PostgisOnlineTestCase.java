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

import static org.junit.Assume.assumeTrue;
import it.geosolutions.geobatch.destination.OutputObject;
import it.geosolutions.geobatch.destination.vulnerability.VulnerabilityComputation;
import it.geosolutions.geobatch.destination.vulnerability.VulnerabilityOperationTest;

import java.io.IOException;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.geotools.data.DataStore;
import org.geotools.data.DataStoreFinder;
import org.geotools.data.DataUtilities;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.jdbc.JDBCDataStoreFactory;
import org.geotools.test.OnlineTestSupport;
import org.junit.After;
import org.junit.Before;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author DamianoG
 *
 */
public abstract class PostgisOnlineTestCase extends OnlineTestSupport {
    
    private final static Logger LOGGER = LoggerFactory.getLogger(PostgisOnlineTestCase.class);
    
    public static final String TEST_VULNERABILITY_TABLE = "tmp_vulnerability";
    
    protected JDBCDataStore dataStore;
    protected OutputObject vulnerabilityObj;
    protected Transaction outTransaction = null;
    
    protected abstract String getFixtureId();

    @Before
    public void before() throws Exception {
        LOGGER.debug(" BaseTest:: <start_of_before()> Create temporary resources on DB...");
        super.before();         
        try{
            connect();
        } catch(Exception e) {
            LOGGER.warn("connect() failed, skipping test ");
            assumeTrue(false);
        }
        outTransaction = new DefaultTransaction();
        // Remove the table... nel dubbio!
        removeTable();
        dataStore.createSchema(getTmpTable());
        try{
            
            vulnerabilityObj = new OutputObject(dataStore, outTransaction, TEST_VULNERABILITY_TABLE, VulnerabilityComputation.GEOID);
            loadFeature(vulnerabilityObj);
        }
        finally{
            if(outTransaction != null){
                try {
                    outTransaction.commit();
                } catch (IOException e) {
                    LOGGER.error(e.getMessage(), e);
                }
            }
        }
        LOGGER.info("---------- Running Test " + getClass().getSimpleName());
    }
    
    @After
    public void after() throws Exception {
        LOGGER.debug(" BaseTest:: <start_of_after()> cleaning created resources...");
        super.after();
        if(outTransaction != null){
            outTransaction.close();
        }
        removeTable();
        if(dataStore != null){
            dataStore.dispose();
            dataStore = null;
        }
        LOGGER.info("---------- End Test " + getClass().getSimpleName());
    }
    
    protected void connect() throws Exception {
        if(dataStore != null){
            return;
        }
        dataStore = (JDBCDataStore)createDatastore();
    }
    
    protected void disconnect() throws Exception {
        
    }
    
    protected DataStore createDatastore() throws IOException {
        Map params = getPostgisParams();
        DataStore dataStore = DataStoreFinder.getDataStore(params);
        return dataStore;
    }
    
    @Override
    protected boolean isOnline() throws Exception {
        connect();
        if(dataStore == null){
            return false;
        }
        String [] names = dataStore.getTypeNames();
        for(String name : names){
            if(name.equals(getFixture().getProperty("src_table"))){
                return true;
            }
        }
        return false;
    }
    
    public Map<String,Serializable> getPostgisParams() {
        Map<String,Serializable> params = new HashMap<String,Serializable>();
        params.put(JDBCDataStoreFactory.DBTYPE.key, "postgis");
        params.put(JDBCDataStoreFactory.HOST.key, getFixture().getProperty("pg_host"));
        params.put(JDBCDataStoreFactory.PORT.key, getFixture().getProperty("pg_port"));
        params.put(JDBCDataStoreFactory.SCHEMA.key, getFixture().getProperty("pg_schema"));
        params.put(JDBCDataStoreFactory.DATABASE.key, getFixture().getProperty("pg_database"));
        params.put(JDBCDataStoreFactory.USER.key, getFixture().getProperty("pg_user"));
        params.put(JDBCDataStoreFactory.PASSWD.key, getFixture().getProperty("pg_password"));
        params.put("src_table", getFixture().getProperty("src_table"));
        return params;
    }
    
    protected Properties getExamplePostgisProps() {
        Properties ret = new Properties();
        ret.setProperty("pg_host", "localhost");
        ret.setProperty("pg_port", "5432");
        ret.setProperty("pg_database", "destination_staging");
        ret.setProperty("pg_schema", "siig_p");
        ret.setProperty("pg_user", "siig_p");
        ret.setProperty("pg_password", "siig_p");
        ret.setProperty("src_table", "siig_geo_ln_arco_1");

        return ret;
    }
    
    private SimpleFeatureType getTmpTable() throws IOException{
        SimpleFeatureType schema = (SimpleFeatureType) dataStore.getSchema(VulnerabilityComputation.VULNERABILITY_TYPE_NAME.replace("X", "1"));
        SimpleFeatureTypeBuilder sftb = new SimpleFeatureTypeBuilder();
        sftb.setName(TEST_VULNERABILITY_TABLE);
        sftb.add("id_geo_arco", Integer.class);
        sftb.add("id_distanza", Integer.class);
        sftb.addAll(schema.getAttributeDescriptors());
        return sftb.buildFeatureType();
    }
    
    private void loadFeature(OutputObject objOut) throws IOException{
        List<SimpleFeature> list = new ArrayList<SimpleFeature>();
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid1=1|1|8|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid2=2|2|8|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid3=3|3|8|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid4=4|4|8|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid5=5|5|8|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid6=6|6|8|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid7=7|7|8|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid8=8|8|8|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid8=9|9|8|0|0|0|0|0|0|0|0|0|0|0|0|0|0|2"));
        SimpleFeatureCollection sfc = DataUtilities.collection(list);
        objOut.getWriter().addFeatures(sfc);
    }
    
    private void removeTable() throws Exception{
        // Remove vunerabilityTestTable
        Statement stmt = null;
        Connection c = null;
        Transaction t = new DefaultTransaction();
        try{
            c = dataStore.getConnection(t);
            stmt = c.createStatement();
            String sql = "DROP TABLE " +  dataStore.getDatabaseSchema() + "." + VulnerabilityOperationTest.TEST_VULNERABILITY_TABLE;
            stmt.executeUpdate(sql);
        }
        catch(SQLException e){
            // An exception occurs? Maybe the table is already been deleted... swallow the exception...
        }
        finally{
            if(t != null){
                try {
                    t.commit();
                    t.close();
                } catch (IOException e) {
                    LOGGER.error(e.getMessage(), e);
                }
            }
            if(stmt != null){
                try {
                    stmt.close();
                } catch (SQLException e) {
                    LOGGER.error(e.getMessage(), e);
                }
            }
            if(c != null){
                try {
                    c.close();
                } catch (SQLException e) {
                    LOGGER.error(e.getMessage(), e);
                }
            }
        }
    }
}