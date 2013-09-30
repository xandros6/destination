/*
 *  Copyright (C) 2007 - 2012 GeoSolutions S.A.S.
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

import org.junit.Test;

/**
 *
 * @author ETj (etj at geo-solutions.it)
 */
public class CSVIngestActionTest extends BaseContextTest {

    public CSVIngestActionTest() {
    }

    /**
     * Test of execute method, of class CSVIngestAction.
     */
    @Test
    public void testExecute() throws Exception {

//        Queue<EventObject> events = new LinkedList<EventObject>();
//        File cropFile = loadFile("testdata/cropdistr.csv");
//        assertNotNull(cropFile);
//
//        { // create FK crop descriptor
//            CropDescriptor cd = new CropDescriptor();
//            cd.setId("crop0");
//            cd.setLabel("label0");
//            cd.setSeasons(Season.KHARIF);
//            cropDescriptorDAO.persist(cd);
//        }
//
//        FileSystemEvent event = new FileSystemEvent(cropFile, FileSystemEventType.FILE_ADDED);
//        events.add(event);
//
//        CSVIngestAction action = new CSVIngestAction(new CSVIngestConfiguration(null, null, null));
//        action.setCropDataDao(cropDataDAO);
//        action.setCropDescriptorDao(cropDescriptorDAO);
//        action.afterPropertiesSet();
//
//        Queue result = action.execute(events);
//
//        assertEquals(1, cropDataDAO.count(null));
    }



}