<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" 
 xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
 xmlns="http://www.opengis.net/sld" 
 xmlns:ogc="http://www.opengis.net/ogc" 
 xmlns:xlink="http://www.w3.org/1999/xlink" 
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <!-- a Named Layer is the basic building block of an SLD document -->
  <NamedLayer>
    <Name>default_point</Name>
    <UserStyle>
    <!-- Styles can have names, titles and abstracts -->
      <Title>Default Point</Title>
      <Abstract>A sample style that draws a point</Abstract>
      <!-- FeatureTypeStyles describe how to render different features -->
      <!-- A FeatureTypeStyle for rendering points -->
      <FeatureTypeStyle>
        <Rule>
          <Filter>
            <PropertyIsNotEqualTo>
              <PropertyName>tipo</PropertyName>                
              <Literal>01</Literal>                
            </PropertyIsNotEqualTo>
          </Filter>
          <Name>rule1</Name>
          <Title>No Direction</Title>
          <Abstract>A 6 pixel square with a red fill and no stroke</Abstract>
            
            <PointSymbolizer>
              <Graphic>
                <Mark>
                  <WellKnownName>circle</WellKnownName>
                  <Fill>
                    <CssParameter name="fill">#000000</CssParameter>
                  </Fill>
                  <Stroke>
                    <CssParameter name="stroke">#000000</CssParameter>
                  </Stroke>
                  
                </Mark>
              <Size>5</Size>
                
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <Rule>
          <Filter>
            <PropertyIsEqualTo>
              <PropertyName>tipo</PropertyName>                
              <Literal>01</Literal>                
            </PropertyIsEqualTo>
          </Filter>
          <Name>rule1</Name>
          <Title>Obu Direction</Title>
          <Abstract>A 6 pixel square with a red fill and no stroke</Abstract>
            
            <PointSymbolizer>
              <Graphic>
                <Mark>
                  <WellKnownName>shape://oarrow</WellKnownName>
                  
                  <Stroke>
                    <CssParameter name="stroke">#FA4E05</CssParameter>
                  </Stroke>
                  
                </Mark>
              <Size>20</Size>
                <Rotation>
                  <PropertyName>direzione</PropertyName></Rotation>
            </Graphic>
          </PointSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>