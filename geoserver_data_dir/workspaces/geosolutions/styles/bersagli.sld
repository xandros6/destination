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
          <Title>Popolazione Residente</Title>
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
          <Title>Aree agricole</Title>
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
          <Title>Acque superficiali</Title>
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
          <Title>Acque sotterranee</Title>
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
          <Title>Aree boscate</Title>
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