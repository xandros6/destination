package it.geosolutions.process.gs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RiskQueryBuilder {

    static class Bersaglio {
        public int id = 0;
        public String name = "";
        public String eField = "";
        public int[] gravita = new int[] {};
        public Bersaglio(int id, String name, String eField) {
            super();
            this.id = id;
            this.name = name;
            this.eField = eField;
        }
        
        public Bersaglio(int id, String name, String eField, int[] gravita) {
            super();
            this.id = id;
            this.name = name;
            this.eField = eField;
            this.gravita = gravita;
        }
    }
    
    static class RiskRange {
        public String name = "";
        public String minValue = "";
        public String maxValue = "";
        public String defaultMinValue = "";
        public String defaultMaxValue = "";        
        public int lineWidth = 0;
        public String color = "";
        public String id = "";
        public RiskRange(String id, String name, String minValue, String maxValue,
                String defaultMinValue, String defaultMaxValue, int lineWidth,
                String color) {
            super();
            this.name = name;
            this.minValue = minValue;
            this.maxValue = maxValue;
            this.defaultMinValue = defaultMinValue;
            this.defaultMaxValue = defaultMaxValue;
            this.lineWidth = lineWidth;
            this.color = color;
            this.id = id;
        }
        
            
    } 
    
    static class Level {
        public int level = 0; 
        public int minScale = 0;
        public int maxScale = 0;        
        public boolean isGrid = false;        
        public boolean hasLabels = false;
        
        public Level(int minScale, int maxScale, boolean isGrid,
                boolean hasLabels, int level) {
            super();
            this.minScale = minScale;
            this.maxScale = maxScale;
            this.isGrid = isGrid;
            this.hasLabels = hasLabels;
           this.level = level;
        }
        
        
    }
    
    private static RiskRange[] ranges = new RiskRange[] {
        new RiskRange("low", "Basso Rischio", "" , "low", "0", "100", 12, "14F200"),
        new RiskRange("medium", "Medio Rischio", "low" , "medium", "100", "500", 14, "FFFB00"),
        new RiskRange("high", "Alto Rischio", "medium" , "", "500", "", 16, "FF0000")
    };
    
    private static Map<String,String> combinedColors = new HashMap<String, String>();
    
    private static Level[] levels = new Level[] {
        new Level(0, 17061, false, true, 1),
        new Level(17061, 500000, false, false, 2),
        new Level(500000, 0 , false, false, 3),
    };
        
    
    private static List<Bersaglio> ambientali = new ArrayList<Bersaglio>();
    private static List<Bersaglio> umani = new ArrayList<Bersaglio>();
    
    static {
        ambientali.add(new Bersaglio(10,"urbanizzate","mq_zone_urbanizzate"));
        ambientali.add(new Bersaglio(11,"boscate","mq_aree_boscate"));
        ambientali.add(new Bersaglio(12,"protette","mq_aree_protette"));
        ambientali.add(new Bersaglio(13,"agricole","mq_aree_agricole"));
        ambientali.add(new Bersaglio(14,"sotterranee","mq_acque_sotterranee"));
        ambientali.add(new Bersaglio(15,"superficiali","mq_acque_superficiali"));
        ambientali.add(new Bersaglio(16,"culturali","mq_beni_culturali"));
        
        umani.add(new Bersaglio(1,"residenti","nr_pers_residenti", new int[] {1, 2, 3, 4}));
        umani.add(new Bersaglio(2,"turistica","nr_turisti_max", new int[] {1, 2, 3, 4}));
        umani.add(new Bersaglio(4,"industria","nr_pers_servizi", new int[] {1, 2, 3, 4}));
        umani.add(new Bersaglio(5,"sanitarie","nr_pers_ospedali", new int[] {1, 2, 3, 4}));
        umani.add(new Bersaglio(6,"scolastiche","nr_pers_scuole", new int[] {1, 2, 3, 4}));
        umani.add(new Bersaglio(7,"commerciali","nr_pers_distrib", new int[] {1, 2, 3, 4}));
        
        combinedColors.put("low-low", "14F200");
        combinedColors.put("low-medium", "0A7900");
        combinedColors.put("low-high", "053800");
        
        combinedColors.put("medium-low", "A5FB00");
        combinedColors.put("medium-medium", "FFFB00");
        combinedColors.put("medium-high", "FF9800");
        
        combinedColors.put("high-low", "FFB4B4");
        combinedColors.put("high-medium", "FF6A6A");
        combinedColors.put("high-high", "FF0000");
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
       
       buildSimple(2, true);
       //buildSimple(3, true);
       //buildCombined(3);
       //buildSimpleStyle(3);
       //buildCombinedStyle(3);
    }

    private static void buildSimpleStyle(int level) {        
        StringBuilder builder = new StringBuilder();
        buildStyleStart(builder);
        int count = 0;
        for(RiskRange range : ranges) {
            builder.append("   <Rule>\n");
            builder.append("    <Title>" + range.name + "</Title>\n");
            builder.append("    <Abstract>" + range.name + "</Abstract>\n");
            buildStyleFilter(builder, range, count == 0, count == ranges.length -1, level);
            buildStyleScales(builder, levels[level -1]);
            buildStyleSymbolizers(builder, range, levels[level -1]);
            builder.append("   </Rule>\n");
            
            count++;
        }     
        buildStyleEnd(builder);
        System.out.println(builder.toString());
    }
    
    
    
    private static void buildCombinedStyle(int level) {        
        StringBuilder builder = new StringBuilder();
        buildStyleStart(builder);
        int countSociale = 0;
        for(RiskRange rangeSociale : ranges) {
            int countAmbientale = 0;
        
            for(RiskRange rangeAmbientale : ranges) {
                builder.append("   <Rule>\n");
                builder.append("    <Title>" + rangeSociale.name + "-" + rangeAmbientale.name + "</Title>\n");
                builder.append("    <Abstract>" + rangeSociale.name + "-" + rangeAmbientale.name + "</Abstract>\n");
                buildCombinedStyleFilter(builder, rangeSociale, countSociale == 0, countSociale == ranges.length -1, rangeAmbientale, countAmbientale == 0, countAmbientale == ranges.length -1, level);
                buildStyleScales(builder, levels[level -1]);
                buildCombinedStyleSymbolizers(builder, rangeSociale, rangeAmbientale, levels[level -1]);
                builder.append("   </Rule>\n");
                
                countAmbientale++;
            }
            
            countSociale++;
        }     
        buildStyleEnd(builder);
        System.out.println(builder.toString());
    }

    private static void buildCombinedStyleSymbolizers(StringBuilder builder,
            RiskRange rangeSociale, RiskRange rangeAmbientale, Level level) {
        if (level.isGrid) {
            builder.append("   <PolygonSymbolizer>\n");
            builder.append("   <Fill>\n");
            builder.append("     <CssParameter name=\"fill\">#" + getCombinedColor(rangeSociale, rangeAmbientale)
                    + "</CssParameter>\n");
            builder.append("     <CssParameter name=\"fill-opacity\">0.7</CssParameter>\n");
            builder.append("    </Fill>\n");
            builder.append("   </PolygonSymbolizer>\n");
        } else {
            builder.append("   <LineSymbolizer uom=\"http://www.opengeospatial.org/se/units/metre\">\n");
            builder.append("     <Stroke>\n");
            builder.append("      <CssParameter name=\"stroke\">#" + getCombinedColor(rangeSociale, rangeAmbientale)
                    + "</CssParameter>\n");
            builder.append("      <CssParameter name=\"stroke-width\">"
                    + getAverage(rangeSociale.lineWidth, rangeAmbientale.lineWidth) + "</CssParameter>\n");
            builder.append("     </Stroke>\n");
            builder.append("   </LineSymbolizer>\n");
            if(level.hasLabels) {
                buildCombinedPointAndTextSymbolizers(builder, level);
            }
        }
    }

    private static void buildCombinedPointAndTextSymbolizers(
            StringBuilder builder, Level level) {
        builder.append("   <PointSymbolizer uom=\"http://www.opengeospatial.org/se/units/metre\">\n");
        builder.append("    <Geometry>\n");
        builder.append("      <ogc:Function name=\"startPoint\">\n");
        builder.append("        <ogc:PropertyName>geometria</ogc:PropertyName>\n");
        builder.append("      </ogc:Function>\n");
        builder.append("    </Geometry>\n");
        builder.append("    <Graphic>\n");
        builder.append("      <Mark>\n");
        builder.append("        <WellKnownName>circle</WellKnownName>\n");
        builder.append("        <Fill>\n");
        builder.append("          <CssParameter name=\"fill\">#000000</CssParameter>\n");
        builder.append("        </Fill>\n");
        builder.append("      </Mark>\n");
        builder.append("      <Size>4</Size>\n");
        builder.append("    </Graphic>\n");
        builder.append("   </PointSymbolizer>\n");
        builder.append("   <PointSymbolizer uom=\"http://www.opengeospatial.org/se/units/metre\">\n");
        builder.append("    <Geometry>\n");
        builder.append("      <ogc:Function name=\"endPoint\">\n");
        builder.append("        <ogc:PropertyName>geometria</ogc:PropertyName>\n");
        builder.append("      </ogc:Function>\n");
        builder.append("    </Geometry>\n");
        builder.append("    <Graphic>\n");
        builder.append("      <Mark>\n");
        builder.append("        <WellKnownName>circle</WellKnownName>\n");
        builder.append("        <Fill>\n");
        builder.append("          <CssParameter name=\"fill\">#000000</CssParameter>\n");
        builder.append("        </Fill>\n");
        builder.append("      </Mark>\n");
        builder.append("      <Size>2</Size>\n");
        builder.append("    </Graphic>\n");
        builder.append("   </PointSymbolizer>\n");
            
        builder.append("   <TextSymbolizer>\n");
        builder.append("     <Label>\n");
        buildRiskProperty(builder, "rischio_sociale", level.level);
        builder.append(" - ");
        buildRiskProperty(builder, "rischio_ambientale", level.level);
        builder.append("     </Label>\n");
        builder.append("     <Halo>\n");
        builder.append("       <Radius>2</Radius>\n");
        builder.append("         <Fill>\n");
        builder.append("          <CssParameter name=\"fill\">#FFFFFF</CssParameter>\n");
        builder.append("         </Fill>\n");
        builder.append("     </Halo>\n");
        builder.append("     <Font>\n");
        builder.append("       <CssParameter name=\"font-family\">Arial</CssParameter>\n");
        builder.append("       <CssParameter name=\"font-size\">10</CssParameter>\n");
        builder.append("       <CssParameter name=\"font-style\">normal</CssParameter>\n");
        builder.append("       <CssParameter name=\"font-weight\">bold</CssParameter>\n");
        builder.append("     </Font>\n");
        builder.append("     <LabelPlacement>\n");
        builder.append("       <PointPlacement>\n");
        builder.append("           <AnchorPoint>\n");
        builder.append("            <AnchorPointX>0.5</AnchorPointX>\n");
        builder.append("            <AnchorPointY>0.0</AnchorPointY>\n");
        builder.append("           </AnchorPoint>\n");
        builder.append("           <Displacement>\n");
        builder.append("             <DisplacementX>0</DisplacementX>\n");
        builder.append("             <DisplacementY>0</DisplacementY>\n");
        builder.append("           </Displacement>\n");
        builder.append("           <Rotation>-45</Rotation>\n");
        builder.append("       </PointPlacement>\n");
        builder.append("       </LabelPlacement>\n");
        builder.append("       <Fill>\n");
        builder.append("          <CssParameter name=\"fill\">#990099</CssParameter>\n");
        builder.append("       </Fill>\n");
        builder.append("       <VendorOption name=\"followLine\">true</VendorOption>\n");
        builder.append("       <VendorOption name=\"repeat\">100</VendorOption>\n");
        builder.append("       <VendorOption name=\"group\">yes</VendorOption>\n");
        builder.append("   </TextSymbolizer>\n");
        
    }

    private static String getCombinedColor(RiskRange rangeSociale,
            RiskRange rangeAmbientale) {
       
        return combinedColors.get(rangeSociale.id + "-" + rangeAmbientale.id);
    }

    private static int getAverage(int w1, int w2) {
        double dw1 = (double)w1;
        double dw2 = (double)w2;
        
        return (int)Math.round((dw1 + dw2)/ 2.0);
    }

    private static void buildCombinedStyleFilter(StringBuilder builder,
            RiskRange rangeSociale, boolean firstSociale, boolean lastSociale,
            RiskRange rangeAmbientale, boolean firstAmbientale, boolean lastAmbientale, int level) {
        builder.append("   <ogc:Filter>\n");       
        builder.append("     <ogc:And>\n");
        
        buildFilterCondition(builder, rangeSociale, firstSociale, lastSociale,
                "rischio_sociale", level);
        
        buildFilterCondition(builder, rangeAmbientale, firstAmbientale, lastAmbientale,
                "rischio_ambientale", level);
        
        builder.append("     </ogc:And>\n");        
        builder.append("   </ogc:Filter>\n");
    }

    private static void buildFilterCondition(StringBuilder builder,
            RiskRange range, boolean first, boolean last, String riskName,  int level) {
        if(!last) {
            builder.append("        <ogc:PropertyIsLessThanOrEqualTo>\n");
            buildRiskProperty(builder, riskName, level);
            builder.append("          <ogc:Function name=\"env\">\n");
            builder.append("            <ogc:Literal>" + range.maxValue + "</ogc:Literal>\n");
            builder.append("            <ogc:Literal>" + range.defaultMaxValue + "</ogc:Literal>\n");
            builder.append("          </ogc:Function>\n");
            builder.append("        </ogc:PropertyIsLessThanOrEqualTo>\n");                      
        }
        if(!first) {
            builder.append("        <ogc:PropertyIsGreaterThanOrEqualTo>\n");
            buildRiskProperty(builder, riskName, level);
            builder.append("          <ogc:Function name=\"env\">\n");
            builder.append("            <ogc:Literal>" + range.minValue + "</ogc:Literal>\n");
            builder.append("            <ogc:Literal>" + range.defaultMinValue + "</ogc:Literal>\n");
            builder.append("          </ogc:Function>\n");
            builder.append("        </ogc:PropertyIsGreaterThanOrEqualTo>\n");                      
        }
    }

    private static void buildStyleSymbolizers(StringBuilder builder,
            RiskRange range, Level level) {
        if (level.isGrid) {
            builder.append("   <PolygonSymbolizer>\n");
            builder.append("   <Fill>\n");
            builder.append("     <CssParameter name=\"fill\">#" + range.color
                    + "</CssParameter>\n");
            builder.append("     <CssParameter name=\"fill-opacity\">0.7</CssParameter>\n");
            builder.append("    </Fill>\n");
            builder.append("   </PolygonSymbolizer>\n");
        } else {
            builder.append("   <LineSymbolizer uom=\"http://www.opengeospatial.org/se/units/metre\">\n");
            builder.append("     <Stroke>\n");
            builder.append("      <CssParameter name=\"stroke\">#" + range.color
                    + "</CssParameter>\n");
            builder.append("      <CssParameter name=\"stroke-width\">"
                    + range.lineWidth + "</CssParameter>\n");
            builder.append("     </Stroke>\n");
            builder.append("   </LineSymbolizer>\n");
            if(level.hasLabels) {
                buildPointAndTextSymbolizers(builder, level);
            }
        }
    }

    private static void buildPointAndTextSymbolizers(StringBuilder builder,
            Level level) {
        builder.append("   <PointSymbolizer uom=\"http://www.opengeospatial.org/se/units/metre\">\n");
        builder.append("    <Geometry>\n");
        builder.append("      <ogc:Function name=\"startPoint\">\n");
        builder.append("        <ogc:PropertyName>geometria</ogc:PropertyName>\n");
        builder.append("      </ogc:Function>\n");
        builder.append("    </Geometry>\n");
        builder.append("    <Graphic>\n");
        builder.append("      <Mark>\n");
        builder.append("        <WellKnownName>circle</WellKnownName>\n");
        builder.append("        <Fill>\n");
        builder.append("          <CssParameter name=\"fill\">#000000</CssParameter>\n");
        builder.append("        </Fill>\n");
        builder.append("      </Mark>\n");
        builder.append("      <Size>4</Size>\n");
        builder.append("    </Graphic>\n");
        builder.append("   </PointSymbolizer>\n");
        builder.append("   <PointSymbolizer uom=\"http://www.opengeospatial.org/se/units/metre\">\n");
        builder.append("    <Geometry>\n");
        builder.append("      <ogc:Function name=\"endPoint\">\n");
        builder.append("        <ogc:PropertyName>geometria</ogc:PropertyName>\n");
        builder.append("      </ogc:Function>\n");
        builder.append("    </Geometry>\n");
        builder.append("    <Graphic>\n");
        builder.append("      <Mark>\n");
        builder.append("        <WellKnownName>circle</WellKnownName>\n");
        builder.append("        <Fill>\n");
        builder.append("          <CssParameter name=\"fill\">#000000</CssParameter>\n");
        builder.append("        </Fill>\n");
        builder.append("      </Mark>\n");
        builder.append("      <Size>2</Size>\n");
        builder.append("    </Graphic>\n");
        builder.append("   </PointSymbolizer>\n");
            
        builder.append("   <TextSymbolizer>\n");
        builder.append("     <Label>\n");
        buildRiskProperty(builder, "rischio", level.level);
        builder.append("     </Label>\n");
        builder.append("     <Halo>\n");
        builder.append("       <Radius>2</Radius>\n");
        builder.append("         <Fill>\n");
        builder.append("          <CssParameter name=\"fill\">#FFFFFF</CssParameter>\n");
        builder.append("         </Fill>\n");
        builder.append("     </Halo>\n");
        builder.append("     <Font>\n");
        builder.append("       <CssParameter name=\"font-family\">Arial</CssParameter>\n");
        builder.append("       <CssParameter name=\"font-size\">10</CssParameter>\n");
        builder.append("       <CssParameter name=\"font-style\">normal</CssParameter>\n");
        builder.append("       <CssParameter name=\"font-weight\">bold</CssParameter>\n");
        builder.append("     </Font>\n");
        builder.append("     <LabelPlacement>\n");
        builder.append("       <PointPlacement>\n");
        builder.append("           <AnchorPoint>\n");
        builder.append("            <AnchorPointX>0.5</AnchorPointX>\n");
        builder.append("            <AnchorPointY>0.0</AnchorPointY>\n");
        builder.append("           </AnchorPoint>\n");
        builder.append("           <Displacement>\n");
        builder.append("             <DisplacementX>0</DisplacementX>\n");
        builder.append("             <DisplacementY>0</DisplacementY>\n");
        builder.append("           </Displacement>\n");
        builder.append("           <Rotation>-45</Rotation>\n");
        builder.append("       </PointPlacement>\n");
        builder.append("       </LabelPlacement>\n");
        builder.append("       <Fill>\n");
        builder.append("          <CssParameter name=\"fill\">#990099</CssParameter>\n");
        builder.append("       </Fill>\n");
        builder.append("       <VendorOption name=\"followLine\">true</VendorOption>\n");
        builder.append("       <VendorOption name=\"repeat\">100</VendorOption>\n");
        builder.append("       <VendorOption name=\"group\">yes</VendorOption>\n");
        builder.append("   </TextSymbolizer>\n");
    }

    private static void buildStyleScales(StringBuilder builder,
            Level level) {
        if(level.maxScale != 0) {
            builder.append("     <MaxScaleDenominator>" + level.maxScale + "</MaxScaleDenominator>\n");
        }
        if(level.minScale != 0) {
            builder.append("     <MinScaleDenominator>" + level.minScale + "</MinScaleDenominator>\n");
        }
        
    }

    private static void buildStyleFilter(StringBuilder builder,
            RiskRange range, boolean first, boolean last, int level) {
        builder.append("   <ogc:Filter>\n");
        if(!first && !last) {
            builder.append("     <ogc:And>\n");
        }
        buildFilterCondition(builder, range, first, last,
                "rischio", level);
        if(!last) {
            builder.append("        <ogc:PropertyIsLessThanOrEqualTo>\n");
            buildRiskProperty(builder, "rischio", level);
            builder.append("          <ogc:Function name=\"env\">\n");
            builder.append("            <ogc:Literal>" + range.maxValue + "</ogc:Literal>\n");
            builder.append("            <ogc:Literal>" + range.defaultMaxValue + "</ogc:Literal>\n");
            builder.append("          </ogc:Function>\n");
            builder.append("        </ogc:PropertyIsLessThanOrEqualTo>\n");                      
        }
        if(!first) {
            builder.append("        <ogc:PropertyIsGreaterThanOrEqualTo>\n");
            buildRiskProperty(builder, "rischio", level);
            builder.append("          <ogc:Function name=\"env\">\n");
            builder.append("            <ogc:Literal>" + range.minValue + "</ogc:Literal>\n");
            builder.append("            <ogc:Literal>" + range.defaultMinValue + "</ogc:Literal>\n");
            builder.append("          </ogc:Function>\n");
            builder.append("        </ogc:PropertyIsGreaterThanOrEqualTo>\n");                      
        }
        if(!first && !last) {
            builder.append("     </ogc:And>\n");
        }
        builder.append("   </ogc:Filter>\n");
    }

    private static void buildRiskProperty(StringBuilder builder, String riskName, int level) {
        builder.append("        <ogc:Function name=\"round\">\n");
        if(level < 3) {            
            builder.append("         <ogc:Div>\n");
            builder.append("          <ogc:PropertyName>" + riskName + "</ogc:PropertyName>\n");
            builder.append("          <ogc:PropertyName>lunghezza</ogc:PropertyName>\n");
            builder.append("         </ogc:Div>\n");            
        } else {
            builder.append("        <ogc:PropertyName>" + riskName + "</ogc:PropertyName>\n");
        }
        builder.append("        </ogc:Function>\n");
        
    }

    private static void buildStyleStart(StringBuilder builder) {
        builder.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
        builder.append("<StyledLayerDescriptor version=\"1.0.0\" xmlns=\"http://www.opengis.net/sld\" xmlns:ogc=\"http://www.opengis.net/ogc\"");
        builder.append(" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"");
        builder.append(" xsi:schemaLocation=\"http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd\">\n");
        builder.append("  <NamedLayer>\n");
        builder.append("    <Name>risk</Name>\n");
        builder.append("    <UserStyle>\n");
        builder.append("      <Title>risk</Title>\n");
        builder.append("      <Abstract>risk</Abstract>\n");       
        builder.append("      <FeatureTypeStyle>\n");
    }
    
    private static void buildStyleEnd(StringBuilder builder) {
        builder.append("      </FeatureTypeStyle>\n");
        builder.append("    </UserStyle>\n");
        builder.append("  </NamedLayer>\n");
        builder.append("</StyledLayerDescriptor>\n");
    }

    private static void buildSimple(int level, boolean human) {       
        StringBuilder builder = new StringBuilder();
        Level lev = levels[level - 1];
        if(lev.isGrid) {
            builder.append("select grid.gid,grid.geometria,avg(a3.rischio) as rischio\n");
            builder.append(" FROM\n"); 
            builder.append("(");
        }
        builder.append("select siig_geo_ln_arco_"+level+".id_geo_arco,");
        buildRisk(level, "rischio", builder, human);
        builder.append(",siig_geo_ln_arco_"+level+".lunghezza,siig_geo_ln_arco_"+level+".geometria\n");
        builder.append("from siig_geo_ln_arco_"+level+"\n");
        builder.append("where siig_geo_ln_arco_"+level+".geometria && st_makeenvelope(%bounds%, 32632)\n");
        if(lev.isGrid) {
            builder.append(") as a3,\n");
            builder.append("(SELECT\n");
            builder.append("        row_number() OVER (ORDER BY q_grid.cell) AS gid,\n");
            builder.append("        q_grid.cell AS geometria\n");
            builder.append("    FROM\n");
            builder.append("        (\n");
            builder.append("            SELECT\n");
            builder.append("              (st_dump(makegrid_2d(st_geomfromtext\n");
            builder.append("              (\n");
            builder.append("             'Polygon((317643 4881313,516288 4881313,516288 5140984,317643 5140984,317643 4881313))'\n");
            builder.append("                ::text, 32632), 5000, 32632))).geom AS cell) q_grid) as grid\n");
            builder.append("WHERE\n");
            builder.append("st_intersects(a3.geometria, grid.geometria)\n");
            builder.append("GROUP BY\n");
            builder.append("grid.gid,\n");
            builder.append("grid.geometria\n");
        }
    
        //builder.append("order by id_geo_arco\n");
        System.out.println(builder.toString());
     }
    
    private static void buildCombined(int level) {        
        
        StringBuilder builder = new StringBuilder();
        Level lev = levels[level - 1];
        if(lev.isGrid) {
            builder.append("select grid.gid,grid.geometria,avg(a3.rischio_sociale) as rischio_sociale,avg(a3.rischio_ambientale) as rischio_ambientale\n");
            builder.append("FROM\n");
            builder.append("(\n");
        }
        builder.append("select siig_geo_ln_arco_"+level+".id_geo_arco,");
        buildRisk(level, "rischio_sociale", builder ,true);
        builder.append(",");
        buildRisk(level, "rischio_ambientale", builder ,false);        
        builder.append(",siig_geo_ln_arco_"+level+".lunghezza,siig_geo_ln_arco_"+level+".geometria\n");
        builder.append("from siig_geo_ln_arco_"+level+"\n");
        builder.append("where siig_geo_ln_arco_"+level+".geometria && st_makeenvelope(%bounds%, 32632)\n");
        if(lev.isGrid) {
            builder.append(") as a3,\n");
            builder.append("(SELECT\n");
            builder.append("        row_number() OVER (ORDER BY q_grid.cell) AS gid,\n");
            builder.append("        q_grid.cell AS geometria\n");
            builder.append("    FROM\n");
            builder.append("        (\n");
            builder.append("            SELECT\n");
            builder.append("              (st_dump(makegrid_2d(st_geomfromtext\n");
            builder.append("              (\n");
            builder.append("             'Polygon((317643 4881313,516288 4881313,516288 5140984,317643 5140984,317643 4881313))'\n");
            builder.append("                ::text, 32632), 5000, 32632))).geom AS cell) q_grid) as grid\n");
            builder.append("WHERE\n");
            builder.append("st_intersects(a3.geometria, grid.geometria)\n");
            builder.append("GROUP BY\n");
            builder.append("grid.gid,\n");
            builder.append("grid.geometria\n");
        }
        //builder.append("order by id_geo_arco\n");
        System.out.println(builder.toString());
    }

    private static void buildRisk(int level, String riskName,
            StringBuilder builder, boolean human) {
        
        builder.append("coalesce(siig_geo_ln_arco_"+level+".nr_incidenti_elab * (\n");
        
        builder.append("   select sum(siig_r_arco_"+level+"_sostanza.padr * (\n");
        
        builder.append("      select sum(siig_r_scenario_sostanza.psc * (\n");
        
        if(human) {
            buildUmani(builder, level);
        } else {
            buildAmbientali(builder, level);  
        }                
        
        builder.append("      )) as psc\n");
        builder.append("      from siig_r_scenario_sostanza\n");
        builder.append("      where siig_r_scenario_sostanza.id_sostanza = siig_r_arco_"+level+"_sostanza.id_sostanza\n");
        builder.append("      and siig_r_scenario_sostanza.id_scenario in (%scenari%)\n");
        builder.append("      and flg_lieve in (%gravita%)\n");
        
        builder.append("   ))\n");
        builder.append("   from siig_r_arco_"+level+"_sostanza\n");
        builder.append("   where siig_r_arco_"+level+"_sostanza.id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
        builder.append("   and id_sostanza in (%sostanze%)\n");
        
        builder.append("),0) as " + riskName);
    }

    

    private static void buildAmbientali(StringBuilder builder, int level) {
        int count = 0;
        for(Bersaglio bersaglio : ambientali) {
            if(count > 0) {
                builder.append("          +\n");
            }
            builder.append("         (select coalesce((select coalesce("+bersaglio.eField+",1)\n");
            builder.append("          from siig_t_vulnerabilita_"+level+"\n");
            builder.append("          where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
            builder.append("          and id_distanza = (\n");
            builder.append("               select fk_distanza\n");
            builder.append("               from siig_r_area_danno\n");            
            builder.append("               where siig_r_area_danno.id_bersaglio = "+bersaglio.id+"\n");
            builder.append("               and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario\n");
            builder.append("               and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza\n");
            builder.append("               and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve\n");
            builder.append("               and siig_r_area_danno.id_gravita = 5\n");
            builder.append("          )\n");
            builder.append("         ) * (\n");
            
            builder.append("             select suscettibilita\n");
            builder.append("             from siig_r_scenario_gravita\n");
            builder.append("             inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita\n");
            builder.append("             where id_scenario = siig_r_scenario_sostanza.id_scenario\n");
            builder.append("             and id_bersaglio = "+bersaglio.id+"\n");
            builder.append("         ) * (1 - coalesce((\n");
            
            
            builder.append("             select cff\n");
            builder.append("             from siig_r_arco_"+level+"_scen_tipobers\n");
            builder.append("             where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
            //builder.append("                 and id_scenario = siig_r_scenario_sostanza.id_scenario\n");
            builder.append("                 and id_bersaglio = "+bersaglio.id+"\n");
            builder.append("         ),0.3)) * %"+bersaglio.name+"%,0))\n");
            
            count++;
        }
        
    }
    
    private static void buildUmani(StringBuilder builder, int level) {
        int count = 0;
        for(Bersaglio bersaglio : umani) {
            if(count > 0) {
                builder.append("          +\n");
            }
            builder.append("                coalesce(\n");
            builder.append("         (\n");      
            for(int i = 0; i<bersaglio.gravita.length; i++) {
                if(i > 0) {
                    builder.append("             +\n");
                }
                
                builder.append("                (\n");
                
                if(i == 0) {
                    builder.append("                  select coalesce("+bersaglio.eField+",1)\n");
                    builder.append("                  from siig_t_vulnerabilita_"+level+"\n");
                    builder.append("                  where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
                    builder.append("                  and id_distanza = (\n");
                    builder.append("                      select fk_distanza\n");
                    builder.append("                      from siig_r_area_danno\n");                    
                    builder.append("                      where siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario\n");
                    builder.append("                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza\n");
                    builder.append("                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve\n");
                    builder.append("                        and siig_r_area_danno.id_gravita = "+bersaglio.gravita[i]+"\n");
                    builder.append("                        and siig_r_area_danno.id_bersaglio = " + bersaglio.id + "\n");
                    builder.append("                  )\n");
                } else {
                    builder.append("                  coalesce((select coalesce("+bersaglio.eField+",1)\n");
                    builder.append("                  from siig_t_vulnerabilita_"+level+"\n");
                    builder.append("                  where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
                    builder.append("                  and id_distanza = (\n");
                    builder.append("                      select fk_distanza\n");
                    builder.append("                      from siig_r_area_danno\n");
                    builder.append("                      where siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario\n");
                    builder.append("                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza\n");
                    builder.append("                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve\n");
                    builder.append("                        and siig_r_area_danno.id_gravita = "+bersaglio.gravita[i]+"\n");
                    builder.append("                        and siig_r_area_danno.id_bersaglio = " + bersaglio.id + "\n");
                    builder.append("                  )) - (\n");
                    builder.append("                  select coalesce("+bersaglio.eField+",1)\n");
                    builder.append("                  from siig_t_vulnerabilita_"+level+"\n");
                    builder.append("                  where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
                    builder.append("                  and id_distanza = (\n");
                    builder.append("                      select fk_distanza\n");
                    builder.append("                      from siig_r_area_danno\n");
                    builder.append("                      where siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario\n");
                    builder.append("                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza\n");
                    builder.append("                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve\n");
                    builder.append("                        and siig_r_area_danno.id_gravita = "+bersaglio.gravita[i-1]+"\n");
                    builder.append("                        and siig_r_area_danno.id_bersaglio = " + bersaglio.id + "\n");
                    builder.append("                  )\n");
                    builder.append("                  ),1)\n");
                }
                
                builder.append("                ) *\n");
                builder.append("                (\n");
                builder.append("                 select suscettibilita\n");
                builder.append("                 from siig_r_scenario_gravita\n");
                builder.append("                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita\n");
                builder.append("                 where id_scenario = siig_r_scenario_sostanza.id_scenario\n");
                builder.append("                 and siig_d_gravita.id_gravita = "+bersaglio.gravita[i]+"\n");
                builder.append("                 and siig_r_scenario_gravita.id_bersaglio = "+bersaglio.id+"\n");
                builder.append("                )\n");
            }
            builder.append("         ) * (1 - coalesce((\n");                        
            builder.append("              select cff\n");
            builder.append("              from siig_r_arco_"+level+"_scen_tipobers\n");
            builder.append("              where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
            builder.append("                 and id_scenario = siig_r_scenario_sostanza.id_scenario\n");
            builder.append("                 and id_bersaglio = "+bersaglio.id+"\n");
            builder.append("         ),0.3)) * (\n");
            builder.append("              select  fp_scen_centrale\n"); 
            builder.append("              from siig_t_bersaglio\n");
            builder.append("              where id_bersaglio = "+bersaglio.id+"\n");                    
            builder.append("         ) * %"+bersaglio.name+"%\n");
            builder.append("                ,1)\n");
            count++;
            
        }
        
    }

}
