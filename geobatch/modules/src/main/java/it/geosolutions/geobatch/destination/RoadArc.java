/*
 *    GeoTools - The Open Source Java GIS Toolkit
 *    http://geotools.org
 *
 *    (C) 2002-2011, Open Source Geospatial Foundation (OSGeo)
 *
 *    This library is free software; you can redistribute it and/or
 *    modify it under the terms of the GNU Lesser General Public
 *    License as published by the Free Software Foundation;
 *    version 2.1 of the License.
 *
 *    This library is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *    Lesser General Public License for more details.
 */
package it.geosolutions.geobatch.destination;

import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.geotools.data.DataStoreFinder;
import org.geotools.data.DataUtilities;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.FeatureStore;
import org.geotools.data.Query;
import org.geotools.data.Transaction;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.factory.Hints;
import org.geotools.feature.FeatureCollection;
import org.geotools.feature.FeatureIterator;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.referencing.CRS;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.feature.type.AttributeDescriptor;
import org.opengis.filter.Filter;
import org.opengis.filter.FilterFactory;
import org.opengis.filter.expression.Function;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.expression.AccessException;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.PropertyAccessor;
import org.springframework.expression.TypedValue;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

import com.thoughtworks.xstream.XStream;
import com.vividsolutions.jts.geom.Geometry;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class RoadArc {
	
	private static final XStream xstream = new XStream();
	
	private final static Logger LOGGER = LoggerFactory.getLogger(RoadArc.class);
	
	private String inputTypeName = "";	
	private ProgressListenerForwarder listenerForwarder=null;
	
	private int partner = 0;
	private String codicePartner = "";
	private String date = "";
	
	private static Properties partners = new Properties();
	
	private static Pattern typeNameParts  = Pattern.compile("^([A-Z]{2})_([A-Z]{1})_([A-Za-z]+)_([0-9]{8})$");
	
	private static SpelExpressionParser expressionParser = new SpelExpressionParser();
	
	private static StandardEvaluationContext evaluationContext = new StandardEvaluationContext();
	
	private static CoordinateReferenceSystem defaultCrs = null;
	
	private boolean valid = false;
	
	private String geoTypeName = "siig_geo_ln_arco_X";	
	private String geoId = "id_geo_arco";
	
	private String byVehicleTypeName = "siig_r_tipovei_geoarcoX";
	private String dissestoTypeName = "siig_r_arco_X_dissesto";
	
	private static Map attributeMappings = null;
	
	private static FilterFactory filterFactory = CommonFactoryFinder.getFilterFactory();
	
	static {	
		// load mappings from resources
		try {
			partners.load(VectorTarget.class.getResourceAsStream("/partners.properties"));
			attributeMappings = (Map) xstream.fromXML(VectorTarget.class.getResourceAsStream("/roadarcs.xml"));
			evaluationContext.addPropertyAccessor(new PropertyAccessor() {
				
				@Override
				public void write(EvaluationContext ctx, Object target, String name,
						Object value) throws AccessException {					
					
				}
				
				@Override
				public TypedValue read(EvaluationContext ctx, Object target, String name)
						throws AccessException {
					if(target instanceof SimpleFeature) {
						SimpleFeature feature = (SimpleFeature) target;
						return new TypedValue(feature.getAttribute(name));
					}
					return null;
				}
				
				@Override
				public Class[] getSpecificTargetClasses() {					
					return new Class[] {SimpleFeature.class};
				}
				
				@Override
				public boolean canWrite(EvaluationContext ctx, Object target, String name)
						throws AccessException {					
					return false;
				}
				
				@Override
				public boolean canRead(EvaluationContext ctx, Object target, String name)
						throws AccessException {
					return target instanceof SimpleFeature;
				}
			});
		} catch (IOException e) {
			LOGGER.error("Unable to load configuration: "+e.getMessage(), e);
		}
	}
	
	/**
	 * Initializes a VectorTarget handler for the given input feature.
	 * 
	 * @param inputTypeName
	 */
	public RoadArc(String inputTypeName, ProgressListenerForwarder listenerForwarder) {
		super();
		this.inputTypeName = inputTypeName;
		this.listenerForwarder = listenerForwarder;
		this.parseTypeName();
	}
	
	/**
	 * Parse input feature typeName and extract useful information from it. 
	 */
	private void parseTypeName() {
		Matcher m = typeNameParts.matcher(inputTypeName);
		if(m.matches()) {
			// partner alphanumerical abbreviation (from siig_t_partner)
			codicePartner = m.group(1);
			// partner numerical id (from siig_t_partner)
			partner = Integer.parseInt(partners.get(codicePartner).toString());
			// target macro type (bu or bnu)			
			// file date identifier
			date = m.group(4);			
			
			// TODO: add other validity checks
			
			valid = true;
		}
	}
	

	/**
	 * Aggregate the arcs feature on the given attribute.
	 * 
	 * @param datastoreParams
	 * @param crs
	 * @throws IOException
	 */
	public void aggregateArcs(Map<String, Serializable> datastoreParams,
			CoordinateReferenceSystem crs, String aggregateAttribute, int aggregationLevel) throws IOException {
		if(!valid) {
			throw new IOException("typeName has an incorrect name format: "+inputTypeName);
		}
		
		JDBCDataStore dataStore = null;				
		
		if(crs == null) {
			if(defaultCrs == null) {
				try {
					defaultCrs = CRS.decode("EPSG:32632");
				} catch (Exception e) {
					LOGGER.error("Error decoding EPSG: " + e.getMessage(), e);
				}
			}
			crs = defaultCrs;
		}
		int process = -1;
		int trace = -1;
		
		int errors = 0;
		
		try {												
			dataStore = (JDBCDataStore)DataStoreFinder.getDataStore(datastoreParams);
			
			if(dataStore == null) {
				throw new IOException("Cannot connect to database for: "+inputTypeName);
			}
						
			// setup input reader
			Query query = new Query();		
			query.setTypeName(inputTypeName);
			
			FeatureStore<SimpleFeatureType, SimpleFeature> featureReader = 
					(FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(inputTypeName);							
			
			
			
			// setup geo feature writer
			String geoName = getTypeName(geoTypeName, aggregationLevel);
			SimpleFeatureType geoSchema = dataStore.getSchema(geoName);
			SimpleFeatureBuilder geoFeatureBuilder = new SimpleFeatureBuilder(geoSchema);
			FeatureStore<SimpleFeatureType, SimpleFeature> geoFeatureWriter = (FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(geoName);
						
			// setup byvehicle feature writer
			String vehicleName = getTypeName(byVehicleTypeName, aggregationLevel);
			SimpleFeatureType byvehicleSchema = dataStore.getSchema(vehicleName);			
			SimpleFeatureBuilder byvehicleFeatureBuilder = new SimpleFeatureBuilder(byvehicleSchema);												
			FeatureStore<SimpleFeatureType, SimpleFeature> byvehicleFeatureWriter = (FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(vehicleName);
			
			
			// setup dissesto feature writer
			String dissestoName = getTypeName(dissestoTypeName, aggregationLevel);
			SimpleFeatureType dissestoSchema = dataStore.getSchema(dissestoName);			
			SimpleFeatureBuilder dissestoFeatureBuilder = new SimpleFeatureBuilder(dissestoSchema);												
			FeatureStore<SimpleFeatureType, SimpleFeature> dissestoFeatureWriter = (FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(dissestoName);			
			
			// remove previous data for the given partner
			Filter removeFilter = filterFactory.equals(
				filterFactory.property("fk_partner"), filterFactory.literal(partner)
			);			
			dissestoFeatureWriter.removeFeatures(removeFilter);
			byvehicleFeatureWriter.removeFeatures(removeFilter);
			geoFeatureWriter.removeFeatures(removeFilter);
			
			
			// get unique aggregation values
			Function unique = filterFactory.function("Collection_Unique", filterFactory.property(aggregateAttribute));			
			FeatureCollection<SimpleFeatureType, SimpleFeature> features = featureReader
					.getFeatures(query);		
			
			Set<Integer> values = (Set<Integer>) unique.evaluate( featureReader.getFeatures(new Query(inputTypeName, Filter.INCLUDE)) );
			
			// calculate max current value for geo output id, to append new data
			Function max = filterFactory.function("Collection_Max", filterFactory.property(geoId));			
										
			BigDecimal maxId = (BigDecimal)max.evaluate( geoFeatureWriter.getFeatures(new Query(geoTypeName + "_" + aggregationLevel, Filter.INCLUDE)) );
			if(maxId == null) {
				maxId = new BigDecimal(0);
			}
			
			int count = 0;
			for(int aggregateValue : values) {			
				
				int id = maxId.intValue()+count+1;		
				
				Filter filter = filterFactory.equals(
					filterFactory.property(aggregateAttribute),
					filterFactory.literal(aggregateValue)
				);
				query.setFilter(filter);
				
				features = featureReader.getFeatures(query);
				
				// iterate over input and create aggregate
				FeatureIterator<SimpleFeature> iterator = features.features();	
				try {
										
					
					Geometry geo = null;
					int lunghezza = 0;
					int incidenti = 0;
					int corsie = 0;
					int[] tgm = new int[] {0, 0};
					int[] velocita = new int[] {0, 0};
					Set<Integer> pterr = new HashSet<Integer>(); 
					
					while (iterator.hasNext()) {
						SimpleFeature inputFeature = iterator.next();
																			
						int idTematico = 0;
						
						try {
							// geo
							if(geo == null) {
								geo = (Geometry)inputFeature.getDefaultGeometry();
							} else {
								geo = geo.union((Geometry)inputFeature.getDefaultGeometry());
							}
							int currentLunghezza = ((Number)getMapping(inputFeature, attributeMappings, "lunghezza")).intValue(); 
							lunghezza +=  currentLunghezza;
							incidenti += ((Number)getMapping(inputFeature, attributeMappings, "nr_incidenti")).intValue();
							corsie += ((Number)getMapping(inputFeature, attributeMappings, "nr_corsie")).intValue() * currentLunghezza;
							
							// by vehicle
							int[] tgms = extractMultipleValues(inputFeature, "TGM");
							int[] velocitas = extractMultipleValues(inputFeature, "VELOCITA");
							
							for(int i=0; i<tgms.length; i++) {
								tgm[i] += tgms[i] * currentLunghezza;
								velocita[i] += velocitas[i] * currentLunghezza;
							}
							
							// dissesto
							String[] pterrs = inputFeature.getAttribute("PTERR") == null ? null : inputFeature.getAttribute("PTERR").toString().split("\\|");					
							
							for(int j=0; j < pterrs.length; j++) {
								try {
									int dissesto = Integer.parseInt(pterrs[j]);
									pterr.add(dissesto);									
								} catch(NumberFormatException e) {
									
								}
							}
						} catch(Exception e) {						
							errors++;
							Ingestion.logError(dataStore, trace, errors,
									"Error writing output feature", getError(e),
									idTematico);
						}

						
					}					

					// geo
					for(AttributeDescriptor attr : geoSchema.getAttributeDescriptors()) {
						if(attr.getLocalName().equals(geoId)) {
							geoFeatureBuilder.add(id);
						} else if(attr.getLocalName().equals("fk_partner")) {
							geoFeatureBuilder.add(partner+"");
						} else if(attr.getLocalName().equals("id_tematico_shape")) {
							geoFeatureBuilder.add(aggregateValue+"");
						} else if(attr.getLocalName().equals("geometria")) {
							geoFeatureBuilder.add(geo);
						} else if(attr.getLocalName().equals("lunghezza")) {
							geoFeatureBuilder.add(lunghezza);
						} else if(attr.getLocalName().equals("nr_incidenti")) {
							geoFeatureBuilder.add(incidenti);
						} else if(attr.getLocalName().equals("nr_corsie")) {
							if(lunghezza == 0) {
								geoFeatureBuilder.add(0);
							} else {
								geoFeatureBuilder.add(corsie / lunghezza);
							}
						} else {
							geoFeatureBuilder.add(null);
						}
					}
					SimpleFeature geoFeature = geoFeatureBuilder.buildFeature(null);		
					geoFeatureWriter.addFeatures(DataUtilities
							.collection(geoFeature));
										
					geoFeatureBuilder.reset();
					
					// by vehicle
					for(int type = 0; type <= 1;type++) {
						for(AttributeDescriptor attr : byvehicleSchema.getAttributeDescriptors()) {
							if(attr.getLocalName().equals(geoId)) {
								byvehicleFeatureBuilder.add(id);
							} else if(attr.getLocalName().equals("densita_veicolare")) {
								if(lunghezza == 0) {
									byvehicleFeatureBuilder.add(0);
								} else {
									byvehicleFeatureBuilder.add(tgm[type] / lunghezza);
								}
							} else if(attr.getLocalName().equals("id_tipo_veicolo")) {
								byvehicleFeatureBuilder.add(type + 1);
							} else if(attr.getLocalName().equals("velocita_media")) {
								if(lunghezza == 0) {
									byvehicleFeatureBuilder.add(0);
								} else {
									byvehicleFeatureBuilder.add(velocita[type] / lunghezza);
								}
							} else if(attr.getLocalName().equals("fk_partner")) {
								byvehicleFeatureBuilder.add(partner+"");
							} else {
								byvehicleFeatureBuilder.add(null);
							}
						}
						String featureid = (type + 1) + "." + id;
						SimpleFeature feature = byvehicleFeatureBuilder.buildFeature(featureid);
						feature.getUserData().put(Hints.USE_PROVIDED_FID, true);			
						
						byvehicleFeatureWriter.addFeatures(DataUtilities
								.collection(feature));
					}
					
					// dissesto
					for(int dissesto : pterr) {
						dissestoFeatureBuilder.reset();
						// compiles the attributes from target and read feature data, using mappings
						// to match input attributes with output ones
						for(AttributeDescriptor attr : dissestoSchema.getAttributeDescriptors()) {
							if(attr.getLocalName().equals(geoId)) {
								dissestoFeatureBuilder.add(id);
							} else if(attr.getLocalName().equals("id_dissesto")) {
								dissestoFeatureBuilder.add(dissesto);
							} else if(attr.getLocalName().equals("fk_partner")) {
								dissestoFeatureBuilder.add(partner+"");
							} else {
								dissestoFeatureBuilder.add(null);
							}
						}
						String featureid = dissesto + "." + id;
						SimpleFeature feature = dissestoFeatureBuilder.buildFeature(featureid);
						feature.getUserData().put(Hints.USE_PROVIDED_FID, true);			
						
						dissestoFeatureWriter.addFeatures(DataUtilities
								.collection(feature));
					}
					
					
					
					count++;
					if (count % 100 == 0) {
						updateImportProgress(count, values.size(), "Importing data in " + geoTypeName);							
					}
					byvehicleFeatureBuilder.reset();
									
				
				} finally {									
					iterator.close();
				}
				updateImportProgress(values.size(), values.size(),  "Data imported in "+ geoTypeName);
			}
			
		} catch (IOException e) {
			errors++;	
			Ingestion.logError(dataStore, trace, errors, "Error reading input feature", getError(e), 0);						
			throw e;
		} finally {			
			if(process != -1) {
				// close current process phase
				//Ingestion.closeProcessPhase(dataStore, process, "A");
			}
			
			if(dataStore != null) {
				dataStore.dispose();
			}			
		}
	}
	
	/**
	 * @param geoTypeName2
	 * @param aggregationLevel
	 * @return
	 */
	private String getTypeName(String typeName, int aggregationLevel) {		
		return typeName.replace("X", aggregationLevel+"");
	}

	/**
	 * Imports the arcs feature from the original Feature to the SIIG
	 * arcs tables (in staging).
	 * 
	 * @param datastoreParams
	 * @param crs
	 * @throws IOException
	 */
	public void importArcs(Map<String, Serializable> datastoreParams,
			CoordinateReferenceSystem crs) throws IOException {
		
		if(!valid) {
			throw new IOException("typeName has an incorrect name format: "+inputTypeName);
		}
		
		JDBCDataStore dataStore = null;		
		Transaction transaction = null;
		
		if(crs == null) {
			if(defaultCrs == null) {
				try {
					defaultCrs = CRS.decode("EPSG:32632");
				} catch (Exception e) {
					LOGGER.error("Error decoding EPSG: " + e.getMessage(), e);
				}
			}
			crs = defaultCrs;
		}
		int process = -1;
		int trace = -1;
		
		int errors = 0;
		
		try {												
			dataStore = (JDBCDataStore)DataStoreFinder.getDataStore(datastoreParams);
			
			if(dataStore == null) {
				throw new IOException("Cannot connect to database for: "+inputTypeName);
			}
			
			// create a new process record for the ingestion
			process = Ingestion.createProcess(dataStore);			
			
			
			
			// write log for the imported file
			trace = Ingestion.logFile(dataStore,  process, -1,
					partner, codicePartner, inputTypeName, date, false);
									
			transaction = new DefaultTransaction();
			
			// setup input reader
			Query query = new Query();		
			query.setTypeName(inputTypeName);
			
			FeatureStore<SimpleFeatureType, SimpleFeature> featureReader = 
					(FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(inputTypeName);							
			featureReader.setTransaction(transaction);
			
			// setup geo feature writer
			String geoName = getTypeName(geoTypeName, 1);
			SimpleFeatureType geoSchema = dataStore.getSchema(geoName);
			SimpleFeatureBuilder geoFeatureBuilder = new SimpleFeatureBuilder(geoSchema);
			FeatureStore<SimpleFeatureType, SimpleFeature> geoFeatureWriter = (FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(geoName);
			geoFeatureWriter.setTransaction(transaction);			
			
			// setup byvehicle feature writer
			String vehicleName = getTypeName(byVehicleTypeName, 1);
			SimpleFeatureType byvehicleSchema = dataStore.getSchema(vehicleName);			
			SimpleFeatureBuilder byvehicleFeatureBuilder = new SimpleFeatureBuilder(byvehicleSchema);												
			FeatureStore<SimpleFeatureType, SimpleFeature> byvehicleFeatureWriter = (FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(vehicleName);
			byvehicleFeatureWriter.setTransaction(transaction);
			
			// setup dissesto feature writer
			String dissestoName = getTypeName(dissestoTypeName, 1);
			SimpleFeatureType dissestoSchema = dataStore.getSchema(dissestoName);			
			SimpleFeatureBuilder dissestoFeatureBuilder = new SimpleFeatureBuilder(dissestoSchema);												
			FeatureStore<SimpleFeatureType, SimpleFeature> dissestoFeatureWriter = (FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(dissestoName);
			dissestoFeatureWriter.setTransaction(transaction);
			
			// remove previous data for the given partner - target couple
			Filter removeFilter = filterFactory.equals(
				filterFactory.property("fk_partner"), filterFactory.literal(partner)
			);
			byvehicleFeatureWriter.removeFeatures(removeFilter);
			dissestoFeatureWriter.removeFeatures(removeFilter);
			geoFeatureWriter.removeFeatures(removeFilter);						
			
			
			// TODO: should we avoid to calc total for performance?
			int total = featureReader.getCount(query);
			
			// calculate max current value for geo output id, to append new data
			Function max = filterFactory.function("Collection_Max", filterFactory.property(geoId));			
			FeatureCollection<SimpleFeatureType, SimpleFeature> features = featureReader
					.getFeatures(query);							
			BigDecimal maxId = (BigDecimal)max.evaluate( geoFeatureWriter.getFeatures(new Query(geoTypeName + "_1", Filter.INCLUDE)) );
			if(maxId == null) {
				maxId = new BigDecimal(0);
			}
						
			transaction.commit();						
			
			
			// iterate over input and import in geo and not-geo tables
			FeatureIterator<SimpleFeature> iterator = features.features();				
						
			//featureWriter.setTransaction(null);
			
			geoFeatureWriter.setTransaction(null);			
			byvehicleFeatureWriter.setTransaction(null);
			dissestoFeatureWriter.setTransaction(null);
			try {
				int count = 0;
				
				
				while (iterator.hasNext()) {
					SimpleFeature inputFeature = iterator.next();
					
					int id = maxId.intValue()+count+1;		
					
					int idTematico = 0;
					
					try {
						geoFeatureBuilder.reset();
						addGeoFeature(geoSchema, geoFeatureBuilder,
								geoFeatureWriter, inputFeature, id);						
						addByVehicleFeature(partner, byvehicleSchema, byvehicleFeatureBuilder,
								byvehicleFeatureWriter, id, inputFeature);
						addDissestoFeature(partner, dissestoSchema, dissestoFeatureBuilder,
								dissestoFeatureWriter, id, inputFeature);
					} catch(Exception e) {						
						errors++;
						Ingestion.logError(dataStore, trace, errors,
								"Error writing output feature", getError(e),
								idTematico);
					}

					count++;
					if (count % 100 == 0) {
						updateImportProgress(count, total, "Importing data in " + geoTypeName + "_1");							
					}
				}
				updateImportProgress(total, total,  "Data imported in "+ geoTypeName + "_1");				
			
			} finally {									
				iterator.close();
			}
			
			Ingestion.updateLogFile(dataStore, trace, total, errors);												
		} catch (IOException e) {
			errors++;	
			Ingestion.logError(dataStore, trace, errors, "Error reading input feature", getError(e), 0);
			transaction.rollback();						
			throw e;
		} finally {
			/*listenerForwarder.setTask("Dropping table "+inputTypeName);
			if(LOGGER.isInfoEnabled()) {
				LOGGER.info("Dropping table "+inputTypeName);
			}
			
			try {
				DbUtils.dropFeatureType(datastoreParams, inputTypeName);
				listenerForwarder.setTask("Table dropped");
				if(LOGGER.isInfoEnabled()) {
					LOGGER.info("Table dropped");
				}
			} catch (SQLException e) {
				LOGGER.error("Error dropping table "+inputTypeName+": "+e.getMessage());
			}*/
			
			if(process != -1) {
				// close current process phase
				Ingestion.closeProcessPhase(dataStore, process, "A");
			}
			
			if(dataStore != null) {
				dataStore.dispose();
			}
			if(transaction != null) {
				transaction.close();
			}
		}
	}
	
	/**
	 * Adds arc - vehicletype data feature.
	 * 
	 */
	private void addByVehicleFeature(int partner, SimpleFeatureType schema,
			SimpleFeatureBuilder featureBuilder,
			FeatureStore<SimpleFeatureType, SimpleFeature> featureWriter, int id, SimpleFeature inputFeature)
			throws IOException {
		
		int[] tgm = extractMultipleValues(inputFeature, "TGM");
		int[] velocita = extractMultipleValues(inputFeature, "VELOCITA");
		
		
		for(int type = 0; type <= 1; type++) {
			featureBuilder.reset();
			// compiles the attributes from target and read feature data, using mappings
			// to match input attributes with output ones
			for(AttributeDescriptor attr : schema.getAttributeDescriptors()) {
				if(attr.getLocalName().equals(geoId)) {
					featureBuilder.add(id);
				} else if(attr.getLocalName().equals("densita_veicolare")) {
					featureBuilder.add(tgm[type]);
				} else if(attr.getLocalName().equals("id_tipo_veicolo")) {
					featureBuilder.add(type + 1);
				} else if(attr.getLocalName().equals("velocita_media")) {
					featureBuilder.add(velocita[type]);
				} else if(attr.getLocalName().equals("fk_partner")) {
					featureBuilder.add(partner+"");
				} else {
					featureBuilder.add(null);
				}
			}
			String featureid = (type + 1) + "." + id;
			SimpleFeature feature = featureBuilder.buildFeature(featureid);
			feature.getUserData().put(Hints.USE_PROVIDED_FID, true);			
			
			featureWriter.addFeatures(DataUtilities
					.collection(feature));
		}		
	}

	/**
	 * @param inputFeature
	 * @return
	 */
	private int[] extractMultipleValues(SimpleFeature inputFeature, String attributeName) {
		String[] svalues = inputFeature.getAttribute(attributeName).toString().split("\\|");				
		int[] values = new int[] {0,0};		
		
		for(int count=0; count < svalues.length; count++) {
			try {
				values[count] = Integer.parseInt(svalues[count]);
			} catch(NumberFormatException e) {
				
			}
		}
		return values;
	}
	
	/**
	 * Adds arc - dissesto data feature.
	 * 
	 */
	private void addDissestoFeature(int partner, SimpleFeatureType schema,
			SimpleFeatureBuilder featureBuilder,
			FeatureStore<SimpleFeatureType, SimpleFeature> featureWriter, int id, SimpleFeature inputFeature)
			throws IOException {
		String[] pterrs = inputFeature.getAttribute("PTERR") == null ? null : inputFeature.getAttribute("PTERR").toString().split("\\|");					
		
		for(int count=0; count < pterrs.length; count++) {
			try {
				int dissesto = Integer.parseInt(pterrs[count]);
				featureBuilder.reset();
				// compiles the attributes from target and read feature data, using mappings
				// to match input attributes with output ones
				for(AttributeDescriptor attr : schema.getAttributeDescriptors()) {
					if(attr.getLocalName().equals(geoId)) {
						featureBuilder.add(id);
					} else if(attr.getLocalName().equals("id_dissesto")) {
						featureBuilder.add(dissesto);
					} else if(attr.getLocalName().equals("fk_partner")) {
						featureBuilder.add(partner+"");
					} else {
						featureBuilder.add(null);
					}
				}
				String featureid = id + "." + dissesto;
				SimpleFeature feature = featureBuilder.buildFeature(featureid);
				feature.getUserData().put(Hints.USE_PROVIDED_FID, true);			
				
				featureWriter.addFeatures(DataUtilities
						.collection(feature));
			} catch(NumberFormatException e) {
				
			}
		}
				
	}
	
	/**
	 * Updates the import progress ( progress / total )
	 * for the listeners.
	 * 
	 * @param progress
	 * @param total
	 * @param message
	 */
	private void updateImportProgress(int progress, int total, String message) {
		listenerForwarder.progressing((float) progress , message);
		if(LOGGER.isInfoEnabled()) {
			LOGGER.info("Importing data: "+progress + "/" + total);
		}
	}
	
	/**
	 * @param e
	 * @return
	 */
	private String getError(Exception e) {		
		// TODO: human readble error
		Throwable t = e;
		while(t.getCause() != null) {
			t=t.getCause();
		}
		
		return t.getMessage().substring(0,Math.min(t.getMessage().length(), 1000));
	}
	
	/**
	 * Adds a new geo arc feature.
	 * 
	 * @param geoSchema
	 * @param geoFeatureBuilder
	 * @param geoFeatureWriter
	 * @param inputFeature
	 * @param id
	 * @throws IOException
	 */
	private void addGeoFeature(SimpleFeatureType geoSchema,
			SimpleFeatureBuilder geoFeatureBuilder,
			FeatureStore<SimpleFeatureType, SimpleFeature> geoFeatureWriter,
			SimpleFeature inputFeature, int id) throws IOException {				
		
		// compiles the attributes from target and read feature data
		for(AttributeDescriptor attr : geoSchema.getAttributeDescriptors()) {
			if(attr.getLocalName().equals(geoId)) {
				geoFeatureBuilder.add(id);
			} else if(attr.getLocalName().equals("fk_partner")) {
				geoFeatureBuilder.add(partner+"");
			} else if(attr.getLocalName().equals("geometria")) {
				geoFeatureBuilder.add(inputFeature.getDefaultGeometry());
			} else if(attributeMappings.containsKey(attr.getLocalName())) {
				geoFeatureBuilder.add(getMapping(inputFeature,attributeMappings, attr.getLocalName()));
			} else {
				geoFeatureBuilder.add(null);
			}
						
		}
		
		SimpleFeature geoFeature = geoFeatureBuilder.buildFeature(null);		
		geoFeatureWriter.addFeatures(DataUtilities
				.collection(geoFeature));
	}
	
	/**
	 * Creates or updates a geo arc aggregate feature.
	 * 
	 * @param geoSchema
	 * @param geoFeatureBuilder
	 * @param geoFeatureWriter
	 * @param inputFeature
	 * @param id
	 * @throws IOException
	 
	private void aggregateGeoFeature(SimpleFeatureType geoSchema,
			SimpleFeatureBuilder geoFeatureBuilder,
			FeatureStore<SimpleFeatureType, SimpleFeature> geoFeatureWriter,
			SimpleFeature inputFeature, int id, String aggregationField) throws IOException {				
		
		// key filter
		Filter filter = filterFactory.and(
			filterFactory.equals(
				filterFactory.property("id_tematico_shape"),
				filterFactory.literal(inputFeature.getAttribute(aggregationField))
			),
			filterFactory.equals(
				filterFactory.property("fk_partner"),
				filterFactory.literal(partner)
			)
		);
		Query existing = new Query(geoSchema.getName().getLocalPart(), filter);
		FeatureIterator<SimpleFeature> iterator = geoFeatureWriter.getFeatures(existing).features();	
		try {
			if(iterator.hasNext()) {
				updateGeoFeature(geoSchema, geoFeatureBuilder, geoFeatureWriter, inputFeature, id, iterator.next(), filter);
			} else {
				addGeoFeature(geoSchema, geoFeatureBuilder, geoFeatureWriter, inputFeature, id);
			}
		} finally {
			iterator.close();
		}		
	}*/
	
	/**
	 * Updates an existing aggregate geo arc feature.
	 * 
	 * @param geoSchema
	 * @param geoFeatureBuilder
	 * @param geoFeatureWriter
	 * @param inputFeature
	 * @param id
	 * @throws IOException
	 
	private void updateGeoFeature(SimpleFeatureType geoSchema,
			SimpleFeatureBuilder geoFeatureBuilder,
			FeatureStore<SimpleFeatureType, SimpleFeature> geoFeatureWriter,
			SimpleFeature inputFeature, int id, SimpleFeature aggregate, Filter filter) throws IOException {				
		List<Name> updated  = new ArrayList<Name>();
		List<Object> values = new ArrayList<Object>();
		// compiles the attributes from target and read feature data
		for(AttributeDescriptor attr : geoSchema.getAttributeDescriptors()) {
			if(attr.getLocalName().equals("geometria")) {
				Geometry geo = (Geometry)aggregate.getDefaultGeometry();
				geo = geo.union((Geometry)inputFeature.getDefaultGeometry());
				updated.add(attr.getName());
				values.add(geo);
			} else if(attr.getLocalName().equals("lunghezza")) {
				int lunghezza = ((Number)aggregate.getAttribute("lunghezza")).intValue();
				updated.add(attr.getName());
				values.add(lunghezza + ((Number)getMapping(inputFeature, attributeMappings, "lunghezza")).intValue());
			} else if(attr.getLocalName().equals("nr_incidenti")) {
				int incidenti = ((Number)aggregate.getAttribute("nr_incidenti")).intValue();
				updated.add(attr.getName());
				values.add(incidenti + ((Number)getMapping(inputFeature, attributeMappings, "nr_incidenti")).intValue());
			} else if(attr.getLocalName().equals("nr_corsie")) {
				int oldlunghezza = ((Number)aggregate.getAttribute("lunghezza")).intValue();
				int oldcorsie = ((Number)aggregate.getAttribute("nr_corsie")).intValue();
				
				int newlunghezza = ((Number)getMapping(inputFeature, attributeMappings, "lunghezza")).intValue();
				int newcorsie = ((Number)getMapping(inputFeature, attributeMappings, "nr_corsie")).intValue();
				
				int sum = oldcorsie * oldlunghezza + newcorsie * newlunghezza;
				
				updated.add(attr.getName());
				values.add(sum / (oldlunghezza + newlunghezza));
			}
		}
		geoFeatureWriter.modifyFeatures(updated.toArray(new Name[] {}), values.toArray(), filter);
		
	}*/
	
	/**
	 * @param inputFeature
	 * @param string
	 * @return
	 * @throws IOException 
	 */
	private Object getMapping(SimpleFeature inputFeature, Map<String,String> mappings, String attribute) throws IOException {
		String expression = mappings.get(attribute);
		// TODO: introduce some form of expression evaluation
		if(expression.trim().startsWith("#{") && expression.trim().endsWith("}")) {
			expression = expression.trim().substring(2,expression.length()-1);
			org.springframework.expression.Expression spelExpression = expressionParser
					.parseExpression(expression);
			
			return spelExpression
					.getValue(evaluationContext, inputFeature);
		} else {
			return inputFeature.getAttribute(expression);
		}
	}
}
