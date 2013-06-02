CREATE INDEX idx_geo_arco_1_partner ON siig_geo_ln_arco_1(fk_partner);
CREATE INDEX idx_geo_arco_2_partner ON siig_geo_ln_arco_2(fk_partner);
CREATE INDEX idx_geo_arco_3_partner ON siig_geo_ln_arco_3(fk_partner);
alter table siig_r_tipovei_geoarco1 add fk_partner varchar(5) NULL;
CREATE INDEX idx_geo_arco_1_tipovei_partner ON siig_r_tipovei_geoarco1(fk_partner);
alter table siig_r_tipovei_geoarco2 add fk_partner varchar(5) NULL;
CREATE INDEX idx_geo_arco_2_tipovei_partner ON siig_r_tipovei_geoarco2(fk_partner);
alter table siig_r_tipovei_geoarco3 add fk_partner varchar(5) NULL;
CREATE INDEX idx_geo_arco_3_tipovei_partner ON siig_r_tipovei_geoarco3(fk_partner);

CREATE INDEX idx_tipovei_geo_arco_1 ON siig_r_tipovei_geoarco1(id_geo_arco);
CREATE INDEX idx_tipovei_geo_arco_2 ON siig_r_tipovei_geoarco1(id_geo_arco);
CREATE INDEX idx_tipovei_geo_arco_3 ON siig_r_tipovei_geoarco1(id_geo_arco);

ALTER TABLE siig_r_tipovei_geoarco1 ALTER COLUMN densita_veicolare TYPE NUMERIC(8,2);
ALTER TABLE siig_r_tipovei_geoarco1 ALTER COLUMN velocita_media TYPE NUMERIC(8,2);

ALTER TABLE siig_r_tipovei_geoarco2 ALTER COLUMN densita_veicolare TYPE NUMERIC(8,2);
ALTER TABLE siig_r_tipovei_geoarco2 ALTER COLUMN velocita_media TYPE NUMERIC(8,2);

ALTER TABLE siig_r_tipovei_geoarco3 ALTER COLUMN densita_veicolare TYPE NUMERIC(8,2);
ALTER TABLE siig_r_tipovei_geoarco3 ALTER COLUMN velocita_media TYPE NUMERIC(8,2);

alter table siig_r_arco_1_dissesto add fk_partner varchar(5) NULL;
CREATE INDEX idx_dissesto_geo_arco_1 ON siig_r_arco_1_dissesto(id_geo_arco);
CREATE INDEX idx_dissesto_1_partner ON siig_r_arco_1_dissesto(fk_partner);

alter table siig_r_arco_2_dissesto add fk_partner varchar(5) NULL;
CREATE INDEX idx_dissesto_geo_arco_2 ON siig_r_arco_2_dissesto(id_geo_arco);
CREATE INDEX idx_dissesto_2_partner ON siig_r_arco_2_dissesto(fk_partner);

alter table siig_r_arco_3_dissesto add fk_partner varchar(5) NULL;
CREATE INDEX idx_dissesto_geo_arco_3 ON siig_r_arco_3_dissesto(id_geo_arco);
CREATE INDEX idx_dissesto_3_partner ON siig_r_arco_3_dissesto(fk_partner);

ALTER TABLE siig_p.siig_geo_ln_arco_3 ALTER COLUMN lunghezza TYPE NUMERIC(8,0);
