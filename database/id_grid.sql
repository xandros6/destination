select siig_geo_ln_arco_1.id_geo_arco,coalesce(siig_geo_ln_arco_1.nr_incidenti_elab * (
   select sum(siig_r_arco_1_sostanza.padr * (
      select sum(siig_r_scenario_sostanza.psc * (
         (
                (
                  select coalesce(nr_pers_residenti,1)
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
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 1
                )
             +
                (
                  (select coalesce(nr_pers_residenti,1)
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
                  )) - (
                  select coalesce(nr_pers_residenti,1)
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
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 35
                )
             +
                (
                  (select coalesce(nr_pers_residenti,1)
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
                  )) - (
                  select coalesce(nr_pers_residenti,1)
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
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 2
                )
             +
                (
                  (select coalesce(nr_pers_residenti,1)
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
                  )) - (
                  select coalesce(nr_pers_residenti,1)
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
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 3
                )
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
         ) * %residenti%
          +
         (
                (
                  select coalesce(nr_turisti_max,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 4
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 4
                )
             +
                (
                  (select coalesce(nr_turisti_max,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 36
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_turisti_max,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 4
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 36
                )
             +
                (
                  (select coalesce(nr_turisti_max,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 5
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_turisti_max,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 36
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 5
                )
             +
                (
                  (select coalesce(nr_turisti_max,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 6
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_turisti_max,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 5
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 6
                )
         ) * (1 - coalesce((
              select cff
              from siig_r_arco_1_scen_tipobers
              where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                 and id_scenario = siig_r_scenario_sostanza.id_scenario
                 and id_bersaglio = 2
         ),0.3)) * (
              select  fp_scen_centrale
              from siig_t_bersaglio
              where id_bersaglio = 2
         ) * %turistica%
          +
         (
                (
                  select coalesce(nr_pers_servizi,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 10
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 10
                )
             +
                (
                  (select coalesce(nr_pers_servizi,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 38
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_servizi,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 10
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 38
                )
             +
                (
                  (select coalesce(nr_pers_servizi,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 11
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_servizi,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 38
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 11
                )
             +
                (
                  (select coalesce(nr_pers_servizi,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 12
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_servizi,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 11
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 12
                )
         ) * (1 - coalesce((
              select cff
              from siig_r_arco_1_scen_tipobers
              where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                 and id_scenario = siig_r_scenario_sostanza.id_scenario
                 and id_bersaglio = 4
         ),0.3)) * (
              select  fp_scen_centrale
              from siig_t_bersaglio
              where id_bersaglio = 4
         ) * %industria%
          +
         (
                (
                  select coalesce(nr_pers_ospedali,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 13
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 13
                )
             +
                (
                  (select coalesce(nr_pers_ospedali,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 39
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_ospedali,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 13
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 39
                )
             +
                (
                  (select coalesce(nr_pers_ospedali,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 14
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_ospedali,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 39
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 14
                )
             +
                (
                  (select coalesce(nr_pers_ospedali,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 15
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_ospedali,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 14
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 15
                )
         ) * (1 - coalesce((
              select cff
              from siig_r_arco_1_scen_tipobers
              where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                 and id_scenario = siig_r_scenario_sostanza.id_scenario
                 and id_bersaglio = 5
         ),0.3)) * (
              select  fp_scen_centrale
              from siig_t_bersaglio
              where id_bersaglio = 5
         ) * %sanitarie%
          +
         (
                (
                  select coalesce(nr_pers_scuole,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 16
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 16
                )
             +
                (
                  (select coalesce(nr_pers_scuole,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 40
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_scuole,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 16
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 40
                )
             +
                (
                  (select coalesce(nr_pers_scuole,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 17
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_scuole,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 40
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 17
                )
             +
                (
                  (select coalesce(nr_pers_scuole,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 18
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_scuole,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 17
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 18
                )
         ) * (1 - coalesce((
              select cff
              from siig_r_arco_1_scen_tipobers
              where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                 and id_scenario = siig_r_scenario_sostanza.id_scenario
                 and id_bersaglio = 6
         ),0.3)) * (
              select  fp_scen_centrale
              from siig_t_bersaglio
              where id_bersaglio = 6
         ) * %scolastiche%
          +
         (
                (
                  select coalesce(nr_pers_distrib,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 19
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 19
                )
             +
                (
                  (select coalesce(nr_pers_distrib,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 41
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_distrib,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 19
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 41
                )
             +
                (
                  (select coalesce(nr_pers_distrib,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 20
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_distrib,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 41
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 20
                )
             +
                (
                  (select coalesce(nr_pers_distrib,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 21
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )) - (
                  select coalesce(nr_pers_distrib,1)
                  from siig_t_vulnerabilita_1
                  where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                  and id_distanza = (
                      select fk_distanza
                      from siig_r_area_danno
                      inner join siig_d_gravita on siig_r_area_danno.id_gravita = siig_d_gravita.id_gravita
                      where siig_d_gravita.id_gravita = 20
                        and siig_r_area_danno.id_scenario = siig_r_scenario_sostanza.id_scenario
                        and siig_r_area_danno.id_sostanza = siig_r_scenario_sostanza.id_sostanza
                        and siig_r_area_danno.flg_lieve = siig_r_scenario_sostanza.flg_lieve
                  )
                  )
                ) *
                (
                 select suscettibilita
                 from siig_r_scenario_gravita
                 inner join siig_d_gravita on siig_r_scenario_gravita.id_gravita = siig_d_gravita.id_gravita
                 where id_scenario = siig_r_scenario_sostanza.id_scenario
                 and siig_d_gravita.id_gravita = 21
                )
         ) * (1 - coalesce((
              select cff
              from siig_r_arco_1_scen_tipobers
              where id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
                 and id_scenario = siig_r_scenario_sostanza.id_scenario
                 and id_bersaglio = 7
         ),0.3)) * (
              select  fp_scen_centrale
              from siig_t_bersaglio
              where id_bersaglio = 7
         ) * %commerciali%
      )) as psc
      from siig_r_scenario_sostanza
      where siig_r_scenario_sostanza.id_sostanza = siig_r_arco_1_sostanza.id_sostanza
      and siig_r_scenario_sostanza.id_scenario in (%scenari%)
      and flg_lieve in (%gravita%)
   ))
   from siig_r_arco_1_sostanza
   where siig_r_arco_1_sostanza.id_geo_arco = siig_geo_ln_arco_1.id_geo_arco
   and id_sostanza in (%sostanze%)
),0) as rischio,siig_geo_ln_arco_1.lunghezza,siig_geo_ln_arco_1.geometria
from siig_geo_ln_arco_1
where siig_geo_ln_arco_1.geometria && st_makeenvelope(%bounds%, 32632)


