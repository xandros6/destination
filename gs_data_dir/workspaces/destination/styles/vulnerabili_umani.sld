<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0"
 xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd"
 xmlns="http://www.opengis.net/sld"
 xmlns:ogc="http://www.opengis.net/ogc"
 xmlns:xlink="http://www.w3.org/1999/xlink"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <!-- a Named Layer is the basic building block of an SLD document -->
  <NamedLayer>
    <Name>default_raster</Name>
    <UserStyle>
    <!-- Styles can have names, titles and abstracts -->
      <Title>Default Raster</Title>
      <Abstract>A sample style that draws a raster, good for displaying imagery</Abstract>
      <!-- FeatureTypeStyles describe how to render different features -->
      <!-- A FeatureTypeStyle for rendering rasters -->
      <FeatureTypeStyle>
            <Transformation>
             <ogc:Function name="gs:Algebric">
               <ogc:Function name="parameter">
                 <ogc:Literal>data</ogc:Literal>
               </ogc:Function>
               <ogc:Function name="parameter">
                 <ogc:Literal>coverages</ogc:Literal>
                 <ogc:Function name="env">
                   <ogc:Literal>coverages</ogc:Literal>
                 </ogc:Function>
               </ogc:Function>
               <ogc:Function name="parameter">
                 <ogc:Literal>operation</ogc:Literal>
                 <ogc:Literal>SUM</ogc:Literal>
               </ogc:Function>
               <ogc:Function name="parameter">
                 <ogc:Literal>destinationNoData</ogc:Literal>
                 <ogc:Literal>0</ogc:Literal>
               </ogc:Function>
               <ogc:Function name="parameter">
                 <ogc:Literal>NoDataMin</ogc:Literal>
                 <ogc:Literal>-1</ogc:Literal>
               </ogc:Function>
               <ogc:Function name="parameter">
                 <ogc:Literal>NoDataMax</ogc:Literal>
                 <ogc:Literal>-1</ogc:Literal>
               </ogc:Function>
               <ogc:Function name="parameter">
                 <ogc:Literal>outputBBOX</ogc:Literal>
                 <ogc:Function name="env">
                   <ogc:Literal>wms_bbox</ogc:Literal>
                 </ogc:Function>
               </ogc:Function>
               <ogc:Function name="parameter">
                 <ogc:Literal>outputWidth</ogc:Literal>
                 <ogc:Function name="env">
                   <ogc:Literal>wms_width</ogc:Literal>
                 </ogc:Function>
               </ogc:Function>
               <ogc:Function name="parameter">
                 <ogc:Literal>outputHeight</ogc:Literal>
                 <ogc:Function name="env">
                   <ogc:Literal>wms_height</ogc:Literal>
                 </ogc:Function>
               </ogc:Function>
             </ogc:Function>
        </Transformation>
        <Rule>
          <Name>rule1</Name>
          <Title>Opaque Raster</Title>
          <Abstract>A raster with 100% opacity</Abstract>
          <RasterSymbolizer>
            <ChannelSelection>
                <GrayChannel>
                        <SourceChannelName>1</SourceChannelName>
                </GrayChannel>
              </ChannelSelection>
            <Opacity>1.0</Opacity>
            <ColorMap type="intervals" extended="true">
        <ColorMapEntry color="#FF0000" quantity="0.00000000001" label="Nessuna" opacity="0"/>
        <ColorMapEntry color="#00FF00" quantity="${env('low',3)}" label="Bassa" opacity="1"/>
        <ColorMapEntry color="#FFFF00" quantity="${env('medium',10)}" label="Media" opacity="1"/>
        <ColorMapEntry color="#FF0000" quantity="${env('high',1000)}" label="Alta" opacity="1"/>
</ColorMap>
          </RasterSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>