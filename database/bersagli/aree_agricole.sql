insert into siig_geo_bers_non_umano_pl(idgeo_bers_non_umano_pl,geometria)
select 1000+fid,the_geom
from "RP_V_BNU_AAGR_C_02";

insert into siig_t_bersaglio_non_umano(id_tematico,id_bersaglio,id_partner,fk_bers_non_umano_pl,fk_classe_clc,superficie)
select "ID_TEMA",13,1,1000+fid,CASE WHEN "FK_CLC" = 0 THEN NULL ELSE "FK_CLC" END,"SUPERFICIE"
from "RP_V_BNU_AAGR_C_02";