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
package it.geosolutions.geobatch.destination.common.utils;

import java.sql.Timestamp;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;

/**
 * Time utilities using JodaTime
 * 
 * @author adiaz
 */
public class TimeUtils {

/**
 * Default formatter for the time
 */
public static final DateTimeFormatter DEFAULT_FORMATTER = org.joda.time.format.DateTimeFormat
        .forPattern("yyyy-MM-dd'T'HH:mm:ss'Z'").withZoneUTC();

/**
 * Formatter for the day
 */
public static final DateTimeFormatter DAY_FORMATTER = org.joda.time.format.DateTimeFormat
        .forPattern("yyyy-MM-dd").withZoneUTC();

/**
 * Check if the time start with the date of today
 * 
 * @param time in a string format starting with a DAY_FORMATTER
 * @return
 */
public static boolean isToday(String time) {
    DateTime now = new DateTime();
    boolean isToday = false;
    if (time.startsWith(now.toString(TimeUtils.DAY_FORMATTER))) {
        isToday = true;
    }
    return isToday;
}

/**
 * Obtain a time stamp for a input sting with the default format
 * 
 * @param date
 * @return
 */
public static Timestamp getTimeStamp(String date) {
    return date != null ? new Timestamp(DEFAULT_FORMATTER.parseMillis(date))
            : null;
}

/**
 * @return String representation for now in timestamp
 */
public static String getTodayTimestamp() {
    DateTime now = new DateTime();
    return (new Timestamp(DEFAULT_FORMATTER.parseMillis(now
            .toString(DEFAULT_FORMATTER)))).toString();
}

/**
 * @return start time (one day ago)
 */
public static DateTime getTodayStart() {
    DateTime now = new DateTime();
    return now.minusDays(1);
}

/**
 * @return start time for today Timestamp
 */
public static Timestamp getTodayStartTime() {
    return (new Timestamp(DEFAULT_FORMATTER.parseMillis(getTodayStart()
            .toString(DEFAULT_FORMATTER))));
}

/**
 * @return start time of the day one month ago
 */
public static Timestamp getMonthStartTime() {
    return (new Timestamp(DEFAULT_FORMATTER.parseMillis(getTodayStart().minusMonths(1)
            .toString(DEFAULT_FORMATTER))));
}

/**
 * @return start time of the day one year ago
 */
public static Timestamp getYearStartTime() {
    return (new Timestamp(DEFAULT_FORMATTER.parseMillis(getTodayStart().minusYears(1)
            .toString(DEFAULT_FORMATTER))));
}

/**
 * @return start time tomorrow (0:00:00:00)
 */
public static Timestamp getTodayEndTime() {
    return (new Timestamp(DEFAULT_FORMATTER.parseMillis(getTodayStart().plusDays(1)
            .toString(DEFAULT_FORMATTER))));
}

/**
 * @return start time for the day one week ago
 */
public static Timestamp getWeekStartTime() {
    return (new Timestamp(DEFAULT_FORMATTER.parseMillis(getTodayStart().minusWeeks(1)
            .toString(DEFAULT_FORMATTER))));
}

}
