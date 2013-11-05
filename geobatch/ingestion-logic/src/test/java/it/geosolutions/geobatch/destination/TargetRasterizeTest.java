package it.geosolutions.geobatch.destination;

import it.geosolutions.geobatch.destination.rasterize.TargetRasterizeProcess;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;
import it.geosolutions.geobatch.task.TaskExecutorConfiguration;

import java.io.File;

import org.apache.commons.io.FileUtils;
import org.geotools.util.logging.Logging;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TargetRasterizeTest {

	private static final Logger LOGGER = LoggerFactory.getLogger(StreetUserTest.class);
	private TaskExecutorConfiguration taskExecutorConfiguration;

	static{
		try {
			Logging.ALL.setLoggerFactory("org.geotools.util.logging.Log4JLoggerFactory");
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
		}
	}

	@Before
	public void before() throws Exception { 

	};

	@Test
	public void rasterizeBNU(){
		try {
			ClassLoader classLoader = getClass().getClassLoader();
			File xmlFile = new File(classLoader.getResource("rasterizeBNU.xml").getFile());

			File configDir = new File(System.getenv("GEOBATCH_CONFIG_DIR")+"/targetrunner/raster_processing/");

			File outputDir = new File(System.getProperty("java.io.tmpdir")+"/RASTERIZE_OUTPUT");
			if(outputDir.exists()){
				FileUtils.deleteDirectory(outputDir);
			}
			outputDir.mkdir();

			TargetRasterizeProcess targetRasterizeProcess = new TargetRasterizeProcess(
					"BZ_BNU-ASOTT_C_20130521_02", new ProgressListenerForwarder(null),
					null, null);
			targetRasterizeProcess.execute(configDir,new File(System.getProperty("java.io.tmpdir")),outputDir,xmlFile);

		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
			Assert.assertFalse(true);
		}
	}

	@Test
	public void rasterizeBU(){
		try {
			ClassLoader classLoader = getClass().getClassLoader();
			File xmlFile = new File(classLoader.getResource("rasterizeBU.xml").getFile());

			File configDir = new File(System.getenv("GEOBATCH_CONFIG_DIR")+"/targetrunner/raster_processing/");

			File outputDir = new File(System.getProperty("java.io.tmpdir")+"/RASTERIZE_OUTPUT");
			if(outputDir.exists()){
				outputDir.delete();
			}
			outputDir.mkdir();

			TargetRasterizeProcess targetRasterizeProcess = new TargetRasterizeProcess(
					"BZ_BU-ASCOL_C_20130531_01", new ProgressListenerForwarder(null),
					null, null);
			targetRasterizeProcess.execute(configDir,new File(System.getProperty("java.io.tmpdir")),outputDir,xmlFile);
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
			Assert.assertFalse(true);
		}
	}

}
