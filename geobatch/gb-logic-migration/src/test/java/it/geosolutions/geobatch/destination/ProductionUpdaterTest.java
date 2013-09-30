package it.geosolutions.geobatch.destination;

import static org.junit.Assert.assertEquals;
import it.geosolutions.geobatch.destination.common.utils.DbUtils;
import it.geosolutions.geobatch.destination.datamigration.ProductionUpdater;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.File;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.geotools.data.DataStoreFinder;
import org.geotools.data.DataUtilities;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.data.collection.ListFeatureCollection;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.data.simple.SimpleFeatureStore;
import org.geotools.factory.Hints;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.filter.text.cql2.CQL;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.util.logging.Logging;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.filter.Filter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.thoughtworks.xstream.XStream;
import it.geosolutions.geobatch.actions.ds2ds.Ds2dsConfiguration;

public class ProductionUpdaterTest{

	private static final Logger LOGGER = LoggerFactory.getLogger(ProductionUpdaterTest.class);
	private Ds2dsConfiguration productionUpdaterConfiguration;

	static{
		try {
			Logging.GEOTOOLS.setLoggerFactory("org.geotools.util.logging.Log4JLoggerFactory");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}
	}

	@Before
	public void before() throws Exception { 
		XStream xstream = new XStream();
		xstream.alias("ProductionUpdaterConfiguration", Ds2dsConfiguration.class);
		File configurationFile = new File("src/test/resources/TS_C_ZURB_20130613.xml");
		this.productionUpdaterConfiguration = (Ds2dsConfiguration)xstream.fromXML(configurationFile);
		clearAll();
	};


	@After
	public void after() throws Exception {
	};

	@Test
	public void copy_siig_geo_bers_non_umano_pl_toProduction() throws Exception {		
		List<String> list = new ArrayList<String>();
		list.add("1||-1|10");
		list.add("2||-1|10");
		this.populateSourceTarget(list,"siig_geo_bers_non_umano_pl","siig_t_bersaglio_non_umano","idgeo_bers_non_umano_pl","fk_bers_non_umano_pl");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_geo_bers_non_umano_pl","siig_t_bersaglio_non_umano","id_partner = '-1'");
	}

	@Test
	public void copy_siig_geo_bers_non_umano_ln_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1||-1|10");
		list.add("2||-1|10");
		this.populateSourceTarget(list,"siig_geo_bers_non_umano_ln","siig_t_bersaglio_non_umano","idgeo_bers_non_umano_ln","fk_bers_non_umano_ln");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_geo_bers_non_umano_ln","siig_t_bersaglio_non_umano","id_partner = '-1'");
	}

	@Test
	public void copy_siig_geo_bers_non_umano_pt_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1||-1|10");
		list.add("2||-1|10");
		this.populateSourceTarget(list,"siig_geo_bers_non_umano_pt","siig_t_bersaglio_non_umano","idgeo_bers_non_umano_pt","fk_bers_non_umano_pt");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_geo_bers_non_umano_pt","siig_t_bersaglio_non_umano","id_partner = '-1'");
	}

	@Test
	public void copy_siig_geo_bers_umano_pt_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1||-1|10");
		list.add("2||-1|10");
		this.populateSourceTarget(list,"siig_geo_bersaglio_umano_pt","siig_t_bersaglio_umano","idgeo_bersaglio_umano_pt","fk_bersaglio_umano_pt");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_geo_bersaglio_umano_pt","siig_t_bersaglio_umano","id_partner = '-1'");
	}

	@Test
	public void copy_siig_geo_bers_umano_pl_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1||-1|10");
		list.add("2||-1|10");
		this.populateSourceTarget(list,"siig_geo_bersaglio_umano_pl","siig_t_bersaglio_umano","idgeo_bersaglio_umano_pl","fk_bersaglio_umano_pl");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_geo_bersaglio_umano_pl","siig_t_bersaglio_umano","id_partner = '-1'");
	}

	@Test
	public void copy_siig_r_arco_1_dissesto_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_arco_1_dissesto","siig_geo_ln_arco_1","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_arco_1_dissesto","siig_geo_ln_arco_1","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_r_arco_1_scen_tipobers_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_arco_1_scen_tipobers","siig_geo_ln_arco_1","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_arco_1_scen_tipobers","siig_geo_ln_arco_1","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_r_arco_1_sostanza_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_arco_1_sostanza","siig_geo_ln_arco_1","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_arco_1_sostanza","siig_geo_ln_arco_1","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_r_tipovei_geoarco1_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_tipovei_geoarco1","siig_geo_ln_arco_1","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_tipovei_geoarco1","siig_geo_ln_arco_1","fk_partner = '-1'");
	}	

	@Test
	public void copy_siig_r_arco_2_dissesto_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_arco_2_dissesto","siig_geo_ln_arco_2","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_arco_2_dissesto","siig_geo_ln_arco_2","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_r_arco_2_scen_tipobers_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_arco_2_scen_tipobers","siig_geo_ln_arco_2","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_arco_2_scen_tipobers","siig_geo_ln_arco_2","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_r_arco_2_sostanza_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_arco_2_sostanza","siig_geo_ln_arco_2","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_arco_2_sostanza","siig_geo_ln_arco_2","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_r_tipovei_geoarco2_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_tipovei_geoarco2","siig_geo_ln_arco_2","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_tipovei_geoarco2","siig_geo_ln_arco_2","fk_partner = '-1'");
	}	

	@Test
	public void copy_siig_r_arco_3_dissesto_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_arco_3_dissesto","siig_geo_pl_arco_3","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_arco_3_dissesto","siig_geo_pl_arco_3","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_r_arco_3_scen_tipobers_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_arco_3_scen_tipobers","siig_geo_pl_arco_3","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_arco_3_scen_tipobers","siig_geo_pl_arco_3","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_r_arco_3_sostanza_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_arco_3_sostanza","siig_geo_pl_arco_3","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_arco_3_sostanza","siig_geo_pl_arco_3","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_r_tipovei_geoarco3_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_r_tipovei_geoarco3","siig_geo_pl_arco_3","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_r_tipovei_geoarco3","siig_geo_pl_arco_3","fk_partner = '-1'");
	}	

	@Test
	public void copy_siig_t_vulnerabilita_1_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_t_vulnerabilita_1","siig_geo_ln_arco_1","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_t_vulnerabilita_1","siig_geo_ln_arco_1","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_t_vulnerabilita_2_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_t_vulnerabilita_2","siig_geo_ln_arco_2","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_t_vulnerabilita_2","siig_geo_ln_arco_2","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_t_vulnerabilita_3_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_t_vulnerabilita_3","siig_geo_pl_arco_3","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_t_vulnerabilita_3","siig_geo_pl_arco_3","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_t_elab_standard_1_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_t_elab_standard_1","siig_geo_ln_arco_1","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_t_elab_standard_1","siig_geo_ln_arco_1","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_t_elab_standard_2_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_t_elab_standard_2","siig_geo_ln_arco_2","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_t_elab_standard_2","siig_geo_ln_arco_2","fk_partner = '-1'");
	}

	@Test
	public void copy_siig_t_elab_standard_3_toProduction() throws Exception {	
		List<String> list = new ArrayList<String>();
		list.add("1|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		list.add("2|||||||-1|LINESTRING(3 4,10 50,20 25)||S|S ");
		this.populateSourceArc(list,"siig_t_elab_standard_3","siig_geo_pl_arco_3","id_geo_arco","id_geo_arco");
		this.execute();
		//Check destination
		this.checkDestiantion("siig_t_elab_standard_3","siig_geo_pl_arco_3","fk_partner = '-1'");
	}

	/*
	 * Private methods
	 */

	private void execute() throws Exception{
		Map<String, Serializable> outputDatastoreParams = productionUpdaterConfiguration.getOutputFeature().getDataStore();
		JDBCDataStore outputDatastore = (JDBCDataStore)DataStoreFinder.getDataStore(outputDatastoreParams);	 
		MetadataIngestionHandler metadataHandler = new MetadataIngestionHandler(outputDatastore);		
		ProductionUpdater pu = new ProductionUpdater(productionUpdaterConfiguration.getSourceFeature().getTypeName(),
				new ProgressListenerForwarder(null),
				metadataHandler,
				outputDatastore);
		pu.setDs2DsConfiguration(productionUpdaterConfiguration);
		pu.execute();
	}

	private void checkDestiantion(String originTable, String relatedTable, String cqlFilter) throws Exception{
		JDBCDataStore destinationDataStore = (JDBCDataStore) DataStoreFinder.getDataStore(productionUpdaterConfiguration.getOutputFeature().getDataStore());
		SimpleFeatureStore store = (SimpleFeatureStore) destinationDataStore.getFeatureSource(relatedTable);
		SimpleFeatureCollection reloaded = store.getFeatures(CQL.toFilter(cqlFilter));
		assertEquals(reloaded.toArray().length,2);
		clear_destination(originTable);
		clear_destination(relatedTable);
	}

	private void clearAll() throws Exception{
		clear_destination("siig_geo_bers_non_umano_pt");
		clear_destination("siig_geo_bers_non_umano_pl");
		clear_destination("siig_geo_bers_non_umano_ln");
		clear_destination("siig_geo_bersaglio_umano_pt");
		clear_destination("siig_geo_bersaglio_umano_pl");
		clear_destination("siig_t_bersaglio_non_umano");
		clear_destination("siig_t_bersaglio_umano");
		clear_destination("siig_geo_ln_arco_1");
		clear_destination("siig_geo_ln_arco_2");
		clear_destination("siig_geo_ln_arco_3");
		clear_destination("siig_geo_pl_arco_3");
		clear_destination("siig_r_arco_1_dissesto");			
		clear_destination("siig_r_arco_1_scen_tipobers");
		clear_destination("siig_r_arco_1_sostanza");
		clear_destination("siig_r_tipovei_geoarco1");
		clear_destination("siig_r_arco_2_dissesto");			
		clear_destination("siig_r_arco_2_scen_tipobers");
		clear_destination("siig_r_arco_2_sostanza");
		clear_destination("siig_r_tipovei_geoarco2");
		clear_destination("siig_r_arco_3_dissesto");			
		clear_destination("siig_r_arco_3_scen_tipobers");
		clear_destination("siig_r_arco_3_sostanza");
		clear_destination("siig_r_tipovei_geoarco3");		
		clear_destination("siig_t_vulnerabilita_1");
		clear_destination("siig_t_vulnerabilita_2");
		clear_destination("siig_t_vulnerabilita_3");		
		clear_destination("siig_t_elab_standard_1");
		clear_destination("siig_t_elab_standard_2");
		clear_destination("siig_t_elab_standard_3");
	}

	private void clear_destination(String table) throws Exception{
		JDBCDataStore sourceDataStore = (JDBCDataStore) DataStoreFinder.getDataStore(productionUpdaterConfiguration.getOutputFeature().getDataStore());		
		DefaultTransaction transaction = new DefaultTransaction();
		try {
			DbUtils.executeSql(sourceDataStore.getConnection(transaction), transaction, "delete from " + table, true);
		} finally {
			transaction.close();
		}		
	}

	private void clear_source(String table) throws Exception{
		JDBCDataStore sourceDataStore = (JDBCDataStore) DataStoreFinder.getDataStore(productionUpdaterConfiguration.getSourceFeature().getDataStore());
		SimpleFeatureStore store = (SimpleFeatureStore) sourceDataStore.getFeatureSource(table);
		store.setTransaction(Transaction.AUTO_COMMIT);					
		store.removeFeatures(Filter.INCLUDE);
	}

	private void populateSourceTarget(List<String> featureList, String originTable, String relatedTable, String pkAttributeName, String fkAttributeName) throws Exception{
		clear_source(originTable);
		clear_source(relatedTable);
		JDBCDataStore sourceDataStore = (JDBCDataStore) DataStoreFinder.getDataStore(productionUpdaterConfiguration.getSourceFeature().getDataStore());
		SimpleFeatureStore store = (SimpleFeatureStore) sourceDataStore.getFeatureSource(originTable);

		//Add test data
		{
			SimpleFeatureType featureType = (SimpleFeatureType) sourceDataStore.getSchema(originTable);

			List<SimpleFeature> list = new ArrayList<SimpleFeature>();
			for(String f : featureList){
				list.add(DataUtilities.createFeature(store.getSchema(), f));
			}

			SimpleFeatureCollection collection = new ListFeatureCollection(featureType, list);
			store.addFeatures(collection);
		}

		//Read test data and add related data
		SimpleFeatureCollection reloaded = store.getFeatures(CQL.toFilter("id_partner = '-1'"));
		SimpleFeatureIterator iterator = reloaded.features();
		SimpleFeatureStore relatedStore = (SimpleFeatureStore) sourceDataStore.getFeatureSource(relatedTable);
		int featureCount = 1;
		while(iterator.hasNext()){
			SimpleFeature sourceFeature = iterator.next();
			SimpleFeatureType featureType = (SimpleFeatureType) sourceDataStore.getSchema(relatedTable);
			List<SimpleFeature> list = new ArrayList<SimpleFeature>();
			String fid = featureCount + "." + sourceFeature.getAttribute("id_bersaglio") + "." + sourceFeature.getAttribute("id_partner");
			SimpleFeature feature = SimpleFeatureBuilder.build(featureType, new Object[] {  }, fid);
			feature.setAttribute(fkAttributeName, sourceFeature.getAttribute(pkAttributeName));
			feature.getUserData().put(Hints.USE_PROVIDED_FID, true);
			list.add(feature);
			SimpleFeatureCollection collection = new ListFeatureCollection(featureType, list);
			relatedStore.addFeatures(collection);			
			featureCount++;
		}
		iterator.close();
	}

	private void populateSourceArc(List<String> featureList, String originTable, String relatedTable, String pkAttributeName, String fkAttributeName) throws Exception{
		clear_source(originTable);
		clear_source(relatedTable);
		JDBCDataStore sourceDataStore = (JDBCDataStore) DataStoreFinder.getDataStore(productionUpdaterConfiguration.getSourceFeature().getDataStore());
		SimpleFeatureStore store = (SimpleFeatureStore) sourceDataStore.getFeatureSource(relatedTable);

		//Add test data
		{
			SimpleFeatureType featureType = (SimpleFeatureType) sourceDataStore.getSchema(relatedTable);

			List<SimpleFeature> list = new ArrayList<SimpleFeature>();
			for(String f : featureList){
				list.add(DataUtilities.createFeature(store.getSchema(), f));
			}

			SimpleFeatureCollection collection = new ListFeatureCollection(featureType, list);
			store.addFeatures(collection);
		}

		//Read test data and add related data
		SimpleFeatureCollection reloaded = store.getFeatures(CQL.toFilter("fk_partner = '-1'"));
		SimpleFeatureIterator iterator = reloaded.features();
		SimpleFeatureStore originStore = (SimpleFeatureStore) sourceDataStore.getFeatureSource(originTable);
		int featureCount = 1;
		while(iterator.hasNext()){
			SimpleFeature sourceFeature = iterator.next();
			SimpleFeatureType featureType = (SimpleFeatureType) sourceDataStore.getSchema(originTable);
			List<SimpleFeature> list = new ArrayList<SimpleFeature>();
			String fid = "";
			if(originTable.contains("siig_t_elab_standard")){
				fid = 0 + "." + sourceFeature.getAttribute("id_geo_arco") + "." + featureCount + "." + featureCount + "." + featureCount;
			}else{
				fid = featureCount + "." + sourceFeature.getAttribute("id_geo_arco");
			}
			SimpleFeature feature = SimpleFeatureBuilder.build(featureType, new Object[] {  }, fid);
			feature.setAttribute("fk_partner", -1);
			feature.getUserData().put(Hints.USE_PROVIDED_FID, true);
			list.add(feature);
			SimpleFeatureCollection collection = new ListFeatureCollection(featureType, list);
			originStore.addFeatures(collection);			
			featureCount++;
		}
		iterator.close();
	}

}
