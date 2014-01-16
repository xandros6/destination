package it.geosolutions.peoplecalculator;

import org.apache.commons.cli.BasicParser;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.MissingOptionException;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Hello world!
 *
 */
public class App {

	static final Logger logger = LoggerFactory.getLogger(App.class);

	@SuppressWarnings("static-access")
	public static void main( String[] args ){
		HelpFormatter f = new HelpFormatter();
		Options opt = new Options();
		try {


			Option shpP   = OptionBuilder.withArgName( "file" )
					.hasArg()
					.isRequired()
					.withDescription(  "The shapefile with point geometry" )
					.create( "shpP" );
			opt.addOption(shpP);

			Option fIn   = OptionBuilder.withArgName( "field" )
					.hasArg()
					.isRequired()
					.withDescription(  "Numeric field name in point geometry shapefile" )
					.create( "fIn" );
			opt.addOption(fIn);

			Option shpA   = OptionBuilder.withArgName( "file" )
					.hasArg()
					.isRequired()
					.withDescription(  "The shapefile with area geometry" )
					.create( "shpA" );
			opt.addOption(shpA);

			Option fOut   = OptionBuilder.withArgName( "field" )
					.hasArg()
					.isRequired()
					.withDescription(  "Numeric field name to add/update in output shapefile" )
					.create( "fOut" );
			opt.addOption(fOut);

			Option dirOut   = OptionBuilder.withArgName( "path" )
					.hasArg()
					.withDescription(  "Output folder" )
					.create( "dirOut" );
			opt.addOption(dirOut);

			Option dMax   = OptionBuilder.withArgName( "integer" )
					.hasArg().withType(Integer.class)
					.withDescription(  "Maximum disance as integer meters (default 10 m)" )
					.create( "dMax" );
			opt.addOption(dMax);

			opt.addOption("h", false, "Print this help");

			BasicParser parser = new BasicParser();
			CommandLine cl = parser.parse(opt, args);

			if ( cl.getOptions().length == 0  || cl.hasOption('h') ) {
				f.printHelp("peoplecalculator", opt);				
			}else {
				logger.info("START");
				String pointShp = cl.getOptionValue("shpP");
				String inputField = cl.getOptionValue("fIn");
				String areaShp = cl.getOptionValue("shpA");
				String outputFeild = cl.getOptionValue("fOut");
				Integer maxDsitance = cl.getOptionValue("dMax")!=null ? new Integer(Integer.parseInt(cl.getOptionValue("dMax"))):null;
				String outputDir =  cl.getOptionValue("dirOut");
				InputData inputData = new InputData(areaShp, pointShp, inputField, outputFeild, outputDir, maxDsitance);
				ShpProcessor.getInstance().compute(inputData);
				logger.info("DONE");
			}
		}catch (ParseException e) {
			if(e instanceof MissingOptionException){
				logger.info(e.getLocalizedMessage());
				f.printHelp("peoplecalculator", opt);
			}else{
				logger.error(e.getMessage(),e);
			}
		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}finally {
		
		}
	}
}
