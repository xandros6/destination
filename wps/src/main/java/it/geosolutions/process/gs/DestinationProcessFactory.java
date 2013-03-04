package it.geosolutions.process.gs;

import org.geotools.process.factory.AnnotatedBeanProcessFactory;
import org.geotools.process.factory.DescribeProcess;
import org.geotools.text.Text;

/**
 * Factory providing some buffer creating operations.
 * <p>
 * Internally this factory makes use of the information provided by
 * the {@link DescribeProcess} annotations to produce the correct
 * process description.
 * 
 * @author "Mauro Bartolomeoli - mauro.bartolomeoli@geo-solutions.it"
 *
 */
public class DestinationProcessFactory extends AnnotatedBeanProcessFactory {

    public DestinationProcessFactory() {
        super(Text.text("Destination Process Factory"), "ds",
                NotHumanBuffer.class,
                HumanBuffer.class);
    }

}
