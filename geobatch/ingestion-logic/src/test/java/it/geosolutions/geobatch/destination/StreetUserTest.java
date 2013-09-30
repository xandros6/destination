package it.geosolutions.geobatch.destination;

import it.geosolutions.geobatch.destination.common.utils.FeatureLoaderUtils;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.streetuser.StreetUserComputation;
import it.geosolutions.geobatch.destination.streetuser.configuration.StreetUserConfiguration;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.File;
import java.io.FileInputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.geotools.data.DataStore;
import org.geotools.data.DataUtilities;
import org.geotools.data.FeatureStore;
import org.geotools.data.Query;
import org.geotools.data.Transaction;
import org.geotools.data.memory.MemoryDataStore;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.feature.FeatureIterator;
import org.geotools.util.logging.Logging;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.filter.FilterFactory2;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StreetUserTest {

	private static final Logger LOGGER = LoggerFactory.getLogger(StreetUserTest.class);
	private StreetUserConfiguration streetUserConfiguration;
	private String typeName;
	private Map<String, Serializable> dbParams;
	private DataStore dataStore;

	static{
		try {
			Logging.ALL.setLoggerFactory("org.geotools.util.logging.Log4JLoggerFactory");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}
	}



	@Before
	public void before() throws Exception { 
		File inputXML = new File("src/test/resources/streetUserInput.xml");
		this.streetUserConfiguration = StreetUserConfiguration.fromXML(new FileInputStream(inputXML));
		//typeName = streetUserConfiguration.getTypeName();
		dbParams = streetUserConfiguration.getDataStore();
		typeName = "RP_C_ZURB_20130613";


		//Create test datastore


		/*
		 * INPUT=siig_geo_ln_arco_X
		 */
		SimpleFeatureType siig_geo_ln_arco_1 = DataUtilities.createType("siig_geo_ln_arco_1", 
				"id_geo_arco:int," +
						"nr_incidenti:int," +
						"nr_incidenti_elab:double," +
						"nr_corsie:int," +
						"lunghezza:int," +
						"nr_bers_umani_strada:int," +
						"id_tematico_shape:int," +
						"fk_partner:string," +
						"geometria:LineString,"+
						"id_origine:int," +
						"flg_nr_corsie:string," +
				"flg_nr_incidenti:string");

		SimpleFeatureType siig_geo_ln_arco_2 = DataUtilities.createType("siig_geo_ln_arco_2", 
				"id_geo_arco:int," +
						"nr_incidenti:int," +
						"nr_incidenti_elab:double," +
						"nr_corsie:int," +
						"lunghezza:int," +
						"nr_bers_umani_strada:int," +
						"id_tematico_shape:int," +
						"fk_partner:string," +
						"geometria:LineString,"+
						"id_origine:int," +
						"flg_nr_corsie:string," +
				"flg_nr_incidenti:string");

		SimpleFeature feature_1_1 = DataUtilities.createFeature(siig_geo_ln_arco_1, "id_geo_arco1=1|0|0|1|10|1|1|1|LINESTRING (0 0, 100 0)|1|S|C" );	
		SimpleFeature feature_1_2 = DataUtilities.createFeature(siig_geo_ln_arco_2, "id_geo_arco1=1|0|0|1|10|1|1|1|LINESTRING (0 0, 100 0)|1|S|C" );		
		SimpleFeature feature_1_3 = DataUtilities.createFeature(siig_geo_ln_arco_1, "id_geo_arco2=2|0|0|1|10|1|1|1|LINESTRING (50 -100, 50 100)|1|S|C" );
		//SimpleFeature feature_1_4 = DataUtilities.createFeature(siig_geo_ln_arco_1, "id_geo_arco3=3|0|0|1|10|1|1|1|LINESTRING (0 100, 100 100)|1|S|C" );

		/*
		 * INPUT=siig_t_scenario
		 */
		SimpleFeatureType siig_t_scenario = DataUtilities.createType("siig_t_scenario", 
				"id_scenario:int," +
						"codice:string," +
						"tipologia:string," +
				"tempo_di_coda:int");

		SimpleFeature feature_3 = DataUtilities.createFeature(siig_t_scenario, "id_scenario1=1|A|POOL FIRE DA LIQUIDO INFIAMMABILE|500" );
		SimpleFeature feature_4 = DataUtilities.createFeature(siig_t_scenario, "id_scenario2=2|B|FLASH FIRE DA VAPORI LIQUIDO INFIAMMABILE|500" );
		SimpleFeature feature_5 = DataUtilities.createFeature(siig_t_scenario, "id_scenario3=3|C|POOL FIRE DA LIQUIDO ESTREMAMENTE INFIAMMABILE|500" );

		/*
		 * INPUT=siig_r_area_danno
		 */
		SimpleFeatureType siig_r_area_danno = DataUtilities.createType("siig_r_area_danno", 
				"id_gravita:int," +
						"id_scenario:int," +
						"id_sostanza:int," +
						"flg_lieve:int," +
						"id_bersaglio:int,"+
				"fk_distanza:int");

		SimpleFeature feature_6 = DataUtilities.createFeature(siig_r_area_danno, "id1=1|1|1|0|1|20" );
		SimpleFeature feature_7 = DataUtilities.createFeature(siig_r_area_danno, "id2=2|2|2|0|1|30" );
		SimpleFeature feature_8 = DataUtilities.createFeature(siig_r_area_danno, "id3=3|3|3|0|1|40" );

		/*
		 * INPUT=siig_d_distanza
		 */
		SimpleFeatureType siig_d_distanza = DataUtilities.createType("siig_d_distanza", 
				"id_distanza:int," +
				"distanza:int");
		SimpleFeature feature_9_1 = DataUtilities.createFeature(siig_d_distanza, "id_distanza1=50|50" );
		SimpleFeature feature_9_2 = DataUtilities.createFeature(siig_d_distanza, "id_distanza2=125|125" );
		SimpleFeature feature_9_3 = DataUtilities.createFeature(siig_d_distanza, "id_distanza3=250|250" );
		SimpleFeature feature_9_4 = DataUtilities.createFeature(siig_d_distanza, "id_distanza4=500|500" );
		SimpleFeature feature_9_5 = DataUtilities.createFeature(siig_d_distanza, "id_distanza5=700|700" );

		/*
		 * INPUT=siig_t_bersaglio
		 */
		SimpleFeatureType siig_t_bersaglio = DataUtilities.createType("siig_t_bersaglio", 
				"id_bersaglio:int," +
				"descrizione_it:string");
		SimpleFeature feature_12 = DataUtilities.createFeature(siig_t_bersaglio, "id_bersaglio1=1|UTENTI DELLA STRADA TERRITORIALI" );
		SimpleFeature feature_13 = DataUtilities.createFeature(siig_t_bersaglio, "id_bersaglio1=2|UTENTI DELLA STRADA COINVOLTI" );

		/*
		 * INPUT=siig_r_tipovei_geoarco1
		 */
		SimpleFeatureType siig_r_tipovei_geoarco1 = DataUtilities.createType("siig_r_tipovei_geoarco1", 
				"id_tipo_veicolo:int," +
						"id_geo_arco:int," +
						"densita_veicolare:int," +
						"velocita_media:int," +
						"fk_partner:string," +
						"flg_velocita:string," +
				"flg_densita_veicolare:string");
		SimpleFeature feature_14_1 = DataUtilities.createFeature(siig_r_tipovei_geoarco1, "id1,1=1|1|56|50|1|S|C" );
		SimpleFeature feature_14_2 = DataUtilities.createFeature(siig_r_tipovei_geoarco1, "id2,1=2|1|16|50|1|S|C" );		
		SimpleFeature feature_14_3 = DataUtilities.createFeature(siig_r_tipovei_geoarco1, "id1,2=1|2|9|50|1|S|C" );
		SimpleFeature feature_14_4 = DataUtilities.createFeature(siig_r_tipovei_geoarco1, "id2,2=2|2|8|50|1|S|C" );		
		SimpleFeature feature_14_5 = DataUtilities.createFeature(siig_r_tipovei_geoarco1, "id1,3=1|3|10|50|1|S|C" );
		SimpleFeature feature_14_6 = DataUtilities.createFeature(siig_r_tipovei_geoarco1, "id2,3=2|3|52|50|1|S|C" );

		SimpleFeatureType siig_d_tipo_veicolo = DataUtilities.createType("siig_d_tipo_veicolo", 
				"id_tipo_veicolo:int," +
						"tipo_veicolo_it:string," +
				"coeff_occupazione:double");
		SimpleFeature feature_15_1 = DataUtilities.createFeature(siig_d_tipo_veicolo, "id1=1|Veicoli leggeri|1.5" );
		SimpleFeature feature_15_2 = DataUtilities.createFeature(siig_d_tipo_veicolo, "id2=2|Veicoli pesanti|1.1" );
		
		SimpleFeatureType siig_t_vulnerabilita_1 = DataUtilities.createType("siig_t_vulnerabilita_1", 
				"id_geo_arco:int," +
				"id_distanza:int," +
				"fk_partner:string," +
				"nr_pers_scuole," +
				"nr_pers_ospedali," +
				"nr_pers_distrib," +
				"nr_pers_residenti," +
				"nr_pers_servizi," +
				"nr_turisti_medi," +
				"nr_turisti_max," +
				"mq_aree_protette," +
				"mq_aree_agricole," +
				"mq_aree_boscate," +
				"mq_beni_culturali," +
				"mq_zone_urbanizzate," +
				"mq_acque_superficiali," +
				"mq_acque_sotterranee");
		SimpleFeature feature_16_1 = DataUtilities.createFeature(siig_t_vulnerabilita_1, "id1,50,1=1|50|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0" );
		SimpleFeature feature_16_2 = DataUtilities.createFeature(siig_t_vulnerabilita_1, "id1,125,1=1|125|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0" );
		SimpleFeature feature_16_3 = DataUtilities.createFeature(siig_t_vulnerabilita_1, "id1,250,1=1|250|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0" );
		SimpleFeature feature_16_4 = DataUtilities.createFeature(siig_t_vulnerabilita_1, "id1,500,1=1|500|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0" );
		SimpleFeature feature_16_5 = DataUtilities.createFeature(siig_t_vulnerabilita_1, "id1,700,1=1|700|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0" );

		/*
		 * OUTPUT=siig_r_scen_vuln_1
		 */		
		SimpleFeatureType siig_r_scen_vuln_1 = DataUtilities.createType("siig_r_scen_vuln_1", 
				"id_distanza:int," + "id_geo_arco:int," + "id_scenario:int," + "utenti_carr_bersaglio:int," + "utenti_carr_sede_inc:int");



		List<SimpleFeature> features = new ArrayList<SimpleFeature>();
		features.add(feature_15_1);
		features.add(feature_15_2);
		features.add(feature_1_1);
		features.add(feature_1_2);
		features.add(feature_1_3);
		//features.add(feature_1_4);
		features.add(feature_3);
		features.add(feature_4);
		features.add(feature_5);
		features.add(feature_6);
		features.add(feature_7);
		features.add(feature_8);
		features.add(feature_9_1);
		features.add(feature_9_2);
		features.add(feature_9_3);
		features.add(feature_9_4);
		features.add(feature_9_5);
		features.add(feature_12);
		features.add(feature_13);
		features.add(feature_14_1);
		features.add(feature_14_2);
		features.add(feature_14_3);
		features.add(feature_14_4);
		features.add(feature_14_5);
		features.add(feature_14_6);

		features.add(feature_16_1);
		features.add(feature_16_2);
		features.add(feature_16_3);
		features.add(feature_16_4);
		features.add(feature_16_5);

		this.dataStore = new MemoryDataStore(DataUtilities.collection(features));

		this.dataStore.createSchema(siig_r_scen_vuln_1);
	};

	@Test
	public void test() throws Exception{
		/*
		 * CALCOLI X TEST ( 2 archi perpendicolari)
		 * 
		 * feature_1_2 (interessata) -> densit‡Leggeri=56  velocit‡MediaLeggeri=50, densit‡Pesanti=16 , velocit‡MediaPesanti=50, nCorsie=1
		 * distanza = 50 -> Ls_1_2 = 100; Ls_1_3 = 100
		 * scneario = 1 -> tempo di coda = 500
		 * 
		 * feature_1_2: 
		 * nTerritoriali_1_2_leggeri = densit‡L * Ls_1_2 = 56 * 100 = 5600
		 * nTerritoriali_1_2_pesanti = densit‡P * Ls_1_2 = 16 * 100 = 1600
		 * nCoda_1_2_leggeri = densit‡L * Vl_1_2 * Tc = 56 * 50 * (500/3600) = 388.88
		 * nCoda_1_2_pesanti = densit‡P * Vp_1_2 * Tc = 16 * 50 * (500/3600) = 111.11
		 * nCoinvolti_1_2_leggeri = nTerritoriali_1_2_leggeri +  nCoda_1_2_leggeri = 5600 + 388.88 = 5988.88
		 * nCoinvolti_1_2_pesanti = nTerritoriali_1_2_pesanti + + nCoda_1_2_pesanti = 1600 + 111.11 = 1711.11
		 * storage = 150 * nCorsie * length = 150 * 1 * 100 = 15000
		 * storage/2 > nCoinvolti_1_2_leggeri -> nCoinvolti_1_2_leggeri = 5988.88
		 * storage/2 > nCoinvolti_1_2_pesanti -> nCoinvolti_1_2_pesanti = 1711.11
		 * N_UTENTI_SEDE = nCoinvolti_1_2_leggeri * coeff_occupazione_l + nCoinvolti_1_2_pesanti * coeff_occupazione_p = 5988.88 * 1.5 + 1711.11 * 1.1 = 8983.32 + 1882.221 = 10865.541
		 * 
		 * feature_1_3 -> densit‡Leggeri=9  velocit‡MediaLeggeri=50, densit‡Pesanti=8 , velocit‡MediaPesanti=50, nCorsie=1
		 * nTerritoriali_1_3_leggeri = densit‡L * Ls_1_3 = 9 * 100 = 900
		 * nTerritoriali_1_3_pesanti = densit‡P * Ls_1_3 = 8 * 100 = 800
		 * nTransito_1_3_leggeri = densit‡L * Ls_1_3 * Tc = 9 * 50 * (500/3600) = 62.50
		 * nTransito_1_3_pesanti = densit‡P * Ls_1_3 * Tc = 8 * 50 * (500/3600) = 55.55
		 * nCoinvolti_1_3_leggeri = nTerritoriali_1_3_leggeri +  nTransito_1_3_leggeri = 962.50
		 * nCoinvolti_1_3_pesanti = nTerritoriali_1_3_pesanti + nTransito_1_3_pesanti = 855.55
		 * N_UTENTI_BERSAGLIO = nCoinvolti_1_3_leggeri * coeff_occupazione_l + nCoinvolti_1_3_pesanti * coeff_occupazione_p = 962.50 * 1.5 + 855.55 * 1.1 = 1443.75 + 941.105 = 2384.855
		 */
		double N_UTENTI_SEDE_1_ATTESO = 10865;
		double N_UTENTI_BERSAGLIO_1_ATTESO = 2384;
		
		Integer aggregationLevel = 1;
		MetadataIngestionHandler metadataHandler = new MetadataIngestionHandler(dataStore);		
		StreetUserComputation streetUserComputation = new StreetUserComputation(this.typeName,
				new ProgressListenerForwarder(null),
				metadataHandler,
				dataStore);
		streetUserComputation.execute(aggregationLevel);
		Integer partner = streetUserComputation.getPartner();
		Assert.assertTrue(partner.intValue() == 1);
		//Check
		FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_r_scen_vuln_1");
		Query inputQuery = new Query("siig_r_scen_vuln_1");
		FeatureIterator<SimpleFeature> inputIterator = inputReader.getFeatures(inputQuery).features();
		int result = 0;
		while(inputIterator.hasNext()) {
			SimpleFeature sf = inputIterator.next();
			int idArco = (Integer) sf.getAttribute("id_geo_arco");
			int distanza = (Integer) sf.getAttribute("id_distanza");
			int idScenario = (Integer) sf.getAttribute("id_scenario");
			double utentiSede = (Integer) sf.getAttribute("utenti_carr_sede_inc");
			double utentiBersaglio = (Integer) sf.getAttribute("utenti_carr_bersaglio");
			LOGGER.info("---- RISULTATO ----");
			LOGGER.info("RISULTATO {arco="+idArco+",distanza="+distanza+",scenario="+idScenario+",utentiSede="+utentiSede+",utentiBersaglio="+utentiBersaglio);
			if(idArco==1 && idScenario ==1 && distanza == 50){
				Assert.assertTrue(utentiSede == N_UTENTI_SEDE_1_ATTESO);
				Assert.assertTrue(utentiBersaglio == N_UTENTI_BERSAGLIO_1_ATTESO);
			}
			result++;
		}
		int nArchi = 2;
		int nDistanze = 5;
		int nscenari = 3;
		Assert.assertTrue(result == (nArchi * nDistanze * nscenari));
		inputIterator.close();
	}
}
