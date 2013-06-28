insert into siig_geo_bersaglio_umano_pl(idgeo_bersaglio_umano_pl,geometria)
select 1800+fid,the_geom
from "RP_V_BU_ASCOL_C_02";

insert into siig_t_bersaglio_umano(id_tematico,id_bersaglio,id_partner,fk_bersaglio_umano_pl,denominazione,fk_tipo_uso,iscritti,flg_nr_iscritti,addetti,flg_nr_addetti_scuole)
select"ID_TEMA",6,1,1800+fid,"DENOM","FK_GR_SCOL","N_ISCRITTI","FLG_N_ISCR","N_ADDETTI","FLG_N_ADD"
from "RP_V_BU_ASCOL_C_02";

insert into siig_geo_bersaglio_umano_pt(idgeo_bersaglio_umano_pt,geometria)
select fid,the_geom
from "RP_V_BU_ASCOL_C_01";

update siig_t_bersaglio_umano set fk_bersaglio_umano_pt=(select fid from "RP_V_BU_ASCOL_C_01" c where "ID_TEMA"=id_tematico) where id_bersaglio=6;