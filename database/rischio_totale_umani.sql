select siig_geo_ln_arco_1.id_geo_arco,siig_geo_ln_arco_1.nr_incidenti_elab * (
     select sum(siig_r_arco_1_sostanza.padr * 
     (
     select sum(siig_r_scenario_sostanza.psc * ((
        ((select coalesce(nr_pers_residenti,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_distanza = (
             select fk_distanza
             from siig_r_area_danno
             inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
             where siig_d_gravita.id_gravita = 1             
             and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
             and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
             and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
        )
        ) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = siig_r_scenario_sostanza.id_scenario
                and siig_d_gravita.id_gravita = 1
        ) + ((select coalesce(nr_pers_residenti,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_distanza = (
             select fk_distanza
             from siig_r_area_danno
             inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
             where siig_d_gravita.id_gravita = 35             
             and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
             and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
             and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
        )) - (select coalesce(nr_pers_residenti,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_distanza = (
             select fk_distanza
             from siig_r_area_danno
             inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
             where siig_d_gravita.id_gravita = 1             
             and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
             and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
             and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
        ))
        ) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = siig_r_scenario_sostanza.id_scenario
                and siig_d_gravita.id_gravita = 35
        ) +  (
        ((select coalesce(nr_pers_residenti,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_distanza = (
             select fk_distanza
             from siig_r_area_danno
             inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
             where siig_d_gravita.id_gravita = 2             
             and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
             and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
             and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
        )) - ((select coalesce(nr_pers_residenti,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_distanza = (
             select fk_distanza
             from siig_r_area_danno
             inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
             where siig_d_gravita.id_gravita = 35             
             and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
             and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
             and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
        ))
        ) * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = siig_r_scenario_sostanza.id_scenario
                and siig_d_gravita.id_gravita = 2
        ) + ((select coalesce(nr_pers_residenti,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_distanza = (
             select fk_distanza
             from siig_r_area_danno
             inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
             where siig_d_gravita.id_gravita = 3             
             and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
             and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
             and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
        )) - (select coalesce(nr_pers_residenti,1)
        from siig_t_vulnerabilita_1
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_distanza = (
             select fk_distanza
             from siig_r_area_danno
             inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
             where siig_d_gravita.id_gravita = 2             
             and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
             and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
             and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
        ))) 
        * (
                select suscettibilita
                from siig_r_scenario_gravita
                inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                where id_scenario = siig_r_scenario_sostanza.id_scenario
                and siig_d_gravita.id_gravita = 3
        )
        ))
        
        ) * (1 - coalesce((
        select cff
        from siig_r_arco_1_scen_tipobers
        where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
        and id_scenario = siig_r_scenario_sostanza.id_scenario
        and id_bersaglio = 1
        ),0.3)) * (
                select  fp_scen_centrale 
                from siig_t_bersaglio
                where id_bersaglio = 1
        ) * 1
     ))
     
     ) as psc
     from siig_r_scenario_sostanza
     where siig_r_scenario_sostanza.id_sostanza = siig_r_arco_1_sostanza.id_sostanza
     and siig_r_scenario_sostanza.id_scenario in (1,2,3,4,5,6,7,8,9,10,11)
     and flg_lieve in (0,1)
     )) as rischio
     
     from siig_r_arco_1_sostanza
     where siig_r_arco_1_sostanza.id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
     and id_sostanza in (1,2,3,4,5,6,7,8,9,10)
) as rischio,siig_geo_ln_arco_1.lunghezza,siig_geo_ln_arco_1.geometria
from siig_geo_ln_arco_1
where siig_geo_ln_arco_1.geometria && st_makeenvelope(437283.798308,4973519.681172,440915.445091,4975761.297918, 32632)
order by id_geo_arco