<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" 
 xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
 xmlns="http://www.opengis.net/sld" 
 xmlns:ogc="http://www.opengis.net/ogc" 
 xmlns:xlink="http://www.w3.org/1999/xlink" 
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <!-- a Named Layer is the basic building block of an SLD document -->
  <NamedLayer>
    <Name>beni_culturali_raster</Name>
    <UserStyle>
    <!-- Styles can have names, titles and abstracts -->
      <Title>beni_culturali_raster</Title>
      <FeatureTypeStyle>
        <Rule>
        <Title>Beni culturali
            <Localized lang="it">Beni culturali</Localized>
            <Localized lang="en">Cultural Sites</Localized>
            <Localized lang="fr">Beni culturali</Localized>
            <Localized lang="de">Beni culturali</Localized>
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
                <ColorMapEntry color="#871CD9" quantity="1.0" label="" opacity="1"/>                             
              </ColorMap>      
          </RasterSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>