package it.geosolutions.geobatch.destination.streetuser.configuration;

import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration;

import java.io.InputStream;

import com.thoughtworks.xstream.XStream;

public class StreetUserConfiguration extends FeatureConfiguration{

	private static final XStream xstream = new XStream();

	static {
		xstream.alias("feature", StreetUserConfiguration.class);                                                     
	}

	public static StreetUserConfiguration fromXML(InputStream inputXML) {
		return (StreetUserConfiguration) xstream.fromXML(inputXML);                
	}
}
