import it.geosolutions.geobatch.action.scripting.ScriptingConfiguration
import it.geosolutions.geobatch.action.scripting.ScriptingAction
import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration
import it.geosolutions.geobatch.flow.event.action.ActionException
import it.geosolutions.filesystemmonitor.monitor.FileSystemEvent
import it.geosolutions.geobatch.destination.vulnerability.VulnerabilityComputation
import groovy.xml.MarkupBuilder

public Map execute(Map argsMap) throws Exception {
	final String fs = System.getProperty('file.separator');
	final ScriptingConfiguration configuration = argsMap.get(ScriptingAction.CONFIG_KEY)
	final File tempDir = argsMap.get(ScriptingAction.TEMPDIR_KEY)
	final File confDir = argsMap.get(ScriptingAction.CONFIGDIR_KEY)
	final Map props = configuration.getProperties()
	String _baseOutputPath = System.getProperty(VulnerabilityComputation.RASTER_PATH_PROP, "")
	if(props != null && props.get('baseOutputPath') != null && !props.get('baseOutputPath').isEmpty()){
		_baseOutputPath = props.get('baseOutputPath')
	}
	// Repair linux dist with file_separator
    if(!_baseOutputPath.endsWith(fs)) {
        _baseOutputPath = _baseOutputPath + fs;
    }
	final List events = argsMap.get(ScriptingAction.EVENTS_KEY)
	final EventObject event = events.poll();
	final FeatureConfiguration featureConfiguration = unwrapFeatureConfig(event)
	final String typeName = featureConfiguration.getTypeName()
	final String shpDir = getShpDir(tempDir, fs, typeName)
	
	def myRegularExpression = '^([A-Z]{2})[_-]([A-Z]{2,3})[_-]([A-Z]+)([_-][C|I])?[_-]([0-9]{8})[_-]([0-9]{2})$'
	def matcher = ( typeName =~ myRegularExpression )
	def targetCategory = matcher[0][3]
	String attribute = 'N_ADDETTI'
	switch ( targetCategory ) {
		case 'PRES':
			attribute = 'RESIDENTI'
			break
		case 'PTUR':
			attribute = 'N_PTUR_MAX'
			break		
	}
	
	def outputFile = new File(tempDir.getParentFile().getAbsolutePath() + fs + 'rasterize.xml')
	def writer = new FileWriter(outputFile)
	def xml = new MarkupBuilder(writer)
	xml.GdalRasterize() {
	  shapefilename(typeName)
	  shapefilepath(shpDir)
	  baseOutputPath(_baseOutputPath)
	  targetValue('1')
	  attributeToNormalize(attribute)
	}
	
	def configFile = ((FileSystemEvent)event).getSource()
	
	def mapOut = [(ScriptingAction.RETURN_KEY):([configFile])]
	 
	return mapOut;
}

 /**
  * Check if the excutions come from a remote operation and obtain related directory
  *
  * @return directory that contains the shp file
  **/
 private String getShpDir(File tempDir, String fs, String typeName){
 	String basePath = tempDir.getParentFile().getAbsolutePath();
 	String restInputStr = basePath + fs + 'rest_input';
 	try{
 		File restInputDir = new File(restInputStr);
 		if(restInputDir.exists()){
 			// basePath it's rest_input path
 			basePath = restInputStr;
 		}
	} catch (Exception e){
		// some error trying to get rest input path. We'll use base path
	}
	return basePath + fs + typeName + fs;
 }

 private FeatureConfiguration unwrapFeatureConfig(EventObject event) throws ActionException {
	if (event instanceof FileSystemEvent) {
		FileSystemEvent fse = (FileSystemEvent) event;
        File file = fse.getSource();
        try {
			return FeatureConfiguration.fromXML(new FileInputStream(file));
        } catch (FileNotFoundException ex) {
			throw new ActionException(this, ex.getMessage(), ex);
        }
    } else {
		throw new ActionException(this, "EventObject not handled " + event);
    }               
}