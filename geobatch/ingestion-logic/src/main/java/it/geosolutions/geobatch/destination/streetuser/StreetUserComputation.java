package it.geosolutions.geobatch.destination.streetuser;

import it.geosolutions.destination.utils.BufferUtils;
import it.geosolutions.geobatch.destination.common.InputObject;
import it.geosolutions.geobatch.destination.common.utils.FeatureLoaderUtils;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.geotools.data.DataStore;
import org.geotools.data.DataUtilities;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.FeatureStore;
import org.geotools.data.Query;
import org.geotools.data.Transaction;
import org.geotools.data.simple.SimpleFeatureStore;
import org.geotools.factory.Hints;
import org.geotools.feature.FeatureIterator;
import org.geotools.jdbc.JDBCDataStore;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vividsolutions.jts.geom.Geometry;

public class StreetUserComputation extends InputObject {

	private final static Logger LOGGER = LoggerFactory.getLogger(StreetUserComputation.class);
	private final static DecimalFormat formatter = new DecimalFormat("##0.0######");
	private Double SECONDS_IN_HOUR = 3600d;
	private String codicePartner;
	private int partner;

	private String siig_r_scen_vuln_X_type;

	//private final static String EXTERNAL_PROP_DIR_PATH = "EXTERNAL_PROP_DIR_PATH";
	//private static final String STREET_USERS_PROP = "/streetusers.properties";

	private static final Integer MAX_VEICLE_QUEUE_SIZE = 150;

	private static SimpleFeatureType siig_r_scen_vuln_X = null;

	private static Pattern TYPE_NAME_PARTS = Pattern
			.compile("^([A-Z]{2})_([A-Z]{1})_([A-Za-z]+)_([0-9]{8})$");

	public StreetUserComputation(String inputTypeName, ProgressListenerForwarder listenerForwarder, MetadataIngestionHandler metadataHandler, DataStore dataStore) {
		super(inputTypeName, listenerForwarder, metadataHandler, dataStore);
	}

	public int getPartner() {
		return partner;
	}

	@Override
	protected boolean parseTypeName(String typeName) {
		Matcher m = TYPE_NAME_PARTS.matcher(typeName);
		if(m.matches()) {
			// partner alphanumerical abbreviation (from siig_t_partner)
			codicePartner = m.group(1);
			// partner numerical id (from siig_t_partner)
			partner = Integer.parseInt(partners.get(codicePartner).toString());					
			return true;
		}
		return false;
	}

	public void execute(Integer aggregationLevel) throws Exception{

		LOGGER.debug("Start execution with partner="+partner+" and aggregationLevel="+aggregationLevel);

		siig_r_scen_vuln_X_type = "siig_r_scen_vuln_"+aggregationLevel;
		siig_r_scen_vuln_X = DataUtilities.createType(siig_r_scen_vuln_X_type, 
				"id_distanza:int," + "id_geo_arco:int," + "id_scenario:int," + "utenti_carr_bersaglio:int," + "utenti_carr_sede_inc:int");

		List<StreetScenario> scenari = new ArrayList<StreetScenario>();

		//Get "scenario" info
		FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_t_scenario");
		Query inputQuery = new Query("siig_t_scenario");
		FeatureIterator<SimpleFeature> inputIterator = inputReader.getFeatures(inputQuery).features();
		while(inputIterator.hasNext()) {
			SimpleFeature sf = inputIterator.next();
			LOGGER.debug("Scenario <" + sf.getAttribute("tipologia") + "> found ");
			StreetScenario scenario = new StreetScenario();
			scenario.setIdScenario(((Number) sf.getAttribute("id_scenario")).intValue());		
			scenario.setDescrizioneScenario((String) sf.getAttribute("tipologia"));
			if(sf.getAttribute("tempo_di_coda") == null) {
				scenario.setTempoDiCoda(1.0);
			} else {
				scenario.setTempoDiCoda((((Number) sf.getAttribute("tempo_di_coda")).doubleValue()) / SECONDS_IN_HOUR);
			}
			
			scenari.add(scenario);

		}
		inputIterator.close();

		//Get "distanza" info
		TreeMap<Integer,StreetDistance> distanze = getDistanze();

		/*
		String basePath = System.getProperty(EXTERNAL_PROP_DIR_PATH, "");
		Properties properties = PropertiesManager.loadProperty(basePath, STREET_USERS_PROP);
		List<StreetDistance> distanze = new ArrayList<StreetDistance>();
		Iterator iter = properties.keySet().iterator();
        while(iter.hasNext()){
            String key = (String)iter.next();
            Integer value = Integer.parseInt(properties.getProperty(key));
            distanze.add(new StreetDistance(value));			
		}
		 */

		inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_t_vulnerabilita_" + aggregationLevel);
		inputQuery = new Query("siig_t_vulnerabilita_" + aggregationLevel);
		inputQuery.setFilter(filterFactory.equals(filterFactory.property("fk_partner"),filterFactory.literal(partner+"")));
		inputIterator = inputReader.getFeatures(inputQuery).features();
		while(inputIterator.hasNext()) {
			SimpleFeature sf = inputIterator.next();
			Integer idGeoArco = ((Number) sf.getAttribute("id_geo_arco")).intValue();
			Integer idDistanza = ((Number) sf.getAttribute("id_distanza")).intValue();
			StreetDistance distanza = distanze.get(idDistanza);
			if(distanza != null){
				computeArcoDistanza(idGeoArco,distanza,scenari,aggregationLevel);
			}
		}
		inputIterator.close();
	}


	private void computeArcoDistanza(Integer idGeoArco, StreetDistance distanza, List<StreetScenario> scenari , Integer aggregationLevel){
		FeatureIterator<SimpleFeature> inputIterator = null;
		try{
			FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_geo_ln_arco_" + aggregationLevel);
			Query inputQuery = new Query("siig_geo_ln_arco_" + aggregationLevel);
			inputQuery.setFilter(filterFactory.equals(filterFactory.property("id_geo_arco"),filterFactory.literal(idGeoArco)));
			inputIterator = inputReader.getFeatures(inputQuery).features();
			if(inputIterator.hasNext()) {
				SimpleFeature sf = inputIterator.next();
				LOGGER.debug("Feature found : " + sf.toString());				
				StreetUser streetUser = new StreetUser(idGeoArco,(Geometry) sf.getDefaultGeometry(),distanza);
				retrieveStreetInBuffer(streetUser.getDistance(),streetUser,aggregationLevel);
				computeVeicles(streetUser,scenari);		
				computeUsers(streetUser,scenari);
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			if(inputIterator != null){
				inputIterator.close();
			}
		}
	}

	private TreeMap<Integer,StreetDistance> getDistanze(){
		TreeMap<Integer,StreetDistance> distanze = new TreeMap<Integer, StreetDistance>();
		FeatureIterator<SimpleFeature> inputIterator = null;
		try{
			FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_d_distanza");
			Query inputQuery = new Query("siig_d_distanza");
			inputIterator = inputReader.getFeatures(inputQuery).features();
			while(inputIterator.hasNext()) {
				SimpleFeature sf = inputIterator.next();
				Integer key = ((Number) sf.getAttribute("id_distanza")).intValue();
				Integer distanza = ((Number) sf.getAttribute("distanza")).intValue();
				distanze.put(key, new StreetDistance(key, distanza));				
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			if(inputIterator != null){
				inputIterator.close();
			}
		}
		return distanze;	
	}

	private void computeUsers(StreetUser streetUser, List<StreetScenario> scenari) {

		Transaction transaction = new DefaultTransaction("handle");
		try{
			SimpleFeatureStore featureStore = (SimpleFeatureStore) this.dataStore.getFeatureSource(this.siig_r_scen_vuln_X_type);
			featureStore.setTransaction( transaction );

			Integer idArco = (Integer) streetUser.getIdArco();
			Integer idDistanza = streetUser.getDistance().getIdDistanza();

			for(StreetScenario scenario : scenari){

				Integer idScenario = scenario.getIdScenario();
				Double utentiSede = 0d;
				Double utentiBersaglio = 0d;

				for(StreetInfo streetInfo  : streetUser.getDistance().getStreetsInfo()){			

					for(StreetVeicle veicle : streetInfo.getVeicleTypes()){

						ComputedData computed = veicle.getComputedData(scenario);

						if(streetInfo.getOriginStreet()){
							Double nCoinvolti = correctCodaByStorage(computed.getN_territoriali(),computed.getN_coda(),streetInfo.getStorage());
							Double utentiVeicoli = nCoinvolti * veicle.getOccupationCoeff();
							utentiSede = utentiSede + utentiVeicoli;
						}else{
							Double utentiVeicoli = (computed.getN_territoriali() + computed.getN_transito())*veicle.getOccupationCoeff();
							utentiBersaglio = utentiBersaglio + utentiVeicoli;
						}

					}

				}

				persistStreetUsersData(idArco,idDistanza,idScenario,utentiSede,utentiBersaglio,featureStore);
			}
			transaction.commit(); 
		}catch (Exception ex){
			LOGGER.error(ex.getMessage(),ex);
			try {
				transaction.rollback();
			} catch (IOException e) {
				LOGGER.error(e.getMessage(),e);
			}
		}
		finally {
			try {
				transaction.close();
			} catch (IOException e) {
				LOGGER.error(e.getMessage(),e);
			}
		}

	}

	private void persistStreetUsersData(Integer idArco, Integer distanza, Integer idScenario, Double utentiSede, Double utentiBersaglio, SimpleFeatureStore featureStore) throws Exception {
		String id = idScenario+"."+idArco+"."+distanza;
		final SimpleFeature feature = DataUtilities.createFeature(StreetUserComputation.siig_r_scen_vuln_X,
				id+"="+distanza+"|"+idArco+"|"+idScenario+"|"+formatter.format(utentiBersaglio)+"|"+formatter.format(utentiSede));
		feature.getUserData().put(Hints.USE_PROVIDED_FID, true);
		featureStore.addFeatures((DataUtilities.collection(new ArrayList<SimpleFeature>() {{add(feature);}})));
	}

	private void computeVeicles(StreetUser streetUser, List<StreetScenario> scenari) {
		for(StreetScenario scenario : scenari){
			for(StreetInfo streetInfo  : streetUser.getDistance().getStreetsInfo()){
				List<StreetVeicle> vt = streetInfo.getVeicleTypes();
				for(int i = 0 ; i < vt.size() ; i++){
					StreetVeicle veicle = vt.get(i);
					ComputedData computed = new ComputedData();
					Double nTerritoriali = computeVeicleT0(veicle,streetInfo);
					computed.setN_territoriali(nTerritoriali);
					if(streetInfo.getOriginStreet()){
						Double nCoda = computeVeicleT1(veicle,streetInfo,scenario);						
						computed.setN_coda(nCoda);
						computed.setN_transito(0d);
					}else{
						Double nTransito = computeVeicleT1(veicle,streetInfo,scenario);
						computed.setN_transito(nTransito);
						computed.setN_coda(0d);
					}
					veicle.addComputedData(scenario,computed);
				}

			}
		}
	}

	private Double correctCodaByStorage(Double nTerritoriali, Double nCoda, Double storage) {
		Double nCoinvolti = (nTerritoriali + nCoda);
		return (nCoinvolti > (storage/2) ? (storage/2) : nCoinvolti);		
	}

	private Double computeVeicleT1(StreetVeicle veicle, StreetInfo streetInfo, StreetScenario scenario) {
		return (veicle.getDensity() * veicle.getMeanVelocity() * scenario.getTempoDiCoda());		
	}

	private Double computeVeicleT0(StreetVeicle veicle, StreetInfo streetInfo) {
		return  (veicle.getDensity() * streetInfo.getEffectiveGeometry().getLength());
	}

	private Double computeVeicleStorage(Double length, Integer nCorsie) {
		return  MAX_VEICLE_QUEUE_SIZE * nCorsie * length;
	}

	private void retrieveStreetInBuffer(StreetDistance street, StreetUser streetUser, int aggregationLevel){
		FeatureIterator<SimpleFeature> inputIterator = null;
		try {
			LOGGER.debug("Look for geometry in buffer " + street.getDistanza());	
			Geometry inputGeometry = (Geometry)streetUser.getGeoemtry();
			Geometry bufferGeometry = BufferUtils.iterativeBuffer(inputGeometry, street.getDistanza().doubleValue(), 50);
			FeatureStore<SimpleFeatureType, SimpleFeature> inputReader =FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_geo_ln_arco_" + aggregationLevel);
			Query inputQuery = new Query("siig_geo_ln_arco_" + aggregationLevel);
			inputQuery.setFilter(filterFactory.and(
					filterFactory.equals(filterFactory.property("fk_partner"),filterFactory.literal(partner)),
					filterFactory.intersects(filterFactory.property("geometria"), filterFactory.literal(bufferGeometry))
					));
			inputIterator = inputReader.getFeatures(inputQuery).features();
			while(inputIterator.hasNext()) {
				SimpleFeature sf = inputIterator.next();
				Geometry intersection = bufferGeometry.intersection( (Geometry) sf.getDefaultGeometry() );
				Integer streetId = ((Number) sf.getAttribute("id_geo_arco")).intValue();
				Boolean isOriginStreet = (streetId.intValue() == streetUser.getIdArco().intValue());
				Integer nCorsie = ((Number) sf.getAttribute("nr_corsie")).intValue();
				Double storage = computeVeicleStorage(intersection.getLength(),nCorsie);
				StreetInfo si = new StreetInfo(sf,intersection,isOriginStreet,storage);	
				retrieveStreetInfo(si,aggregationLevel);
				street.addStreetInfo(si);
			}
			inputIterator.close();
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			if(inputIterator != null){
				inputIterator.close();
			}
		}	
	}

	private void retrieveStreetInfo(StreetInfo ss, int aggregationLevel){
		FeatureIterator<SimpleFeature> inputIterator = null;
		try {
			Integer id_geo_arco = ((Number) ss.getOriginFeature().getAttribute("id_geo_arco")).intValue();
			FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_r_tipovei_geoarco" + aggregationLevel);
			Query inputQuery = new Query("siig_r_tipovei_geoarco" + aggregationLevel);
			inputQuery.setFilter(filterFactory.and(
					filterFactory.equals(filterFactory.property("fk_partner"),filterFactory.literal(partner)),
					filterFactory.equals(filterFactory.property("id_geo_arco"), filterFactory.literal(id_geo_arco))
					));
			inputIterator = inputReader.getFeatures(inputQuery).features();
			while(inputIterator.hasNext()) {
				SimpleFeature sf = inputIterator.next();
				StreetVeicle veicle = new StreetVeicle();
				veicle.setType( ((Number) sf.getAttribute("id_tipo_veicolo")).intValue());				
				int speed = ((Number) sf.getAttribute("velocita_media")).intValue() * 1000;
				veicle.setMeanVelocity(speed);
				veicle.setDensity(((Number) sf.getAttribute("densita_veicolare")).doubleValue() / speed / 24);
				retrieveVeicleInfo(veicle);
				ss.addVeicleType(veicle);
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			if(inputIterator != null){
				inputIterator.close();
			}
		}
	}

	private void retrieveVeicleInfo(StreetVeicle veicle){
		FeatureIterator<SimpleFeature> inputIterator = null;
		try {
			FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_d_tipo_veicolo");
			Query inputQuery = new Query("siig_d_tipo_veicolo");
			inputQuery.setFilter(filterFactory.equals(filterFactory.property("id_tipo_veicolo"),filterFactory.literal(veicle.getType())));
			inputIterator = inputReader.getFeatures(inputQuery).features();
			if(inputIterator.hasNext()) {
				SimpleFeature sf = inputIterator.next();
				veicle.setTypeDescription((String) sf.getAttribute("tipo_veicolo_it"));
				veicle.setOccupationCoeff(((Number) sf.getAttribute("coeff_occupazione")).doubleValue());
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			if(inputIterator != null){
				inputIterator.close();
			}
		}
	}


}
