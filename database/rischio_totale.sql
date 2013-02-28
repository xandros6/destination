select siig_geo_ln_arco_1.id_geo_arco,siig_geo_ln_arco_1.nr_incidenti_elab * (
     select sum(siig_r_arco_1_sostanza.padr * 
     (
     select sum(siig_r_scenario_sostanza.psc * (
        (select mq_aree_agricole
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco) * (1 - (
        select cff 
        from siig_r_arco_1_scen_tipobers
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_scenario = 1--siig_r_scenario_sostanza.id_scenario
        and id_bersaglio = 3--13
        )) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = 1--siig_r_scenario_sostanza.id_scenario
                and fk_bersaglio = 13
        ) + 
        (select mq_aree_boscate
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco) * (1 - (
        select cff 
        from siig_r_arco_1_scen_tipobers
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_scenario = 1--siig_r_scenario_sostanza.id_scenario
        and id_bersaglio = 3--11
        )) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = 1--siig_r_scenario_sostanza.id_scenario
                and fk_bersaglio = 13--11
        ) + 
        (select mq_aree_protette
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco) * (1 - (
        select cff 
        from siig_r_arco_1_scen_tipobers
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_scenario = 1--siig_r_scenario_sostanza.id_scenario
        and id_bersaglio = 3--12
        )) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = 1--siig_r_scenario_sostanza.id_scenario
                and fk_bersaglio = 13--12
        ) + 
        (select coalesce(mq_zone_urbanizzate,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco) * (1 - (
        select cff 
        from siig_r_arco_1_scen_tipobers
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_scenario = 1--siig_r_scenario_sostanza.id_scenario
        and id_bersaglio = 3--10
        )) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = 1--siig_r_scenario_sostanza.id_scenario
                and fk_bersaglio = 13--10
        ) + 
        (select coalesce(mq_beni_culturali,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco) * (1 - (
        select cff 
        from siig_r_arco_1_scen_tipobers
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_scenario = 1--siig_r_scenario_sostanza.id_scenario
        and id_bersaglio = 3--16
        )) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = 1--siig_r_scenario_sostanza.id_scenario
                and fk_bersaglio = 13--16
        ) + 
        (select coalesce(mq_acque_superficiali,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco) * (1 - (
        select cff 
        from siig_r_arco_1_scen_tipobers
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_scenario = 1--siig_r_scenario_sostanza.id_scenario
        and id_bersaglio = 3--15
        )) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = 1--siig_r_scenario_sostanza.id_scenario
                and fk_bersaglio = 13--15
        ) + 
        (select coalesce(mq_acque_sotterranee,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco) * (1 - (
        select cff 
        from siig_r_arco_1_scen_tipobers
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_scenario = 1--siig_r_scenario_sostanza.id_scenario
        and id_bersaglio = 3--14
        )) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = 1--siig_r_scenario_sostanza.id_scenario
                and fk_bersaglio = 13--14
        )   
     )) as psc
     from siig_r_scenario_sostanza
     where siig_r_scenario_sostanza.id_sostanza = siig_r_arco_1_sostanza.id_sostanza
     and siig_r_scenario_sostanza.id_scenario in (1)--param scenario single value or comma delimited list   
     and flg_lieve in (0,1)--param gravita 0 1 o 0,1
     )) as rischio
     
     from siig_r_arco_1_sostanza
     where siig_r_arco_1_sostanza.id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
     and id_sostanza in (1,9) --param sostanza single value or comma delimited list    
) as rischio,siig_geo_ln_arco_1.geometria
from siig_geo_ln_arco_1
order by id_geo_arco
