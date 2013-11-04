<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>Default Line</Name>
    <UserStyle>
      <Title>Rischio</Title>
      <Abstract>Default line style, 1 pixel wide blue</Abstract>

      <FeatureTypeStyle>
        <Transformation>
            <ogc:Function name="gs:RiskCalculator">
              <ogc:Function name="parameter">
                <ogc:Literal>features</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>store</ogc:Literal>
                <ogc:Literal>destination</ogc:Literal>
              </ogc:Function>
              
              <ogc:Function name="parameter">
                <ogc:Literal>formula</ogc:Literal>
                <ogc:Function name="env">
                   <ogc:Literal>formula</ogc:Literal>
                   <ogc:Literal>16</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>target</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>target</ogc:Literal>
                  <ogc:Literal>0</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>materials</ogc:Literal>
                <ogc:Function name="env">
                   <ogc:Literal>materials</ogc:Literal>
                   <ogc:Literal>1,4</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>scenarios</ogc:Literal>
                <ogc:Function name="env">
                   <ogc:Literal>scenarios</ogc:Literal>
                   <ogc:Literal>4,5</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>entities</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>entities</ogc:Literal>
                  <ogc:Literal>0,1</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
             <ogc:Function name="parameter">
                <ogc:Literal>severeness</ogc:Literal>
                <ogc:Function name="env">
                   <ogc:Literal>severeness</ogc:Literal>
                   <ogc:Literal>1,2,3,4,5</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>fp</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>fp</ogc:Literal>
                  <ogc:Literal>fp_scen_centrale</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>processing</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>processing</ogc:Literal>
                  <ogc:Literal>1</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>pis</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>pis</ogc:Literal>
                  <ogc:Literal></ogc:Literal>
                </ogc:Function>
              </ogc:Function>
               <ogc:Function name="parameter">
                <ogc:Literal>padr</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>padr</ogc:Literal>
                  <ogc:Literal></ogc:Literal>
                </ogc:Function>
              </ogc:Function>
               <ogc:Function name="parameter">
                <ogc:Literal>cff</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>cff</ogc:Literal>
                  <ogc:Literal></ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>changedTargets</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>changedTargets</ogc:Literal>
                  <ogc:Literal></ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>distances</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>distances</ogc:Literal>
                  <ogc:Literal></ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>damageArea</ogc:Literal>
                <ogc:Function name="env">
                  <ogc:Literal>damageArea</ogc:Literal>
                  <ogc:Literal></ogc:Literal>
                </ogc:Function>
              </ogc:Function>
            </ogc:Function>
          </Transformation>
        <Rule>
    <Title>Basso Rischio
    <Localized lang="it">Basso Rischio</Localized>
      <Localized lang="en">Low Risk</Localized>
      <Localized lang="fr">Basso Rischio</Localized>
      <Localized lang="de">Niedriges Risiko</Localized>
  </Title>
    <Abstract>Basso Rischio</Abstract>
   <ogc:Filter>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>low</ogc:Literal>
            <ogc:Literal>100</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>low</ogc:Literal>
            <ogc:Literal>100</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
   </ogc:Filter>
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#14F200</CssParameter>
      <CssParameter name="stroke-width">12</CssParameter>
     </Stroke>
   </LineSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="startPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>4</Size>
    </Graphic>
   </PointSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="endPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>2</Size>
    </Graphic>
   </PointSymbolizer>
   <TextSymbolizer>
     <Label>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
     </Label>
     <Halo>
       <Radius>2</Radius>
         <Fill>
          <CssParameter name="fill">#FFFFFF</CssParameter>
         </Fill>
     </Halo>
     <Font>
       <CssParameter name="font-family">Arial</CssParameter>
       <CssParameter name="font-size">10</CssParameter>
       <CssParameter name="font-style">normal</CssParameter>
       <CssParameter name="font-weight">bold</CssParameter>
     </Font>
     <LabelPlacement>
       <PointPlacement>
           <AnchorPoint>
            <AnchorPointX>0.5</AnchorPointX>
            <AnchorPointY>0.0</AnchorPointY>
           </AnchorPoint>
           <Displacement>
             <DisplacementX>0</DisplacementX>
             <DisplacementY>0</DisplacementY>
           </Displacement>
           <Rotation>-45</Rotation>
       </PointPlacement>
       </LabelPlacement>
       <Fill>
          <CssParameter name="fill">#990099</CssParameter>
       </Fill>
       <VendorOption name="followLine">true</VendorOption>
       <VendorOption name="repeat">100</VendorOption>
       <VendorOption name="group">yes</VendorOption>
   </TextSymbolizer>
   </Rule>
   <Rule>
    <Title>Medio Rischio
    <Localized lang="it">Medio Rischio</Localized>
      <Localized lang="en">Medium Risk</Localized>
      <Localized lang="fr">Medio Rischio</Localized>
      <Localized lang="de">Mittleres Risiko</Localized>
  </Title>
    <Abstract>Medio Rischio</Abstract>
   <ogc:Filter>
     <ogc:And>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>medium</ogc:Literal>
            <ogc:Literal>500</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>low</ogc:Literal>
            <ogc:Literal>100</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>medium</ogc:Literal>
            <ogc:Literal>500</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsLessThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>low</ogc:Literal>
            <ogc:Literal>100</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
     </ogc:And>
   </ogc:Filter>
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FFFB00</CssParameter>
      <CssParameter name="stroke-width">14</CssParameter>
     </Stroke>
   </LineSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="startPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>4</Size>
    </Graphic>
   </PointSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="endPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>2</Size>
    </Graphic>
   </PointSymbolizer>
   <TextSymbolizer>
     <Label>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
     </Label>
     <Halo>
       <Radius>2</Radius>
         <Fill>
          <CssParameter name="fill">#FFFFFF</CssParameter>
         </Fill>
     </Halo>
     <Font>
       <CssParameter name="font-family">Arial</CssParameter>
       <CssParameter name="font-size">10</CssParameter>
       <CssParameter name="font-style">normal</CssParameter>
       <CssParameter name="font-weight">bold</CssParameter>
     </Font>
     <LabelPlacement>
       <PointPlacement>
           <AnchorPoint>
            <AnchorPointX>0.5</AnchorPointX>
            <AnchorPointY>0.0</AnchorPointY>
           </AnchorPoint>
           <Displacement>
             <DisplacementX>0</DisplacementX>
             <DisplacementY>0</DisplacementY>
           </Displacement>
           <Rotation>-45</Rotation>
       </PointPlacement>
       </LabelPlacement>
       <Fill>
          <CssParameter name="fill">#990099</CssParameter>
       </Fill>
       <VendorOption name="followLine">true</VendorOption>
       <VendorOption name="repeat">100</VendorOption>
       <VendorOption name="group">yes</VendorOption>
   </TextSymbolizer>
   </Rule>
   <Rule>
    <Title>Alto Rischio
    <Localized lang="it">Alto Rischio</Localized>
      <Localized lang="en">High Risk</Localized>
      <Localized lang="fr">Alto Rischio</Localized>
      <Localized lang="de">Hohes Risiko</Localized>
  </Title>
    <Abstract>Alto Rischio</Abstract>
   <ogc:Filter>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>medium</ogc:Literal>
            <ogc:Literal>500</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyIsGreaterThanOrEqualTo>
        <ogc:PropertyName>rischio1</ogc:PropertyName>
          <ogc:Function name="env">
            <ogc:Literal>medium</ogc:Literal>
            <ogc:Literal>500</ogc:Literal>
          </ogc:Function>
        </ogc:PropertyIsGreaterThanOrEqualTo>
   </ogc:Filter>
     <MaxScaleDenominator>17070</MaxScaleDenominator>
   <LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
     <Stroke>
      <CssParameter name="stroke">#FF0000</CssParameter>
      <CssParameter name="stroke-width">16</CssParameter>
     </Stroke>
   </LineSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="startPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>4</Size>
    </Graphic>
   </PointSymbolizer>
   <PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
    <Geometry>
      <ogc:Function name="endPoint">
        <ogc:PropertyName>geometria</ogc:PropertyName>
      </ogc:Function>
    </Geometry>
    <Graphic>
      <Mark>
        <WellKnownName>circle</WellKnownName>
        <Fill>
          <CssParameter name="fill">#000000</CssParameter>
        </Fill>
      </Mark>
      <Size>2</Size>
    </Graphic>
   </PointSymbolizer>
   <TextSymbolizer>
     <Label>
       <ogc:PropertyName>rischio1</ogc:PropertyName>
     </Label>
     <Halo>
       <Radius>2</Radius>
         <Fill>
          <CssParameter name="fill">#FFFFFF</CssParameter>
         </Fill>
     </Halo>
     <Font>
       <CssParameter name="font-family">Arial</CssParameter>
       <CssParameter name="font-size">10</CssParameter>
       <CssParameter name="font-style">normal</CssParameter>
       <CssParameter name="font-weight">bold</CssParameter>
     </Font>
     <LabelPlacement>
       <PointPlacement>
           <AnchorPoint>
            <AnchorPointX>0.5</AnchorPointX>
            <AnchorPointY>0.0</AnchorPointY>
           </AnchorPoint>
           <Displacement>
             <DisplacementX>0</DisplacementX>
             <DisplacementY>0</DisplacementY>
           </Displacement>
           <Rotation>-45</Rotation>
       </PointPlacement>
       </LabelPlacement>
       <Fill>
          <CssParameter name="fill">#990099</CssParameter>
       </Fill>
       <VendorOption name="followLine">true</VendorOption>
       <VendorOption name="repeat">100</VendorOption>
       <VendorOption name="group">yes</VendorOption>
   </TextSymbolizer>
   </Rule>
        

        
        
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>