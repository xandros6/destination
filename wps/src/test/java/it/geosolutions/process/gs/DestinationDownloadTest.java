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

import java.io.File;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.sql.SQLException;
import java.util.Locale;
import java.util.Map;

import junit.framework.TestCase;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geoserver.catalog.impl.CatalogImpl;
import org.geoserver.config.DefaultGeoServerLoader;
import org.geoserver.config.GeoServer;
import org.geoserver.config.impl.GeoServerImpl;
import org.geoserver.platform.GeoServerExtensions;
import org.geoserver.platform.GeoServerResourceLoader;
import org.geotools.data.DataUtilities;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.feature.SchemaException;
import org.geotools.jdbc.JDBCDataStore;
import org.json.simple.parser.ParseException;
import org.junit.After;
import org.junit.Before;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.filter.FilterFactory2;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.MessageSourceResolvable;
import org.springframework.context.NoSuchMessageException;
import org.springframework.core.env.Environment;
import org.springframework.core.io.Resource;
import org.vfny.geoserver.global.GeoserverDataDirectory;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class DestinationDownloadTest extends TestCase {
	
	/** SIMULATION_PROCESSING */
	private static final int SIMULATION_PROCESSING = 3;
	/** FP_SCEN_CENTRALE */
	private static final String FP_SCEN_CENTRALE = "fp_scen_centrale";
	/** ALL_SEVERENESS */
	private static final String ALL_SEVERENESS = "1,2,3,4,5";
	/** ALL_ENTITIES */
	private static final String ALL_ENTITIES = "0,1";
	/** ALL_SCENARIOS */
	private static final String ALL_SCENARIOS = "1,2,3,4,5,6,7,8,9,10,11";
	/** ALL_MATERIALS */
	private static final String ALL_MATERIALS = "1,2,3,4,5,6,7,8,9,10";
	/** ALL_TARGETS */
	private static final int ALL_TARGETS = 100;
	/** STANDARD_PROCESSING */
	private static final int STANDARD_PROCESSING = 1;
	
	Catalog catalog;
	DestinationDownload downloader;
	JDBCDataStore dataStore;
	FilterFactory2 ff = CommonFactoryFinder.getFilterFactory2();
	
	String dataStoreName = System.getProperty("GS_DS_NAME");
	SimpleFeatureType inputType;
	
	@Before
	public void setUp() throws IOException, SchemaException {
		String dataDirPath = System.getProperty("GS_TEST_DATA_DIR");
		
		if(dataDirPath != null) {
			catalog = new CatalogImpl();
			
			final GeoServerResourceLoader resourceLoader = new GeoServerResourceLoader(
					new File(dataDirPath));
			
			GeoserverDataDirectory.setResourceLoader(resourceLoader);
			DefaultGeoServerLoader loader = new DefaultGeoServerLoader(resourceLoader);
			catalog = (Catalog)loader.postProcessBeforeInitialization(catalog, "catalog");
			if(catalog != null) {
				downloader = new DestinationDownload(catalog);	
				
				DataStoreInfo dataStoreInfo = catalog.getDataStoreByName(dataStoreName);
				dataStore = (JDBCDataStore)dataStoreInfo.getDataStore(null);
				
				(new GeoServerExtensions()).setApplicationContext(new ApplicationContext() {

					@Override
					public Environment getEnvironment() {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public boolean containsBeanDefinition(String beanName) {
						// TODO Auto-generated method stub
						return false;
					}

					@Override
					public int getBeanDefinitionCount() {
						// TODO Auto-generated method stub
						return 0;
					}

					@Override
					public String[] getBeanDefinitionNames() {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public String[] getBeanNamesForType(Class<?> type) {
						if(type.isAssignableFrom(GeoServerResourceLoader.class))
							return new String[] {"resourceLoader"};
						return new String[] {};
					}

					@Override
					public String[] getBeanNamesForType(Class<?> type,
							boolean includeNonSingletons, boolean allowEagerInit) {
						return getBeanNamesForType(type);
					}

					@Override
					public <T> Map<String, T> getBeansOfType(Class<T> type)
							throws BeansException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public <T> Map<String, T> getBeansOfType(Class<T> type,
							boolean includeNonSingletons, boolean allowEagerInit)
							throws BeansException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public Map<String, Object> getBeansWithAnnotation(
							Class<? extends Annotation> annotationType)
							throws BeansException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public <A extends Annotation> A findAnnotationOnBean(
							String beanName, Class<A> annotationType) {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public Object getBean(String name) throws BeansException {
						if(name.equals("resourceLoader"))
							return resourceLoader;
						return null;
					}

					@Override
					public <T> T getBean(String name, Class<T> requiredType)
							throws BeansException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public <T> T getBean(Class<T> requiredType)
							throws BeansException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public Object getBean(String name, Object... args)
							throws BeansException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public boolean containsBean(String name) {
						// TODO Auto-generated method stub
						return false;
					}

					@Override
					public boolean isSingleton(String name)
							throws NoSuchBeanDefinitionException {
						// TODO Auto-generated method stub
						return false;
					}

					@Override
					public boolean isPrototype(String name)
							throws NoSuchBeanDefinitionException {
						// TODO Auto-generated method stub
						return false;
					}

					@Override
					public boolean isTypeMatch(String name, Class<?> targetType)
							throws NoSuchBeanDefinitionException {
						// TODO Auto-generated method stub
						return false;
					}

					@Override
					public Class<?> getType(String name)
							throws NoSuchBeanDefinitionException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public String[] getAliases(String name) {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public BeanFactory getParentBeanFactory() {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public boolean containsLocalBean(String name) {
						// TODO Auto-generated method stub
						return false;
					}

					@Override
					public String getMessage(String code, Object[] args,
							String defaultMessage, Locale locale) {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public String getMessage(String code, Object[] args,
							Locale locale) throws NoSuchMessageException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public String getMessage(
							MessageSourceResolvable resolvable, Locale locale)
							throws NoSuchMessageException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public void publishEvent(ApplicationEvent event) {
						// TODO Auto-generated method stub
						
					}

					@Override
					public Resource[] getResources(String locationPattern)
							throws IOException {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public Resource getResource(String location) {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public ClassLoader getClassLoader() {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public String getId() {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public String getDisplayName() {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public long getStartupDate() {
						// TODO Auto-generated method stub
						return 0;
					}

					@Override
					public ApplicationContext getParent() {
						// TODO Auto-generated method stub
						return null;
					}

					@Override
					public AutowireCapableBeanFactory getAutowireCapableBeanFactory()
							throws IllegalStateException {
						// TODO Auto-generated method stub
						return null;
					}
					
				});
			}
			
			
		}
	}
	
	public void testSimpleDownload() throws IOException, SQLException, SchemaException, ParseException {
		if(downloader != null && dataStoreName != null && dataStore != null) {
		
			
			String fileName = downloader.execute(getSampleData(1, 1),
					dataStoreName, null, null, null, 3, /* cff */
					26, 98, ALL_MATERIALS, ALL_SCENARIOS,					
					ALL_ENTITIES, ALL_SEVERENESS, FP_SCEN_CENTRALE,"-1,0,POLYGON((379700 4934400,379800 4934400, 379800 4934500, 379700 4934500,379700 4934400))_1,1000,POLYGON((379700 4934400,379800 4934400, 379800 4934500, 379700 4934500,379700 4934400))", "[{\"id\":0,\"type\":\"popolazione_residente_box\",\"geometry\":\"POLYGON((379700 4934400,379800 4934400, 379800 4934500, 379700 4934500,379700 4934400))\",\"value\":1000,\"newfeature\":true,\"removed\":false},{\"id\":249023,\"type\":\"popolazione_residente_box\",\"geometry\":\"POLYGON((379700 4934400,379800 4934400, 379800 4934500, 379700 4934500,379700 4934400))\",\"value\":1000,\"newfeature\":true,\"removed\":true},{\"id\":249023,\"type\":\"popolazione_residente_box\",\"geometry\":\"POLYGON((379700 4934400,379800 4934400, 379800 4934500, 379700 4934500,379700 4934400))\",\"value\":1000,\"newfeature\":false,\"removed\":false}]", null,
					null, null, null, "8,125,250,500,780", "Ambientale,Alta Letalita,Bassa Letalita,Lesioni irreversibili,Lesioni reversibili", null, "it");
				
			assertNotNull(fileName);
			
		}
	}
	
	@After
	public void tearDown() {
		if(dataStore != null) {
			dataStore.dispose();
		}
	}
	
	private void createInputType(int level) throws SchemaException {
		inputType = DataUtilities.createType("siig_geo_ln_arco_" + level,"id_geo_arco:Integer,nr_incidenti:Integer,nr_incidenti_elab:Double,nr_corsie:Integer,lunghezza:Integer,nr_bers_umani_strada:Integer,id_tematico_shape:Integer,fk_partner:String,geometria:Geometry:32632,id_origine:Integer,flg_nr_corsie:String,flg_nr_incidenti:String");
	}
	
	/**
	 * @param level
	 * @param numOfFeatures
	 * @return
	 * @throws SchemaException 
	 */
	private SimpleFeatureCollection getSampleData(int level, int numOfFeatures) throws SchemaException {
		
		createInputType(level);
		
		SimpleFeature[] features = new SimpleFeature[numOfFeatures];
		for(int count = 0; count < numOfFeatures; count++) {
			int id = count+1;			
			features[count] = DataUtilities.createFeature(inputType, id + "=" + id + "|1|0.8|2|100|0|1|1|LINESTRING(379750 4934450, 379800 4934450,  379800 4934400)|1|S|S");
		}
		return DataUtilities.collection(features);		
	}

}
