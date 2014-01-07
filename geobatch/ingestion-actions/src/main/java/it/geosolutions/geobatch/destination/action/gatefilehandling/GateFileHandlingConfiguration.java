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

import it.geosolutions.geobatch.destination.action.gateingestion.GateIngestionConfiguration;
import it.geosolutions.geobatch.ftp.client.configuration.FTPActionConfiguration;

/**
 * Gate file handling configuration. Not use input ds (input data it's read from xml).
 * Includes ftp connection parameters for the remote file browsing
 * 
 * @author adiaz
 */
public class GateFileHandlingConfiguration extends GateIngestionConfiguration {

/**
 * Configuration for the FTP connection
 */
private FTPActionConfiguration ftpConfiguration;

/**
 * Base path for the remote operations
 */
private String baseRemotePath;

/**
 * Input remote directory
 */
private String inputRemotePath;

/**
 * Output for done files
 */
private String succesRemotePath;

/**
 * Output for fail files
 */
private String failRemotePath;

public GateFileHandlingConfiguration(String id, String name, String description) {
    super(id, name, description);
}

/**
 * @return the ftpConfiguration
 */
public FTPActionConfiguration getFtpConfiguration() {
    return ftpConfiguration;
}

/**
 * @param ftpConfiguration the ftpConfiguration to set
 */
public void setFtpConfiguration(FTPActionConfiguration ftpConfiguration) {
    this.ftpConfiguration = ftpConfiguration;
}
/**
 * @return the baseRemotePath
 */
public String getBaseRemotePath() {
    return baseRemotePath;
}

/**
 * @param baseRemotePath the baseRemotePath to set
 */
public void setBaseRemotePath(String baseRemotePath) {
    this.baseRemotePath = baseRemotePath;
}

/**
 * @return the inputRemotePath
 */
public String getInputRemotePath() {
    return inputRemotePath;
}

/**
 * @param inputRemotePath the inputRemotePath to set
 */
public void setInputRemotePath(String inputRemotePath) {
    this.inputRemotePath = inputRemotePath;
}

/**
 * @return the succesRemotePath
 */
public String getSuccesRemotePath() {
    return succesRemotePath;
}

/**
 * @param succesRemotePath the succesRemotePath to set
 */
public void setSuccesRemotePath(String succesRemotePath) {
    this.succesRemotePath = succesRemotePath;
}

/**
 * @return the failRemotePath
 */
public String getFailRemotePath() {
    return failRemotePath;
}

/**
 * @param failRemotePath the failRemotePath to set
 */
public void setFailRemotePath(String failRemotePath) {
    this.failRemotePath = failRemotePath;
}

}
