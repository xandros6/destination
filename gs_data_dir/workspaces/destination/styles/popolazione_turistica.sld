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
          <Title>Popolazione Turistica
            <Localized lang="it">Popolazione Turistica</Localized>
            <Localized lang="en">Tourist People</Localized>
            <Localized lang="fr">Popolazione Turistica</Localized>
            <Localized lang="de">Popolazione Turistica</Localized>
          </Title>
          
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://times</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#1CD6D9</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                     <CssParameter name="stroke-opacity">0.2</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
                 <Opacity>0.2</Opacity>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#1CD6D9</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.2</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
        

      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>