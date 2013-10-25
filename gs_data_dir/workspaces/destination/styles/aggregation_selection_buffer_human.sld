<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
    <NamedLayer>
        <Name>Default Line</Name>
        <UserStyle>
            <Title>Aree Danno (Bersagli umani)</Title>
            <Abstract>Default line style, 1 pixel wide blue</Abstract>  
            
            <FeatureTypeStyle>
                <Transformation>
                  <ogc:Function name="ds:MultipleBuffer">
                    <ogc:Function name="parameter">
                      <ogc:Literal>features</ogc:Literal>
                    </ogc:Function>
                    <ogc:Function name="parameter">
                      <ogc:Literal>distances</ogc:Literal>
                      <ogc:Function name="env">
                         <ogc:Literal>elevata</ogc:Literal>
                      </ogc:Function> 
                      <ogc:Function name="env">
                         <ogc:Literal>inizio</ogc:Literal>
                      </ogc:Function>
                      <ogc:Function name="env">
                         <ogc:Literal>irreversibili</ogc:Literal>
                      </ogc:Function> 
                      <ogc:Function name="env">
                         <ogc:Literal>reversibili</ogc:Literal>
                      </ogc:Function>                                                                
                    </ogc:Function>
                    
                  </ogc:Function>
                </Transformation>
                <Rule>
                    
                    <Title>Lesioni reversibili
                    <Localized lang="it">Lesioni reversibili</Localized>
                    <Localized lang="en">Reversible Injuries</Localized>
                    <Localized lang="fr">Lesioni reversibili</Localized>
                    <Localized lang="de">Lesioni reversibili</Localized>
                    </Title>
                    <Abstract>Buffer per Rischio Incidentale</Abstract>
                    <MaxScaleDenominator>17070</MaxScaleDenominator>
                    <PolygonSymbolizer>
                        <Geometry>
                          <ogc:PropertyName>geometria4</ogc:PropertyName>
                        </Geometry>
                        <Fill>
                            <CssParameter name="fill">#00FFFF</CssParameter>
                            <CssParameter name="fill-opacity">0.5</CssParameter>                            
                        </Fill>
                    </PolygonSymbolizer>

                </Rule>

                

            
                <Rule>
                    
                    <Title>Lesioni irreversibili
                    <Localized lang="it">Lesioni irreversibili</Localized>
                    <Localized lang="en">Irreversible Injuries</Localized>
                    <Localized lang="fr">Lesioni irreversibili</Localized>
                    <Localized lang="de">Lesioni irreversibili</Localized>
                    </Title>
                    <Abstract>Buffer per Rischio Incidentale</Abstract>
                    <MaxScaleDenominator>17070</MaxScaleDenominator>
                    <PolygonSymbolizer>
                        <Geometry>
                            <ogc:PropertyName>geometria3</ogc:PropertyName>
                        </Geometry>
                        <Fill>
                            <CssParameter name="fill">#007FFF</CssParameter>
                            <CssParameter name="fill-opacity">0.5</CssParameter>                            
                        </Fill>
                        
                    </PolygonSymbolizer>

                </Rule>
                
            


                <Rule>
                    
                    <Title>Inizio letalità
                    <Localized lang="it">Inizio letalità</Localized>
                    <Localized lang="en">Start Lethality</Localized>
                    <Localized lang="fr">Inizio letalità</Localized>
                    <Localized lang="de">Inizio letalità</Localized>
                    </Title>
                    <Abstract>Buffer per Rischio Incidentale</Abstract>
                    <MaxScaleDenominator>17070</MaxScaleDenominator>
                    <PolygonSymbolizer>
                        <Geometry>
                            <ogc:PropertyName>geometria2</ogc:PropertyName>
                        </Geometry>
                        <Fill>
                            <CssParameter name="fill">#0000FF</CssParameter>
                            <CssParameter name="fill-opacity">0.5</CssParameter>                            
                        </Fill>
                        
                    </PolygonSymbolizer>

                </Rule>
                
            


                <Rule>
                    
                    <Title>Elevata letalità
                    <Localized lang="it">Elevata letalità</Localized>
                    <Localized lang="en">High Lethality</Localized>
                    <Localized lang="fr">Elevata letalità</Localized>
                    <Localized lang="de">Elevata letalità</Localized>
                    </Title>
                    <Abstract>Buffer per Rischio Incidentale</Abstract>
                    <MaxScaleDenominator>17070</MaxScaleDenominator>
                    <PolygonSymbolizer>
                        <Geometry>
                            <ogc:PropertyName>geometria</ogc:PropertyName>
                        </Geometry>
                        <Fill>
                            <CssParameter name="fill">#000F6D</CssParameter>
                            <CssParameter name="fill-opacity">0.5</CssParameter>                            
                        </Fill>
                        
                    </PolygonSymbolizer>

                </Rule>

                

            </FeatureTypeStyle>
        </UserStyle>
    </NamedLayer>
</StyledLayerDescriptor>