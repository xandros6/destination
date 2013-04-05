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
package it.geosolutions.geobatch.destination;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.jdbc.JDBCDataStore;

/**
 * Handles the ingestion metadata structures on database.
 * 
 * TODO: use Hibernate ?
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class Ingestion {
	
	/**	
	 * Creates a new process in the metadata table.
	 * 
	 * @param dataStore
	 * @return
	 * @throws IOException
	 */
	public static int createProcess(JDBCDataStore dataStore) throws IOException {
		Transaction transaction = null;	
		Connection conn = null;
		try {			
			transaction = new DefaultTransaction();
			conn = dataStore.getConnection(transaction);
			int processo = DbUtils.getNewId(conn, transaction, "siig_t_processo", "id_processo");		
			String sql = "INSERT INTO siig_t_processo(id_processo,data_creazione) values(" +processo+ ",now())";
			
			DbUtils.executeSql(conn, transaction, sql, true);
			return processo;
		} catch (SQLException e) {
			throw new IOException(e);
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					throw new IOException(e);
				}
			}
			if(transaction != null) {
				transaction.close();
			}
		}
		
		
	}
	
	/**
	 * Close the given phase of a process.
	 * 
	 * @param dataStore
	 * @param processo
	 * @param phase
	 * @throws IOException
	 */
	public static void closeProcessPhase(JDBCDataStore dataStore,
			int processo, String phase) throws IOException {		
		try {												
			String sql = "UPDATE siig_t_processo SET data_chiusura_"+phase.toLowerCase()+"=now() where id_processo="+processo;
			
			DbUtils.executeSql(dataStore, null, sql, true);			
		} catch (SQLException e) {
			throw new IOException(e);
		}
	}
	
	/**
	 * Creates the log metadata for an imported file.
	 *  
	 * @param dataStore
	 * @param processo
	 * @param bersaglio
	 * @param partner
	 * @param codicePartner
	 * @param typeName
	 * @param date
	 * @param total
	 * @param update
	 * @return
	 * @throws IOException
	 */
	public static int logFile(JDBCDataStore dataStore, 
			int processo, int bersaglio, int partner, String codicePartner, String typeName, String date, boolean update) throws IOException {
		Transaction transaction = null;	
		Connection conn = null;
		try {			
			transaction = new DefaultTransaction();
			conn = dataStore.getConnection(transaction);
			int tracciamento = DbUtils.getNewId(conn, transaction, "siig_t_tracciamento", "id_tracciamento");		
						
			String sql = "INSERT INTO siig_t_tracciamento(id_tracciamento,fk_processo,fk_bersaglio,fk_partner,codice_partner,nome_file,data,";
			sql       += "nr_rec_shape,nr_rec_storage,nr_rec_scartati,nr_rec_scartati_siig,data_imp_storage,data_elab,flg_tipo_imp)";
			sql       += "values("+tracciamento+","+processo+","+(bersaglio == -1 ? "null" : (bersaglio+""))+",'"+partner+ "','"+codicePartner+"','"+typeName+"', to_date('"+date+"', 'YYYYMMDD'),0,0,0,0,now(),now(),'"+(update ? "I" : "C")+"')";
			
			DbUtils.executeSql(conn, transaction, sql, true);
			return tracciamento;
		} catch (SQLException e) {
			throw new IOException(e);
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					throw new IOException(e);
				}
			}
			if(transaction != null) {
				transaction.close();
			}
		}
	}

	/**
	 * Logs a new error for an imported file.
	 * 
	 * @param dataStore
	 * @param trace
	 * @param errors
	 * @param message
	 * @param message2
	 * @param idTematico
	 * @throws IOException 
	 */
	public static void logError(JDBCDataStore dataStore, int trace, int progr,
			String codiceLog, String error, int idTematico) throws IOException {
		Transaction transaction = null;	
		Connection conn = null;
		try {			
			transaction = new DefaultTransaction();
			conn = dataStore.getConnection(transaction);				
						
			String sql = "INSERT INTO siig_t_log(id_tracciamento,progressivo,codice_log,descr_errore,id_tematico_shape_orig)";			
			sql       += "values("+trace+","+progr+",'"+codiceLog+"','"+error.replace("'", "''")+ "',"+idTematico+")";
			
			DbUtils.executeSql(conn, transaction, sql, true);
			
		} catch (SQLException e) {
			throw new IOException(e);
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					throw new IOException(e);
				}
			}
			if(transaction != null) {
				transaction.close();
			}
		}
	}

	/**
	 * @param dataStore
	 * @param trace
	 * @param errors
	 * @throws IOException 
	 */
	public static void updateLogFile(JDBCDataStore dataStore, int trace, int total,
			int errors) throws IOException {
		Transaction transaction = null;	
		Connection conn = null;
		try {			
			transaction = new DefaultTransaction();
			conn = dataStore.getConnection(transaction);				
		
			String sql = "UPDATE siig_t_tracciamento SET nr_rec_shape=" + total
					+ ",nr_rec_storage=" + (total - errors)
					+ ",nr_rec_scartati=" + errors + "WHERE id_tracciamento="
					+ trace;
			
			DbUtils.executeSql(conn, transaction, sql, true);
			
		} catch (SQLException e) {
			throw new IOException(e);
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					throw new IOException(e);
				}
			}
			if(transaction != null) {
				transaction.close();
			}
		}
	}
}
