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

//import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration;
import it.geosolutions.geobatch.destination.common.utils.SequenceManager;
import it.geosolutions.geobatch.destination.commons.DestinationMemoryTest;
import it.geosolutions.geobatch.destination.ingestion.ArcsIngestionProcess;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;

import org.junit.Before;
import org.junit.Test;

/**
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class RoadArcTest extends DestinationMemoryTest{

	private static final String sampleInput = "BZ_C_Grafo_20130917";

	@Before
	public void before() throws Exception { 	
		initTestWithData(new String[] {"arcs_test_data"});
	}

	@Test
	public void testLevel1() throws IOException {
		ArcsIngestionProcess arcIngestion = createProcess();

		arcIngestion.importArcs(null, 1, false, false, null);

		checkFeature("siig_geo_ln_arco_1", 3);
		checkFeature("siig_r_tipovei_geoarco1", 6);
		checkFeature("siig_r_arco_1_dissesto", 6);
		checkFeature("siig_r_arco_1_scen_tipobers", 39);
		checkFeature("siig_r_arco_1_sostanza", 30);
	}

	@Test
	public void testLevel2() throws IOException {
		ArcsIngestionProcess arcIngestion = createProcess();

		arcIngestion.importArcs(null, 2, false, false, null);

		checkFeature("siig_geo_ln_arco_2", 2);
		checkFeature("siig_r_tipovei_geoarco2", 4);
		checkFeature("siig_r_arco_2_dissesto", 6);
		checkFeature("siig_r_arco_2_scen_tipobers", 26);
		checkFeature("siig_r_arco_2_sostanza", 20); 
	}

	@Test
	public void testLevel3() throws IOException {
		ArcsIngestionProcess arcIngestion = createProcess();

		arcIngestion.importArcs(null, 3, false, false, null);

		checkFeature("siig_geo_ln_arco_3", 1);
		checkFeature("siig_r_tipovei_geoarco3", 2);
		checkFeature("siig_r_arco_3_dissesto", 0);
		checkFeature("siig_r_arco_3_scen_tipobers", 0);
		checkFeature("siig_r_arco_3_sostanza", 0); 
	}

	@Test
	public void testGridLevel3() throws IOException {
		ArcsIngestionProcess arcIngestion = createProcess();

		arcIngestion.importArcs(null, 3, true, false, null);

		checkFeature("siig_geo_pl_arco_3", 1);
		checkFeature("siig_r_tipovei_geoarco3", 0);
		checkFeature("siig_r_arco_3_dissesto", 3);
		checkFeature("siig_r_arco_3_scen_tipobers", 13);
		checkFeature("siig_r_arco_3_sostanza", 10); 
	}



	/**
	 * @return
	 */
	private ArcsIngestionProcess createProcess() {
		ArcsIngestionProcess process = new ArcsIngestionProcess(sampleInput,
				new ProgressListenerForwarder(null), metadataHandler, dataStore);
		process.setSequenceManager(new SequenceManager(dataStore, "") {
			int value = 1;
			@Override
			public long retrieveValue() throws IOException {
				return value++;
			}

		});
		return process;
	}

	@Override
	protected void checkData() {
		// TODO Auto-generated method stub
		
	}

	/*
	@Test  @Ignore
	public void testImportArcs() throws IOException {
		String input = "D:\\Develop\\GEOBATCH_CONFIG\\temp\\importBersagliVettoriali\\20130402-080846-028\\0_Ds2dsGeneratorService\\output.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		ArcsIngestionProcess arc = new ArcsIngestionProcess(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {

			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub

			}

			@Override
			public String getId() {
				return "id";
			}
		}));

		arc.importArcs(cfg.getDataStore(), null, 1, false, false, null);

	}

	@Test  @Ignore
	public void testRemoveZeros() throws IOException {
		String input = "D:\\Develop\\arcsoutput.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		ArcsIngestionProcess arc = new ArcsIngestionProcess(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {

			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub

			}

			@Override
			public String getId() {
				return "id";
			}
		}));

//		arc.removeZeros(cfg.getDataStore(), null, 1, false, false);

	}

	@Test  @Ignore
	public void testAggregateArcs() throws IOException {
		String input = "D:\\Develop\\GEOBATCH_CONFIG\\temp\\importBersagliVettoriali\\20130402-080846-028\\0_Ds2dsGeneratorService\\output.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		ArcsIngestionProcess arc = new ArcsIngestionProcess(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {

			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub

			}

			@Override
			public String getId() {
				return "id";
			}
		}));

		arc.importArcs(cfg.getDataStore(), null, 2, false, false, null);

	}

	@Test  @Ignore
	public void testAggregateGrid() throws IOException {
		String input = "D:\\Develop\\GEOBATCH_CONFIG\\temp\\importBersagliVettoriali\\20130402-080846-028\\0_Ds2dsGeneratorService\\output.xml";
		FeatureConfiguration cfg = FeatureConfiguration.fromXML(new FileInputStream(input));
		ArcsIngestionProcess arc = new ArcsIngestionProcess(cfg.getTypeName(), new ProgressListenerForwarder(new Identifiable() {

			@Override
			public void setId(String arg0) {
				// TODO Auto-generated method stub

			}

			@Override
			public String getId() {
				return "id";
			}
		}));

		arc.importArcs(cfg.getDataStore(), null, 3, true, false, null);

	}*/
}
