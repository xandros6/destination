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
package it.geosolutions.destination.utils;

public class FormulaCriteria {
	private int id;
	private boolean required;
	private boolean aggregate;
	/**
	 * @param id
	 * @param required
	 * @param aggregate
	 */
	public FormulaCriteria(int id, boolean required, boolean aggregate) {
		super();
		this.id = id;
		this.required = required;
		this.aggregate = aggregate;
	}
	/**
	 * @return the required
	 */
	public boolean isRequired() {
		return required;
	}
	/**
	 * @return the aggregate
	 */
	public boolean isAggregate() {
		return aggregate;
	}
	
	
}