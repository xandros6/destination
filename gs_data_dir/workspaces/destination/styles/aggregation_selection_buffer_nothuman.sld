<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>Default Line</Name>
    <UserStyle>
      <Title>Aree Danno (Bersagli umani)</Title>
      <Abstract>Default line style, 1 pixel wide blue</Abstract>

      <FeatureTypeStyle>
        <Transformation>
            <ogc:Function name="ds:MultipleBuffer">
              <ogc:Function name="parameter">
                <ogc:Literal>features</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>distance</ogc:Literal>
                <ogc:Function name="env">
                   <ogc:Literal>distance</ogc:Literal>
                </ogc:Function>
                
              </ogc:Function>
             
            </ogc:Function>
          </Transformation>
        <Rule>
          <Title>Area di Danno
            <Localized lang="it">Area di Danno</Localized>
            <Localized lang="en">Damage Area</Localized>
            <Localized lang="fr">Area di Danno</Localized>
            <Localized lang="de">Area di Danno</Localized>
          </Title>
          <Abstract>Buffer per Rischio Incidentale</Abstract>
          <MaxScaleDenominator>17070</MaxScaleDenominator>
          <PolygonSymbolizer>
           
            <Fill>
              <CssParameter name="fill">#5C3B03</CssParameter>
              <CssParameter name="fill-opacity">0.8</CssParameter>
            </Fill>
          </PolygonSymbolizer>
          
        </Rule>

        
        
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>