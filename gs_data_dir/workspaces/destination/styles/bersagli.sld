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
          <Title>Popolazione Residente
            <Localized lang="it">Popolazione Residente</Localized>
            <Localized lang="en">People Resident</Localized>
            <Localized lang="fr">Popolazione Residente</Localized>
            <Localized lang="de">Popolazione Residente</Localized>
          </Title>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>tipobersaglio</ogc:PropertyName>
                <ogc:Literal>Popolazione residente</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://times</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#FF7FFF</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>8</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#FF7FFF</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Aree agricole
            <Localized lang="it">Aree agricole</Localized>
            <Localized lang="en">Coltivated Area</Localized>
            <Localized lang="fr">Aree agricole</Localized>
            <Localized lang="de">Aree agricole</Localized>
          </Title>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>tipobersaglio</ogc:PropertyName>
                <ogc:Literal>Aree agricole</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://horline</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#FFAA7F</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>6</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#FFAA7F</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
            
          </PolygonSymbolizer>
          
        </Rule>
         <Rule>
          <Title>Aree protette</Title>
            <Localized lang="it">Aree protette</Localized>
            <Localized lang="en">Protected Areas</Localized>
            <Localized lang="fr">Aree protette</Localized>
            <Localized lang="de">Aree protette</Localized>
          </Title>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>tipobersaglio</ogc:PropertyName>
                <ogc:Literal>Aree protette</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://slash</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#C2AC9B</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                   
                 </Mark>
                 <Size>6</Size>
                
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#C2AC9B</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
            
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Acque superficiali
            <Localized lang="it">Acque superficiali</Localized>
            <Localized lang="en">Surface Waters</Localized>
            <Localized lang="fr">Acque superficiali</Localized>
            <Localized lang="de">Acque superficiali</Localized>
          </Title>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>tipobersaglio</ogc:PropertyName>
                <ogc:Literal>Acque superficiali</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://backslash</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#9C8783</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                   
                 </Mark>
                 <Size>6</Size>
                
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#9C8783</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
            
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Acque sotterranee
            <Localized lang="it">Acque sotterranee</Localized>
            <Localized lang="en">Underground Waters</Localized>
            <Localized lang="fr">Acque sotterranee</Localized>
            <Localized lang="de">Acque sotterranee</Localized>
          </Title>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>tipobersaglio</ogc:PropertyName>
                <ogc:Literal>Acque sotterranee</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://backslash</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#32735C</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                   
                 </Mark>
                 <Size>6</Size>
                
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#32735C</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
            
          </PolygonSymbolizer>
          
        </Rule>
        <Rule>
          <Title>Aree boscate
            <Localized lang="it">Aree boscate</Localized>
            <Localized lang="en">Forest Area</Localized>
            <Localized lang="fr">Aree boscate</Localized>
            <Localized lang="de">Aree boscate</Localized>
          </Title>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>tipobersaglio</ogc:PropertyName>
                <ogc:Literal>Aree boscate</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator>50000</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
               <Graphic>
                 <Mark>
                   <WellKnownName>shape://vertline</WellKnownName>
                   <Stroke>
                     <CssParameter name="stroke">#7FFFD4</CssParameter>
                     <CssParameter name="stroke-width">1</CssParameter>
                   </Stroke>
                 </Mark>
                 <Size>6</Size>
               </Graphic>
               
             </GraphicFill>
          </Fill>
            <Stroke>
               <CssParameter name="stroke">#7FFFD4</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
             </Stroke>
           
          </PolygonSymbolizer>
          
        </Rule>

      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>