package it.geosolutions.peoplecalculator;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.measure.unit.Unit;

import org.apache.commons.io.FilenameUtils;
import org.geotools.data.DataStore;
import org.geotools.data.DataStoreFinder;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.FeatureSource;
import org.geotools.data.Transaction;
import org.geotools.data.shapefile.ShapefileDataStore;
import org.geotools.data.shapefile.ShapefileDataStoreFactory;
import org.geotools.data.simple.SimpleFeatureSource;
import org.geotools.data.simple.SimpleFeatureStore;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.factory.GeoTools;
import org.geotools.feature.DefaultFeatureCollection;
import org.geotools.feature.FeatureCollection;
import org.geotools.feature.FeatureIterator;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.feature.type.Name;
import org.opengis.filter.Filter;
import org.opengis.filter.FilterFactory2;
import org.opengis.filter.expression.Expression;
import org.opengis.filter.expression.Function;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vividsolutions.jts.geom.Geometry;


public class ShpProcessor {

	static final Logger logger = LoggerFactory.getLogger(ShpProcessor.class);

	private static ShpProcessor privateIntance;

	private ShpProcessor() {}

	public static ShpProcessor getInstance(){
		if (privateIntance == null){
			privateIntance = new ShpProcessor();
		}
		return privateIntance;
	}

	public void compute(InputData inputData) throws IOException {

		FeatureSource<?, ?> area = getFeatureSource(inputData.getAreaShp());
		FeatureSource<?, ?> point = getFeatureSource(inputData.getPointShp());
		SimpleFeatureType schema = (SimpleFeatureType) area.getSchema();

		//Create output SHP file
		SimpleFeatureStore outputFeatureStore = createOutputShp(schema,inputData);
		Transaction transaction = new DefaultTransaction();
		outputFeatureStore.setTransaction(transaction);
		DefaultFeatureCollection outputCollection = new DefaultFeatureCollection();
		SimpleFeatureBuilder featureBuilder = new SimpleFeatureBuilder(outputFeatureStore.getSchema());

		//Execute computation
		CoordinateReferenceSystem crs = schema.getGeometryDescriptor().getCoordinateReferenceSystem();
		Unit<?> uom = crs.getCoordinateSystem().getAxis(0).getUnit();
		FeatureIterator<?> areaIterator = area.getFeatures().features();

		try {
			FilterFactory2 ff = CommonFactoryFinder.getFilterFactory2( GeoTools.getDefaultHints() );
			Name geometryPointName = point.getSchema().getGeometryDescriptor().getName();			
			while( areaIterator.hasNext() ){
				//For every area compute output value
				Integer outputValue = new Integer(0);
				SimpleFeature areaFeature = (SimpleFeature) areaIterator.next();
				Geometry areaGeometry = (Geometry) areaFeature.getDefaultGeometry();

				Filter filter = ff.within(ff.property(geometryPointName), ff.literal(areaGeometry));
				FeatureCollection<?, ?> pointCollection = point.getFeatures( filter );
				Function sum = ff.function("Collection_Sum", new Expression[]{ff.property(inputData.getInputField())});
				Object sumResult = sum.evaluate( pointCollection );

				if(sumResult != null){
					outputValue = new Integer(Integer.parseInt(sum.evaluate( pointCollection ).toString()));
				}else{
					//Found the nearest geometry into distance
					Filter distanceFilter = ff.dwithin(ff.property(geometryPointName), ff.literal(areaGeometry), inputData.getMaxDsitance().doubleValue(), uom.toString());
					pointCollection = point.getFeatures( distanceFilter );
					FeatureIterator<?> pointIteartor = pointCollection.features();
					try{
						int minDistance = inputData.getMaxDsitance().intValue();
						while( pointIteartor.hasNext() ){
							SimpleFeature pointFeature = (SimpleFeature) pointIteartor.next();
							Geometry pointGeometry = (Geometry) pointFeature.getDefaultGeometry();
							double distance = areaGeometry.distance(pointGeometry);
							logger.debug("Found point in " + inputData.getMaxDsitance().doubleValue() + " from area");
							if(distance <=  minDistance){
								outputValue =  new Integer(Integer.parseInt(pointFeature.getProperty(inputData.getInputField()).getValue().toString()));
							}
						}
					}finally {
						pointIteartor.close();
					}
				}
				logger.debug(outputValue.toString());
				//Add computed feature to output collection				
				featureBuilder.init(areaFeature);
				featureBuilder.set(inputData.getOutputFeild(), outputValue);				
				SimpleFeature feature = featureBuilder.buildFeature(null);				
				outputCollection.add(feature);				
			}
			outputFeatureStore.addFeatures(outputCollection);
			transaction.commit();
		}finally {
			areaIterator.close();
			transaction.close();
		}
	}

	private  SimpleFeatureStore createOutputShp(SimpleFeatureType originFeatureType, InputData data) throws IOException{
		ShapefileDataStoreFactory dataStoreFactory = new ShapefileDataStoreFactory();
		Map<String, Serializable> params = new HashMap<String, Serializable>();
		String outputPath = FilenameUtils.getFullPath(data.getAreaShp()) + Constant.DEFAULT_OUTPUT_DIR + "\\" + FilenameUtils.getName(data.getAreaShp());
		if(data.getOutputDir() != null){
			outputPath = data.getOutputDir() + "\\" + FilenameUtils.getName(data.getAreaShp());
		}
		File outputDir = new File(FilenameUtils.getFullPath(outputPath));
		if(!outputDir.exists()){
			outputDir.mkdirs();
		}
		logger.info("Output SHP in : " + outputPath);
		params.put("url",new File(outputPath).toURI().toURL());
		params.put("create spatial index", Boolean.TRUE);
		ShapefileDataStore newDataStore = (ShapefileDataStore) dataStoreFactory.createNewDataStore(params);
		//Add output filed if not exists
		SimpleFeatureTypeBuilder builder = new SimpleFeatureTypeBuilder();
		builder.init(originFeatureType);
		builder.setName(originFeatureType.getName());
		if(originFeatureType.indexOf(data.getOutputFeild()) == -1){
			builder.add(data.getOutputFeild(), Integer.class);
		}
		SimpleFeatureType ft = builder.buildFeatureType();
		newDataStore.createSchema(ft);

		String typeName = newDataStore.getTypeNames()[0];
		SimpleFeatureSource featureSource = newDataStore.getFeatureSource(typeName);
		SimpleFeatureStore featureStore = (SimpleFeatureStore) featureSource;
		return featureStore;
	}

	private FeatureSource<?, ?> getFeatureSource(String shpFilePath) throws IOException{
		File file = new File(shpFilePath);
		Map<String,URL> map = new HashMap<String,URL>();
		map.put( "url", file.toURI().toURL() );
		DataStore dataStore = DataStoreFinder.getDataStore(map);
		String typeName = dataStore.getTypeNames()[0];
		FeatureSource<?, ?> source = dataStore.getFeatureSource(typeName);
		return source;
	}


}
