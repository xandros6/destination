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
import org.joda.time.DateTimeZone;
import org.joda.time.format.DateTimeFormatter;

/**
 * Time utilities using JodaTime
 * 
 * @author adiaz
 */
public class TimeUtils {

// Date/ time parameters
private static final int MILLISECONDS_PER_HOUR = 3600000;
private static final int MILLISECONDS_PER_MINUTE = 60000;
private static String defaultFormatter = "yyyy-MM-dd'T'HH:mm:ssZZ";
private static String dayFormatter = "yyyy-MM-dd";

/**
 * Change if you prefer to use local UTC
 */
private static boolean USE_UTC = true;

/**
 * @return default formatter for the time
 */
public static DateTimeFormatter getDefaultFormatter() {
    return USE_UTC ? org.joda.time.format.DateTimeFormat.forPattern(
            defaultFormatter).withZoneUTC()
            : org.joda.time.format.DateTimeFormat.forPattern(defaultFormatter);
}

/**
 * @return formatter for a day
 */
public static DateTimeFormatter getDayFormatter() {
    return org.joda.time.format.DateTimeFormat.forPattern(dayFormatter);
}

/**
 * Obtain hour offset of the zone
 * 
 * @param date to obtain it
 * @return hour offset
 */
public static int getHour(DateTime date) {
    DateTimeZone zone = date.getZone();
    return getHour(zone);
}

/**
 * Obtain minutes offset of the zone (need to be conbined with
 * {@link TimeUtils#getHour(DateTime)})
 * 
 * @param date to obtain it
 * @return minutes offset
 */
public static int getMinutes(DateTime date) {
    DateTimeZone zone = date.getZone();
    return getMinutes(zone);
}

/**
 * Obtain hour offset of the zone
 * 
 * @param zone to obtain it
 * @return hour offset
 */
public static int getHour(DateTimeZone zone) {
    return (int) Math.floor(zone.getStandardOffset(0) / MILLISECONDS_PER_HOUR);
}

/**
 * Obtain minutes offset of the zone (need to be conbined with
 * {@link TimeUtils#getHour(DateTimeZone)})
 * 
 * @param zone to obtain it
 * @return minutes offset
 */
public static int getMinutes(DateTimeZone zone) {
    return (zone.getStandardOffset(0) - (getHour(zone) * MILLISECONDS_PER_HOUR))
            * MILLISECONDS_PER_MINUTE;
}

/**
 * Check if the time start with the date of today
 * 
 * @param time in a string format starting with a getDayFormatter()
 * @return
 */
public static boolean isToday(String time) {
    DateTime now = new DateTime();
    boolean isToday = false;
    if (time.startsWith(now.toString(TimeUtils.getDayFormatter()))) {
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
    return date != null ? new Timestamp(getDefaultFormatter().parseMillis(date))
            : null;
}

/**
 * @return String representation for now in timestamp
 */
public static String getTodayTimestamp() {
    DateTime now = new DateTime();
    return (new Timestamp(getDefaultFormatter().parseMillis(
            now.toString(getDefaultFormatter())))).toString();
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
    return (new Timestamp(getDefaultFormatter().parseMillis(
            getTodayStart().toString(getDefaultFormatter()))));
}

/**
 * @return start time of the day one month ago
 */
public static Timestamp getMonthStartTime() {
    return (new Timestamp(getDefaultFormatter().parseMillis(
            getTodayStart().minusMonths(1).toString(getDefaultFormatter()))));
}

/**
 * @return start time of the day one year ago
 */
public static Timestamp getYearStartTime() {
    return (new Timestamp(getDefaultFormatter().parseMillis(
            getTodayStart().minusYears(1).toString(getDefaultFormatter()))));
}

/**
 * @return start time tomorrow (0:00:00:00)
 */
public static Timestamp getTodayEndTime() {
    return (new Timestamp(getDefaultFormatter().parseMillis(
            getTodayStart().plusDays(1).toString(getDefaultFormatter()))));
}

/**
 * @return start time for the day one week ago
 */
public static Timestamp getWeekStartTime() {
    return (new Timestamp(getDefaultFormatter().parseMillis(
            getTodayStart().minusWeeks(1).toString(getDefaultFormatter()))));
}

}
