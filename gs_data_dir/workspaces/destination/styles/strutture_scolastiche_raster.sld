<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" 
 xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
 xmlns="http://www.opengis.net/sld" 
 xmlns:ogc="http://www.opengis.net/ogc" 
 xmlns:xlink="http://www.w3.org/1999/xlink" 
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <!-- a Named Layer is the basic building block of an SLD document -->
  <NamedLayer>
    <Name>popolazione_residente_raster</Name>
    <UserStyle>
    <!-- Styles can have names, titles and abstracts -->
      <Title>popolazione_residente_raster</Title>
      <FeatureTypeStyle>
        <Rule>
          <Title>Addetti e utenti strutture scolastiche
            <Localized lang="it">Addetti e utenti strutture scolastiche</Localized>
            <Localized lang="en">Scholastic Structrures Employees and Users</Localized>
            <Localized lang="fr">Addetti e utenti strutture scolastiche</Localized>
            <Localized lang="de">Addetti e utenti strutture scolastiche</Localized>
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
              <ColorMap type="intervals">
                <ColorMapEntry color="#000000" quantity="0.000000000001" label="" opacity="0"/>                                          
                <ColorMapEntry color="#354A66" quantity="10000.0" label="" opacity="1"/>                             
              </ColorMap>    
              
          </RasterSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>