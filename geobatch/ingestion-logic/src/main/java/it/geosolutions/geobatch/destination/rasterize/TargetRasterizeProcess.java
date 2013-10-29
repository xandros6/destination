package it.geosolutions.geobatch.destination.rasterize;

import it.geosolutions.filesystemmonitor.monitor.FileSystemEvent;
import it.geosolutions.geobatch.catalog.Identifiable;
import it.geosolutions.geobatch.destination.common.InputObject;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.ingestion.TargetIngestionProcess;
import it.geosolutions.geobatch.flow.event.IProgressListener;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;
import it.geosolutions.geobatch.task.TaskExecutor;
import it.geosolutions.geobatch.task.TaskExecutorConfiguration;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Queue;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.filefilter.WildcardFileFilter;
import org.apache.commons.lang3.StringEscapeUtils;
import org.geotools.jdbc.JDBCDataStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.thoughtworks.xstream.XStream;

public class TargetRasterizeProcess extends InputObject{

	private final static Logger LOGGER = LoggerFactory.getLogger(TargetRasterizeProcess.class);

	//private static Pattern TYPE_NAME_PARTS_ARCS = Pattern.compile("^([A-Z]{2})_([A-Z]{1})-([A-Za-z]+)_([0-9]{8})$");
	private static Pattern TYPE_NAME_PARTS_TARGETS  = Pattern.compile("^([A-Z]{2})[_-]([A-Z]{2,3})[_-]([A-Z]+)([_-][C|I])?[_-]([0-9]{8})[_-]([0-9]{2})$");
	private static Properties targetTypes = new Properties();

	private String inputTypeName;
	private String codicePartner;
	private int partner;
	private int targetType;

	static {	
		// load mappings from resources
		try {			
			targetTypes.load(TargetIngestionProcess.class.getResourceAsStream("/targets.properties"));	
		} catch (IOException e) {
			LOGGER.error("Unable to load configuration: "+e.getMessage(), e);
		}
	}

	public TargetRasterizeProcess(String inputTypeName,
			ProgressListenerForwarder listenerForwarder,
			MetadataIngestionHandler metadataHandler, JDBCDataStore dataStore) {
		super(inputTypeName, listenerForwarder, metadataHandler, dataStore);
		this.inputTypeName = inputTypeName;
	}

	@Override
	protected boolean parseTypeName(String typeName) {
		Matcher m = TYPE_NAME_PARTS_TARGETS.matcher(typeName);
		if(m.matches()) {
			// partner alphanumerical abbreviation (from siig_t_partner)
			codicePartner = m.group(1);
			// partner numerical id (from siig_t_partner)
			partner = Integer.parseInt(partners.get(codicePartner).toString());		
			targetType = Integer.parseInt(targetTypes.get(m.group(3)).toString());			
			return true;
		}
		return false;
	}

	private List<String> receivedEvents = new ArrayList<String>();

	private IProgressListener listener = new IProgressListener() {

		@Override
		public void terminated() {
			receivedEvents.add("terminated");				
		}

		@Override
		public void started() {
			receivedEvents.add("started");				
		}

		@Override
		public void setTask(String currentTask) {

		}

		@Override
		public void setProgress(float progress) {

		}

		@Override
		public void resumed() {
			receivedEvents.add("resumed");			
		}

		@Override
		public void progressing() {
			receivedEvents.add("progressing");		
		}

		@Override
		public void paused() {
			receivedEvents.add("paused");			
		}

		@Override
		public String getTask() {				
			return null;
		}

		@Override
		public float getProgress() {
			return 0;
		}

		@Override
		public Identifiable getOwner() {				
			return null;
		}

		@Override
		public void failed(Throwable exception) {
			receivedEvents.add("failed");			
		}

		@Override
		public void completed() {
			receivedEvents.add("completed");			
		}
	};

	public void execute(Queue<FileSystemEvent> events , File configDir, File outputDir) throws Exception{
		LOGGER.debug("Execute Task Executor Action for partner : " + partner);

		XStream xstream = new XStream();
		xstream.alias("TaskExecutorConfiguration", TaskExecutorConfiguration.class);

		TaskExecutor action = initAction(configDir);

		clearOutput(outputDir);

		//No human target
		if(targetType>=10){
			LOGGER.debug("NO HUMAN TARGET");

			//EXECUTE rasterize		
			events = rasterizeBNU(action,events,outputDir);

			//Execute overview on output TIF
			events = overview(action,events,outputDir);

		}

		if(targetType>0 && targetType<10){
			LOGGER.debug("HUMAN TARGET");

			//Create temp SHP
			events = createTempBU(action,events,outputDir);

			//Alter temp SHP: create NORM field
			events = alterTempBU(action,events,outputDir);

			//Fill NORM field of temp SHP
			events = fillTempBU(action,events,outputDir);

			//Execute rasterize on temporary SHP
			events = rasterizeBU(action,events,outputDir);

			//Execute overview on output TIF
			events = overview(action,events,outputDir);
			
			//Clear normalized SHP
			FileFilter fileFilter = new WildcardFileFilter(this.inputTypeName+"_normalized*.*");
			File[] files = new File(outputDir.getAbsoluteFile()+"/"+codicePartner).listFiles(fileFilter);
			for (File file : files) {
				file.delete();
			}
			
		}

	}

	private Queue<FileSystemEvent> fillTempBU(TaskExecutor action, Queue<FileSystemEvent> events, File outputDir) throws Exception{
		TaskExecutorConfiguration taskExecutorConfiguration = action.getConfiguration();
		taskExecutorConfiguration.setExecutable("ogrinfo");
		File xslFile = addOutputFolderToXsl(new File("src/main/resources/rasterize/updateNormalizedTaskExecutorConfiguration.xsl"),outputDir);
		taskExecutorConfiguration.setXsl(xslFile.getAbsolutePath());
		Queue<FileSystemEvent> outEvents = action.execute(events);
		xslFile.delete();
		return outEvents;
	}

	private Queue<FileSystemEvent> alterTempBU(TaskExecutor action, Queue<FileSystemEvent> events, File outputDir) throws Exception{
		TaskExecutorConfiguration taskExecutorConfiguration = action.getConfiguration();
		taskExecutorConfiguration.setExecutable("ogrinfo");
		File xslFile = addOutputFolderToXsl(new File("src/main/resources/rasterize/alterNormalizedTaskExecutorConfiguration.xsl"),outputDir);
		taskExecutorConfiguration.setXsl(xslFile.getAbsolutePath());
		Queue<FileSystemEvent> outEvents = action.execute(events);
		xslFile.delete();
		return outEvents;
	}

	private Queue<FileSystemEvent> createTempBU(TaskExecutor action, Queue<FileSystemEvent> events, File outputDir) throws Exception{
		TaskExecutorConfiguration taskExecutorConfiguration = action.getConfiguration();
		taskExecutorConfiguration.setExecutable("ogr2ogr");
		File xslFile = addOutputFolderToXsl(new File("src/main/resources/rasterize/createNormalizedTaskExecutorConfiguration.xsl"),outputDir);
		taskExecutorConfiguration.setXsl(xslFile.getAbsolutePath());
		Queue<FileSystemEvent> outEvents = action.execute(events);
		xslFile.delete();
		return outEvents;
	}

	private Queue<FileSystemEvent> rasterizeBU(TaskExecutor action, Queue<FileSystemEvent> events, File outputDir) throws Exception{		
		TaskExecutorConfiguration taskExecutorConfiguration = action.getConfiguration();
		taskExecutorConfiguration.setExecutable("gdal_rasterize");
		File xslFile = addOutputFolderToXsl(new File("src/main/resources/rasterize/rasterizeBUTaskExecutorConfiguration.xsl"),outputDir);
		taskExecutorConfiguration.setXsl(xslFile.getAbsolutePath());
		Queue<FileSystemEvent> outEvents = action.execute(events);
		xslFile.delete();
		return outEvents;
	}


	private void clearOutput(File outputDir) throws Exception{
		File partnerOutput = new File(outputDir.getAbsolutePath()+"/"+codicePartner);
		if(partnerOutput.exists()){
			//FileUtils.deleteDirectory(partnerOutput);
		}else{
			partnerOutput.mkdir();		
		}
	}

	private Queue<FileSystemEvent> overview(TaskExecutor action, Queue<FileSystemEvent> events, File outputDir) throws Exception{
		TaskExecutorConfiguration taskExecutorConfiguration = action.getConfiguration();
		taskExecutorConfiguration.setExecutable("gdaladdo");
		File xslFile = addOutputFolderToXsl(new File("src/main/resources/rasterize/overviewTaskExecutorConfiguration.xsl"),outputDir);
		taskExecutorConfiguration.setXsl(xslFile.getAbsolutePath());
		Queue<FileSystemEvent> outEvents = action.execute(events);
		xslFile.delete();
		return outEvents;
	}

	private Queue<FileSystemEvent> rasterizeBNU(TaskExecutor action, Queue<FileSystemEvent> events, File outputDir) throws Exception{
		TaskExecutorConfiguration taskExecutorConfiguration = action.getConfiguration();
		taskExecutorConfiguration.setExecutable("gdal_rasterize");
		File xslFile = addOutputFolderToXsl(new File("src/main/resources/rasterize/rasterizeBNUTaskExecutorConfiguration.xsl"),outputDir);
		taskExecutorConfiguration.setXsl(xslFile.getAbsolutePath());
		Queue<FileSystemEvent> outEvents = action.execute(events);
		xslFile.delete();
		return outEvents;
	}

	private File addOutputFolderToXsl(File xslFile, File outputDir) throws Exception{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse(new InputSource(xslFile.getAbsolutePath()));

		XPathFactory xPathfactory = XPathFactory.newInstance();
		XPath xpath = xPathfactory.newXPath();
		{
			XPathExpression expr = xpath.compile("//*[local-name()='template'][@match=\"baseOutputPath\"]/value-of/@select");
			NodeList nl = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
			if(nl.item(0) != null){
				String toReplace = nl.item(0).getFirstChild().getTextContent().replace("_baseOutputPath_", StringEscapeUtils.escapeXml(outputDir.getAbsolutePath()) + "/");
				nl.item(0).getFirstChild().setTextContent(toReplace);
			}
		}
		{
			XPathExpression expr = xpath.compile("//*[local-name()='template'][@match=\"GdalRasterize\"]/value-of/@select");
			NodeList nl = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
			if(nl.item(0) != null){
				String toReplace = nl.item(0).getFirstChild().getTextContent().replace("_baseOutputPath_", StringEscapeUtils.escapeXml(outputDir.getAbsolutePath()) + "/");
				nl.item(0).getFirstChild().setTextContent(toReplace);
			}
		}
		{
			XPathExpression expr = xpath.compile("//*[local-name()='template'][@match=\"shapefilepath\"]/value-of/@select");
			NodeList nl = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
			if(nl.item(0) != null){
				String toReplace = nl.item(0).getFirstChild().getTextContent().replace("_baseOutputPath_", StringEscapeUtils.escapeXml(outputDir.getAbsolutePath()) + "/");
				nl.item(0).getFirstChild().setTextContent(toReplace);
			}
		}
		File newXsl = new File(outputDir+"/"+FilenameUtils.removeExtension(xslFile.getName())+(new Date().getTime())+".xsl");
		if(newXsl.exists()){
			newXsl.delete();
		}
		Transformer xformer = TransformerFactory.newInstance().newTransformer();
		xformer.transform(new DOMSource(doc), new StreamResult(newXsl));		
		return newXsl;
	}

	private TaskExecutor initAction(File configDir) throws Exception{
		TaskExecutorConfiguration taskExecutorConfiguration = new TaskExecutorConfiguration("rasterizeTask", "rasterizeTask", "rasterizeTask");
		taskExecutorConfiguration.setTimeOut(1200000L);				

		taskExecutorConfiguration.setErrorFile("errorlog.txt");			

		TaskExecutor action = new TaskExecutor(taskExecutorConfiguration);
		if(action.getConfigDir() == null){
			action.setConfigDir(configDir);
		}
		action.setTempDir(new File(System.getProperty("java.io.tmpdir")));
		action.setFailIgnored(true);
		action.addListener(listener);
		return action;
	}
}
