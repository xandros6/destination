insert into siig_geo_bersaglio_umano_pl(idgeo_bersaglio_umano_pl,geometria)
select 5000+fid,the_geom
from "RP_V_BU_PRES_C_02";

insert into siig_t_bersaglio_umano(id_tematico,id_bersaglio,id_partner,fk_bersaglio_umano_pl,residenti)
select"ID_TEMA",1,1,5000+fid,"RESIDENTI"
from "RP_V_BU_PRES_C_02";