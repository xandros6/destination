<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" 
 xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
 xmlns="http://www.opengis.net/sld" 
 xmlns:ogc="http://www.opengis.net/ogc" 
 xmlns:xlink="http://www.w3.org/1999/xlink" 
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <!-- a Named Layer is the basic building block of an SLD document -->
  <NamedLayer>
    <Name>acque_superficiali_raster</Name>
    <UserStyle>
    <!-- Styles can have names, titles and abstracts -->
      <Title>acque_superficiali_raster</Title>
      <FeatureTypeStyle>
        <Rule>
        <Title>Acque superficiali
            <Localized lang="it">Acque superficiali</Localized>
            <Localized lang="en">Surface Waters</Localized>
            <Localized lang="fr">Acque superficiali</Localized>
            <Localized lang="de">Acque superficiali</Localized>
        </Title>
          <Name>rule1</Name>
          <Title>Opaque Raster</Title>
          <Abstract>A raster with 100% opacity</Abstract>
          <MinScaleDenominator>50000</MinScaleDenominator>
          <RasterSymbolizer>
              <Opacity>1.0</Opacity>
              <ChannelSelection>      
              <GrayChannel>
                        <SourceChannelName>1</SourceChannelName>
                </GrayChannel>
              </ChannelSelection>       
              <ColorMap type="values">
                <ColorMapEntry color="#000000" quantity="0.0" label="" opacity="0"/>             
                <ColorMapEntry color="#000000" quantity="2.0" label="" opacity="0"/>
                <ColorMapEntry color="#000000" quantity="3.0" label="" opacity="0"/>        
                <ColorMapEntry color="#000000" quantity="4.0" label="" opacity="0"/>        
                <ColorMapEntry color="#9C8783" quantity="1.0" label="" opacity="1"/>        
                <ColorMapEntry color="#000000" quantity="6.0" label="" opacity="0"/>        
              </ColorMap>
          </RasterSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>