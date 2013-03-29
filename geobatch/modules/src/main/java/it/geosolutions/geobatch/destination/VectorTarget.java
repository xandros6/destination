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
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;
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


/**
 * Handle the vector targets ingestion processes.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class VectorTarget {
	
	private static final XStream xstream = new XStream();
	
	private final static Logger LOGGER = LoggerFactory.getLogger(VectorTarget.class);
	
	private static CoordinateReferenceSystem defaultCrs = null;
		
	private String inputTypeName = "";
	private ProgressListenerForwarder listenerForwarder=null;
	
	private static Pattern typeNameParts  = Pattern.compile("^([A-Z]{2})_([A-Z]{2,3})-([A-Z]+)_([0-9]{8})_([0-9]{2})$");
	
	private int partner = 0;
	private String codicePartner = "";
	private String targetMacroType = "";
	private int targetType = 0;
	private String date = "";
	private String geometryType = "";
	
	private static Properties partners = new Properties();
	private static Properties targetTypes = new Properties();
	private static Properties geometryTypes = new Properties();						
	
	private static Map attributeMappings = null;
	
	private static FilterFactory filterFactory = CommonFactoryFinder.getFilterFactory();
	
	String geoSuffix = "";
	String geoTypeName = "";
	String geoId = "";
	String fkGeoId = "";

	String outTypeName = "";
	
	private boolean valid = false;
	
	private static SpelExpressionParser expressionParser = new SpelExpressionParser();
	
	private static StandardEvaluationContext evaluationContext = new StandardEvaluationContext();
	
	static {	
		// load mappings from resources
		try {
			partners.load(VectorTarget.class.getResourceAsStream("/partners.properties"));
			targetTypes.load(VectorTarget.class.getResourceAsStream("/targets.properties"));	
			geometryTypes.load(VectorTarget.class.getResourceAsStream("/geometries.properties"));								
			attributeMappings = (Map) xstream.fromXML(VectorTarget.class.getResourceAsStream("/targets.xml"));
			
			// add a property accessor to extract attributes from SimpleFeature objects
			// to SpelExpressionParser EvaluationContext
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
	public VectorTarget(String inputTypeName, ProgressListenerForwarder listenerForwarder) {
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
			targetMacroType = m.group(2);
			// target detailed type id (from siig_t_bersaglio)
			targetType = Integer.parseInt(targetTypes.get(m.group(3)).toString());
			// file date identifier
			date = m.group(4);
			// geometry type (pt, pl or ln)
			geometryType = geometryTypes.get(m.group(5)).toString();			
			
			// final part of the target geo table name (siig_geo_<suffix>) 
			geoSuffix = (targetMacroType.equals("BU") ? "bersaglio_umano" : "bers_non_umano") + "_" + geometryType;
			// target geo table name (siig_geo_<suffix>)
			geoTypeName = "siig_geo_" + geoSuffix;
			// target geo id name (idgeo_<suffix>)
			geoId = "idgeo_" + geoSuffix;
			// target non-geo table name (siig_t_bersaglio_<non geo suffix>)
			outTypeName = "siig_t_bersaglio_" + (targetMacroType.equals("BU") ? "umano" : "non_umano");
			// target non-geo to geo foreign key name
			fkGeoId = "fk_" + geoSuffix;
			
			// TODO: add other validity checks
			
			valid = true;
		}
	}

	/**
	 * Imports the target feature from the original Feature to the SIIG
	 * targets tables (in staging).
	 * 
	 * @param datastoreParams
	 * @param crs
	 * @throws IOException
	 */
	public void importTarget(Map<String, Serializable> datastoreParams,
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
			
			// is it an update (alternative geo shapefile for an already imported one)
			boolean update =isAnUpdate(dataStore, transaction);
			
			// write log for the imported file
			trace = Ingestion.logFile(dataStore,  process, targetType,
					partner, codicePartner, inputTypeName, date, false);
			
			// is it an update with new records (currently acque superficiali supports this
			// modality)
			boolean hasMoreData = update && canHaveMoreData(targetType);
			
			transaction = new DefaultTransaction();
			
			// setup input reader
			Query query = new Query();		
			query.setTypeName(inputTypeName);
			
			FeatureStore<SimpleFeatureType, SimpleFeature> featureReader = 
					(FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(inputTypeName);							
			featureReader.setTransaction(transaction);
			
			// setup geo feature writer
			SimpleFeatureType geoSchema = dataStore.getSchema(geoTypeName);
			SimpleFeatureBuilder geoFeatureBuilder = new SimpleFeatureBuilder(geoSchema);
			FeatureStore<SimpleFeatureType, SimpleFeature> geoFeatureWriter = (FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(geoTypeName);
			geoFeatureWriter.setTransaction(transaction);
			
			// setup non-geo feature writer
			SimpleFeatureType schema = dataStore.getSchema(outTypeName);			
			SimpleFeatureBuilder featureBuilder = new SimpleFeatureBuilder(schema);												
			FeatureStore<SimpleFeatureType, SimpleFeature> featureWriter = (FeatureStore<SimpleFeatureType, SimpleFeature>) dataStore
					.getFeatureSource(outTypeName);
			featureWriter.setTransaction(transaction);
			
			// remove previous data for the given partner - target couple
			Filter removeFilter = filterFactory.and(
				filterFactory.equals(
					filterFactory.property("id_bersaglio"), filterFactory.literal(targetType)
				),
				filterFactory.equals(
					filterFactory.property("id_partner"), filterFactory.literal(partner)
				)
			);
			
			if(!update) {
				// first shapefile of a series, we can remove all previous data for the
				// target - partner couple
				featureWriter.removeFeatures(removeFilter);
			} else {
				// on update we only reset the foreign key column
				featureWriter.modifyFeatures(schema.getDescriptor(fkGeoId).getName(), null, removeFilter);
			}
			if(hasMoreData) {
				// remove records with no more geometry bound
				String otherGeo = geometryType.equals("pl") ? "ln" : "pl";
				Filter extraRemoveFilter = filterFactory.and(
					removeFilter,
					filterFactory.isNull(
						filterFactory.property("fk_bers_non_umano_" + otherGeo)
					)
					
				); 
				featureWriter.removeFeatures(extraRemoveFilter);
			}
			// remove geo records
			geoFeatureWriter.removeFeatures(removeFilter);
			
			// TODO: should we avoid to calc total for performance?
			int total = featureReader.getCount(query);
			
			// calculate max current value for geo output id, to append new data
			Function max = filterFactory.function("Collection_Max", filterFactory.property(geoId));			
			FeatureCollection<SimpleFeatureType, SimpleFeature> features = featureReader
					.getFeatures(query);							
			BigDecimal maxId = (BigDecimal)max.evaluate( geoFeatureWriter.getFeatures(new Query(geoTypeName, Filter.INCLUDE)) );
			if(maxId == null) {
				maxId = new BigDecimal(0);
			}
			
			transaction.commit();						
			
			
			// iterate over input and import in geo and not-geo tables
			FeatureIterator<SimpleFeature> iterator = features.features();				
						
			featureWriter.setTransaction(null);
			geoFeatureWriter.setTransaction(null);
			try {
				int count = 0;
				
				
				while (iterator.hasNext()) {
					SimpleFeature inputFeature = iterator.next();
					
					int id = maxId.intValue()+count+1;		
					
					
					
					int idTematico = 0;
					
					try {
						addGeoFeature(geoSchema, geoFeatureBuilder,
								geoFeatureWriter, inputFeature, id);
						if(hasMoreData) {
							idTematico = addOrUpdateFeature(targetType, partner, geometryType, fkGeoId, schema, featureBuilder, featureWriter,
									id, inputFeature);
						} else if(update) {
							idTematico = updateFeature(targetType, partner, geometryType, fkGeoId, schema, featureBuilder, featureWriter,
									id, inputFeature);
						} else {
							idTematico = addFeature(targetType, partner, geometryType, fkGeoId, schema, featureBuilder, featureWriter,
									id, inputFeature);
						}						
						
					} catch(Exception e) {						
						errors++;
						Ingestion.logError(dataStore, trace, errors,
								"Error writing output feature", getError(e),
								idTematico);
					}

					count++;
					if (count % 100 == 0) {
						updateImportProgress(count, total, "Importing data in " + geoTypeName+ " and "+outTypeName);							
					}
				}
				updateImportProgress(total, total,  "Data imported in "+ geoTypeName + " and "+outTypeName);				
			
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
			listenerForwarder.setTask("Dropping table "+inputTypeName);
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
			}
			
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
	 * Add a new record or update the existing one for non-geo table 
	 *  
	 * @param targetType
	 * @param partner
	 * @param geometryType
	 * @param fkGeoId
	 * @param schema
	 * @param featureBuilder
	 * @param featureWriter
	 * @param id
	 * @param inputFeature
	 * @throws IOException
	 */
	private int addOrUpdateFeature(int targetType, int partner,
			String geometryType, String fkGeoId, SimpleFeatureType schema,
			SimpleFeatureBuilder featureBuilder,
			FeatureStore<SimpleFeatureType, SimpleFeature> featureWriter,
			int id, SimpleFeature inputFeature) throws IOException {
		Map<String,String> mappings = (Map<String,String>)attributeMappings.get(targetType);
		
		// key filter
		Filter filter = filterFactory.and(
				filterFactory.and(
					filterFactory.equals(
						filterFactory.property("id_tematico"),
						filterFactory.literal(getMapping(inputFeature, mappings, "id_tematico"))
					),
					filterFactory.equals(
						filterFactory.property("id_bersaglio"),
						filterFactory.literal(targetType)
					)
				),				
				filterFactory.equals(
					filterFactory.property("id_partner"),
					filterFactory.literal(partner)
				)
		);
		Query existing = new Query(schema.getName().getLocalPart(), filter);
		if(featureWriter.getCount(existing) > 0) {
			return updateFeature(targetType, partner, geometryType, fkGeoId, schema, featureBuilder, featureWriter,
					id, inputFeature);
		} else {
			return addFeature(targetType, partner, geometryType, fkGeoId, schema, featureBuilder, featureWriter,
					id, inputFeature);
		}		
	}


	/**
	 * Update the non-geo table with foreign keys of the imported geos.
	 * 
	 * @param targetType
	 * @param partner
	 * @param geometryType
	 * @param fkGeoId
	 * @param schema
	 * @param featureBuilder
	 * @param featureWriter
	 * @param id
	 * @param inputFeature
	 * @throws IOException
	 */
	private int updateFeature(int targetType, int partner,
			String geometryType, String fkGeoId, SimpleFeatureType schema,
			SimpleFeatureBuilder featureBuilder,
			FeatureStore<SimpleFeatureType, SimpleFeature> featureWriter,
			int id, SimpleFeature inputFeature) throws IOException {
		Map<String,String> mappings = (Map<String,String>)attributeMappings.get(targetType);
		
		// key filter
		Filter filter = filterFactory.and(
				filterFactory.and(
					filterFactory.equals(
						filterFactory.property("id_tematico"),
						filterFactory.literal(getMapping(inputFeature, mappings, "id_tematico"))
					),
					filterFactory.equals(
						filterFactory.property("id_bersaglio"),
						filterFactory.literal(targetType)
					)
				),				
				filterFactory.equals(
					filterFactory.property("id_partner"),
					filterFactory.literal(partner)
				)
		);
		
		featureWriter.modifyFeatures(schema.getDescriptor(fkGeoId).getName(), id, filter);	
		
		return normalizeIdTematico(getMapping(inputFeature, mappings, "id_tematico").toString());
	}



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



	/**
	 * Checks if the current import is an update, so we only need
	 * to import geo data and insert foreign keys in non-geo table.
	 * 
	 * @param dataStore
	 * @param transaction
	 * @return
	 * @throws IOException
	 */
	private boolean isAnUpdate(JDBCDataStore dataStore, Transaction transaction) throws IOException {		
		// targets having multi geometry types
		if(hasAlternativeGeo(targetType)) {					
			String alternativeGeo = ""; 
			// this is a particular case, we can have records to insert
			if(canHaveMoreData(targetType)) {
				if(geometryType.equals("pl")) {
					alternativeGeo = "03";
				} else {
					alternativeGeo = "02";
				}
			} else {
				if(geometryType.equals("pl")) {
					alternativeGeo = "01";
				} else {
					alternativeGeo = "02";
				}
			}
			// check if an import for the other existing geo has already been executed
			String alternativeTypeName = inputTypeName.substring(0, inputTypeName.lastIndexOf('_'))+"_"+alternativeGeo;
			try {
				return !DbUtils.executeScalar(dataStore, transaction, "SELECT COUNT(*) FROM siig_t_tracciamento where nome_file='"+alternativeTypeName+"'").equals(new Long(0));
			} catch (SQLException e) {
				throw new IOException(e);
			}
		}
		return false;
	}



	/**
	 * The target can have different records in the various alternative geos.
	 * 
	 * @param targetType
	 * @return
	 */
	private boolean canHaveMoreData(int targetType) {		
		return targetType == 15;
	}



	/**
	 * The target has multiple alternative geometries
	 * @param targetType
	 * @return
	 */
	private boolean hasAlternativeGeo(int targetType) {		
		return targetType == 4 || targetType == 6 || targetType >= 14;
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
	 * Adds a new geo target feature.
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
			}
			if(attr.getLocalName().equals("id_bersaglio")) {
				geoFeatureBuilder.add(targetType);
			}
			if(attr.getLocalName().equals("id_partner")) {
				geoFeatureBuilder.add(partner+"");
			}
			if(attr.getLocalName().equals("geometria")) {
				geoFeatureBuilder.add(inputFeature.getDefaultGeometry());
			}
		}
		
		SimpleFeature geoFeature = geoFeatureBuilder.buildFeature(null);
		geoFeatureWriter.addFeatures(DataUtilities
				.collection(geoFeature));
	}
	
	/**
	 * Adds a new non-geo feature.
	 * 
	 * @param targetType
	 * @param partner
	 * @param geometryTypeName
	 * @param geoId
	 * @param schema
	 * @param featureBuilder
	 * @param featureWriter
	 * @param id
	 * @param inputFeature
	 * @throws IOException
	 */
	private int addFeature(int targetType, int partner, String geometryTypeName, String geoId, SimpleFeatureType schema,
			SimpleFeatureBuilder featureBuilder,
			FeatureStore<SimpleFeatureType, SimpleFeature> featureWriter, int id, SimpleFeature inputFeature)
			throws IOException {
		Map<String,String> mappings = (Map<String,String>)attributeMappings.get(targetType);
		
		// compiles the attributes from target and read feature data, using mappings
		// to match input attributes with output ones
		for(AttributeDescriptor attr : schema.getAttributeDescriptors()) {
			if(attr.getLocalName().equals(geoId)) {
				featureBuilder.add(id);
			} else if(attr.getLocalName().equals("id_bersaglio")) {
				featureBuilder.add(targetType);
			} else if(attr.getLocalName().equals("id_partner")) {
				featureBuilder.add(partner+"");
			} else if(mappings.containsKey(attr.getLocalName())) {
				featureBuilder.add(getMapping(inputFeature,mappings, attr.getLocalName()));
			} else {
				featureBuilder.add(null);
			}
		}
		
		// compiles the fid to be sure the feature is correctly inserted
		// the fid should be "id_tematico.id_bersaglio.id_partner"
		String featureid = normalizeIdTematico(getMapping(inputFeature, mappings, "id_tematico")) + "." + targetType + "." + partner;
		SimpleFeature feature = featureBuilder.buildFeature(featureid);
		feature.getUserData().put(Hints.USE_PROVIDED_FID, true);
		featureWriter.addFeatures(DataUtilities
				.collection(feature));
		
		return normalizeIdTematico(getMapping(inputFeature, mappings, "id_tematico"));
	}



	/**
	 * @param attribute
	 * @return
	 */
	private int normalizeIdTematico(Object attribute) {
		if(attribute == null) {
			return 0;
		}
		if(attribute instanceof Number) {
			return ((Number)attribute).intValue();
		}
		return Integer.parseInt(attribute.toString());
	}
}
