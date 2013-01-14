<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
    <NamedLayer>
        <Name>Default Line</Name>
        <UserStyle>
            <Title>1 px blue line</Title>
            <Abstract>Default line style, 1 pixel wide blue</Abstract>  
            
            <FeatureTypeStyle>

                <Rule>
                    
                    <Title>Lesioni reversibili</Title>
                    <Abstract>Buffer per Rischio Incidentale</Abstract>
                    <MaxScaleDenominator>50000</MaxScaleDenominator>
                    <PolygonSymbolizer>
                        <Geometry>
                            <ogc:Function name="difference">
                                <ogc:Function name="buffer">
                                    <ogc:PropertyName>geometria</ogc:PropertyName>
                                    <ogc:Function name="env">
                                       <ogc:Literal>reversibili</ogc:Literal>
                                    </ogc:Function>
                                </ogc:Function>
                                <ogc:Function name="buffer">
                                    <ogc:PropertyName>geometria</ogc:PropertyName>
                                    <ogc:Function name="env">
                                       <ogc:Literal>irreversibili</ogc:Literal>
                                    </ogc:Function>
                                </ogc:Function>
                            </ogc:Function>
                        </Geometry>
                        <Fill>
                            <CssParameter name="fill">#00FFFF</CssParameter>
                            <CssParameter name="fill-opacity">0.2</CssParameter>                            
                        </Fill>
                    </PolygonSymbolizer>

                </Rule>

                


            </FeatureTypeStyle>
            <FeatureTypeStyle>


                <Rule>
                    
                    <Title>Lesioni irreversibili</Title>
                    <Abstract>Buffer per Rischio Incidentale</Abstract>
                    <MaxScaleDenominator>50000</MaxScaleDenominator>
                    <PolygonSymbolizer>
                        <Geometry>
                            <ogc:Function name="difference">
                                <ogc:Function name="buffer">
                                    <ogc:PropertyName>geometria</ogc:PropertyName>
                                    <ogc:Function name="env">
                                       <ogc:Literal>irreversibili</ogc:Literal>
                                    </ogc:Function>
                                </ogc:Function>
                                <ogc:Function name="buffer">
                                    <ogc:PropertyName>geometria</ogc:PropertyName>
                                    <ogc:Function name="env">
                                       <ogc:Literal>inizio</ogc:Literal>
                                    </ogc:Function>
                                </ogc:Function>
                            </ogc:Function>
                        </Geometry>
                        <Fill>
                            <CssParameter name="fill">#007FFF</CssParameter>
                            <CssParameter name="fill-opacity">0.2</CssParameter>                            
                        </Fill>
                        
                    </PolygonSymbolizer>

                </Rule>
                
            </FeatureTypeStyle>
            <FeatureTypeStyle>


                <Rule>
                    
                    <Title>Inizio letalità</Title>
                    <Abstract>Buffer per Rischio Incidentale</Abstract>
                    <MaxScaleDenominator>50000</MaxScaleDenominator>
                    <PolygonSymbolizer>
                        <Geometry>
                            <ogc:Function name="difference">
                                <ogc:Function name="buffer">
                                    <ogc:PropertyName>geometria</ogc:PropertyName>
                                    <ogc:Function name="env">
                                       <ogc:Literal>inizio</ogc:Literal>
                                    </ogc:Function>
                                </ogc:Function>
                                <ogc:Function name="buffer">
                                    <ogc:PropertyName>geometria</ogc:PropertyName>
                                    <ogc:Function name="env">
                                       <ogc:Literal>elevata</ogc:Literal>
                                    </ogc:Function>
                                </ogc:Function>
                            </ogc:Function>
                        </Geometry>
                        <Fill>
                            <CssParameter name="fill">#0000FF</CssParameter>
                            <CssParameter name="fill-opacity">0.2</CssParameter>                            
                        </Fill>
                        
                    </PolygonSymbolizer>

                </Rule>
                
            </FeatureTypeStyle>
            <FeatureTypeStyle>


                <Rule>
                    
                    <Title>Elevata letalità</Title>
                    <Abstract>Buffer per Rischio Incidentale</Abstract>
                    <MaxScaleDenominator>50000</MaxScaleDenominator>
                    <PolygonSymbolizer>
                        <Geometry>
                            <ogc:Function name="buffer">
                                <ogc:PropertyName>geometria</ogc:PropertyName>
                                <ogc:Function name="env">
                                     <ogc:Literal>elevata</ogc:Literal>
                                  </ogc:Function>
                            </ogc:Function>
                        </Geometry>
                        <Fill>
                            <CssParameter name="fill">#000F6D</CssParameter>
                            <CssParameter name="fill-opacity">0.2</CssParameter>                            
                        </Fill>
                        
                    </PolygonSymbolizer>

                </Rule>

                

            </FeatureTypeStyle>
        </UserStyle>
    </NamedLayer>
</StyledLayerDescriptor>