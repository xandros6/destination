package it.geosolutions.peoplecalculator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class InputData {
	
	static final Logger logger = LoggerFactory.getLogger(ShpProcessor.class);

	private String pointShp;
	private String inputField;
	private String areaShp;
	private String outputFeild;
	private String outputDir;
	private Integer maxDsitance = Constant.DEFAULT_DISTANCE;
	
	public InputData(String areaShp, String pointShp, String inputField,
			String outputFeild, String outputDir, Integer maxDsitance) {
		super();
		this.areaShp = areaShp;
		this.pointShp = pointShp;
		this.inputField = inputField;
		this.outputFeild = outputFeild;
		this.outputDir = outputDir;
		if(maxDsitance != null){
			this.maxDsitance = maxDsitance;
		}
	}	
	
	public String getOutputDir() {
		return outputDir;
	}
	
	public String getPointShp() {
		return pointShp;
	}

	public String getInputField() {
		return inputField;
	}

	public String getAreaShp() {
		return areaShp;
	}

	public String getOutputFeild() {
		return outputFeild;
	}

	public Integer getMaxDsitance() {
		return maxDsitance;
	}

}
