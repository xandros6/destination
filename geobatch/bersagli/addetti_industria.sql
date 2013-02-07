insert into siig_geo_bersaglio_umano_pl(idgeo_bersaglio_umano_pl,geometria)
select 1200000+fid,the_geom
from "RP_V_BU_AIND_C_02";

insert into siig_t_bersaglio_umano(id_tematico,id_bersaglio,id_partner,fk_bersaglio_umano_pl,denominazione,cod_fisc,fk_ateco,addetti,flg_letti_ordinari,flg_letti_day_h,flg_nr_addetti_h,flg_nr_iscritti,flg_nr_addetti_scuole,flg_nr_utenti,flg_nr_addetti_comm,fk_tipo_uso)
select "ID_TEMA",4,1,1200000+fid,"DENOM","COD_FISC","FK_ATECO","N_ADDETTI",0,0,0,0,0,0,0,0
from "RP_V_BU_AIND_C_02";

insert into siig_geo_bersaglio_umano_pt(idgeo_bersaglio_umano_pt,geometria)
select 3000+fid,the_geom
from "RP_V_BU_AIND_C_01";

update siig_t_bersaglio_umano set fk_bersaglio_umano_pt=(select fid from "RP_V_BU_AIND_C_01" c where "ID_TEMA"=id_tematico) where id_bersaglio=4;
