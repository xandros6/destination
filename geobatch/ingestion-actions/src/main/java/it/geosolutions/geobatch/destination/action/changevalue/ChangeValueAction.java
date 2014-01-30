package it.geosolutions.geobatch.destination.action.changevalue;

import it.geosolutions.geobatch.actions.ds2ds.dao.FeatureConfiguration;
import it.geosolutions.geobatch.actions.ds2ds.util.FeatureConfigurationUtil;
import it.geosolutions.geobatch.annotations.Action;
import it.geosolutions.geobatch.destination.action.DestinationBaseAction;
import it.geosolutions.geobatch.destination.ingestion.ChangeValueProcess;
import it.geosolutions.geobatch.destination.ingestion.MetadataIngestionHandler;
import it.geosolutions.geobatch.flow.event.action.ActionException;

import java.io.File;
import java.io.IOException;

import org.geotools.data.DataStore;
import org.geotools.data.DefaultTransaction;
import org.geotools.data.Transaction;
import org.geotools.jdbc.JDBCDataStore;

@Action(configurationClass = ChangeValueConfiguration.class)
public class ChangeValueAction extends DestinationBaseAction<ChangeValueConfiguration> {


	public ChangeValueAction(ChangeValueConfiguration actionConfiguration) throws IOException {
		super(actionConfiguration);
	}

	@Override
	protected void doProcess(ChangeValueConfiguration cfg,
			FeatureConfiguration featureCfg, JDBCDataStore dataStore,
			MetadataIngestionHandler metadataHandler, File file) throws ActionException {
		Transaction transaction = new DefaultTransaction();
		try{
			DataStore configurationDataStore = FeatureConfigurationUtil.createDataStore(cfg.getOutputFeature());
			ChangeValueProcess changeValueProcess = new ChangeValueProcess(configurationDataStore, transaction, cfg.getOutputFeature().getTypeName(), cfg.getId());
			changeValueProcess.execute(cfg.getFilter(),cfg.getAttribute(),cfg.getValue());
			transaction.commit();
		} catch (Exception ex) {
			LOGGER.error(ex.getMessage(),ex);
			try{ transaction.rollback();} catch (IOException exr) {LOGGER.error(exr.getMessage(),exr);}
		}finally{
			try{ transaction.close();} catch (IOException exr) {LOGGER.error(exr.getMessage(),exr);}
		}
	}


}