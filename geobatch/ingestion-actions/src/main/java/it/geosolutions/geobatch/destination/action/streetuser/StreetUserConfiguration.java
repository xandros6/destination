package it.geosolutions.geobatch.destination.action.streetuser;

import it.geosolutions.geobatch.configuration.event.action.ActionConfiguration;

public class StreetUserConfiguration extends ActionConfiguration {

    private int aggregationLevel;
	
	public StreetUserConfiguration(String id, String name, String description) {
		super(id, name, description);
	}

	public int getAggregationLevel() {
		return aggregationLevel;
	}

	public void setAggregationLevel(int aggregationLevel) {
		this.aggregationLevel = aggregationLevel;
	}
	
    @Override
    public StreetUserConfiguration clone() {
        final StreetUserConfiguration configuration = (StreetUserConfiguration) super.clone();
        
        return configuration;
    }
	
	

}
