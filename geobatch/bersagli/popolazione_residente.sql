insert into siig_geo_bersaglio_umano_pl(idgeo_bersaglio_umano_pl,geometria)
select 5000+fid,the_geom
from "RP_V_BU_PRES_C_02";

insert into siig_t_bersaglio_umano(id_tematico,id_bersaglio,id_partner,fk_bersaglio_umano_pl,residenti,flg_nr_utenti,flg_nr_addetti_comm,flg_letti_ordinari,flg_letti_day_h,flg_nr_addetti_h,flg_nr_iscritti,flg_nr_addetti_scuole)
select"ID_TEMA",1,1,5000+fid,"RESIDENTI",0,0,0,0,0,0,0
from "RP_V_BU_PRES_C_02";