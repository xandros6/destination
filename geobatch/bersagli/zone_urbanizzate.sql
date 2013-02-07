insert into siig_geo_bers_non_umano_pl(idgeo_bers_non_umano_pl,geometria)
select 715000+fid,the_geom
from "RP_V_BNU_ZURB_C_02";

insert into siig_t_bersaglio_non_umano(id_tematico,id_bersaglio,id_partner,fk_bers_non_umano_pl,fk_classe_clc,superficie,fk_tipo_uso)
select "ID_TEMA",10,1,715000+fid,"FK_CLC","SUPERFICIE",0
from "RP_V_BNU_ZURB_C_02";