insert into siig_geo_bersaglio_umano_pl(idgeo_bersaglio_umano_pl,geometria)
select 500+fid,the_geom
from "RP_V_BU_PTUR_C_02";

insert into siig_t_bersaglio_umano(id_tematico,id_bersaglio,id_partner,fk_bersaglio_umano_pl,denominazione,nat_code,pres_max,pres_med)
select"ID_TEMA",2,1,500+fid,"DENOM","NAT_CODE","N_PTUR_MAX","N_PTUR_MED"
from "RP_V_BU_PTUR_C_02";