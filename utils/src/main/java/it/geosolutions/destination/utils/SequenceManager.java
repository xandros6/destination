/*
 *  Copyright (C) 2007-2012 GeoSolutions S.A.S.
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
package it.geosolutions.destination.utils;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

import org.geotools.data.Transaction;

/**
 * @author DamianoG
 * 
 */
public class SequenceManager {

    private static Logger LOGGER = Logger.getLogger(SequenceManager.class.getName());
            
    private String seqName = null;
    private Connection connection = null;
    private Transaction transaction = null;
    
    public SequenceManager(Connection conn, Transaction transaction, String seqName){
        try {
            seqName = seqName.replaceAll("-", "_");
            seqName = seqName.replaceAll("\\.", "_");
            seqName = seqName.toLowerCase();
            this.connection = conn;
            this.seqName = seqName;
            this.transaction = transaction;
            createSequence(seqName);                                    
        } catch (IOException e) {
            LOGGER.severe(e.getMessage());
        }
    }
    
    public long retrieveValue() throws IOException {

        String sql = null;
        Long id = null;
        PreparedStatement stmt = null;
        ResultSet resultSet = null;
        try {
            sql = "SELECT nextval('" + this.seqName + "')";
            stmt = connection.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            if(resultSet.next()) {
            	id = resultSet.getLong(1);
            }            
        } catch (SQLException e) {
        	transaction.rollback();
            throw new IOException(e);
        } finally {
        	try {
        		if(resultSet != null) {
        			resultSet.close();
	        	}
	        	if(stmt != null) {
	        		stmt.close();
	        	}	            
        	} catch (SQLException e) {
                throw new IOException(e);
            }
        }
        return id;
    }
    
    public void disposeManager(){
          connection = null;          
    }

    private boolean createSequence(String seqName)
            throws IOException {

        String sql = null;                
        PreparedStatement stmt = null;
        try {
            sql = "CREATE SEQUENCE " + seqName;
            stmt = connection.prepareStatement(sql);
            stmt.execute();
            transaction.commit();
        } catch (SQLException e) {
        	transaction.rollback();
        	// existing sequence
            if ("42P07".equals(e.getSQLState())) {
                return false;
            } else {
                throw new IOException(e);
            }
        } finally {
        	try {
	        	if(stmt != null) {
	        		stmt.close();
	        	}	            
        	} catch (SQLException e) {
                throw new IOException(e);
            }            
        }
        return true;
    }

    

    

}
