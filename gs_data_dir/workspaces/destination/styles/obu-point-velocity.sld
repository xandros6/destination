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
              <PropertyIsEqualTo>
                  <PropertyName>velocita</PropertyName>                    
                  <Literal>0</Literal>                    
              </PropertyIsEqualTo>
          </Filter> 
          <Name>rule1</Name>
          <Title>Fermo</Title>
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
            <And>
              <PropertyIsGreaterThan>
                  <PropertyName>velocita</PropertyName>                    
                  <Literal>0</Literal>                    
              </PropertyIsGreaterThan>
              <PropertyIsLessThanOrEqualTo>
                  <PropertyName>velocita</PropertyName>                    
                  <Literal>50</Literal>                    
              </PropertyIsLessThanOrEqualTo>
            </And>
          </Filter> 
          <Name>rule1</Name>
          <Title>Bassa</Title>
          <Abstract>A 6 pixel square with a red fill and no stroke</Abstract>
            <PointSymbolizer>
              <Graphic>
                <Mark>
                  <WellKnownName>circle</WellKnownName>
                  <Fill>
                    <CssParameter name="fill">#00FF00</CssParameter>
                  </Fill>
                  <Stroke>
                    <CssParameter name="stroke">#000000</CssParameter>
                  </Stroke>
                </Mark>
              <Size>10</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <Rule>        
          <Filter>
            <And>
              <PropertyIsGreaterThan>
                  <PropertyName>velocita</PropertyName>                    
                  <Literal>50</Literal>                    
              </PropertyIsGreaterThan>
              <PropertyIsLessThanOrEqualTo>
                  <PropertyName>velocita</PropertyName>                    
                  <Literal>1000</Literal>                    
              </PropertyIsLessThanOrEqualTo>
            </And>
          </Filter> 
          <Name>rule1</Name>
          <Title>Media</Title>
          <Abstract>A 6 pixel square with a red fill and no stroke</Abstract>
            <PointSymbolizer>
              <Graphic>
                <Mark>
                  <WellKnownName>circle</WellKnownName>
                  <Fill>
                    <CssParameter name="fill">#FFFF00</CssParameter>
                  </Fill>
                  <Stroke>
                    <CssParameter name="stroke">#000000</CssParameter>
                  </Stroke>
                </Mark>
              <Size>15</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        <Rule>        
          <Filter>
              <PropertyIsGreaterThan>
                  <PropertyName>velocita</PropertyName>                    
                  <Literal>100</Literal>                    
              </PropertyIsGreaterThan>
          </Filter> 
          <Name>rule1</Name>
          <Title>Alta</Title>
          <Abstract>A 6 pixel square with a red fill and no stroke</Abstract>
            <PointSymbolizer>
              <Graphic>
                <Mark>
                  <WellKnownName>circle</WellKnownName>
                  <Fill>
                    <CssParameter name="fill">#FF0000</CssParameter>
                  </Fill>
                  <Stroke>
                    <CssParameter name="stroke">#000000</CssParameter>
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