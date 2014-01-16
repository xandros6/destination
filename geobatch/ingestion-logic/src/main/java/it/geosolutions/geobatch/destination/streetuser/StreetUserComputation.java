package it.geosolutions.geobatch.destination.streetuser;

import it.geosolutions.destination.utils.BufferUtils;
import it.geosolutions.geobatch.destination.common.InputObject;
import it.geosolutions.geobatch.destination.common.utils.FeatureLoaderUtils;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.geotools.data.DataStore;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.FeatureStore;
import org.geotools.data.Query;
import org.geotools.data.Transaction;
import org.geotools.data.collection.ListFeatureCollection;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureStore;
import org.geotools.factory.Hints;
import org.geotools.feature.FeatureIterator;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vividsolutions.jts.geom.Geometry;

public class StreetUserComputation extends InputObject {

	private final static Logger LOGGER = LoggerFactory.getLogger(StreetUserComputation.class);
	private Double SECONDS_IN_HOUR = 3600d;
	private Double KM_IN_METER = 1/1000d;
	private Double HOUR_IN_DAY = 24d;
	private String codicePartner;
	private int partner;
	private boolean removeFeatures = true;

	private String siig_r_scen_vuln_X_type;

	//private final static String EXTERNAL_PROP_DIR_PATH = "EXTERNAL_PROP_DIR_PATH";
	//private static final String STREET_USERS_PROP = "/streetusers.properties";

	private static final Integer MAX_VEICLE_QUEUE_SIZE = 150;

	//private static SimpleFeatureType siig_r_scen_vuln_X = null;

	private static Pattern TYPE_NAME_PARTS = Pattern
			.compile("^([A-Z]{2})_([A-Z]{1})_([A-Za-z]+)_([0-9]{8})(_ORIG)?$");

	public StreetUserComputation(String inputTypeName, ProgressListenerForwarder listenerForwarder, MetadataIngestionHandler metadataHandler, DataStore dataStore) {
		super(inputTypeName, listenerForwarder, metadataHandler, dataStore);
	}
	
	@Override
	protected String getInputTypeName(String inputTypeName) {
		return inputTypeName.replace("_ORIG", "");
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

	public void clearOutputFeature(Integer aggregationLevel){
		Transaction transaction = new DefaultTransaction("handle");
		try{						
			FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_t_vulnerabilita_" + aggregationLevel);
			Query inputQuery = new Query("siig_t_vulnerabilita_" + aggregationLevel);
			inputQuery.setFilter(filterFactory.equals(filterFactory.property("fk_partner"),filterFactory.literal(partner)));
			FeatureIterator<SimpleFeature> inputIterator = null;
			try {
				inputIterator = inputReader.getFeatures(inputQuery).features();

				FeatureStore<SimpleFeatureType, SimpleFeature> outputFeatureStore = FeatureLoaderUtils.createFeatureSource(dataStore, transaction,this.siig_r_scen_vuln_X_type);
				Query clearQuery = new Query(this.siig_r_scen_vuln_X_type);
				while(inputIterator.hasNext()) {
					SimpleFeature sf = inputIterator.next();
					Integer idGeoArco = getAttributeAsInt(sf.getAttribute("id_geo_arco"));
					//Clear output				
					clearQuery.setFilter(filterFactory.equals(filterFactory.property("id_geo_arco"),filterFactory.literal(idGeoArco)));
					outputFeatureStore.removeFeatures(clearQuery.getFilter());
				}

				transaction.commit();
			} finally  {
				if(inputIterator != null) {
					inputIterator.close();
				}
			}	
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

	private List<StreetScenario> getScenari() throws Exception{
		List<StreetScenario> scenari = new ArrayList<StreetScenario>();
		//Get "scenario" info
		FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_t_scenario");
		Query inputQuery = new Query("siig_t_scenario");
		FeatureIterator<SimpleFeature> inputIterator = null;
		try {
			inputIterator = inputReader.getFeatures(inputQuery).features();

			while(inputIterator.hasNext()) {
				SimpleFeature sf = inputIterator.next();
				if(sf.getAttribute("tempo_di_coda") != null){
					LOGGER.debug("Scenario <" + sf.getAttribute("tipologia") + "> found ");
					StreetScenario scenario = new StreetScenario();
					scenario.setIdScenario(getAttributeAsInt(sf.getAttribute("id_scenario")));
					scenario.setDescrizioneScenario((String) sf.getAttribute("tipologia"));
					scenario.setTempoDiCoda(getAttributeAsDouble(sf.getAttribute("tempo_di_coda")) / SECONDS_IN_HOUR);
					scenari.add(scenario);	
				}
			}
			return scenari;
		} finally {
			if(inputIterator != null) {
				inputIterator.close();
			}
		}


	}

	public void execute(Integer aggregationLevel, boolean dropInput, String closePhase) throws IOException {
		try {
			if(aggregationLevel == 1 || aggregationLevel == 2){
				executeArc(aggregationLevel);
			}
			if(aggregationLevel == 3){
				executeCell(aggregationLevel);
			}
		} finally {
			if(dropInput) {
				dropInputFeature(dataStore);
			}
			/*
			 *TODO: implement process and closing if(process != -1 && processPhase != null) {
				// close current process phase
				metadataHandler.closeProcessPhase(process, processPhase);
			}*/
		}
	}

	public void executeCell(Integer aggregationLevel){
		LOGGER.info("Start execution for CELL with partner="+partner+" and aggregationLevel="+aggregationLevel);

		Transaction transaction = new DefaultTransaction("handle");
		try{
			siig_r_scen_vuln_X_type = "siig_r_scen_vuln_"+aggregationLevel;


			if(removeFeatures) {
				clearOutputFeature(aggregationLevel);
			}

			List<StreetScenario> scenari = getScenari();

			TreeMap<Integer,StreetDistance> distanze = getDistanze();

			SimpleFeatureStore featureStore = (SimpleFeatureStore) this.dataStore.getFeatureSource(this.siig_r_scen_vuln_X_type);
			featureStore.setTransaction( transaction );

			FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, transaction,"siig_t_vulnerabilita_" + aggregationLevel);
			Query inputQuery = new Query("siig_t_vulnerabilita_" + aggregationLevel);
			inputQuery.setFilter(filterFactory.equals(filterFactory.property("fk_partner"),filterFactory.literal(partner)));
			FeatureIterator<SimpleFeature> inputIterator = null;
			try {
				inputIterator = inputReader.getFeatures(inputQuery).features();

				while(inputIterator.hasNext()) {
					SimpleFeature sf = inputIterator.next();
					//Found record on pl_arco3
					Integer idGeoCell = getAttributeAsInt(sf.getAttribute("id_geo_arco"));
					Integer idDistanza = getAttributeAsInt(sf.getAttribute("id_distanza"));
					StreetDistance distanza = distanze.get(idDistanza);
					if(distanza == null){
						continue;
					}
					/*
					 * SEARCH for cell
					 */	
					SimpleFeature sfCell = null;
					FeatureStore<SimpleFeatureType, SimpleFeature> inputReaderCell = FeatureLoaderUtils.createFeatureSource(dataStore, transaction,"siig_geo_pl_arco_" + aggregationLevel);
					Query inputQueryCell = new Query("siig_geo_pl_arco_" + aggregationLevel);

					inputQueryCell.setFilter(filterFactory.and(
							filterFactory.equals(filterFactory.property("fk_partner"),filterFactory.literal(partner)),
							filterFactory.equals(filterFactory.property("id_geo_arco"), filterFactory.literal(idGeoCell))
							));

					FeatureIterator<SimpleFeature>  inputIteratorCell = null; 
					try {
						inputIteratorCell = inputReaderCell.getFeatures(inputQueryCell).features();
						if(inputIteratorCell.hasNext()) {
							sfCell = inputIteratorCell.next();					
						}

					} finally {
						if(inputIteratorCell != null) {
							inputIteratorCell.close();
						}
					}


					if(sfCell == null){
						continue;
					}
					/*
					 * START cell computation
					 */				
					//Found all arc that intercept cell and override the intersected geometry
					Map<Integer,StreetUserResult> cellResults = new HashMap<Integer, StreetUserResult>();
					FeatureStore<SimpleFeatureType, SimpleFeature> inputReaderArc = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_geo_ln_arco_" + aggregationLevel);
					Query inputQueryArc = new Query("siig_geo_ln_arco_" + aggregationLevel);
					inputQueryArc.setFilter(filterFactory.and(
							filterFactory.equals(filterFactory.property("fk_partner"),filterFactory.literal(partner)),
							filterFactory.intersects(filterFactory.property("geometria"), filterFactory.literal(sfCell.getDefaultGeometry()))
							));
					FeatureIterator<SimpleFeature> inputIteratorArc = null;
					try {
						inputIteratorArc = inputReaderArc.getFeatures(inputQueryArc).features();
						while(inputIteratorArc.hasNext()) {
							SimpleFeature sfArc = inputIteratorArc.next();
							Geometry intersection = ((Geometry) sfArc.getDefaultGeometry()).intersection( (Geometry) sfCell.getDefaultGeometry() );
							Integer idGeoArco = getAttributeAsInt(sfArc.getAttribute("id_geo_arco"));
							Map<Integer,StreetUserResult> arcResults = computeArcoDistanza(idGeoArco,intersection,distanza,scenari,aggregationLevel);	
							//Cumulate arc result to cell result
							for(Integer scenarioId : arcResults.keySet()){
								StreetUserResult rArc = arcResults.get(scenarioId);
								StreetUserResult rCell = cellResults.get(scenarioId);
								if(rCell==null){
									rCell = new StreetUserResult(idGeoArco, idDistanza, scenarioId, rArc.getUtentiSede(), rArc.getUtentiBersaglio());
									cellResults.put(scenarioId, rCell);
								}else{
									Double utentiSedeCell =  rArc.getUtentiSede() + rCell.getUtentiSede();
									Double utentiBersaglioCell = rArc.getUtentiBersaglio() + rCell.getUtentiBersaglio();
									rCell.setUtentiBersaglio(utentiBersaglioCell);
									rCell.setUtentiSede(utentiSedeCell);							
								}
							}
						}
					} finally {
						if(inputIteratorArc != null) {
							inputIteratorArc.close();
						}
					}

					for(Integer idScenario : cellResults.keySet()){
						StreetUserResult celResult = cellResults.get(idScenario);
						persistStreetUsersData(partner,idGeoCell, idDistanza, idScenario, celResult.getUtentiSede(), celResult.getUtentiBersaglio(), featureStore);
						transaction.commit(); 
					}

				}

				transaction.commit();
			} finally {
				
				if(inputIterator != null) {
					inputIterator.close();
				}
			}
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

	public void executeArc(Integer aggregationLevel){

		LOGGER.info("Start execution with partner="+partner+" and aggregationLevel="+aggregationLevel);
		Transaction transaction = new DefaultTransaction("handle");		
		try{
			siig_r_scen_vuln_X_type = "siig_r_scen_vuln_"+aggregationLevel;

			if(removeFeatures) {
				clearOutputFeature(aggregationLevel);
			}

			List<StreetScenario> scenari = getScenari();

			TreeMap<Integer,StreetDistance> distanze = getDistanze();

			FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,"siig_t_vulnerabilita_" + aggregationLevel);
			Query inputQuery = new Query("siig_t_vulnerabilita_" + aggregationLevel);
			inputQuery.setFilter(filterFactory.equals(filterFactory.property("fk_partner"),filterFactory.literal(partner)));
			FeatureIterator<SimpleFeature> inputIterator = null;
			try {
				inputIterator = inputReader.getFeatures(inputQuery).features();


				SimpleFeatureStore featureStore = (SimpleFeatureStore) this.dataStore.getFeatureSource(this.siig_r_scen_vuln_X_type);
				featureStore.setTransaction( transaction );

				while(inputIterator.hasNext()) {
					SimpleFeature sf = inputIterator.next();
					Integer idGeoArco = getAttributeAsInt(sf.getAttribute("id_geo_arco"));
					Integer idDistanza = getAttributeAsInt(sf.getAttribute("id_distanza"));
					StreetDistance distanza = distanze.get(idDistanza);
					if(distanza != null){
						Map<Integer,StreetUserResult> results = computeArcoDistanza(idGeoArco,null,distanza,scenari,aggregationLevel);
						for(Integer key : results.keySet()){
							StreetUserResult r = results.get(key);
							persistStreetUsersData(partner,r.getIdArco(),r.getIdDistanza(),r.getIdScenario(),r.getUtentiSede(),r.getUtentiBersaglio(),featureStore);
							transaction.commit(); 
						}
					}
				}

				transaction.commit(); 
			} finally {
				if(inputIterator != null) {
					inputIterator.close();
				}
			}
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


	private Map<Integer,StreetUserResult> computeArcoDistanza(Integer idGeoArco, Geometry overrideGeometry, StreetDistance distanza, List<StreetScenario> scenari , Integer aggregationLevel){
		Map<Integer,StreetUserResult> result = new HashMap<Integer,StreetUserResult>();
		FeatureIterator<SimpleFeature> inputIterator = null;
		try{
			String typeName = "siig_geo_ln_arco_";
			FeatureStore<SimpleFeatureType, SimpleFeature> inputReader = FeatureLoaderUtils.createFeatureSource(dataStore, Transaction.AUTO_COMMIT,typeName + aggregationLevel);
			Query inputQuery = new Query(typeName + aggregationLevel);
			inputQuery.setFilter(filterFactory.and(
					filterFactory.equals(filterFactory.property("fk_partner"),filterFactory.literal(partner)),
					filterFactory.equals(filterFactory.property("id_geo_arco"),filterFactory.literal(idGeoArco))
					));			
			inputIterator = inputReader.getFeatures(inputQuery).features();
			if(inputIterator.hasNext()) {
				SimpleFeature sf = inputIterator.next();
				LOGGER.debug("Feature found : " + sf.toString());		
				Geometry geometry = (Geometry) sf.getDefaultGeometry();
				if(overrideGeometry != null){
					geometry = overrideGeometry;
				}
				StreetUser streetUser = new StreetUser(idGeoArco,geometry,distanza);
				retrieveStreetInBuffer(streetUser.getDistance(),streetUser,aggregationLevel);
				computeVeicles(streetUser,scenari);		
				result = computeUsers(streetUser,scenari);
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			if(inputIterator != null){
				inputIterator.close();
			}
		}
		return result;
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
				Integer key = getAttributeAsInt(sf.getAttribute("id_distanza"));
				Integer distanza = getAttributeAsInt(sf.getAttribute("distanza"));
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

	private Map<Integer,StreetUserResult> computeUsers(StreetUser streetUser, List<StreetScenario> scenari) {
		Map<Integer,StreetUserResult> result = new HashMap<Integer,StreetUserResult>();

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
			result.put(idScenario,new StreetUserResult(idArco,idDistanza,idScenario,utentiSede,utentiBersaglio));
		}
		return result;

	}

	private void persistStreetUsersData(Integer partner, Integer idArco, Integer distanza, Integer idScenario, Double utentiSede, Double utentiBersaglio, SimpleFeatureStore featureStore) throws Exception {
		List<SimpleFeature> list = new ArrayList<SimpleFeature>();
		SimpleFeatureBuilder builder = new SimpleFeatureBuilder(featureStore.getSchema());
		String featureid = idScenario+"."+idArco + "." + distanza;
		builder.featureUserData(Hints.USE_PROVIDED_FID, Boolean.TRUE);
		builder.set( "id_distanza", distanza );
		builder.set( "id_geo_arco", idArco );
		builder.set( "id_scenario", idScenario );
		builder.set( "utenti_carr_bersaglio", utentiBersaglio );
		builder.set( "utenti_carr_sede_inc", utentiSede );
		builder.set( "fk_partner", partner );
		final SimpleFeature feature = builder.buildFeature(featureid);
		feature.getUserData().put(Hints.USE_PROVIDED_FID, Boolean.TRUE);
		list.add(feature);
		SimpleFeatureCollection collection = new ListFeatureCollection(featureStore.getSchema(), list);
		LOGGER.debug("Update street user data : " +feature.toString());
		featureStore.addFeatures(collection);
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
		return  (veicle.getDensity() * (streetInfo.getEffectiveGeometry().getLength() * KM_IN_METER));
	}

	private Double computeVeicleStorage(Double length, Integer nCorsie) {
		return  MAX_VEICLE_QUEUE_SIZE * nCorsie * (length * KM_IN_METER);
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
				Integer streetId = getAttributeAsInt(sf.getAttribute("id_geo_arco"));
				Boolean isOriginStreet = (streetId.intValue() == streetUser.getIdArco().intValue());
				Integer nCorsie = getAttributeAsInt(sf.getAttribute("nr_corsie"));
				Double storage = computeVeicleStorage(intersection.getLength(),nCorsie);
				StreetInfo si = new StreetInfo(sf,intersection,isOriginStreet,storage);	
				retrieveStreetInfo(si,aggregationLevel);
				street.addStreetInfo(si);
			}			
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
			Integer id_geo_arco = getAttributeAsInt(ss.getOriginFeature().getAttribute("id_geo_arco"));
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
				veicle.setType(getAttributeAsInt(sf.getAttribute("id_tipo_veicolo")));
				int tgm = getAttributeAsInt(sf.getAttribute("densita_veicolare"));
				int meanVelocity = getAttributeAsInt(sf.getAttribute("velocita_media"));
				double densita = tgm / (meanVelocity * HOUR_IN_DAY);						
				veicle.setDensity(densita);
				veicle.setMeanVelocity(meanVelocity);
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
				veicle.setOccupationCoeff(getAttributeAsDouble(sf.getAttribute("coeff_occupazione")));
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}finally{
			if(inputIterator != null){
				inputIterator.close();
			}
		}
	}

	public void setRemoveFeatures(boolean removeFeatures) {
		this.removeFeatures = removeFeatures;
	}

	private int getAttributeAsInt(Object value){
		if(value instanceof BigDecimal){
			return ((BigDecimal)value).intValue();
		}else{
			return ((Integer)value).intValue();
		}
	}

	private double getAttributeAsDouble(Object value){
		if(value instanceof BigDecimal){
			return ((BigDecimal)value).doubleValue();
		}else{
			return ((Double)value).doubleValue();
		}
	}

}
