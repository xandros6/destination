package it.geosolutions.geobatch.destination.action.rasterize;

import it.geosolutions.filesystemmonitor.monitor.FileSystemEvent;
import it.geosolutions.filesystemmonitor.monitor.FileSystemEventType;
import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration;
import it.geosolutions.geobatch.annotations.Action;
import it.geosolutions.geobatch.annotations.CheckConfiguration;
import it.geosolutions.geobatch.configuration.event.action.ActionConfiguration;
import it.geosolutions.geobatch.destination.rasterize.TargetRasterizeProcess;
import it.geosolutions.geobatch.flow.event.action.ActionException;
import it.geosolutions.geobatch.flow.event.action.BaseAction;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.EventObject;
import java.util.LinkedList;
import java.util.Queue;

import org.apache.commons.io.FilenameUtils;

@Action(configurationClass = RasterizeConfiguration.class)
public class RasterizeAction extends BaseAction<EventObject> {

	private RasterizeConfiguration configuration;

	public RasterizeAction(RasterizeConfiguration actionConfiguration) {
		super(actionConfiguration);
		this.configuration = actionConfiguration;
	}

	private void checkInit() {
		RasterizeConfiguration cfg = getConfiguration();
		if (cfg == null) {
			throw new IllegalStateException("ActionConfig is null.");
		}
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

	@Override
	public Queue<EventObject> execute(Queue<EventObject> events)
			throws ActionException {

		listenerForwarder.setTask("Check config");

		checkInit();

		listenerForwarder.started();

		final LinkedList<EventObject> ret = new LinkedList<EventObject>();

		String typeName;
		while (!events.isEmpty()) {
			EventObject event = events.poll();
			FeatureConfiguration featureConfiguration = unwrapFeatureConfig(event);
			doProcess(configuration, featureConfiguration);

			// pass the feature config to the next action
			ret.add(new FileSystemEvent(((FileSystemEvent)event).getSource(), FileSystemEventType.FILE_ADDED));
		}

		return ret;
	}

	private void doProcess(RasterizeConfiguration configuration, FeatureConfiguration featureConfiguration) throws ActionException {
		TargetRasterizeProcess rasterize = new TargetRasterizeProcess(featureConfiguration.getTypeName(), listenerForwarder, null, null);
		File outputDir = new File(getConfigDir().getParentFile().getAbsolutePath() + "/out/");
		if(configuration.getBaseOutputPath() != null && !configuration.getBaseOutputPath().isEmpty()){
			outputDir = new File(configuration.getBaseOutputPath());
		}		
		File eventFile = new File(getTempDir().getParentFile().getAbsolutePath() + "/rasterize.xml");
		rasterize.execute(getConfigDir(), getTempDir(), outputDir, eventFile);
	}

	@Override
	@CheckConfiguration
	public boolean checkConfiguration() {
		if(configuration.isFailIgnored()) {
			LOGGER.warn("FailIgnored is true. This is a multi-step action, and can't proceed when errors are encountered");
			return false;
		}

		return true;
	}

}