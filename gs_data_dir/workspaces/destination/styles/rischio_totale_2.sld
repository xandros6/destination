<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>risk</Name>
    <UserStyle>
      <Title>risk</Title>
      <Abstract>risk</Abstract>
      <FeatureTypeStyle>
   <Rule>
      <Title>Basso Rischio-Basso Rischio
    <Localized lang="it">Basso Rischio-Basso Rischio</Localized>
      <Localized lang="en">Low Risk-Low Risk</Localized>
      <Localized lang="fr">Basso Rischio-Basso Rischio</Localized>
      <Localized lang="de">Niedriges Risiko-Niedriges Risiko</Localized>
  </Title>
    <Abstract>Basso Rischio-Basso Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>500000</MaxScaleDenominator>
     <MinScaleDenominator>17070</MinScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#14F200</CssParameter>
      <CssParameter name="stroke-width">12</CssParameter>
     </Stroke>
   </LineSymbolizer>
   </Rule>
   <Rule>
    <Title>Basso Rischio-Medio Rischio
    <Localized lang="it">Basso Rischio-Medio Rischio</Localized>
      <Localized lang="en">Low Risk-Medium Risk</Localized>
      <Localized lang="fr">Basso Rischio-Medio Rischio</Localized>
      <Localized lang="de">Niedriges Risiko-Mittleres Risiko</Localized>
  </Title>
    <Abstract>Basso Rischio-Medio Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>500000</MaxScaleDenominator>
     <MinScaleDenominator>17070</MinScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#0A7900</CssParameter>
      <CssParameter name="stroke-width">13</CssParameter>
     </Stroke>
   </LineSymbolizer>
   </Rule>
   <Rule>
    <Title>Basso Rischio-Alto Rischio
    <Localized lang="it">Basso Rischio-Alto Rischio</Localized>
      <Localized lang="en">Low Risk-High Risk</Localized>
      <Localized lang="fr">Basso Rischio-Alto Rischio</Localized>
      <Localized lang="de">Niedriges Risiko-Hohes Risiko</Localized>  
  </Title>
    <Abstract>Basso Rischio-Alto Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>500000</MaxScaleDenominator>
     <MinScaleDenominator>17070</MinScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#053800</CssParameter>
      <CssParameter name="stroke-width">14</CssParameter>
     </Stroke>
   </LineSymbolizer>
   </Rule>
   <Rule>
    <Title>Medio Rischio-Basso Rischio
    <Localized lang="it">Medio Rischio-Basso Rischio</Localized>
      <Localized lang="en">Medium Risk-Low Risk</Localized>
      <Localized lang="fr">Medio Rischio-Basso Rischio</Localized>
      <Localized lang="de">Mittleres Risiko-Niedriges Risiko</Localized>    
  </Title>
    <Abstract>Medio Rischio-Basso Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>500000</MaxScaleDenominator>
     <MinScaleDenominator>17070</MinScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#A5FB00</CssParameter>
      <CssParameter name="stroke-width">13</CssParameter>
     </Stroke>
   </LineSymbolizer>
   </Rule>
   <Rule>
    <Title>Medio Rischio-Medio Rischio
    <Localized lang="it">Medio Rischio-Medio Rischio</Localized>
      <Localized lang="en">Medium Risk-Medium Risk</Localized>
      <Localized lang="fr">Medio Rischio-Medio Rischio</Localized>
      <Localized lang="de">Mittleres Risiko-Mittleres Risiko</Localized>    
  </Title>
    <Abstract>Medio Rischio-Medio Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>500000</MaxScaleDenominator>
     <MinScaleDenominator>17070</MinScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FFFB00</CssParameter>
      <CssParameter name="stroke-width">14</CssParameter>
     </Stroke>
   </LineSymbolizer>
   </Rule>
   <Rule>
    <Title>Medio Rischio-Alto Rischio
    <Localized lang="it">Medio Rischio-Alto Rischio</Localized>
      <Localized lang="en">Medium Risk-High Risk</Localized>
      <Localized lang="fr">Medio Rischio-Alto Rischio</Localized>
      <Localized lang="de">Mittleres Risiko-Hohes Risiko</Localized>  
  </Title>
    <Abstract>Medio Rischio-Alto Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>500000</MaxScaleDenominator>
     <MinScaleDenominator>17070</MinScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FF9800</CssParameter>
      <CssParameter name="stroke-width">15</CssParameter>
     </Stroke>
   </LineSymbolizer>
   </Rule>
   <Rule>
    <Title>Alto Rischio-Basso Rischio
    <Localized lang="it">Alto Rischio-Basso Rischio</Localized>
      <Localized lang="en">High Risk-Low Risk</Localized>
      <Localized lang="fr">Alto Rischio-Basso Rischio</Localized>
      <Localized lang="de">Hohes Risiko-Niedriges Risiko</Localized>
  </Title>
    <Abstract>Alto Rischio-Basso Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>500000</MaxScaleDenominator>
     <MinScaleDenominator>17070</MinScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FFB4B4</CssParameter>
      <CssParameter name="stroke-width">14</CssParameter>
     </Stroke>
   </LineSymbolizer>
   </Rule>
   <Rule>
    <Title>Alto Rischio-Medio Rischio
    <Localized lang="it">Alto Rischio-Medio Rischio</Localized>
      <Localized lang="en">High Risk-Medium Risk</Localized>
      <Localized lang="fr">Alto Rischio-Medio Rischio</Localized>
      <Localized lang="de">Hohes Risiko-Mittleres Risiko</Localized>  
  </Title>
    <Abstract>Alto Rischio-Medio Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>lowambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>500000</MaxScaleDenominator>
     <MinScaleDenominator>17070</MinScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FF6A6A</CssParameter>
      <CssParameter name="stroke-width">15</CssParameter>
     </Stroke>
   </LineSymbolizer>
   </Rule>
   <Rule>
    <Title>Alto Rischio-Alto Rischio
    <Localized lang="it">Alto Rischio-Alto Rischio</Localized>
      <Localized lang="en">High Risk-High Risk</Localized>
      <Localized lang="fr">Alto Rischio-Alto Rischio</Localized>
      <Localized lang="de">Hohes Risiko-Hohes Risiko</Localized>  
  </Title>
    <Abstract>Alto Rischio-Alto Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_sociale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumsociale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio_ambientale</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>mediumambientale</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>500000</MaxScaleDenominator>
     <MinScaleDenominator>17070</MinScaleDenominator>
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