/*
 *  Copyright (C) 2007 - 2013 GeoSolutions S.A.S.
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
package it.geosolutions.geobatch.destination.ingestion.gate.model;

import static org.junit.Assert.assertEquals;
import it.geosolutions.geobatch.destination.common.utils.TimeUtils;

import org.joda.time.DateTimeZone;
import org.junit.Test;

/**
 * Test Joda time formatter
 * 
 * @author adiaz
 */
public class JodaTimeTest {

/**
 * Test if the formatter run correctly between String and milliseconds
 */
@Test
public void testJodaTime() {
    String stringDate = "2013-12-18T13:26:09+00:00";
    long millis = TimeUtils.getDefaultFormatter().parseMillis(stringDate);
    DateTimeZone zone = TimeUtils.getDefaultFormatter().parseDateTime(stringDate).getZone();
    assertEquals(stringDate, TimeUtils.getDefaultFormatter().withZone(zone).print(millis));
    stringDate = "2013-12-18T13:20:45+00:00";
    zone = TimeUtils.getDefaultFormatter().parseDateTime(stringDate).getZone();
    millis = TimeUtils.getDefaultFormatter().parseMillis(stringDate);
    assertEquals(stringDate, TimeUtils.getDefaultFormatter().withZone(zone).print(millis));
}


/**
 * Test zones
 */
@Test
public void testJodaZones() {
    // now it's activated UTC zone
    String stringDate = "2013-12-18T13:26:09+02:00";
    DateTimeZone zone = TimeUtils.getDefaultFormatter().parseDateTime(stringDate).getZone();
    assertEquals(TimeUtils.getHour(zone), 0);
    assertEquals(TimeUtils.getMinutes(zone), 0);
    /* if disable UTC zone, you need to fix:
    String stringDate = "2013-12-18T13:26:09+02:00";
    DateTimeZone zone = TimeUtils.getDefaultFormatter().parseDateTime(stringDate).getZone();
    assertEquals(TimeUtils.getHour(zone), 2);
    assertEquals(TimeUtils.getMinutes(zone), 0);
    stringDate = "2013-12-18T13:26:09+02:30";
    zone = TimeUtils.getDefaultFormatter().parseDateTime(stringDate).getZone();
    assertEquals(TimeUtils.getHour(zone), 2);
    assertEquals(TimeUtils.getMinutes(zone), 30);
    */
}

}
