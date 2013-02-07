insert into siig_geo_bersaglio_umano_pl(idgeo_bersaglio_umano_pl,geometria)
select fid,the_geom
from "RP_V_BU_ASAN_C_02";

insert into siig_t_bersaglio_umano(id_tematico,id_bersaglio,id_partner,fk_bersaglio_umano_pl,denominazione,fk_tipo_uso,letti_o,flg_letti_ordinari,letti_day,flg_letti_day_h,addetti,flg_nr_addetti_h,flg_nr_iscritti,flg_nr_addetti_scuole,flg_nr_utenti,flg_nr_addetti_comm)
select "ID_TEMA",5,1,fid,"DENOM","FK_TIPO_SS","N_LETTI_OR","FLG_LT_OR","N_LETTI_DH","FLG_LT_DH","N_ADDETTI","FLG_N_ADD",0,0,0,0
from "RP_V_BU_ASAN_C_02";