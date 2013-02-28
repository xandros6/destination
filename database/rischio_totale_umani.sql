select siig_geo_ln_arco_1.id_geo_arco,siig_geo_ln_arco_1.nr_incidenti_elab * (
     select sum(siig_r_arco_1_sostanza.padr * 
     (
     select sum(siig_r_scenario_sostanza.psc * (
        ((select nr_pers_residenti
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_distanza = (
             select fk_distanza
             from siig_r_area_danno
             inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
             where siig_d_gravita.fk_bersaglio = 1
             and siig_d_gravita.id_gravita = 1
             and siig_r_area_danno.id_scenario = 1--siig_r_scenario_sostanza.id_scenario
             and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
             and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
        ))  * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = 1--siig_r_scenario_sostanza.id_scenario
                and fk_bersaglio = 13
                and siig_d_gravita.id_gravita = 1
        ) + 
        () * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = 1--siig_r_scenario_sostanza.id_scenario
                and fk_bersaglio = 13
                and siig_d_gravita.id_gravita = 1
        ) )
        * (1 - (
        select cff 
        from siig_r_arco_1_scen_tipobers
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_scenario = 1--siig_r_scenario_sostanza.id_scenario
        and id_bersaglio = 3--13
        ))
           
     )) as psc
     from siig_r_scenario_sostanza
     where siig_r_scenario_sostanza.id_sostanza = siig_r_arco_1_sostanza.id_sostanza
     and siig_r_scenario_sostanza.id_scenario in (1)--param scenario single value or comma delimited list   
     and flg_lieve in (0,1)--param gravita 0 1 o 0,1
     )) as rischio
     
     from siig_r_arco_1_sostanza
     where siig_r_arco_1_sostanza.id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
     and id_sostanza in (9) --param sostanza single value or comma delimited list    
) as rischio,siig_geo_ln_arco_1.geometria
from siig_geo_ln_arco_1
order by id_geo_arco
