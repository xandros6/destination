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

import it.geosolutions.destination.utils.SequenceManager;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.jdbc.JDBCDataStore;
import org.geotools.process.ProcessException;
import org.geotools.process.factory.DescribeParameter;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.process.factory.DescribeResult;
import org.geotools.process.gs.GSProcess;
import org.geotools.util.logging.Logging;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
@DescribeProcess(title = "ProcessingRepository", description = "Save and load processing info for further use")
public class ProcessingRepository  implements GSProcess {
	private static final Logger LOGGER = Logging.getLogger(ProcessingRepository.class);	
	// GeoServer catalog, used to extract the DataStore used by the process
	protected Catalog catalog;
	
	/**
	 * @param catalog
	 */
	public ProcessingRepository(Catalog catalog) {
		this.catalog = catalog;	
	}
	
	@DescribeResult(description = "ProcessingRepository action")
	public String execute(			
			@DescribeParameter(name = "store", description = "repository data store name", min = 1, max = 1) String storeName,
			@DescribeParameter(name = "action", description = "repository action (load/save)", min = 1, max = 1) String action,
			@DescribeParameter(name = "user", description = "user asking action", min = 1, max = 1) Integer user,
			@DescribeParameter(name = "dataid", description = "id of data to load", min = 0) Integer dataId,
			@DescribeParameter(name = "data", description = "data to save", min = 0) String data,
			@DescribeParameter(name = "clean", description = "clean expired data", min = 0) Boolean clean

		)  {
		if(storeName == null) {
			throw new ProcessException("Missing storeName parameter");
		}
		if(user == null) {
			throw new ProcessException("Missing user parameter");
		}
		if(clean == null) {
			clean = false;
		}
		JDBCDataStore dataStore = null;
		if(catalog != null && storeName != null) {
			LOGGER.info("Loading DataStore " + storeName + " from Catalog");
			DataStoreInfo dataStoreInfo = catalog.getDataStoreByName(storeName);
			if(dataStoreInfo == null) {
				LOGGER.severe("DataStore not found");
				throw new ProcessException("DataStore not found: " + storeName);
			}
			try {
				dataStore = (JDBCDataStore)dataStoreInfo.getDataStore(null);
			} catch (IOException e) {
				throw new ProcessException("Can't connect to DataStore: " + storeName, e);
			}
		}
		if(clean) {
			try {
				cleanData(dataStore, user, getCleaningLimit());
			} catch (Exception e) {
				LOGGER.warning("Cannot clean old items");			
			}
		}
		if(action.equalsIgnoreCase("save")) {
			if(data == null) {
				throw new ProcessException("Missing data parameter");
			}
			try {
				return saveData(dataStore, user, data);
			} catch (Exception e) {
				throw new ProcessException("Error saving data", e);
			}
			
		} else if(action.equalsIgnoreCase("load")) {
			if(dataId == null) {
				throw new ProcessException("Missing dataid parameter");
			}
			try {
				return loadData(dataStore, user, dataId);
			} catch (Exception e) {
				throw new ProcessException("Error loading data", e);
			}
			
		} else {
			throw new ProcessException("Unrecognized action: " + action);
		}
		
	}

	/**
	 * @return
	 */
	private long getCleaningLimit() {
		Calendar now = Calendar.getInstance();
		now.add(Calendar.DAY_OF_MONTH, -1);
		return now.getTime().getTime();
	}

	/**
	 * @param user
	 * @param dataId
	 * @return
	 * @throws IOException 
	 * @throws SQLException 
	 */
	public static String loadData(JDBCDataStore dataStore, Integer user, Integer dataId) throws IOException, SQLException {
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet resultSet = null;
		try {
			 conn = dataStore.getConnection(Transaction.AUTO_COMMIT);
			 
			 stmt = conn.prepareStatement("select xml_richiesta from siig_t_save where id_save = ? and fk_utente = ?");
			 stmt.setInt(1, dataId);
			 stmt.setInt(2, user);			 
			 resultSet = stmt.executeQuery();
			 if(resultSet.next()) {
				 return resultSet.getString(1);
			 }
			 throw new IOException("No data found for id: " + dataId);
		} finally {							
			if(resultSet != null) {
				resultSet.close();
			}
			if(stmt != null) {
				stmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		}
	}

	/**
	 * @param dataStore
	 * @param user
	 * @param data
	 * @return
	 * @throws IOException 
	 * @throws SQLException 
	 */
	public static String saveData(JDBCDataStore dataStore, Integer user, String data) throws IOException, SQLException {
		DefaultTransaction transaction = new DefaultTransaction();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			 conn = dataStore.getConnection(transaction);
			 SequenceManager sequenceManager = new SequenceManager(conn, transaction, "siig_t_save_seq");
			 int id = (int)sequenceManager.retrieveValue();
			 stmt = conn.prepareStatement("insert into siig_t_save(id_save,fk_utente,xml_richiesta,data_aggiornamento) values(?,?,?,?)");
			 stmt.setInt(1, id);
			 stmt.setInt(2, user);
			 stmt.setString(3, data);
			 stmt.setTimestamp(4, new java.sql.Timestamp(getCurrentDate()));
			 stmt.execute();
			 transaction.commit();
			 return id + "";
		} catch(IOException e) {
			transaction.rollback();
			throw e;
		} catch(SQLException e) {
			transaction.rollback();
			throw e;
		} finally {				
			transaction.close();
			
			if(stmt != null) {
				stmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		}
	}
	
	/**
	 * @param dataStore
	 * @param user
	 * @param data
	 * @return
	 * @throws IOException 
	 * @throws SQLException 
	 */
	public static void cleanData(JDBCDataStore dataStore, Integer user, long limit) throws IOException, SQLException {
		DefaultTransaction transaction = new DefaultTransaction();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			 conn = dataStore.getConnection(transaction);			 
			 stmt = conn.prepareStatement("delete from siig_t_save where fk_utente = ? and data_aggiornamento < ?");			 
			 stmt.setInt(1, user);		
			 if(limit == -1) {
				 limit = getCurrentDate();
			 }
			 stmt.setTimestamp(2, new java.sql.Timestamp(limit));
			 stmt.execute();
			 transaction.commit();			 
		} catch(IOException e) {
			transaction.rollback();
			throw e;
		} catch(SQLException e) {
			transaction.rollback();
			throw e;
		} finally {				
			transaction.close();
			
			if(stmt != null) {
				stmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		}
	}

	/**
	 * @return
	 */
	private static long getCurrentDate() {
		return Calendar.getInstance().getTime().getTime();
	}
}
