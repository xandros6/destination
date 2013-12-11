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
package it.geosolutions.process.gs;

import it.geosolutions.destination.utils.BufferUtils;
import it.geosolutions.destination.utils.Formula;
import it.geosolutions.destination.utils.FormulaUtils;
import it.geosolutions.process.gs.RiskCalculator.TargetInfo;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.UUID;
import java.util.logging.Logger;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geoserver.wfs.response.ShapeZipOutputFormat;
import org.geotools.data.DataStoreFinder;
import org.geotools.data.DataUtilities;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.Query;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.data.simple.SimpleFeatureSource;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.feature.FeatureIterator;
import org.geotools.feature.SchemaException;
import org.geotools.feature.collection.DecoratingSimpleFeatureCollection;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.process.ProcessException;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.process.gs.WrappingIterator;
import org.geotools.util.logging.Logging;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.feature.type.AttributeDescriptor;
import org.opengis.feature.type.GeometryDescriptor;
import org.opengis.filter.FilterFactory2;
import org.vfny.geoserver.global.GeoserverDataDirectory;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.io.WKTReader;

/**
 * 
 * WPS Process for risk analysis results download.
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "DestinationDownload", description = "Dynamically downloads calculated risk on road arcs.")
public class DestinationDownload extends RiskCalculatorBase {
	
	private static final Logger LOGGER = Logging.getLogger(DestinationDownload.class);
	private static final WKTReader wktReader = new WKTReader();	
	
	RiskCalculator riskCalculator;
	RiskCalculatorSimple simpleRiskCalculator;
	MultipleBuffer multipleBuffer;
	String downloadFolder;
	
	static Map<String, String> targetIdToLayer = new HashMap<String, String>();
	static Map<String, String> reverseTargetIdToLayer = new HashMap<String, String>();
	static Map<String, Integer> targetLayerToId = new HashMap<String, Integer>();
	static Map<String, String> targetValueField = new HashMap<String, String>();
	static Map<String, String> allScenarios = new HashMap<String, String>();
	static Map<String, String> allTargets = new HashMap<String, String>();	
	static Map<String, String> allSevereness = new HashMap<String, String>();
	static FilterFactory2 ff = CommonFactoryFinder.getFilterFactory2();
	
	class ChangedTargetsIterator extends WrappingIterator {
		
		SimpleFeatureIterator iterator;
		
		/**
		 * @param delegate
		 */
		public ChangedTargetsIterator(SimpleFeatureIterator delegate) {
			super(delegate);		
			this.iterator  = delegate;
		}

		@Override
		public void close() {
			iterator.close();
		}				
		
	}
	
	class ChangedTargetsFeatureIterator implements SimpleFeatureIterator {
		
		SimpleFeatureIterator delegate;
		Map<String, TargetInfo> simulationTargets;
		List<TargetInfo> newTargets;
		String targetId;
		SimpleFeature next = null;
		SimpleFeatureBuilder builder;
		
		public ChangedTargetsFeatureIterator(SimpleFeatureIterator delegate, Map<String, TargetInfo> simulationTargets, List<TargetInfo> newTargets, String targetId, SimpleFeatureBuilder builder) {
			this.delegate = delegate;
			this.simulationTargets = simulationTargets;
			this.newTargets = newTargets;
			this.builder = builder;
			this.targetId = targetId;
		}
		
		@Override
		public SimpleFeature next() throws NoSuchElementException {
			if (!hasNext()) {
                throw new NoSuchElementException("hasNext() returned false!");
            }
			
			SimpleFeature result = next;
			next = null;
			return result;
		}
		
		@Override
		public boolean hasNext() {
			if(next != null) {
                return true;
            }
			
			if(delegate.hasNext()) {
				next = delegate.next();
				String currentId = next.getAttribute("id_tematico").toString();
				if(simulationTargets.containsKey(targetId+"."+currentId)) {
					TargetInfo info = simulationTargets.get(targetId+"."+currentId);
					if(info.isRemoved()) {						
						// skip current
						next = null;
						return hasNext();
					} else {
						// change target
						builder.reset();
						for(AttributeDescriptor attr : builder.getFeatureType().getAttributeDescriptors()) {
							if(attr instanceof GeometryDescriptor) {
								builder.add(info.getGeometry());
							} else if(info.isHuman() && attr.getLocalName().equals(targetValueField.get(targetId))) {
								builder.add(info.getValue());
							} else {
								builder.add(next.getAttribute(attr.getName()));
							}
						}
						next = builder.buildFeature(null);
						return true;
					}
				}
				
				return true;									
			}
			if(newTargets.size()>0) {
				try {
					// build added target
					TargetInfo info = newTargets.remove(0);
					builder.reset();
					for(AttributeDescriptor attr : builder.getFeatureType().getAttributeDescriptors()) {
						if(attr instanceof GeometryDescriptor) {
							builder.add(info.getGeometry());
						} else if(info.isHuman() && attr.getLocalName().equals(targetValueField.get(targetId))) {
							builder.add(info.getValue());
						} else if(!info.isHuman() && attr.getLocalName().equals("superficie")) {
							builder.add(info.getArea());
						} else if(attr.getLocalName().equals("id_tematico")) {
							builder.add(0);
						} else {
							builder.add(null);;
						}
					}
					next = builder.buildFeature(null);
				} catch(Exception e) {
					System.out.println("ciao");
				}
				return true;
			}
			next = null;
            return false; 
		}
		
		@Override
		public void close() {
			delegate.close();							
		}
	}

	
	static {		
		targetIdToLayer.put("1", "v_geo_popolazione_residente_pl");		
		targetIdToLayer.put("2", "v_geo_popolazione_turistica_pl");
		targetIdToLayer.put("4", "v_geo_industria_pl");
		targetIdToLayer.put("5", "v_geo_ospedale_pl");
		targetIdToLayer.put("6", "v_geo_scuola_pl");
		targetIdToLayer.put("7", "v_geo_commercio_pl");
		targetIdToLayer.put("10", "v_geo_zone_urbanizzate_pl");
		targetIdToLayer.put("11", "v_geo_aree_boscate_pl");
		targetIdToLayer.put("12", "v_geo_aree_protette_pl");
		targetIdToLayer.put("13", "v_geo_aree_agricole_pl");
		targetIdToLayer.put("14", "v_geo_acque_sotterranee_pl");
		targetIdToLayer.put("15", "v_geo_acque_superficiali_pl");
		targetIdToLayer.put("16", "v_geo_beni_culturali_pl");
		
		allSevereness.put("1.it", "Elevata letalità");
		allSevereness.put("2.it", "Inizio letalità");
		allSevereness.put("3.it", "Lesioni irreversibili");
		allSevereness.put("4.it", "Lesioni reversibili");
		allSevereness.put("5.it", "Ambientale");
		
		allSevereness.put("1.en", "Elevata letalità");
		allSevereness.put("2.en", "Inizio letalità");
		allSevereness.put("3.en", "Lesioni irreversibili");
		allSevereness.put("4.en", "Lesioni reversibili");
		allSevereness.put("5.en", "Ambientale");
		
		allSevereness.put("1.de", "Elevata letalità");
		allSevereness.put("2.de", "Inizio letalità");
		allSevereness.put("3.de", "Lesioni irreversibili");
		allSevereness.put("4.de", "Lesioni reversibili");
		allSevereness.put("5.de", "Ambientale");
		
		allSevereness.put("1.fr", "Elevata letalità");
		allSevereness.put("2.fr", "Inizio letalità");
		allSevereness.put("3.fr", "Lesioni irreversibili");
		allSevereness.put("4.fr", "Lesioni reversibili");
		allSevereness.put("5.fr", "Ambientale");
				
		targetLayerToId.put("popolazione_residente_box", 1);
		targetLayerToId.put("popolazione_turistica_box", 2);
		targetLayerToId.put("industria_servizi_box", 4);
		targetLayerToId.put("strutture_sanitarie_box", 5);
		targetLayerToId.put("strutture_scolastiche_box", 6);
		targetLayerToId.put("centri_commerciali_box", 7);
		targetLayerToId.put("zone_urbanizzate_box", 10);
		targetLayerToId.put("aree_boscate_box", 11);
		targetLayerToId.put("aree_protette_box", 12);
		targetLayerToId.put("aree_agricole_box", 13);
		targetLayerToId.put("acque_sotterranee_box", 14);
		targetLayerToId.put("acque_superficiali_box", 15);
		targetLayerToId.put("beni_culturali_box", 16);
		
		for(String key  : targetIdToLayer.keySet()) {
			reverseTargetIdToLayer.put(targetIdToLayer.get(key), key);
		}
		
		targetValueField.put("1", "residenti");		
		targetValueField.put("2", "pres_max");
		targetValueField.put("4", "addetti");
		targetValueField.put("5", "addetti");
		targetValueField.put("6", "addetti");
		targetValueField.put("7", "addetti");
	}
	
	/**
	 * @param catalog
	 */
	public DestinationDownload(Catalog catalog) {
		super(catalog);
		riskCalculator = new RiskCalculator(catalog);
		simpleRiskCalculator = new RiskCalculatorSimple(catalog);
		multipleBuffer = new MultipleBuffer();
		downloadFolder = GeoserverDataDirectory.getGeoserverDataDirectory()
				.getAbsolutePath()
				+ File.separator
				+ "www"
				+ File.separator
				+ "downloads";
	}
	
	@DescribeResult(description = "Download Risk calculus result")
	public String execute(
			@DescribeParameter(name = "features", description = "Input feature collection") SimpleFeatureCollection features,
			@DescribeParameter(name = "store", description = "risk data store name", min = 0) String storeName,
			@DescribeParameter(name = "batch", description = "batch calculus size", min = 0) Integer batch,
			@DescribeParameter(name = "precision", description = "output value precision (decimals)", min = 0) Integer precision,
			@DescribeParameter(name = "connection", description = "risk database connection params", min = 0) String connectionParams,
			@DescribeParameter(name = "processing", description = "id of the processing type") int processing,
			@DescribeParameter(name = "formula", description = "id of the formula to calculate") int formula,
			@DescribeParameter(name = "target", description = "id of the target/s to use in calculation") int target,
			@DescribeParameter(name = "materials", description = "ids of the materials to use in calculation") String materials,
			@DescribeParameter(name = "scenarios", description = "ids of the scenarios to use in calculation") String scenarios,
			@DescribeParameter(name = "entities", description = "ids of the entities to use in calculation") String entities,
			@DescribeParameter(name = "severeness", description = "ids of the severeness to use in calculation") String severeness,
			@DescribeParameter(name = "fp", description = "fields to use for fp calculation", min = 0) String fpfield,			
			@DescribeParameter(name = "changedTargets", description = "optional field containing csv list of targets to be removed, added, changed or an id for the ProcessingRepository storing the same data", min = 0) String changedTargets,			
			@DescribeParameter(name = "changedTargetsInfo", description = "optional field containing json description of targets to be removed, added, changed or an id for the ProcessingRepository storing the same data", min = 0) String changedTargetsInfo,
			
			@DescribeParameter(name = "cff", description = "optional List (_ delimited) of csv id_geo_arco,id_bersaglo,cff values to use on the simulation", min = 0) String cff,
			@DescribeParameter(name = "psc", description = "optional List (_ delimited) of csv id_sostanza,psc values to use on the simulation", min = 0) String psc,
			@DescribeParameter(name = "padr", description = "optional List (_ delimited) of csv id_geo_arco,id_sostanza,padr values to use on the simulation", min = 0) String padr,
			@DescribeParameter(name = "pis", description = "optional List (_ delimited) of csv id_geo_arco,pis values to use on the simulation", min = 0) String pis,
			@DescribeParameter(name = "distances", description = "list of distances for damage areas", min = 0) String distances,
			@DescribeParameter(name = "distanceNames", description = "optional list of distance names for damage areas", min = 0) String distanceNames,
			@DescribeParameter(name = "damageArea", description = "optional field containing damage area geometry or an id for the ProcessingRepository storing the same data", min = 0) String damageArea,
			@DescribeParameter(name = "language", description = "optional field containing language to be used in localized data", min = 0) String language,
			@DescribeParameter(name = "onlyarcs", description = "optional flag to include only arcs in download", min = 0) Boolean onlyArcs

		)  {
		try {
			// default language if non specified
			if(language == null) {
				language = "it";
			}
			// default fp if non specified
			if(fpfield == null) {
				fpfield = "fp_scen_centrale";
			}
			// normalize aggregate target indentifiers
			if(target == -1) {
				target = 100;
			} else if(target == -2) {
				target = 98;
			} else if(target == -3) {
				target = 99;
			}
			
			if(onlyArcs == null) {
				onlyArcs = true;
			}
			
			List<String> finalZipFileNames = new ArrayList<String>();
			
			DefaultTransaction transaction = new DefaultTransaction();
			Connection conn = null;
			try {
				
				JDBCDataStore dataStore;
				if(catalog != null && storeName != null) {
					LOGGER.info("Loading DataStore " + storeName + " from Catalog");
					DataStoreInfo dataStoreInfo = catalog.getDataStoreByName(storeName);
					if(dataStoreInfo == null) {
						LOGGER.severe("DataStore not found");
						throw new IOException("DataStore not found: " + storeName);
					}
					dataStore = (JDBCDataStore)dataStoreInfo.getDataStore(null);
				} else if(connectionParams != null) {
					dataStore = (JDBCDataStore)DataStoreFinder.getDataStore(getConnectionParameters(connectionParams));
				} else {
					throw new IOException(
							"DataStore connection not configured, either catalog, storeName or connectionParams are not available");
				}
				
				
				
				
				conn = dataStore.getConnection(transaction);
				
				// preload static data for description decoding 
				synchronized(allScenarios) {
					if(allScenarios.size() == 0) {
						loadAllScenarios(conn);
					}				
				}
				
				synchronized(allTargets) {
					if(allTargets.size() == 0) {
						loadAllTargets(conn);
					}				
				}
				
				Formula formulaDescriptor = Formula.load(conn, processing, formula, target, language);
				String formulaDesc = formulaDescriptor.getDescription();
				if(formulaDescriptor.useArcs()) {
					// arcs with risk columns
					finalZipFileNames.add(createRiskShapefile(features, storeName, batch, precision,
							connectionParams, processing, formula, target, materials,
							scenarios, entities, severeness, fpfield, changedTargets, cff,
							psc, padr, pis, distances, damageArea));
				} else {
					// tabular data in CSV format
					finalZipFileNames.add(createSimpleRiskShapefile(features, storeName, batch, precision,
							connectionParams, processing, formula, formulaDesc, target, materials,
							scenarios, entities, severeness, fpfield, changedTargets, cff,
							psc, padr, pis, distances, damageArea, language));
					
					String riskShapeFileName = createUniqueFileName() + ".zip";							
					
					// original arcs with no risk
					finalZipFileNames.add(writeToShapeFile(riskShapeFileName, features));
					
				}
				
				if(!onlyArcs) {
					// damage area buffers
					finalZipFileNames.add(createDamageAreasShapefile(features,
							storeName, distances,
							distanceNames,
							processing,
							damageArea));
					
					// selected targets shapefiles
					addTargets(features, storeName, connectionParams, target, distances,
							finalZipFileNames, dataStore, processing, changedTargetsInfo);
				}
				
				finalZipFileNames.add(createReportFile(processing, formula, target, materials, scenarios,
						entities, fpfield, language, conn));
			} finally {
				transaction.close();
				if(conn != null) {				
					conn.close();
				}
			}
			
			return createFinalZipFile(finalZipFileNames.toArray(new String[finalZipFileNames.size()]));
		} catch(Exception e) {
			throw new ProcessException(e);
		}
			
	}

	/**
	 * @param processing
	 * @param formula
	 * @param target
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param fpfield
	 * @param language
	 * @param finalZipFileNames
	 * @param conn
	 * @throws IOException
	 * @throws SQLException
	 */
	private String createReportFile(int processing, int formula, int target,
			String materials, String scenarios, String entities,
			String fpfield, String language,
			Connection conn) throws IOException, SQLException {
		String reportFileName = createUniqueFileName() + ".txt";
		BufferedWriter writer = null;
		try{
			 writer = new BufferedWriter(new FileWriter(downloadFolder + File.separator + reportFileName));
			 
			 writer.write("Tipo elaborazione: ");
			 writer.write(getDescriptionFromDatabase(conn, "select descrizione_elaborazione_"+language+" from siig_mtd_d_elaborazione where id_elaborazione="+processing));
			 writer.write("\r\n");
			 writer.write("Formula: ");
			 writer.write(getDescriptionFromDatabase(conn, "select descrizione_"+language+" from siig_mtd_t_formula where id_formula="+formula));
			 writer.write("\r\n");
			 writer.write("Condizioni temporali: ");
			 writer.write(getDescriptionFromDatabase(conn, "select descrizione_"+language+" from siig_t_variabile where campo_fp='"+fpfield+"'"));
			 writer.write("\r\n");
			 writer.write("Tipo bersaglio: ");
			 if(FormulaUtils.isSimpleTarget(target)) {
				 writer.write(getDescriptionFromDatabase(conn, "select descrizione_"+language+" from siig_t_bersaglio where id_bersaglio="+target));
			 } else if(FormulaUtils.isAllHumanTargets(target)) {
				 writer.write("Tutti i bersagli umani");
			 } else if(FormulaUtils.isAllNotHumanTargets(target)) {
				 writer.write("Tutti i bersagli ambientali");
			 } else {
				 writer.write("Tutti i bersagli");
			 }
			 writer.write("\r\n");
			 writer.write("Sostanze: ");
			 if(materials.contains(",")) {
				 writer.write("Tutte le sostanze");
			 } else {
				 writer.write(getDescriptionFromDatabase(conn, "select nome_sostanza_"+language+" from siig_t_sostanza where id_sostanza="+materials));
			 }
			 writer.write("\r\n");
			 writer.write("Incidente: ");
			 if(scenarios.contains(",")) {
				 writer.write("Tutti gli incidenti");
			 } else {
				 writer.write(getDescriptionFromDatabase(conn, "select tipologia_"+language+" from siig_t_scenario where id_scenario="+scenarios));
			 }
			 writer.write("\r\n");
			 writer.write("Entità: ");
			 if(entities.contains(",")) {
				 writer.write("Tutte le entità");
			 } else if(entities.equals("0")){
				 writer.write("Lieve");
			 } else {
				 writer.write("Grave");
			 }
			 writer.write("\r\n");
			 
			 return reportFileName;
		} finally {
			if(writer != null) {
				writer.close();
			}
			
		}
	}
	
	/**
	 * @param conn
	 * @throws SQLException 
	 */
	private void loadAllScenarios(Connection conn) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement("select id_scenario,tipologia_it,tipologia_en,tipologia_de,tipologia_fr from siig_t_scenario");
			
			rs = stmt.executeQuery();				
			while(rs.next()) {
				int id = rs.getInt(1);
				allScenarios.put(id+".it", rs.getString(2));
				allScenarios.put(id+".en", rs.getString(3));
				allScenarios.put(id+".de", rs.getString(4));
				allScenarios.put(id+".fr", rs.getString(5));
			}
			
		} finally {
			if(rs != null) {
				rs.close();				
			}
			if(stmt != null) {
				stmt.close();
			}
			
		}
	}
	
	/**
	 * @param conn
	 * @throws SQLException 
	 */
	private void loadAllTargets(Connection conn) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement("select id_bersaglio,descrizione_it,descrizione_en,descrizione_de,descrizione_fr from siig_t_bersaglio");
			
			rs = stmt.executeQuery();				
			while(rs.next()) {
				int id = rs.getInt(1);
				allTargets.put(id+".it", rs.getString(2));
				allTargets.put(id+".en", rs.getString(3));
				allTargets.put(id+".de", rs.getString(4));
				allTargets.put(id+".fr", rs.getString(5));
			}
			
		} finally {
			if(rs != null) {
				rs.close();				
			}
			if(stmt != null) {
				stmt.close();
			}
			
		}
	}

	private String getDescriptionFromDatabase(Connection conn, String sql) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();	
			String description = null;
			if(rs.next()) {				
				description = rs.getString(1);
			}
			return description;
		} finally {
			if(rs != null) {
				rs.close();				
			}
			if(stmt != null) {
				stmt.close();
			}
			
		}
	}

	/**
	 * @param features
	 * @param storeName
	 * @param connectionParams
	 * @param target
	 * @param distances
	 * @param finalZipFileNames
	 * @throws IOException
	 * @throws FileNotFoundException
	 * @throws SQLException 
	 * @throws com.vividsolutions.jts.io.ParseException 
	 */
	private void addTargets(SimpleFeatureCollection features, String storeName,
			String connectionParams, int target, String distances,
			List<String> finalZipFileNames, JDBCDataStore dataStore, int processing, String changedTargets) throws IOException,
			FileNotFoundException, com.vividsolutions.jts.io.ParseException, SQLException, ParseException {
		
		final Map<String, TargetInfo> simulationTargets = new HashMap<String, TargetInfo>();
		final List<TargetInfo> newTargets = new ArrayList<TargetInfo>();
		if(processing == 3 && changedTargets != null && !changedTargets.equals("")) {
			loadSimulationTargets(dataStore, simulationTargets, newTargets, changedTargets);				
		}
		
		String targetList;
		if(FormulaUtils.isAllTargets(target)) {
			targetList = FormulaUtils.humanTargetsList + "," + FormulaUtils.notHumanTargetsList;			
		} else if(FormulaUtils.isAllHumanTargets(target)) {
			targetList = FormulaUtils.humanTargetsList;			
		} else if(FormulaUtils.isAllNotHumanTargets(target)) {
			targetList = FormulaUtils.notHumanTargetsList;
		} else {
			targetList = target +"";
		}
		
		Geometry buffer = getMaxDistanceBuffer(features, distances);
		
		
		for(final String targetId : targetList.split(",")) {
			String targetTypeName = targetIdToLayer.get(targetId);
			SimpleFeatureSource featureSource = dataStore
					.getFeatureSource(targetTypeName);
			Query query = new Query(targetTypeName, ff.intersects(ff.property("geometria"), ff.literal(buffer)));
			SimpleFeatureCollection targetCollection = featureSource.getFeatures(query);
			final SimpleFeatureCollection originalCollection = targetCollection;
			if(simulationTargets.size() > 0) {
				final SimpleFeatureBuilder builder = new SimpleFeatureBuilder(targetCollection.getSchema());
				targetCollection = new DecoratingSimpleFeatureCollection(targetCollection) {
					
					@Override
				    public void close(Iterator<SimpleFeature> close) {
				        ((ChangedTargetsIterator)close).close();				     
				    }
				
					@Override
					public SimpleFeatureIterator features() {						
						return new ChangedTargetsFeatureIterator(originalCollection.features(), simulationTargets, newTargets, targetId, builder);
					}

					@Override
					public Iterator iterator() {							
						return new ChangedTargetsIterator(features());
					}
					
					
					
				};
			}
			finalZipFileNames.add(createTargetShapefile(targetCollection));
		}
	}

	/**
	 * @param dataStore
	 * @param simulationTargets
	 * @param changedTargets
	 * @throws ParseException 
	 * @throws com.vividsolutions.jts.io.ParseException 
	 * @throws NumberFormatException 
	 */
	private void loadSimulationTargets(JDBCDataStore dataStore,
			Map<String, TargetInfo> simulationTargets, List<TargetInfo> newTargets, String changedTargets) throws ParseException, NumberFormatException, com.vividsolutions.jts.io.ParseException {
		JSONParser parser = new JSONParser();
		JSONArray targetsArr = (JSONArray)parser.parse(changedTargets);
		for(int count = 0; count < targetsArr.size(); count++) {
			JSONObject targetObj = (JSONObject)targetsArr.get(count);
			String featureType = targetObj.get("type").toString();
			int targetType = targetLayerToId.get(featureType);
			boolean isNew = targetObj.get("newfeature").toString().equals("true");
			if(isNew) {
				newTargets.add(new TargetInfo(0, targetType, wktReader
						.read(targetObj.get("geometry").toString()), Double
						.parseDouble(targetObj.get("value").toString())));
			} else {
				int id = Integer.parseInt(targetObj
						.get("id").toString());
				simulationTargets.put(targetType+"."+id,new TargetInfo(id, (targetObj.get("removed").toString().equals("true") ? -1 : 1) * targetType, wktReader
						.read(targetObj.get("geometry").toString()), Double
						.parseDouble(targetObj.get("value").toString())));
			}
		}
	}

	/**
	 * @param targetCollection
	 * @return
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	private String createTargetShapefile(
			SimpleFeatureCollection targetCollection) throws FileNotFoundException, IOException {
		String targetShapeFileName = createUniqueFileName() + ".zip";			
		
		return writeToShapeFile(targetShapeFileName, targetCollection);
	}

	/**
	 * @param features
	 * @param maxDistance
	 */
	private Geometry getMaxDistanceBuffer(SimpleFeatureCollection features,
			String distances) {
		
		double maxDistance = 0.0;
		String[] sDistances = distances.split(",");
		for(String sDistance : sDistances) {
			double currDistance = Double.parseDouble(sDistance);
			if(currDistance > maxDistance) {
				maxDistance = currDistance;
			}
		}
		Geometry buffer = null;
		SimpleFeatureCollection buffers = BufferUtils.createMultipleBuffer(features, new Double[] {maxDistance}, new String[] {"distance"});
		SimpleFeatureIterator iterator = buffers.features();
		try {
			if(iterator.hasNext()) {
				SimpleFeature feature = iterator.next();
				buffer =(Geometry)feature.getDefaultGeometry();
			}
		} finally {
			iterator.close();
		}
		return buffer;
	}

	/**
	 * @param strings
	 * @return
	 * @throws IOException 
	 */
	private String createFinalZipFile(String[] tempFiles) throws IOException {
		File tempDir = org.geoserver.data.util.IOUtils
				.createTempDirectory("download");
		for (String tempFile : tempFiles) {
			String tempFilePath = downloadFolder + File.separator + tempFile;
			if(tempFile.endsWith(".zip")) {				
				unZip(tempFilePath, tempDir.getAbsolutePath());				
			} else if(tempFile.endsWith(".csv")) {
				org.geoserver.data.util.IOUtils.copy(new File(tempFilePath), new File(tempDir.getAbsolutePath() + File.separator + "risk.csv"));
			} else {			
				org.geoserver.data.util.IOUtils.copy(new File(tempFilePath), new File(tempDir.getAbsolutePath() + File.separator + "report.txt"));
			}
			new File(tempFilePath).delete();
		}
		String fileName = createUniqueFileName() + ".zip";
		ZipOutputStream outZip = new ZipOutputStream(new FileOutputStream(
				downloadFolder + File.separator + fileName));
		org.geoserver.data.util.IOUtils.zipDirectory(tempDir, outZip, null);
		outZip.close();
		return fileName;
	}

	public void unZip(String zipFile, String outputFolder) throws IOException {

		byte[] buffer = new byte[1024];
		ZipInputStream zis = null;
		try {

			// create output directory is not exists
			File folder = new File(outputFolder);
			if (!folder.exists()) {
				folder.mkdirs();
			}

			// get the zip file content
			zis = new ZipInputStream(
					new FileInputStream(zipFile));
			// get the zipped file list entry
			ZipEntry ze = zis.getNextEntry();

			while (ze != null) {

				String fileName = ze.getName();
				File newFile = new File(outputFolder + File.separator
						+ fileName);

				// create all non exists folders
				// else you will hit FileNotFoundException for compressed folder
				new File(newFile.getParent()).mkdirs();

				FileOutputStream fos = null;
				try {
					fos = new FileOutputStream(newFile);
					
	
					int len;
					while ((len = zis.read(buffer)) > 0) {
						fos.write(buffer, 0, len);
					}
				} catch(IOException e) {
					throw e;
				} finally {
					if(fos != null) {
						fos.close();
					}					
				}
				ze = zis.getNextEntry();
			}

			zis.closeEntry();			

		} finally {
			if(zis != null) {
				zis.close();
			}
		}
	}
	
	/**
	 * @param features
	 * @param storeName
	 * @param batch
	 * @param precision
	 * @param connectionParams
	 * @param processing
	 * @param formula
	 * @param target
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param fpfield
	 * @param changedTargets
	 * @param cff
	 * @param psc
	 * @param padr
	 * @param pis
	 * @param distances
	 * @param damageArea
	 * @param fileName
	 * @throws IOException
	 * @throws SQLException
	 * @throws FileNotFoundException
	 */
	private String createRiskShapefile(SimpleFeatureCollection features,
			String storeName, Integer batch, Integer precision,
			String connectionParams, int processing, int formula, int target,
			String materials, String scenarios, String entities,
			String severeness, String fpfield, String changedTargets,
			String cff, String psc, String padr, String pis, String distances,
			String damageArea) throws IOException,
			SQLException, FileNotFoundException {
		
		String riskShapeFileName = createUniqueFileName() + ".zip";
		SimpleFeatureCollection fc = riskCalculator.execute(features,
				storeName, batch, precision, connectionParams, processing,
				formula, target, materials, scenarios, entities, severeness,
				fpfield, changedTargets, cff, psc, padr, pis, distances,
				damageArea, true);			
		
		return writeToShapeFile(riskShapeFileName, fc);
	}

	/**
	 * @return
	 */
	private String createUniqueFileName() {
		return UUID.randomUUID().toString();
	}
	
	/**
	 * @param features
	 * @param storeName
	 * @param batch
	 * @param precision
	 * @param connectionParams
	 * @param processing
	 * @param formula
	 * @param target
	 * @param materials
	 * @param scenarios
	 * @param entities
	 * @param severeness
	 * @param fpfield
	 * @param changedTargets
	 * @param cff
	 * @param psc
	 * @param padr
	 * @param pis
	 * @param distances
	 * @param damageArea
	 * @param fileName
	 * @throws IOException
	 * @throws SQLException
	 * @throws FileNotFoundException
	 * @throws ParseException 
	 */
	private String createSimpleRiskShapefile(SimpleFeatureCollection features,
			String storeName, Integer batch, Integer precision,
			String connectionParams, int processing, int formula, String formulaDesc, int target,
			String materials, String scenarios, String entities,
			String severeness, String fpfield, String changedTargets,
			String cff, String psc, String padr, String pis, String distances,
			String damageArea, String language) throws IOException,
			SQLException, FileNotFoundException, ParseException {
		
		String riskCSVFileName = createUniqueFileName() + ".csv";
		String fcString = simpleRiskCalculator.execute(storeName, batch, precision, connectionParams, processing, formula, target, materials, scenarios, entities, severeness, fpfield);			
		JSONParser parser = new JSONParser();
		JSONObject root = (JSONObject)parser.parse(fcString);
		JSONArray targets = (JSONArray)root.get("targets");
		BufferedWriter writer = null;
		try {
			writer = new BufferedWriter(new FileWriter(downloadFolder + File.separator + riskCSVFileName));
			String header = "";
			if(targets.size() > 1) {
				header += ",Tipo Bersaglio";
			}
			if(((JSONArray)((JSONObject)targets.get(0)).get("scenarios")).size() > 1) {
				header += ",Incidenti";
			}
			if(((JSONArray)((JSONObject)((JSONArray)((JSONObject)targets.get(0)).get("scenarios")).get(0)).get("severeness")).size() > 1) {
				header += ",Gravità";
			}
			writer.write(header.substring(1)+","+formulaDesc+"\n");
			for(int i = 0; i < targets.size(); i++) {
				
				JSONObject targetObj = (JSONObject)targets.get(i);
				JSONArray scenarioArr = (JSONArray)targetObj.get("scenarios");
				for(int j = 0; j < scenarioArr.size(); j++) {
					JSONObject scenarioObj = (JSONObject)scenarioArr.get(j);
					JSONArray severenessArr = (JSONArray)scenarioObj.get("severeness");
					for(int k = 0; k < severenessArr.size(); k++) { 
						String row = "";
						JSONObject severenessObj = (JSONObject)severenessArr.get(k);
						if(targets.size() > 1) {
							row += "," + allTargets.get(targetObj.get("id")+"."+language);
						}
						if(scenarioArr.size() > 1) {
							row += "," + allScenarios.get(scenarioObj.get("id")+"."+language);
						}
						if(severenessArr.size() > 1) {
							row += "," + allSevereness.get(severenessObj.get("id")+"."+language);
						}
						writer.write(row.substring(1)+","+((JSONArray)severenessObj.get("risk")).get(0)+"\n");
					}
				}				
			}
			
		} finally {
			if(writer != null) {
				writer.close();
			}
		}
		return riskCSVFileName;
	}

	/**
	 * @param riskShapeFileName
	 * @param fc
	 * @param of
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	private String writeToShapeFile(String riskShapeFileName,
			SimpleFeatureCollection fc)
			throws FileNotFoundException, IOException {
		ShapeZipOutputFormat of = new ShapeZipOutputFormat(null, catalog, null);
		FileOutputStream os = null;
		try {			
			os = new FileOutputStream(downloadFolder + File.separator + riskShapeFileName);
	        of.write(Collections.singletonList(fc), Charset.forName("ISO-8859-1"), os, null);
	        return riskShapeFileName;
		} finally {
			if(os != null) {
				os.close();
			}
		}
		
	}	
	
	private String createDamageAreasShapefile(SimpleFeatureCollection features,
			String storeName, String distances,
			String distanceNames,
			int processing,
			String damageArea) throws IOException,
			SQLException, FileNotFoundException, SchemaException {
		
		String damageAreaShapeFileName = createUniqueFileName() + ".zip";
		SimpleFeatureCollection fc = null;
		if(processing == 4) {
			SimpleFeatureType type = DataUtilities.createType("damagearea", 
					"id:int," +
					"descrizione:String," +							
					"geometria:Polygon:srid=32632");
			SimpleFeature feature = DataUtilities.createFeature(type, "1=1|Area di danno|"+damageArea );
			fc = DataUtilities.collection(feature);
		} else {
			String[] splittedDists = distances.split(",");
			Double[] dists = new Double[splittedDists.length];
			
			for(int count = 0; count < splittedDists.length; count++) {
				dists[count] = Double.parseDouble(splittedDists[count]);
			}
			fc = multipleBuffer.execute(features, null,
					null, dists, distanceNames.split(","), true, "buffers");
		}
		
		
		return writeToShapeFile(damageAreaShapeFileName, fc);
	}	
}
