/*

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
package it.geosolutions.geobatch.destination.ingestion;

import it.geosolutions.geobatch.destination.common.InputObject;
import it.geosolutions.geobatch.destination.common.utils.DbUtils;
import it.geosolutions.geobatch.destination.common.utils.SequenceManager;
import it.geosolutions.geobatch.destination.common.utils.TimeUtils;
import it.geosolutions.geobatch.destination.ingestion.gate.model.ExportData;
import it.geosolutions.geobatch.destination.ingestion.gate.model.Transit;
import it.geosolutions.geobatch.destination.ingestion.gate.model.Transits;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.bind.JAXB;

import org.geotools.data.DataStore;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.jdbc.JDBCDataStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Handle the gate ingestion processes. This processor reads a known format
 * exported data file for transit elements and insert in 'siig_gate_t_dato'
 * table using JDBCDataSource. <br />
 * <br />
 * This is an example of the xml file: <br/>
 * <code>
 * &lt;ExportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"&gt;
 * <br/>    &lt;Transits&gt;
 * <br/>    &lt;Transit&gt;
 * <br/>      &lt;IdGate&gt;2004&lt;/IdGate&gt;
 * <br/>      &lt;IdTransito&gt;81831&lt;/IdTransito&gt;
 * <br/>      &lt;DataRilevamento&gt;2013-10-23T10:34:00Z&lt;/DataRilevamento&gt;
 * <br/>      &lt;Corsia&gt;0&lt;/Corsia&gt;
 * <br/>      &lt;Direzione&gt;0&lt;/Direzione &gt;
 * <br/>      &lt;KemlerCode /&gt;
 * <br/>      &lt;OnuCode /&gt;
 * <br/>    &lt;/Transit&gt;
 * <br/>    &lt;Transit&gt;
 * <br/>      &lt;IdGate&gt;2004&lt;/IdGate&gt;
 * <br/>      &lt;IdTransito&gt;81832&lt;/IdTransito&gt;
 * <br/>      &lt;DataRilevamento&gt;2013-10-23T10:34:00Z&lt;/DataRilevamento&gt;
 * <br/>      &lt;Corsia&gt;0&lt;/ Corsia &gt;
 * <br/>      &lt;Direzione&gt;1&lt;/Direzione&gt;
 * <br/>      &lt;KemlerCode /&gt;
 * <br/>      &lt;OnuCode /&gt;
 * <br/>    &lt;/Transit&gt;
 * <br/>  &lt;/Transits&gt;
 * <br/>&lt;/ExportData&gt;
 * </code>
 * 
 * @author adiaz
 */
public class GateIngestionProcess extends InputObject {

private final static Logger LOGGER = LoggerFactory
        .getLogger(GateIngestionProcess.class);

/**
 * No target specified
 */
private static final Integer DEFAULT_GATE_TYPE = NO_TARGET;

/**
 * Pattern: [Server]_[date]_[time].xml
 */
private static Pattern typeNameParts = Pattern
        .compile("^([A-Z])([0-9]{2})[_-]([0-9]{8})[_-]([0-9]{6})$");

/**
 * Used to clean fileName
 */
private static final String DOT = ".";

/**
 * Partner always 1
 */
private static int PARTNER = 1;

/**
 * Always 'A'
 */
private static String PARTNER_CODE = "A";

/**
 * Flag to indicate that
 */
private Boolean ignorePks;

/**
 * Sequence manager to generate transits PKs
 */
private SequenceManager transitSequenceManager;

/**
 * Database connection for the insert
 */
private JDBCDataStore dataStore;

/**
 * File with the data to be inserted
 */
private File file = null;

/**
 * Date in the stored in the file name
 */
private String date;

/**
 * Parametrized constructor
 * 
 * @param typeName
 * @param listenerForwarder
 * @param metadataHandler
 * @param dataStore
 * @param file
 */
public GateIngestionProcess(String typeName,
        ProgressListenerForwarder listenerForwarder,
        MetadataIngestionHandler metadataHandler, DataStore dataStore, File file) {

    super(typeName, listenerForwarder, metadataHandler, dataStore);

    // init datastore
    if (dataStore instanceof JDBCDataStore) {
        this.dataStore = (JDBCDataStore) dataStore;
        transitSequenceManager = new SequenceManager(this.dataStore,
                "transit_seq");
    }

    // init from file to be inserted
    this.file = file;
    String fileName = this.file != null ? this.file.getName() : null;
    if (fileName != null && fileName.contains(DOT)) {
        fileName = fileName.substring(0, fileName.lastIndexOf(DOT));
    }
    parseTypeName(fileName);
}

/**
 * Parametrized constructor
 * 
 * @param typeName
 * @param listenerForwarder
 * @param metadataHandler
 * @param dataStore
 * @param file
 * @param ignorePks
 */
public GateIngestionProcess(String typeName,
        ProgressListenerForwarder listenerForwarder,
        MetadataIngestionHandler metadataHandler, DataStore dataStore,
        File file, Boolean ignorePks) {
    this(typeName, listenerForwarder, metadataHandler, dataStore, file);
    this.ignorePks = ignorePks;
}

/**
 * Read data from the file name
 */
protected boolean parseTypeName(String inputTypeName) {
    Matcher m = typeNameParts.matcher(inputTypeName);

    if (m.matches()) {
        // file date identifier
        date = m.group(4);

        return true;
    }
    return false;
}

/**
 * Imports the gate data from the exported file to database.
 * 
 * @param ignorePks Flag to indicates that should ignore pks in the xml file and
 *        create a new one with a sequence manager
 * @throws IOException
 */
public List<Long> importGates(boolean ignorePks) throws IOException {

    List<Long> ids = new ArrayList<Long>();
    reset();
    this.ignorePks = ignorePks;
    if (isValid()) {

        int process = -1;
        int trace = -1;
        int errors = 0;
        int total = 0;
        int processed = 0;
        float percent = 0;

        try {

            process = createProcess();

            // write log for the imported file
            trace = logFile(process, DEFAULT_GATE_TYPE, PARTNER, PARTNER_CODE,
                    date, false);

            // Read xml file
            ExportData exportData = null;
            try {
                exportData = JAXB.unmarshal(file, ExportData.class);
            } catch (Exception e) {
                String msg = "Unknown file format for gate ingestion";
                updateProgress(90, msg);
                metadataHandler.logError(trace, errors, msg, getError(e), 0);
                throw new IOException(msg);
            }

            if (exportData != null && exportData.getTransits().size() == 1) {
                Transits transits = exportData.getTransits().get(0);
                total = transits.getTransit().size();
                float ftot = new Float(total);

                // Insert one by one
                for (Transit transit : transits.getTransit()) {
                    Long id = null;
                    try {

                        // Update status
                        inputCount++;
                        float fproc = new Float(++processed);
                        String msg = "Importing data in transit table: "
                                + (processed) + "/" + total;
                        percent = (fproc++ / ftot);
                        updateProgress(percent * 100, msg);
                        if (LOGGER.isInfoEnabled()) {
                            LOGGER.info(msg);
                        }

                        // insert
                        id = createTransit(transit);

                        // add to result
                        if (id != null) {
                            // Trace insert
                            if (LOGGER.isTraceEnabled()) {
                                LOGGER.trace("Correctly insert id " + id);
                            }
                            ids.add(id);
                        } else {
                            LOGGER.error("Error on gate ingestion for element "
                                    + inputCount);
                        }

                    } catch (Exception e) {
                        errors++;
                        if (id != null) {
                            metadataHandler.logError(trace, errors,
                                    "Error on gate ingestion", getError(e),
                                    id.intValue());
                            String msg = "Error on gate ingestion for id "
                                    + id.intValue();
                            updateProgress(percent * 100, msg);
                            LOGGER.error(msg);
                        } else {
                            metadataHandler.logError(trace, errors,
                                    "Error importing element " + inputCount,
                                    getError(e), 0);
                            String msg = "Error on gate ingestion for element "
                                    + inputCount;
                            updateProgress(percent * 100, msg);
                            LOGGER.error(msg);
                        }
                    }
                }
            } else {
                LOGGER.error("Incorrect format for ingestion");
            }

            // all complete
            importFinished(total, errors, "Data imported in transit table");
            metadataHandler.updateLogFile(trace, total, errors, true);

        } catch (IOException e) {
            errors++;
            metadataHandler.logError(trace, errors, "Error importing data",
                    getError(e), 0);

            // close current process phase
            process = closeProcess(process);

            throw e;
        } finally {
            if (process != -1) {
                // close current process phase
                metadataHandler.closeProcessPhase(process, "A");
            }

        }

        // close current process phase
        process = closeProcess(process);
    }

    return ids;
}

private void updateProgress(float progress, String msg) {
    listenerForwarder.setProgress(progress);
    listenerForwarder.setTask(msg);
    listenerForwarder.progressing();
}

private int closeProcess(int process) throws IOException {
    if (process != -1) {
        // close current process phase
        metadataHandler.closeProcessPhase(process, "A");
        process = -1;
    }
    return process;
}

/**
 * Creates a new transit in the transit table.
 * 
 * @return id of the transit
 * @throws IOException if an exception occur when execute sql insert
 */
public Long createTransit(Transit transit) throws IOException {

    Transaction transaction = null;
    Connection conn = null;
    try {
        transaction = new DefaultTransaction();
        conn = dataStore.getConnection(transaction);

        // ignored pk (use generated) or not
        Long id = (Boolean.TRUE.equals(ignorePks) ? transitSequenceManager
                .retrieveValue() : transit.getIdTransito());

        Timestamp timestamp = TimeUtils.getTimeStamp(transit
                .getDataRilevamento());

        // null value should throw an exception
        String arriveDate = timestamp != null ? "'" + timestamp + "'" : null;

        // sql insert into transit
        String sql = "insert into siig_gate_t_dato(" + "id_dato, "
                + "fk_gate, " + "data_rilevamento, " + "data_ricezione, "
                + "flg_corsia, " + "direzione, " + "codice_kemler, "
                + "codice_onu)" + " values(" + id + ", " + transit.getIdGate()
                + ", " + arriveDate + ", '" + TimeUtils.getTodayTimestamp()
                + "', " + transit.getCorsia() + ", '" + transit.getDirezione()
                + "', '" + transit.getKemlerCode() + "', '"
                + transit.getOnuCode() + "')";

        // trace sql
        if (LOGGER.isTraceEnabled()) {
            LOGGER.trace("SQL insert: " + sql);
        }

        DbUtils.executeSql(conn, transaction, sql, true);
        return id;
    } catch (SQLException e) {
        throw new IOException(e);
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                throw new IOException(e);
            }
        }
        if (transaction != null) {
            transaction.close();
        }
    }

}

/**
 * Check if file and datastore is not null
 */
protected boolean isValid() throws IOException {
    return file != null && dataStore != null;
}

}
