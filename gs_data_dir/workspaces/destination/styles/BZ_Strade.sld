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
          <Title>Autostrade
            <Localized lang="it">Autostrade</Localized>
            <Localized lang="en">Routes</Localized>
            <Localized lang="fr">Autostrade</Localized>
            <Localized lang="de">Autostrade</Localized>
          </Title>
          <Abstract>Autostrade</Abstract>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>                   
                       <ogc:PropertyName>TIPO</ogc:PropertyName>
                       <ogc:Literal>Autostrada</ogc:Literal>
                     
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          
          <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <Stroke>
              <CssParameter name="stroke">#14F200</CssParameter>
              <CssParameter name="stroke-width">12</CssParameter>
            </Stroke>
          </LineSymbolizer>
          
        </Rule>

        <Rule>
          <Title>Strade statali
            <Localized lang="it">Strade statali</Localized>
            <Localized lang="en">State street</Localized>
            <Localized lang="fr">Strade statali</Localized>
            <Localized lang="de">Strade statali</Localized>
          </Title>
          <Abstract>Strade statali</Abstract>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>                   
                       <ogc:PropertyName>TIPO</ogc:PropertyName>
                       <ogc:Literal>Strada statale</ogc:Literal>
                     
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          
          <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <Stroke>
              <CssParameter name="stroke">#FFFB00</CssParameter>
              <CssParameter name="stroke-width">9</CssParameter>
            </Stroke>
          </LineSymbolizer>
          
        </Rule>
        
         <Rule>
          <Title>Strade provinciali
            <Localized lang="it">Strade provinciali</Localized>
            <Localized lang="en">Provincial street</Localized>
            <Localized lang="fr">Strade provinciali</Localized>
            <Localized lang="de">Strade provinciali</Localized>
          </Title>
          <Abstract>Strade provinciali</Abstract>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>                   
                       <ogc:PropertyName>TIPO</ogc:PropertyName>
                       <ogc:Literal>Strada provinciale</ogc:Literal>
                     
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          
          <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <Stroke>
              <CssParameter name="stroke">#FF0000</CssParameter>
              <CssParameter name="stroke-width">6</CssParameter>
            </Stroke>
          </LineSymbolizer>
          
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>