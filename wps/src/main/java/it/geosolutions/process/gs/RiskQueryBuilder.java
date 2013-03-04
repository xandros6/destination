package it.geosolutions.process.gs;

import java.util.ArrayList;
import java.util.List;

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
        
        umani.add(new Bersaglio(1,"residenti","nr_pers_residenti", new int[] {1, 35, 2, 3}));
        umani.add(new Bersaglio(2,"turistica","nr_turisti_max", new int[] {4, 36, 5, 6}));
        umani.add(new Bersaglio(4,"industria","nr_pers_servizi", new int[] {10, 38, 11, 12}));
        umani.add(new Bersaglio(5,"sanitarie","nr_pers_ospedali", new int[] {13, 39, 14, 15}));
        umani.add(new Bersaglio(6,"scolastiche","nr_pers_scuole", new int[] {16, 40, 17, 18}));
        umani.add(new Bersaglio(7,"commerciali","nr_pers_distrib", new int[] {19, 41, 20, 21}));
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
       
       int level = 3;
       StringBuilder builder = new StringBuilder();
       builder.append("select siig_geo_ln_arco_"+level+".id_geo_arco,coalesce(siig_geo_ln_arco_"+level+".nr_incidenti_elab * (\n");
       
       builder.append("   select sum(siig_r_arco_"+level+"_sostanza.padr * (\n");
       
       builder.append("      select sum(siig_r_scenario_sostanza.psc * (\n");
       
       //buildAmbientali(builder, level);
       buildUmani(builder, level);
       
       builder.append("      )) as psc\n");
       builder.append("      from siig_r_scenario_sostanza\n");
       builder.append("      where siig_r_scenario_sostanza.id_sostanza = siig_r_arco_"+level+"_sostanza.id_sostanza\n");
       builder.append("      and siig_r_scenario_sostanza.id_scenario in (%scenari%)\n");
       builder.append("      and flg_lieve in (%gravita%)\n");
       
       builder.append("   ))\n");
       builder.append("   from siig_r_arco_"+level+"_sostanza\n");
       builder.append("   where siig_r_arco_"+level+"_sostanza.id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
       builder.append("   and id_sostanza in (%sostanze%)\n");
       
       builder.append("),0) as rischio,siig_geo_ln_arco_"+level+".lunghezza,siig_geo_ln_arco_"+level+".geometria\n");
       builder.append("from siig_geo_ln_arco_"+level+"\n");
       builder.append("where siig_geo_ln_arco_"+level+".geometria && st_makeenvelope(%bounds%, 32632)\n");
       builder.append("order by id_geo_arco\n");
       System.out.println(builder.toString());
    
    }

    private static void buildAmbientali(StringBuilder builder, int level) {
        int count = 0;
        for(Bersaglio bersaglio : ambientali) {
            if(count > 0) {
                builder.append("          +\n");
            }
            builder.append("         (select coalesce("+bersaglio.eField+",1)\n");
            builder.append("          from siig_t_vulnerabilita_"+level+"\n");
            builder.append("          where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
            builder.append("          and id_distanza = (\n");
            builder.append("               select fk_distanza\n");
            builder.append("               from siig_r_area_danno\n");
            builder.append("               inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita\n");
            builder.append("               where siig_d_gravita.fk_bersaglio = "+bersaglio.id+"\n");
            builder.append("               and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario\n");
            builder.append("               and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza\n");
            builder.append("               and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve\n");
            builder.append("          )\n");
            builder.append("         ) * (\n");
            
            builder.append("             select suscettibilita\n");
            builder.append("             from siig_r_scenario_gravita\n");
            builder.append("             inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita\n");
            builder.append("             where id_scenario = siig_r_scenario_sostanza.id_scenario\n");
            builder.append("             and fk_bersaglio = "+bersaglio.id+"\n");
            builder.append("         ) * (1 - coalesce((\n");
            
            
            builder.append("             select cff\n");
            builder.append("             from siig_r_arco_"+level+"_scen_tipobers\n");
            builder.append("             where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
            builder.append("                 and id_scenario = siig_r_scenario_sostanza.id_scenario\n");
            builder.append("                 and id_bersaglio = "+bersaglio.id+"\n");
            builder.append("         ),0.3)) * %"+bersaglio.name+"%\n");
            
            count++;
        }
        
    }
    
    private static void buildUmani(StringBuilder builder, int level) {
        int count = 0;
        for(Bersaglio bersaglio : umani) {
            if(count > 0) {
                builder.append("          +\n");
            }
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
                    builder.append("                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita\n");
                    builder.append("                      where siig_d_gravita.id_gravita = "+bersaglio.gravita[i]+"\n");             
                    builder.append("                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario\n");
                    builder.append("                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza\n");
                    builder.append("                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve\n");
                    builder.append("                  )\n");
                } else {
                    builder.append("                  (select coalesce("+bersaglio.eField+",1)\n");
                    builder.append("                  from siig_t_vulnerabilita_"+level+"\n");
                    builder.append("                  where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
                    builder.append("                  and id_distanza = (\n");
                    builder.append("                      select fk_distanza\n");
                    builder.append("                      from siig_r_area_danno\n");
                    builder.append("                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita\n");
                    builder.append("                      where siig_d_gravita.id_gravita = "+bersaglio.gravita[i]+"\n");             
                    builder.append("                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario\n");
                    builder.append("                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza\n");
                    builder.append("                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve\n");
                    builder.append("                  )) - (\n");
                    builder.append("                  select coalesce("+bersaglio.eField+",1)\n");
                    builder.append("                  from siig_t_vulnerabilita_"+level+"\n");
                    builder.append("                  where id_geo_arco = siig_geo_ln_arco_"+level+".id_geo_arco\n");
                    builder.append("                  and id_distanza = (\n");
                    builder.append("                      select fk_distanza\n");
                    builder.append("                      from siig_r_area_danno\n");
                    builder.append("                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita\n");
                    builder.append("                      where siig_d_gravita.id_gravita = "+bersaglio.gravita[i-1]+"\n");             
                    builder.append("                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario\n");
                    builder.append("                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza\n");
                    builder.append("                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve\n");
                    builder.append("                  )\n");
                    builder.append("                  )\n");
                }
                
                builder.append("                ) *\n");
                builder.append("                (\n");
                builder.append("                 select suscettibilita\n");
                builder.append("                 from siig_r_scenario_gravita\n");
                builder.append("                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita\n");
                builder.append("                 where id_scenario = siig_r_scenario_sostanza.id_scenario\n");
                builder.append("                 and siig_d_gravita.id_gravita = "+bersaglio.gravita[i]+"\n");
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
            
            count++;
        }
        
    }

}
