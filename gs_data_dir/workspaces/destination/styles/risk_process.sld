<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>Default Line</Name>
    <UserStyle>
      <Title>Rischio</Title>
      <Abstract>Default line style, 1 pixel wide blue</Abstract>

      <FeatureTypeStyle>
        <Transformation>
            <ogc:Function name="gs:RiskCalculator">
              <ogc:Function name="parameter">
                <ogc:Literal>features</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>store</ogc:Literal>
                <ogc:Literal>destination</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>level</ogc:Literal>
                <ogc:Literal>1</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>formula</ogc:Literal>
                <ogc:Literal>16</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>target</ogc:Literal>
                <ogc:Literal>0</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>materials</ogc:Literal>
                <ogc:Literal>1,4</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>scenarios</ogc:Literal>
                <ogc:Literal>4,5</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>entities</ogc:Literal>
                <ogc:Literal>0,1</ogc:Literal>
              </ogc:Function>
             <ogc:Function name="parameter">
                <ogc:Literal>severeness</ogc:Literal>
                <ogc:Literal>1,2,3,4,5</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>fp</ogc:Literal>
                <ogc:Literal>fp_scen_centrale</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>processing</ogc:Literal>
                <ogc:Literal>1</ogc:Literal>
              </ogc:Function>
            </ogc:Function>
          </Transformation>
        <Rule>
          <Title>Rischio
            <Localized lang="it">Rischio</Localized>
            <Localized lang="en">Risk</Localized>
            <Localized lang="fr">Rischio</Localized>
            <Localized lang="de">Rischio</Localized>          
          </Title>
          <Abstract>Rischio Incidentale</Abstract>
          
          <LineSymbolizer>
           
            <Stroke>
              <CssParameter name="stroke">#5C3B03</CssParameter>
              <CssParameter name="stroke-width">5</CssParameter>
            </Stroke>
          </LineSymbolizer>
          
        </Rule>

        
        
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>