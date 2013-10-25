<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
    <NamedLayer>
        <Name>Default Line</Name>
        <UserStyle>
            <Title>Area di Danno</Title>
            <Abstract>Default line style, 1 pixel wide blue</Abstract>  
              <FeatureTypeStyle>
            
                <Rule>
                    
                    <Title>Area di danno
                    <Localized lang="it">Area di danno</Localized>
                    <Localized lang="en">Damage Area</Localized>
                    <Localized lang="fr">Damage Area</Localized>
                    <Localized lang="de">Damage Area</Localized>
                    </Title>
                    <Abstract>Valutazione del danno</Abstract>
                    <MaxScaleDenominator>50000</MaxScaleDenominator>
                    <PolygonSymbolizer>
                        <Geometry>
                          <ogc:PropertyName>geometria</ogc:PropertyName>
                        </Geometry>
                        <Fill>
                            <CssParameter name="fill">#00FFFF</CssParameter>
                            <CssParameter name="fill-opacity">0.5</CssParameter>                            
                        </Fill>
                    </PolygonSymbolizer>

                </Rule>


                

            </FeatureTypeStyle>
        </UserStyle>
    </NamedLayer>
</StyledLayerDescriptor>