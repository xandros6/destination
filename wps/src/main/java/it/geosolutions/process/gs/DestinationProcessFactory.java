package it.geosolutions.process.gs;

import org.geotools.process.factory.AnnotatedBeanProcessFactory;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.text.Text;

/**
 * Factory providing a number of processes for working with feature data.
 * <p>
 * Internally this factory makes use of the information provided by
 * the {@link DescribeProcess} annotations to produce the correct
 * process description.
 * 
 * @author Jody Garnett (LISAsoft)
 *
 * @source $URL$
 */
public class DestinationProcessFactory extends AnnotatedBeanProcessFactory {

    public DestinationProcessFactory() {
        super(Text.text("Destination Process Factory"), "ds",
                NotHumanBuffer.class,
                HumanBuffer.class);
    }

}
