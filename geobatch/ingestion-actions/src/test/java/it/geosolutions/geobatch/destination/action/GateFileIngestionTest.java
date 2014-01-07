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
package it.geosolutions.geobatch.destination.action;

import static org.junit.Assert.assertTrue;
import it.geosolutions.geobatch.destination.action.gatefilehandling.GateFileHandlingAction;
import it.geosolutions.geobatch.destination.action.gatefilehandling.GateFileHandlingConfiguration;
import it.geosolutions.geobatch.ftp.client.FTPHelperBare;
import it.geosolutions.geobatch.ftp.client.configuration.FTPActionConfiguration;
import it.geosolutions.geobatch.ftp.client.configuration.FTPActionConfiguration.FTPConnectMode;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.mockftpserver.fake.FakeFtpServer;
import org.mockftpserver.fake.UserAccount;
import org.mockftpserver.fake.filesystem.DirectoryEntry;
import org.mockftpserver.fake.filesystem.FileEntry;
import org.mockftpserver.fake.filesystem.FileSystem;
import org.mockftpserver.fake.filesystem.UnixFakeFileSystem;

import com.enterprisedt.net.ftp.FTPFile;
import com.enterprisedt.net.ftp.FTPTransferType;
import com.enterprisedt.net.ftp.WriteMode;

/**
 * JUnit test for {@link GateFileHandlingAction} action
 * 
 * @author adiaz
 */
public class GateFileIngestionTest {

/**
 * Mocked FTP server for testing
 */
private FakeFtpServer fakeFtpServer;

/**
 * Action configuration
 */
private GateFileHandlingConfiguration config;

/**
 * Port to start fake FTP server
 */
private int fakeFtpPort = 10580;

/**
 * Prepare test for remote FTP file browsing
 * 
 * @throws Exception
 */
@Before
public void setup() throws Exception {

    // fake FTP server
    fakeFtpServer = new FakeFtpServer();
    fakeFtpServer.setServerControlPort(fakeFtpPort);
    fakeFtpServer.addUserAccount(new UserAccount("user", "password", "/tmp"));
    FileSystem fileSystem = new UnixFakeFileSystem();
    fileSystem.add(new DirectoryEntry("/tmp/SIIG"));
    fileSystem.add(new DirectoryEntry("/tmp/SIIG/Acquisiti"));
    fileSystem.add(new DirectoryEntry("/tmp/SIIG/Elaborati"));
    fileSystem.add(new DirectoryEntry("/tmp/SIIG/Scarti"));
    fileSystem.add(new FileEntry("/tmp/SIIG/Acquisiti/00_20131218_141116.xml",
            "fake"));
    fileSystem.add(new FileEntry("/tmp/SIIG/Acquisiti/00_20140107_142500.xml",
            "fake"));
    fakeFtpServer.setFileSystem(fileSystem);
    fakeFtpServer.start();

    // file handling config
    config = new GateFileHandlingConfiguration(null, null, null);
    config.setBaseRemotePath("SIIG");
    config.setInputRemotePath("Acquisiti");
    config.setSuccesRemotePath("Elaborati");
    config.setFailRemotePath("Scarti");
    FTPActionConfiguration ftpConfig = new FTPActionConfiguration(null, null,
            null);
    ftpConfig.setFtpserverHost("localhost");
    ftpConfig.setFtpserverUSR("user");
    ftpConfig.setFtpserverPWD("password");
    ftpConfig.setTimeout(100);
    ftpConfig.setConnectMode(FTPConnectMode.ACTIVE);
    ftpConfig.setFtpserverPort(fakeFtpPort);
    config.setFtpConfiguration(ftpConfig);
    config.setIgnorePks(Boolean.TRUE);
}

/**
 * Run {@link GateFileHandlingAction} with two files that will fail only to
 * check if the remote file browsing it's ok
 * 
 * @throws Exception
 */
@Test
public void testTwoErrors() throws Exception {
    GateFileHandlingAction gateFileHandlingAction = new GateFileHandlingAction(
            config);
    gateFileHandlingAction.doProcess(config, null, null);
    //
    final com.enterprisedt.net.ftp.FTPConnectMode connectMode = config
            .getFtpConfiguration()
            .getConnectMode()
            .toString()
            .equalsIgnoreCase(
                    com.enterprisedt.net.ftp.FTPConnectMode.ACTIVE.toString()) ? com.enterprisedt.net.ftp.FTPConnectMode.ACTIVE
            : com.enterprisedt.net.ftp.FTPConnectMode.PASV;

    // files must be on fail directory
    FTPFile[] files = FTPHelperBare.dirDetails(config.getFtpConfiguration()
            .getFtpserverHost(),
            config.getBaseRemotePath() + "/" + config.getFailRemotePath(), "/",
            config.getFtpConfiguration().getFtpserverUSR(), config
                    .getFtpConfiguration().getFtpserverPWD(), config
                    .getFtpConfiguration().getFtpserverPort(),
            FTPTransferType.BINARY, WriteMode.OVERWRITE, connectMode, config
                    .getFtpConfiguration().getTimeout());
    assertTrue(files.length == 2);

    // success dir must be empty
    files = FTPHelperBare.dirDetails(config.getFtpConfiguration()
            .getFtpserverHost(),
            config.getBaseRemotePath() + "/" + config.getSuccesRemotePath(),
            "/", config.getFtpConfiguration().getFtpserverUSR(), config
                    .getFtpConfiguration().getFtpserverPWD(), config
                    .getFtpConfiguration().getFtpserverPort(),
            FTPTransferType.BINARY, WriteMode.OVERWRITE, connectMode, config
                    .getFtpConfiguration().getTimeout());
    assertTrue(files.length == 0);

    // input dir must be empty
    files = FTPHelperBare.dirDetails(config.getFtpConfiguration()
            .getFtpserverHost(),
            config.getBaseRemotePath() + "/" + config.getInputRemotePath(),
            "/", config.getFtpConfiguration().getFtpserverUSR(), config
                    .getFtpConfiguration().getFtpserverPWD(), config
                    .getFtpConfiguration().getFtpserverPort(),
            FTPTransferType.BINARY, WriteMode.OVERWRITE, connectMode, config
                    .getFtpConfiguration().getTimeout());
    assertTrue(files.length == 0);
}

/**
 * Stop FTP fake server
 */
@After
public void tearDown() {
    fakeFtpServer.stop();
}

}
