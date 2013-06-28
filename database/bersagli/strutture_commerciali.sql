insert into siig_geo_bersaglio_umano_pl(idgeo_bersaglio_umano_pl,geometria)
select 150+fid,the_geom
from "RP_V_BU_ACOMM_C_02";

insert into siig_t_bersaglio_umano(id_tematico,id_bersaglio,id_partner,fk_bersaglio_umano_pl,denominazione,insegna,sup_vendita,utenti,flg_nr_utenti,addetti,flg_nr_addetti_comm)
select cast("ID_TEMA" as numeric),7,1,150+fid,"DENOM","INSEGNA","SUP_VEND","N_UTENTI","FLG_N_UTEN","N_ADDETTI","FLG_N_ADD"
from "RP_V_BU_ACOMM_C_02";