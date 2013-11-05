import it.geosolutions.geobatch.action.scripting.ScriptingConfiguration
import it.geosolutions.geobatch.action.scripting.ScriptingAction
import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration
import it.geosolutions.geobatch.flow.event.action.ActionException
import it.geosolutions.filesystemmonitor.monitor.FileSystemEvent
import groovy.xml.MarkupBuilder

public Map execute(Map argsMap) throws Exception {
	final String fs = System.getProperty('file.separator');
	final ScriptingConfiguration configuration = argsMap.get(ScriptingAction.CONFIG_KEY)
	final File tempDir = argsMap.get(ScriptingAction.TEMPDIR_KEY)
	final File confDir = argsMap.get(ScriptingAction.CONFIGDIR_KEY)
	final Map props = configuration.getProperties()
	String _baseOutputPath = confDir.getParentFile().getAbsolutePath() + fs + 'out' + fs
	if(props != null && props.get('baseOutputPath') != null && !props.get('baseOutputPath').isEmpty()){
		_baseOutputPath = props.get('baseOutputPath')
	}
	final List events = argsMap.get(ScriptingAction.EVENTS_KEY)
	final EventObject event = events.poll();
	final FeatureConfiguration featureConfiguration = unwrapFeatureConfig(event)
	final String typeName = featureConfiguration.getTypeName()
	final String shpDir = tempDir.getParentFile().getAbsolutePath() + fs + typeName + fs
	
	def myRegularExpression = '^([A-Z]{2})[_-]([A-Z]{2,3})[_-]([A-Z]+)([_-][C|I])?[_-]([0-9]{8})[_-]([0-9]{2})$'
	def matcher = ( typeName =~ myRegularExpression )
	def targetCategory = matcher[0][3]
	String attribute = 'N_ADDETTI'
	switch ( targetCategory ) {
		case 'PRES':
			attribute = 'RESIDENTI'
			break
		case 'PTUR':
			attribute = 'PRES_MAX'
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