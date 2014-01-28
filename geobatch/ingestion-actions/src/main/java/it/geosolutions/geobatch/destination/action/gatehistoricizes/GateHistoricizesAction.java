package it.geosolutions.geobatch.destination.action.gatehistoricizes;

import it.geosolutions.geobatch.actions.ds2ds.Ds2dsAction;
import it.geosolutions.geobatch.annotations.Action;

import java.io.IOException;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

@Action(configurationClass = GateHistoricizesConfiguration.class)
public class GateHistoricizesAction extends Ds2dsAction {

	static GateHistoricizesConfiguration preprocessEcqlFilter(GateHistoricizesConfiguration configuration) {
		DateTimeFormatter fmt = ISODateTimeFormat.dateTime();		
		DateTime testDate = DateTime.now().minusYears(configuration.getBeforeYear()).minusMonths(configuration.getBeforeMonth()).minusDays(configuration.getBeforeDay());
		String ecqlFilter = "data_rilevamento BEFORE " + fmt.print(testDate);				
		configuration.setEcqlFilter(ecqlFilter);		
		return configuration;
	}

	public GateHistoricizesAction(GateHistoricizesConfiguration configuration) throws IOException {		
		super(preprocessEcqlFilter(configuration));	
	}

}

