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

import it.geosolutions.geobatch.destination.common.OutputObject;
import it.geosolutions.geobatch.destination.common.utils.FeatureLoaderUtils;
import it.geosolutions.geobatch.destination.commons.DestinationOnlineTestCase;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.zeroremoval.ZeroRemovalComputation;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Pattern;

import org.geotools.data.DataStoreFinder;
import org.geotools.data.DataUtilities;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.jdbc.JDBCDataStoreFactory;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.opengis.feature.simple.SimpleFeature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author DamianoG
 * 
 */
public class ZeroRemovalTest extends DestinationOnlineTestCase{

	private final static Logger LOGGER = LoggerFactory.getLogger(ZeroRemovalTest.class);
	
    @Before
    public void before() throws Exception{
        //Setup the origin table... this table schema will be copied and replicated into the test table
        setOriginTable("siig_geo_ln_arco_1");
        // The test table, where the tests run
        testTable = "siig_geo_ln_arcotest_1";
        this.removeAfter = false;
        super.before();
    }
    
    @Test
    public void testZeroRemovalProcess() throws IOException {
        //Alter the standard pattern and name for feature name validity check... it's an awful stuff but mandatory for this kind of test
        ZeroRemovalComputation.GEO_TYPE_NAME = "siig_geo_ln_arcotest_X"; 
        
        //Prepare the static list of results to compare with
       // Double [] results = {0.0,72.66666666666667,963.6666666666666,53.666666666666664,0.8952380952380953,1.8952380952380952,2.895238095238095,3.895238095238095,4.895238095238096,0.6285714285714286,6.895238095238096};
      //  List<Double> resultsList = Arrays.asList(results);
        
        Map<String, Serializable> datastoreParams = new HashMap<String, Serializable>();
        datastoreParams.put(JDBCDataStoreFactory.DBTYPE.key, "postgis");
        datastoreParams.put(JDBCDataStoreFactory.HOST.key, getFixture().getProperty("pg_host"));
        datastoreParams.put(JDBCDataStoreFactory.PORT.key, getFixture().getProperty("pg_port"));
        datastoreParams.put(JDBCDataStoreFactory.SCHEMA.key, getFixture().getProperty("pg_schema"));
        datastoreParams.put(JDBCDataStoreFactory.DATABASE.key, getFixture().getProperty("pg_database"));
        datastoreParams.put(JDBCDataStoreFactory.USER.key, getFixture().getProperty("pg_user"));
        datastoreParams.put(JDBCDataStoreFactory.PASSWD.key, getFixture().getProperty("pg_password"));
        JDBCDataStore dataStore = null;        
        MetadataIngestionHandler metadataHandler = null;
        try {
        	
        	dataStore = (JDBCDataStore)DataStoreFinder.getDataStore(datastoreParams);	        
	        metadataHandler = null;
			ZeroRemovalComputation zeroRemovalComputation = new ZeroRemovalComputation(
					"TS_C_ZURB_20130613", new ProgressListenerForwarder(null),
					metadataHandler, dataStore);
        
			zeroRemovalComputation.removeZeros(null, 1, null);
			List<SimpleFeature> features = FeatureLoaderUtils.loadFeatures(dataStore, testTable);
			Double nr_incidenti_sum = 0d;
			Double nr_incidenti_elab_sum = 0d;
			for(SimpleFeature f : features){
				BigDecimal nr_incidenti = (BigDecimal) f.getAttribute("nr_incidenti");
				BigDecimal nr_incidenti_elab = new BigDecimal((Double)f.getAttribute("nr_incidenti_elab"));
				BigDecimal length = (BigDecimal) f.getAttribute("lunghezza");
				nr_incidenti_sum = nr_incidenti_sum + nr_incidenti.doubleValue() * length.doubleValue();
				nr_incidenti_elab_sum = nr_incidenti_elab_sum + nr_incidenti_elab.doubleValue() * length.doubleValue();
			}
			LOGGER.info("nr_incidenti_sum = " + Math.rint(nr_incidenti_sum));
			LOGGER.info("nr_incidenti_elab_sum = " + Math.rint(nr_incidenti_elab_sum));
	        Assert.assertTrue(Math.rint(nr_incidenti_sum.doubleValue()) == Math.rint(nr_incidenti_elab_sum.doubleValue()));
        } catch(Exception e) {
        	LOGGER.error(e.getMessage(),e);
        } finally {
        	if(metadataHandler != null) {
        		metadataHandler.dispose();
        	}
        	
        	if(dataStore != null) {
        		dataStore.dispose();
        	}        	
        }
    }
    
    @Override
    protected void loadFeature(OutputObject objOut) throws IOException{
        List<SimpleFeature> list = new ArrayList<SimpleFeature>();
        // fid	id_geo_arco	nr_incidenti	nr_incidenti_elab	nr_corsie	lunghezza	nr_bers_umani_strada	id_tematico_shape	fk_partner	geometria	id_origine	flg_nr_corsie	flg_nr_incidenti
/*
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid1=1|1|1|0|3|100|0|1|-1|1|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid2=2|1|20|0|3|1000|0|1|-1|1|0|0|0"));
        for(int i = 3 ; i<=500 ; i++){
        	 list.add(DataUtilities.createFeature(objOut.getSchema(), "fid"+i+"="+i+"|1|0|0|3|100|0|1|-1|1|0|0|0"));
        }
        */
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid1=1|1|0|0|1|11100|0|1|-1|1|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid2=2|2|0|0|1|11300|0|1|-1|1|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid3=3|3|1|0|1|100|0|1|-1|1|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid4=4|4|1|0|1|100|0|1|-1|1|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid5=5|5|1|0|1|100|0|1|-1|1|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid6=6|6|1|0|1|100|0|1|-1|1|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid7=7|7|1|0|1|100|0|1|-1|1|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid8=8|8|1|0|1|100|0|20|-1|1|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid9=9|9|1|0|1|100|0|1|-1|2|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid10=10|10|1|0|1|100|0|1|-1|2|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid11=11|11|1|0|1|100|0|1|-1|2|0|0|0"));
        list.add(DataUtilities.createFeature(objOut.getSchema(), "fid12=12|12|0|0|1|100|0|1|-1|2|1|0|0"));
 

        SimpleFeatureCollection sfc = DataUtilities.collection(list);
        objOut.getWriter().addFeatures(sfc);
    }
    
    @Override
    protected String getFixtureId() {
        return "destination";
    }
    
    @Override
    protected Properties createExampleFixture() {
        Properties ret = new Properties();
        for (Map.Entry entry : getExamplePostgisProps().entrySet()) {
            ret.setProperty(entry.getKey().toString(), entry.getValue().toString());
        }
        return ret;
    }
}