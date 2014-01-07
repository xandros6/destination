/*
 *  GeoBatch - Open Source geospatial batch processing system
 *  http://geobatch.geo-solutions.it/
 *  Copyright (C) 2014 GeoSolutions S.A.S.
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
package it.geosolutions.geobatch.destination.action.gatefilehandling;

import it.geosolutions.filesystemmonitor.monitor.FileSystemEvent;
import it.geosolutions.filesystemmonitor.monitor.FileSystemEventType;
import it.geosolutions.geobatch.actions.ds2ds.util.FeatureConfigurationUtil;
import it.geosolutions.geobatch.annotations.Action;
import it.geosolutions.geobatch.destination.ingestion.GateIngestionProcess;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.flow.event.action.ActionException;
import it.geosolutions.geobatch.flow.event.action.BaseAction;
import it.geosolutions.geobatch.ftp.client.FTPHelperBare;
import it.geosolutions.geobatch.ftp.client.configuration.FTPActionConfiguration;

import java.io.File;
import java.io.IOException;
import java.util.EventObject;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;

import org.geotools.data.DataStore;
import org.geotools.jdbc.JDBCDataStore;

import com.enterprisedt.net.ftp.FTPConnectMode;
import com.enterprisedt.net.ftp.FTPFile;
import com.enterprisedt.net.ftp.FTPTransferType;
import com.enterprisedt.net.ftp.WriteMode;

/**
 * GeoBatch gate ingestion remote file handling action
 * 
 * @author adiaz
 */
@Action(configurationClass = GateFileHandlingConfiguration.class)
public class GateFileHandlingAction extends BaseAction<EventObject> {

/**
 * Temporal directory
 */
private static String TMP_DIR = System.getProperty("java.io.tmpdir");

/**
 * File separator
 */
private static String SEPARATOR = System.getProperty("file.separator");

/**
 * Action configuration
 */
private GateFileHandlingConfiguration configuration;

public GateFileHandlingAction(final GateFileHandlingConfiguration configuration)
        throws IOException {
    super(configuration);
    this.configuration = configuration;
}

/**
 * Check if the configuration it's correctly. Just obtain the data source
 */
public boolean checkConfiguration() {
    DataStore ds = null;
    try {
        // Don't read configuration for the file, just
        // this.outputfeature configuration
        ds = FeatureConfigurationUtil.createDataStore(configuration
                .getOutputFeature());
        if (!(ds instanceof JDBCDataStore)) {
            LOGGER.error("Incorrect datasource for this action");
            return false;
        } else {
            return true;
        }
    } catch (Exception e) {
        LOGGER.error("Incorrect datasource for this action");
        return false;
    } finally {
        ds.dispose();
    }
}

/**
 * Execute process
 */
public Queue<EventObject> execute(Queue<EventObject> events)
        throws ActionException {

    // return object
    final Queue<EventObject> ret = new LinkedList<EventObject>();

    while (events.size() > 0) {
        final EventObject ev;
        try {
            if ((ev = events.remove()) != null) {
                if (LOGGER.isTraceEnabled()) {
                    LOGGER.trace("Working on incoming event: " + ev.getSource());
                }
                if (ev instanceof FileSystemEvent) {
                    FileSystemEvent fileEvent = (FileSystemEvent) ev;
                    @SuppressWarnings("unused")
                    File file = fileEvent.getSource();
                    // Don't read configuration for the file, just
                    // this.outputfeature configuration
                    DataStore ds = FeatureConfigurationUtil
                            .createDataStore(configuration.getOutputFeature());
                    if (ds == null) {
                        throw new ActionException(this, "Can't find datastore ");
                    }
                    try {
                        if (!(ds instanceof JDBCDataStore)) {
                            throw new ActionException(this,
                                    "Bad Datastore type "
                                            + ds.getClass().getName());
                        }
                        JDBCDataStore dataStore = (JDBCDataStore) ds;
                        dataStore.setExposePrimaryKeyColumns(true);
                        MetadataIngestionHandler metadataHandler = new MetadataIngestionHandler(
                                dataStore);
                        doProcess(configuration, dataStore, metadataHandler);

                        // pass the feature config to the next action
                        ret.add(new FileSystemEvent(((FileSystemEvent) ev)
                                .getSource(), FileSystemEventType.FILE_ADDED));
                    } finally {
                        ds.dispose();
                    }
                }

                // add the event to the return
                ret.add(ev);

            } else {
                if (LOGGER.isErrorEnabled()) {
                    LOGGER.error("Encountered a NULL event: SKIPPING...");
                }
                continue;
            }
        } catch (Exception ioe) {
            final String message = "Unable to produce the output: "
                    + ioe.getLocalizedMessage();
            if (LOGGER.isErrorEnabled())
                LOGGER.error(message, ioe);

            throw new ActionException(this, message);
        }
    }
    return ret;
}

/**
 * Call to Gate ingestion process
 * 
 * @param cfg
 * @param dataStore
 * @param metadataHandler
 * @param file
 * @throws ActionException
 */
public void doProcess(GateFileHandlingConfiguration cfg,
        JDBCDataStore dataStore, MetadataIngestionHandler metadataHandler)
        throws ActionException {

    try {

        // Read configuration
        FTPActionConfiguration ftpActionConfiguration = cfg
                .getFtpConfiguration();
        String ftpserverHost = ftpActionConfiguration.getFtpserverHost();
        String ftpserverUSR = ftpActionConfiguration.getFtpserverUSR();
        String ftpserverPWD = ftpActionConfiguration.getFtpserverPWD();
        int ftpserverPort = ftpActionConfiguration.getFtpserverPort();
        final FTPConnectMode connectMode = ftpActionConfiguration
                .getConnectMode().toString()
                .equalsIgnoreCase(FTPConnectMode.ACTIVE.toString()) ? FTPConnectMode.ACTIVE
                : FTPConnectMode.PASV;
        final int timeout = ftpActionConfiguration.getTimeout();

        // Input directory is the temporal directory (for file download)
        String inputDir = TMP_DIR;

        // Base remote directories from configuration
        String dirName = cfg.getBaseRemotePath();
        String remotePath = cfg.getInputRemotePath();

        FTPFile[] files = FTPHelperBare.dirDetails(ftpserverHost, dirName
                + SEPARATOR + remotePath, SEPARATOR, ftpserverUSR, ftpserverPWD,
                ftpserverPort, FTPTransferType.BINARY, WriteMode.OVERWRITE,
                connectMode, timeout);

        // For each file on the remote directory
        for (FTPFile file : files) {
            if (LOGGER.isInfoEnabled()) {
                LOGGER.info("Processing file " + file.getName());
            }

            // Download the file
            FTPHelperBare.downloadFile(ftpserverHost, inputDir, dirName
                    + SEPARATOR + remotePath, file.getName(), ftpserverUSR,
                    ftpserverPWD, ftpserverPort, FTPTransferType.BINARY,
                    WriteMode.OVERWRITE, connectMode, timeout);
            File inputFile = new File(inputDir + SEPARATOR + file.getName());

            // process the file
            if (inputFile.exists()) {
                // delete downloaded file
                FTPHelperBare.deleteFileOrDirectory(ftpserverHost,
                        file.getName(), false,
                        dirName + SEPARATOR + remotePath, ftpserverUSR,
                        ftpserverPWD, ftpserverPort, connectMode, timeout);
                
                boolean error = true;
                
                try{
                    // Import gate data
                    GateIngestionProcess computation = new GateIngestionProcess(
                            // type name read on file name
                            "", listenerForwarder, metadataHandler, dataStore,
                            inputFile);
                    Map<String, Object> procResult = computation.doProcess(cfg
                            .getIgnorePks());
                    
                    // is correct?
                    if (procResult != null
                            && !procResult.isEmpty()
                            && procResult.get(GateIngestionProcess.ERROR_COUNT) != null
                            && procResult.get(GateIngestionProcess.ERROR_COUNT)
                                    .equals(0)) {
                        error = false;
                    }
                }catch (Exception e){
                    if(LOGGER.isErrorEnabled()){
                        LOGGER.error("Error processing "+file.getName(), e);
                    }
                }

                // Post process.
                if (!error) {
                    // success: put on success remote dir
                    FTPHelperBare.putBinaryFileTo(ftpserverHost,
                            inputFile.getAbsolutePath(), dirName + SEPARATOR
                                    + cfg.getSuccesRemotePath(), ftpserverUSR,
                            ftpserverPWD, ftpserverPort, WriteMode.OVERWRITE,
                            connectMode, timeout);
                } else {
                    // fail: put on fail remote dir
                    FTPHelperBare.putBinaryFileTo(ftpserverHost,
                            inputFile.getAbsolutePath(), dirName + SEPARATOR
                                    + cfg.getFailRemotePath(), ftpserverUSR,
                            ftpserverPWD, ftpserverPort, WriteMode.OVERWRITE,
                            connectMode, timeout);
                }

                // clean downloaded file
                inputFile.delete();

            } else if (LOGGER.isErrorEnabled()) {
                LOGGER.error("Error downloading " + file.getName());
            }
        }

    } catch (Exception ex) {
        // TODO: what shall we do here??
        // log and rethrow for the moment, but a rollback should be
        // implementened somewhere
        LOGGER.error("Error in importing gates", ex);
        throw new ActionException(this, "Error in importing gates", ex);
    }

}

}
