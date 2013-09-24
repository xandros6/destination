package it.geosolutions.geobatch.destination.streetuser;

import java.util.ArrayList;
import java.util.List;

public class StreetDistance {
	private Integer idDistanza;
	private Integer distanza;
	private List<StreetInfo> streetsInfo = new ArrayList<StreetInfo>();
	
	public StreetDistance(Integer idDistanza, Integer distanza) {
		super();
		this.idDistanza = idDistanza;
		this.distanza = distanza;
	}
	public Integer getDistanza() {
		return distanza;
	}
	public void setDistanza(Integer distanza) {
		this.distanza = distanza;
	}
	public Integer getIdDistanza() {
		return idDistanza;
	}
	public void setIdDistanza(Integer idDistanza) {
		this.idDistanza = idDistanza;
	}
	public void addStreetInfo(StreetInfo info) {
		this.streetsInfo.add(info);
	}
	public List<StreetInfo> getStreetsInfo() {
		return streetsInfo;
	}
	
	
}
