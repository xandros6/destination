<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>Bersagli Style</Name>
    <UserStyle>
      <Title>Bersagli style</Title>
      <Abstract>Bersagli</Abstract>
      <FeatureTypeStyle>
        <Rule>
          <Title>Addetti industria e servizi
            <Localized lang="it">Addetti industria e servizi</Localized>
            <Localized lang="en">Industry and Service Employees</Localized>
            <Localized lang="fr">Addetti industria e servizi</Localized>
            <Localized lang="de">Addetti industria e servizi</Localized>
          </Title>
          
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
                <Mark>
                  <WellKnownName>circle</WellKnownName>
                  <Fill>
                    <GraphicFill>
                     <Graphic>
                       <Mark>
                         <WellKnownName>shape://oarrow</WellKnownName>
                         <Stroke>
                           <CssParameter name="stroke">#AAB310</CssParameter>
                           <CssParameter name="stroke-width">1</CssParameter>
                         </Stroke>
                         
                       </Mark>
                       <Size>6</Size>
                      
                     </Graphic>
                     
                   </GraphicFill>
                </Fill>
                  <Stroke>
                     <CssParameter name="stroke">#AAB310</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                </Mark>
              <Size>20</Size>
            </Graphic>
            
            
          </PointSymbolizer>
          
          
        </Rule>
        

      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>