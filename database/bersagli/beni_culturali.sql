insert into siig_geo_bers_non_umano_pl(idgeo_bers_non_umano_pl,geometria)
select 550000+fid,the_geom
from "RP_V_BNU_BCULT_C_02";

insert into siig_t_bersaglio_non_umano(id_tematico,id_bersaglio,id_partner,fk_bers_non_umano_pl,denominazione,fk_tipo_bene,superficie)
select "ID_TEMA",16,1,550000+fid,"DESC_",CASE WHEN "FK_BCULT" = 0 THEN NULL ELSE "FK_BCULT" END,"SUPERFICIE"
from "RP_V_BNU_BCULT_C_02";

insert into siig_geo_bers_non_umano_pt(idgeo_bers_non_umano_pt,geometria)
select fid,the_geom
from "RP_V_BNU_BCULT_C_01";

update siig_t_bersaglio_non_umano set fk_bers_non_umano_pt=(select fid from "RP_V_BNU_BCULT_C_01" c where "ID_TEMA"=id_tematico) where id_bersaglio=16;
