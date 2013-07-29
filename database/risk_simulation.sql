select id_geo_arco,avg(cff) 
  from (select id_geo_arco,id_bersaglio,fk_partner,cff from siig_r_arco_%livello%_scen_tipobers 
 where id_geo_arco in (%id_geo_arco%) and id_bersaglio in (%id_bersaglio%) %cff%)) x group by id_geo_arco

  select id_geo_arco,avg(cff) 
    from 
    (
       select id_geo_arco,id_bersaglio,cff from siig_r_arco_1_scen_tipobers where id_geo_arco in (1,2,3,4,5) and id_bersaglio in (1,2,4,5,6,7)
       union all
       select 1 as id_geo_arco, 10001 as id_bersaglio, 0.8 as cff
       union all
       select 2 as id_geo_arco, 10001 as id_bersaglio, 0.8 as cff
    ) x
   group by id_geo_arco;

select id_geo_arco,avg(cff) 
  from (select id_geo_arco,id_bersaglio,fk_partner,cff from siig_r_arco_1_scen_tipobers 
 where id_geo_arco in (1,2,3,4,5) and id_bersaglio in (1,2,4,5,6,7)) x group by id_geo_arco

---------------------------------------------------------------------------------------------------
select sum(psc) 
from
(
 select id_sostanza,psc from siig_r_scenario_sostanza where id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%)
 %psc%
) x

select sum(psc) 
  from 
  (
      select id_sostanza,psc from siig_r_scenario_sostanza where id_scenario in (1,3,7,8) and id_sostanza in (1,2,3,7,8,9) and flg_lieve in (0,1)
      union all
      select 4 as id_sostanza, 0.3 as psc
  ) x;

---------------------------------------------------------------------------------------------------
select id_geo_arco,%padr% from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %id_sostanza%

select id_geo_arco,padr from siig_r_arco_1_sostanza where id_geo_arco in (1,2,3,4,5) and id_sostanza = 1
select id_geo_arco,0.6 as padr from siig_r_arco_1_sostanza where id_geo_arco in (1,2,3,4,5) and id_sostanza = 1

---------------------------------------------------------------------------------------------------
"select id_geo_arco,%formula(117)% from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco"
  "nr_incidenti_elab/lunghezza*1000*(%formula(119)%*%elaborazione(2)%)"

select *
 from
 (
	select id_geo_arco,nr_incidenti_elab/lunghezza*1000 from siig_geo_ln_arco_1 where id_geo_arco in (1,2,3,4,5) group by id_geo_arco
	union all
	select id_geo_arco,55 from siig_geo_ln_arco_1 where id_geo_arco in (5) 
 ) x

---------------------------------------------------------------------------------------------------
"select id_geo_arco,%formula(118)% from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco"
  "nr_incidenti_elab/5*(%formula(119)%*%elaborazione(2)%)"
  



