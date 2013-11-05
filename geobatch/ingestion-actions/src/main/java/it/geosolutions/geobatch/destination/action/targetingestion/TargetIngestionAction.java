/*
 *  GeoBatch - Open Source geospatial batch processing system
 *  http://geobatch.geo-solutions.it/
 *  Copyright (C) 2013 GeoSolutions S.A.S.
 *  http://www.geo-solutions.it
 *
 *  GPLv3 + Classpath exception
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package it.geosolutions.geobatch.destination.action.targetingestion;

import it.geosolutions.filesystemmonitor.monitor.FileSystemEvent;
import it.geosolutions.filesystemmonitor.monitor.FileSystemEventType;
import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration;
import it.geosolutions.geobatch.actions.ds2ds.util.FeatureConfigurationUtil;
import it.geosolutions.geobatch.flow.event.action.ActionException;
import it.geosolutions.geobatch.flow.event.action.BaseAction;
import it.geosolutions.geobatch.annotations.Action;
import it.geosolutions.geobatch.annotations.CheckConfiguration;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.destination.ingestion.TargetIngestionProcess;
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

@Action(configurationClass = TargetIngestionConfiguration.class)
public class TargetIngestionAction extends BaseAction<EventObject> {

    private final static Logger LOGGER = LoggerFactory.getLogger(TargetIngestionAction.class);
    private final TargetIngestionConfiguration configuration;

    public TargetIngestionAction(final TargetIngestionConfiguration configuration) throws IOException {
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
        TargetIngestionConfiguration cfg = getConfiguration();
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

    private void doProcess(TargetIngestionConfiguration cfg, FeatureConfiguration featureCfg) throws ActionException {
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

        TargetIngestionProcess computation = new TargetIngestionProcess(
                featureCfg.getTypeName(),
                listenerForwarder,
                metadataHandler,
                dataStore);

        try {
            computation.importTarget(null, cfg.isDropInput());

        } catch (IOException ex) {
            // TODO: what shall we do here??
            // log and rethrow for the moment, but a rollback should be implementened somewhere
            LOGGER.error("Error in importing targets", ex);
            throw new ActionException(this, "Error in importing targets", ex);
        }
    }
}
