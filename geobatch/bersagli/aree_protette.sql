insert into siig_geo_bers_non_umano_pl(idgeo_bers_non_umano_pl,geometria)
select fid-2898,the_geom
from "RP_V_BNU_APROT_C_02";

insert into siig_t_bersaglio_non_umano(id_tematico,id_bersaglio,id_partner,fk_bers_non_umano_pl,denominazione,denominazione_ente,fk_iucn,superficie)
select "ID_TEMA",12,1,fid-2898,"DENOM","DENOM_ENTE","FK_IUCN","SUPERFICIE"
from "RP_V_BNU_APROT_C_02";