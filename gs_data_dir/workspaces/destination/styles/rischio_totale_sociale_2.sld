<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>Default Line</Name>
    <UserStyle>
      <Title>1 px blue line</Title>
      <Abstract>Default line style, 1 pixel wide blue</Abstract>

      <FeatureTypeStyle>
        <Rule>
          <Title>Basso Rischio
    <Localized lang="it">Basso Rischio</Localized>
      <Localized lang="en">Low Risk</Localized>
      <Localized lang="fr">Basso Rischio</Localized>
      <Localized lang="de">Basso Rischio</Localized>
  </Title>
          <Abstract>Linea per Basso Rischio Incidentale</Abstract>
          <ogc:Filter>
              <ogc:PropertyIsLessThanOrEqualTo>
                   <ogc:PropertyName>rischio</ogc:PropertyName>
                   <ogc:Function name="env">
                       <ogc:Literal>low</ogc:Literal>
                    </ogc:Function>
              </ogc:PropertyIsLessThanOrEqualTo>
          </ogc:Filter>
          <MinScaleDenominator>17070</MinScaleDenominator>
          <MaxScaleDenominator>500000</MaxScaleDenominator>
          <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <Stroke>
              <CssParameter name="stroke">#14F200</CssParameter>
              <CssParameter name="stroke-width">12</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>

        <Rule>
          <Title>Medio Rischio
    <Localized lang="it">Medio Rischio</Localized>
      <Localized lang="en">Medium Risk</Localized>
      <Localized lang="fr">Medio Rischio</Localized>
      <Localized lang="de">Medio Rischio</Localized>
  </Title>
          <Abstract>Linea per Medio Rischio Incidentale</Abstract>
          <ogc:Filter>
              <ogc:And>
                <ogc:PropertyIsLessThanOrEqualTo>
                   <ogc:PropertyName>rischio</ogc:PropertyName>
                   <ogc:Function name="env">
                       <ogc:Literal>medium</ogc:Literal>
                    </ogc:Function>
                </ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyIsGreaterThanOrEqualTo>
                   <ogc:PropertyName>rischio</ogc:PropertyName>
                   <ogc:Function name="env">
                       <ogc:Literal>low</ogc:Literal>
                    </ogc:Function>
                </ogc:PropertyIsGreaterThanOrEqualTo>
              </ogc:And>
          </ogc:Filter>
          <MinScaleDenominator>17070</MinScaleDenominator>
          <MaxScaleDenominator>500000</MaxScaleDenominator>
          <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <Stroke>
             <CssParameter name="stroke">#FFFB00</CssParameter>
              <CssParameter name="stroke-width">14</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        
        
        <Rule>
          <Title>Alto Rischio
    <Localized lang="it">Alto Rischio</Localized>
      <Localized lang="en">High Risk</Localized>
      <Localized lang="fr">Alto Rischio</Localized>
      <Localized lang="de">Alto Rischio</Localized>
  </Title>
          <Abstract>Linea per Alto Rischio Incidentale</Abstract>
          <ogc:Filter>
            <ogc:PropertyIsGreaterThanOrEqualTo>
               <ogc:PropertyName>rischio</ogc:PropertyName>
               <ogc:Function name="env">
                       <ogc:Literal>medium</ogc:Literal>
                    </ogc:Function>
            </ogc:PropertyIsGreaterThanOrEqualTo>
          </ogc:Filter>
          <MinScaleDenominator>17070</MinScaleDenominator>
          <MaxScaleDenominator>500000</MaxScaleDenominator>
          <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <Stroke>
              <CssParameter name="stroke">#FF0000</CssParameter>
              <CssParameter name="stroke-width">16</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>