package it.geosolutions.geobatch.destination.action.streetuser;

import it.geosolutions.filesystemmonitor.monitor.FileSystemEvent;
import it.geosolutions.filesystemmonitor.monitor.FileSystemEventType;
import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration;
import it.geosolutions.geobatch.actions.ds2ds.util.FeatureConfigurationUtil;
import it.geosolutions.geobatch.annotations.Action;
import it.geosolutions.geobatch.annotations.CheckConfiguration;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.streetuser.StreetUserComputation;
import it.geosolutions.geobatch.flow.event.action.ActionException;
import it.geosolutions.geobatch.flow.event.action.BaseAction;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.EventObject;
import java.util.LinkedList;
import java.util.Queue;

import org.geotools.data.DataStore;
import org.geotools.jdbc.JDBCDataStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Action(configurationClass = StreetUserConfiguration.class)
public class StreetUserAction extends BaseAction<EventObject> {

	private final static Logger LOGGER = LoggerFactory.getLogger(StreetUserAction.class);
	private final StreetUserConfiguration configuration;

	public StreetUserAction(final StreetUserConfiguration configuration) throws IOException {
		super(configuration);
		this.configuration = configuration;
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

	private void checkInit() {
		StreetUserConfiguration cfg = getConfiguration();
		if (cfg == null) {
			throw new IllegalStateException("ActionConfig is null.");
		}
	}

	/**
	 *
	 */
	public Queue<EventObject> execute(Queue<EventObject> events) throws ActionException {

		listenerForwarder.setTask("Check config");

		checkInit();

		listenerForwarder.started();

		final LinkedList<EventObject> ret = new LinkedList<EventObject>();

		while (!events.isEmpty()) {
			EventObject event = events.poll();
			FeatureConfiguration featureConfiguration = unwrapFeatureConfig(event);
			doProcess(configuration, featureConfiguration);

			// pass the feature config to the next action
			ret.add(new FileSystemEvent(((FileSystemEvent)event).getSource(), FileSystemEventType.FILE_ADDED));
		}

		return ret;
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

	private void doProcess(StreetUserConfiguration cfg, FeatureConfiguration featureCfg) throws ActionException {
		DataStore ds = FeatureConfigurationUtil.createDataStore(featureCfg);
		if (ds == null) {
			throw new ActionException(this, "Can't find datastore ");
		}
		if (!(ds instanceof JDBCDataStore)) {
			throw new ActionException(this, "Bad Datastore type " + ds.getClass().getName());
		}

		JDBCDataStore dataStore = (JDBCDataStore) ds;
		dataStore.setExposePrimaryKeyColumns(true);
		MetadataIngestionHandler metadataHandler = new MetadataIngestionHandler(dataStore);

		StreetUserComputation computation = new StreetUserComputation(
				featureCfg.getTypeName(),
				listenerForwarder,
				metadataHandler,
				dataStore);

		computation.execute(cfg.getAggregationLevel());
	}
}
