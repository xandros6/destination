package it.geosolutions.geobatch.destination.action.rasterize;

import it.geosolutions.geobatch.configuration.event.action.ActionConfiguration;

public class RasterizeConfiguration extends ActionConfiguration {

	public RasterizeConfiguration(String id, String name, String description) {
		super(id, name, description);
		// TODO Auto-generated constructor stub
	}

	@Override
	public RasterizeConfiguration clone() {
		final RasterizeConfiguration configuration = (RasterizeConfiguration) super.clone();

		return configuration;
	}
	
	private String baseOutputPath;

	public String getBaseOutputPath() {
		return baseOutputPath;
	}

	public void setBaseOutputPath(String baseOutputPath) {
		this.baseOutputPath = baseOutputPath;
	}
	
	

}
