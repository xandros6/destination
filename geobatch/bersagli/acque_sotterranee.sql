insert into siig_geo_bers_non_umano_pl(idgeo_bers_non_umano_pl,geometria)
select 1900000+fid,the_geom
from "RP_V_BNU_ASOTT_C_02";

insert into siig_t_bersaglio_non_umano(id_tematico,id_bersaglio,id_partner,fk_bers_non_umano_pl,denominazione,profondita_max,quota_pdc,fk_tipo_captazione,superficie,fk_tipo_uso)
select "ID_TIPO",14,1,1900000+fid,"DENOM","PROF_MAX","QUOTA","FK_TIPO_CP","SUPERFICIE",0
from "RP_V_BNU_ASOTT_C_02";

insert into siig_geo_bers_non_umano_pt(idgeo_bers_non_umano_pt,geometria)
select 21000+fid,the_geom
from "RP_V_BNU_ASOTT_C_01";

update siig_t_bersaglio_non_umano set fk_bers_non_umano_pt=(select fid from "RP_V_BNU_ASOTT_C_01" c where "ID_TIPO"=id_tematico)+21000 where id_bersaglio=14;