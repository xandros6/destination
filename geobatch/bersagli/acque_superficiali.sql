insert into siig_geo_bers_non_umano_pl(idgeo_bers_non_umano_pl,geometria)
select 1924000+fid,the_geom
from "RP_V_BNU_ASUP_C_02";

insert into siig_t_bersaglio_non_umano(id_tematico,id_bersaglio,id_partner,fk_bers_non_umano_pl,denominazione,fk_classe_clc,toponimo_completo,superficie,fk_tipo_uso)
select "ID_TEMA",15,1,1924000+fid,"DENOM","FK_CLC","TOPONIMO","SUPERFICIE",0
from "RP_V_BNU_ASUP_C_02";

insert into siig_geo_bers_non_umano_ln(idgeo_bers_non_umano_ln,geometria)
select fid,the_geom
from "RP_V_BNU_ASUP_C_03";

update siig_t_bersaglio_non_umano set fk_bers_non_umano_ln=(select fid from "RP_V_BNU_ASUP_C_03" c where "ID_TEMA"=id_tematico) where id_bersaglio=15;