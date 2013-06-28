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
package it.geosolutions.geobatch.destination;

import it.geosolutions.geobatch.destination.ingestion.ArcsIngestionProcess;
import it.geosolutions.geobatch.flow.event.ProgressListenerForwarder;

import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;

/**
 * @author DamianoG
 * 
 */
public class RoadArcsTest {

    @Test @Ignore
    public void testImportTarget() throws IOException {

        Map<String, Serializable> datastoreParams = new HashMap<String, Serializable>();
        datastoreParams.put("port", 5432);
        datastoreParams.put("schema", "siig_p");
        datastoreParams.put("passwd", "siig_p");
        datastoreParams.put("dbtype", "postgis");
        datastoreParams.put("host", "192.168.88.132");
        datastoreParams.put("Expose primary keys", "true");
        datastoreParams.put("user", "siig_p");
        datastoreParams.put("database", "destination_staging");
        ArcsIngestionProcess arcsImport = new ArcsIngestionProcess("RP_C_Grafo_20130424",
                new ProgressListenerForwarder(null));
        try {
            arcsImport.importArcs(datastoreParams, null, 3, true, false);
        } catch (IOException e) {
        }
    }
}
