--MODIFICHE DAL 26/04/2013


------------------------------
-- RICHIESTE Da GEOSOLUTION
------------------------------
ALTER TABLE siig_geo_ln_arco_3 ALTER COLUMN lunghezza TYPE NUMERIC(8,0);

ALTER TABLE siig_t_processo ALTER COLUMN id_processo TYPE NUMERIC(6,0);
ALTER TABLE siig_t_tracciamento ALTER COLUMN fk_processo TYPE NUMERIC(6,0);

/*********************************************************
effettuate su DB (SVI & TST)														 *
su modello erwin																				 *
su script iniziale (no patch) PROD + STAGING						 *
*********************************************************/


CREATE INDEX idx_bers_non_umano_geo_ln ON siig_t_bersaglio_non_umano(fk_bers_non_umano_ln);
CREATE INDEX idx_bers_non_umano_geo_pt ON siig_t_bersaglio_non_umano(fk_bers_non_umano_pt);
CREATE INDEX idx_bers_non_umano_geo_pl ON siig_t_bersaglio_non_umano(fk_bers_non_umano_pl);

CREATE INDEX idx_bersaglio_non_umano_bersaglio_partner ON siig_t_bersaglio_non_umano(id_bersaglio,id_partner);

CREATE INDEX idx_bers_umano_geo_pl ON siig_t_bersaglio_umano(fk_bersaglio_umano_pl);
CREATE INDEX idx_bers_umano_geo_pt ON siig_t_bersaglio_umano(fk_bersaglio_umano_pt);

CREATE INDEX idx_bersaglio_umano_bersaglio_partner ON siig_t_bersaglio_umano(id_bersaglio,id_partner);

/*********************************************************
su modello erwin		           PROD + STAGING						 *
su script iniziale (no patch)  PROD + STAGING					   *
*********************************************************/
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------



ALTER TABLE siig_t_bersaglio_umano RENAME denominazione  TO denominazione_it;
ALTER TABLE siig_t_bersaglio_umano RENAME denominazione_comune  TO denominazione_comune_it;
ALTER TABLE siig_t_bersaglio_umano RENAME insegna  TO insegna_it;
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN denominazione_it character varying(250);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN denominazione_en character varying(250);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN denominazione_de character varying(250);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN denominazione_fr character varying(250);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN denominazione_comune_it character varying(100);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN denominazione_comune_en character varying(100);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN denominazione_comune_de character varying(100);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN denominazione_comune_fr character varying(100);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN insegna_it character varying(250);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN insegna_en character varying(250);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN insegna_de character varying(250);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN insegna_fr character varying(250);
ALTER TABLE siig_t_bersaglio_umano ADD COLUMN flg_nr_addetti_ind character varying(1)
CONSTRAINT dom_s_c57 CHECK (flg_nr_addetti_ind::text = ANY (ARRAY['C'::character varying, 'S'::character varying]::text[]));


ALTER TABLE siig_t_bersaglio_non_umano RENAME denominazione  TO denominazione_it;
ALTER TABLE siig_t_bersaglio_non_umano RENAME denominazione_ente  TO denominazione_ente_it;
ALTER TABLE siig_t_bersaglio_non_umano RENAME toponimo_completo  TO toponimo_completo_it;

ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN denominazione_it character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN denominazione_en character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN denominazione_de character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN denominazione_fr character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN denominazione_ente_it character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN denominazione_ente_en character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN denominazione_ente_de character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN denominazione_ente_fr character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN toponimo_completo_it character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN toponimo_completo_en character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN toponimo_completo_de character varying(250);
ALTER TABLE siig_t_bersaglio_non_umano ADD COLUMN toponimo_completo_fr character varying(250);

/*********************************************************
su modello erwin		           PROD + STAGING						 *
su db di test 																					 *
patch                          PROD + STAGING					   *
*********************************************************/





-- drop viste da cui dipendono le colonne da droppare
drop view v_geo_ospedale_pl;
drop view v_geo_ospedale_pt;
drop view v_geo_scuola_pl ;
drop view v_geo_scuola_pt ;
drop view v_geo_aree_protette_pl ;
drop view v_geo_beni_culturali_pl ;
drop view v_geo_beni_culturali_pt ;
drop view v_geo_industria_pl  ;
drop view v_geo_industria_pt   ;
DROP VIEW v_geo_commercio_pl;	
DROP VIEW v_geo_acque_sotterranee_pl;
DROP VIEW v_geo_acque_sotterranee_pt;
DROP VIEW v_geo_acque_superficiali_ln;
DROP VIEW v_geo_acque_superficiali_pl;
DROP VIEW v_geo_aree_agricole_pl;
DROP VIEW v_geo_aree_boscate_pl;
DROP VIEW v_geo_popolazione_residente_pl;
DROP VIEW v_geo_popolazione_residente_pt;
DROP VIEW v_geo_popolazione_turistica_pl;
DROP VIEW v_geo_zone_urbanizzate_pl;  


ALTER TABLE siig_d_tipo_uso RENAME descrizione_uso  TO descrizione_uso_it;
ALTER TABLE siig_d_classe_clc RENAME descrizione_clc  TO descrizione_clc_it;
ALTER TABLE siig_d_iucn RENAME descrizione_iucn  TO descrizione_iucn_it;
ALTER TABLE siig_d_tipo_captazione RENAME descrizione  TO descrizione_it;
ALTER TABLE siig_d_bene_culturale RENAME tipologia  TO tipologia_it;
ALTER TABLE siig_d_ateco RENAME descrizione_ateco  TO descrizione_ateco_it;
ALTER TABLE siig_d_classe_adr RENAME descrizione  TO descrizione_it;
ALTER TABLE siig_d_dissesto RENAME descrizione  TO descrizione_it;
ALTER TABLE siig_d_gravita RENAME descrizione  TO descrizione_it;
ALTER TABLE siig_d_partner RENAME partner  TO partner_it;
ALTER TABLE siig_d_stato_fisico RENAME descrizione  TO descrizione_it;
ALTER TABLE siig_d_tipo_contenitore RENAME descrizione  TO descrizione_it;
ALTER TABLE siig_d_tipo_trasporto RENAME descrizione  TO descrizione_it;
ALTER TABLE siig_d_tipo_veicolo RENAME tipo_veicolo  TO tipo_veicolo_it;
ALTER TABLE siig_t_bersaglio RENAME descrizione  TO descrizione_it;

ALTER TABLE siig_d_tipo_uso DROP COLUMN codice_uso;
ALTER TABLE siig_d_tipo_uso ADD COLUMN descrizione_uso_it character varying(1000);
ALTER TABLE siig_d_tipo_uso ADD COLUMN descrizione_uso_en character varying(1000);
ALTER TABLE siig_d_tipo_uso ADD COLUMN descrizione_uso_de character varying(1000);
ALTER TABLE siig_d_tipo_uso ADD COLUMN descrizione_uso_fr character varying(1000);

ALTER TABLE siig_d_classe_clc ADD COLUMN descrizione_clc_it character varying(1000);
ALTER TABLE siig_d_classe_clc ADD COLUMN descrizione_clc_en character varying(1000);
ALTER TABLE siig_d_classe_clc ADD COLUMN descrizione_clc_de character varying(1000);
ALTER TABLE siig_d_classe_clc ADD COLUMN descrizione_clc_fr character varying(1000);

ALTER TABLE siig_d_iucn DROP COLUMN codice_iucn;
ALTER TABLE siig_d_iucn ADD COLUMN descrizione_iucn_it character varying(1000);
ALTER TABLE siig_d_iucn ADD COLUMN descrizione_iucn_en character varying(1000);
ALTER TABLE siig_d_iucn ADD COLUMN descrizione_iucn_de character varying(1000);
ALTER TABLE siig_d_iucn ADD COLUMN descrizione_iucn_fr character varying(1000);

ALTER TABLE siig_d_tipo_captazione ADD COLUMN descrizione_it character varying(1000);
ALTER TABLE siig_d_tipo_captazione ADD COLUMN descrizione_en character varying(1000);
ALTER TABLE siig_d_tipo_captazione ADD COLUMN descrizione_de character varying(1000);
ALTER TABLE siig_d_tipo_captazione ADD COLUMN descrizione_fr character varying(1000);

ALTER TABLE siig_d_bene_culturale DROP COLUMN cod_bene;
ALTER TABLE siig_d_bene_culturale ADD COLUMN tipologia_it character varying(250);
ALTER TABLE siig_d_bene_culturale ADD COLUMN tipologia_en character varying(250);
ALTER TABLE siig_d_bene_culturale ADD COLUMN tipologia_de character varying(250);
ALTER TABLE siig_d_bene_culturale ADD COLUMN tipologia_fr character varying(250);

ALTER TABLE siig_d_ateco DROP COLUMN codice_ateco;
ALTER TABLE siig_d_ateco ADD COLUMN descrizione_ateco_it character varying(1000);
ALTER TABLE siig_d_ateco ADD COLUMN descrizione_ateco_en character varying(1000);
ALTER TABLE siig_d_ateco ADD COLUMN descrizione_ateco_de character varying(1000);
ALTER TABLE siig_d_ateco ADD COLUMN descrizione_ateco_fr character varying(1000);

ALTER TABLE siig_d_classe_adr ADD COLUMN descrizione_it character varying(100);
ALTER TABLE siig_d_classe_adr ADD COLUMN descrizione_en character varying(100);
ALTER TABLE siig_d_classe_adr ADD COLUMN descrizione_de character varying(100);
ALTER TABLE siig_d_classe_adr ADD COLUMN descrizione_fr character varying(100);

ALTER TABLE siig_d_dissesto ADD COLUMN descrizione_it character varying(250);
ALTER TABLE siig_d_dissesto ADD COLUMN descrizione_en character varying(250);
ALTER TABLE siig_d_dissesto ADD COLUMN descrizione_de character varying(250);
ALTER TABLE siig_d_dissesto ADD COLUMN descrizione_fr character varying(250);

ALTER TABLE siig_d_gravita ADD COLUMN descrizione_it character varying(50);
ALTER TABLE siig_d_gravita ADD COLUMN descrizione_en character varying(50);
ALTER TABLE siig_d_gravita ADD COLUMN descrizione_de character varying(50);
ALTER TABLE siig_d_gravita ADD COLUMN descrizione_fr character varying(50);

ALTER TABLE siig_d_partner ADD COLUMN partner_it character varying(50);
ALTER TABLE siig_d_partner ADD COLUMN partner_en character varying(50);
ALTER TABLE siig_d_partner ADD COLUMN partner_de character varying(50);
ALTER TABLE siig_d_partner ADD COLUMN partner_fr character varying(50);

ALTER TABLE siig_d_stato_fisico ADD COLUMN descrizione_it character varying(100);
ALTER TABLE siig_d_stato_fisico ADD COLUMN descrizione_en character varying(100);
ALTER TABLE siig_d_stato_fisico ADD COLUMN descrizione_de character varying(100);
ALTER TABLE siig_d_stato_fisico ADD COLUMN descrizione_fr character varying(100);

ALTER TABLE siig_d_tipo_contenitore ADD COLUMN descrizione_it character varying(100);
ALTER TABLE siig_d_tipo_contenitore ADD COLUMN descrizione_en character varying(100);
ALTER TABLE siig_d_tipo_contenitore ADD COLUMN descrizione_de character varying(100);
ALTER TABLE siig_d_tipo_contenitore ADD COLUMN descrizione_fr character varying(100);

ALTER TABLE siig_d_tipo_trasporto ADD COLUMN descrizione_it character varying(100);
ALTER TABLE siig_d_tipo_trasporto ADD COLUMN descrizione_en character varying(100);
ALTER TABLE siig_d_tipo_trasporto ADD COLUMN descrizione_de character varying(100);
ALTER TABLE siig_d_tipo_trasporto ADD COLUMN descrizione_fr character varying(100);

ALTER TABLE siig_d_tipo_veicolo ADD COLUMN tipo_veicolo_it character varying(100);
ALTER TABLE siig_d_tipo_veicolo ADD COLUMN tipo_veicolo_en character varying(100);
ALTER TABLE siig_d_tipo_veicolo ADD COLUMN tipo_veicolo_de character varying(100);
ALTER TABLE siig_d_tipo_veicolo ADD COLUMN tipo_veicolo_fr character varying(100);

ALTER TABLE siig_t_bersaglio ADD COLUMN descrizione_it character varying(100);
ALTER TABLE siig_t_bersaglio ADD COLUMN descrizione_en character varying(100);
ALTER TABLE siig_t_bersaglio ADD COLUMN descrizione_de character varying(100);
ALTER TABLE siig_t_bersaglio ADD COLUMN descrizione_fr character varying(100);



create table siig_d_tipo_variabile (
       id_tipo_variabile    numeric(2,0) not null,
       tipo_variabile       character varying(50) not null
);


alter table siig_d_tipo_variabile
       add  constraint pk_siig_d_tipo_variabile primary key (
              id_tipo_variabile)  ;


create table siig_t_variabile (
       id_variabile         numeric(3,0) not null,
       fk_tipo_variabile    numeric(2,0) not null,
       descrizione_it       character varying(100) not null,
       descrizione_en       character varying(100) not null,
       descrizione_de       character varying(100) not null,
       descrizione_fr       character varying(100) not null,
       coefficiente         numeric(6,3) null
);


alter table siig_t_variabile
       add  constraint pk_siig_t_variabile primary key (
              id_variabile) ;


alter table siig_t_variabile
       add  constraint fk_siig_d_tipo_variabile_01
              foreign key (fk_tipo_variabile)
                             references siig_d_tipo_variabile ;



INSERT INTO siig_d_tipo_variabile(
            id_tipo_variabile, tipo_variabile)
    VALUES (1, 'Temporale');

INSERT INTO siig_d_tipo_variabile(
            id_tipo_variabile, tipo_variabile)
    VALUES (2, 'Meteo');

commit;



INSERT INTO siig_t_variabile(
   id_variabile, fk_tipo_variabile, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, coefficiente)
VALUES (1, 2, 'Normale/standard', 'Normal/standard','Normal/standard','Normal/standard',1);

INSERT INTO siig_t_variabile(
   id_variabile, fk_tipo_variabile, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, coefficiente)
VALUES (2, 2, 'Presenza nebbia', 'presence fog','Presence nebel','Brouillard de présence',1);

INSERT INTO siig_t_variabile(
   id_variabile, fk_tipo_variabile, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, coefficiente)
VALUES (3, 2, 'Presenza ghiaccio', 'Presence ice','Presence eis','Glace de présence',1);

INSERT INTO siig_t_variabile(
   id_variabile, fk_tipo_variabile, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, coefficiente)
VALUES (4, 2, 'Presenza pioggia', 'Presence rain','Presence regen','Pluie de présence',1);
commit;

INSERT INTO siig_t_variabile(
   id_variabile, fk_tipo_variabile, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, coefficiente)
VALUES (5, 1, 'Scenario centrale', 'Central scenario','Zentral szenario','scénario central',1);

INSERT INTO siig_t_variabile(
   id_variabile, fk_tipo_variabile, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, coefficiente)
VALUES (6, 1, 'Scenario feriale diurno', 'Scenario weekday daytime','Szenario wochentagen tagsüber','Journée en semaine Scénario',1);

INSERT INTO siig_t_variabile(
   id_variabile, fk_tipo_variabile, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, coefficiente)
VALUES (7, 1, 'Scenario notturno', 'Night Scenery','Nacht-Landschaft','Paysage de nuit',1);

INSERT INTO siig_t_variabile(
   id_variabile, fk_tipo_variabile, descrizione_it, descrizione_en, descrizione_de, descrizione_fr, coefficiente)
VALUES (8, 1, 'Scenario festivo diurno', 'Scenario festive day','Szenario Festtag','Scénario journée festive',1);


---------------------------------------------------------------------------------

ALTER TABLE siig_r_tipovei_geoarco1 add column flg_velocita character varying (1) NULL
CONSTRAINT dom_1_scm CHECK (flg_velocita::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));

ALTER TABLE siig_r_tipovei_geoarco1 add column flg_densita_veicolare character varying (1) NULL
CONSTRAINT dom_2_scm CHECK (flg_densita_veicolare::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));


ALTER TABLE siig_r_tipovei_geoarco2 add column flg_velocita character varying (1) NULL
CONSTRAINT dom_3_scm CHECK (flg_velocita::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));

ALTER TABLE siig_r_tipovei_geoarco2 add column flg_densita_veicolare character varying (1) NULL
CONSTRAINT dom_4_scm CHECK (flg_densita_veicolare::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));


ALTER TABLE siig_r_tipovei_geoarco3 add column flg_velocita character varying (1) NULL
CONSTRAINT dom_5_scm CHECK (flg_velocita::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));

ALTER TABLE siig_r_tipovei_geoarco3 add column flg_densita_veicolare character varying (1) NULL
CONSTRAINT dom_6_scm CHECK (flg_densita_veicolare::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));


ALTER TABLE siig_geo_ln_arco_1 add column id_origine numeric(9,0);
ALTER TABLE siig_geo_ln_arco_2 add column id_origine numeric(9,0);
ALTER TABLE siig_geo_ln_arco_3 add column id_origine numeric(9,0);

ALTER TABLE siig_geo_ln_arco_1 add column flg_nr_corsie character varying (1) NULL
CONSTRAINT dom_7_scm CHECK (flg_nr_corsie::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));
ALTER TABLE siig_geo_ln_arco_1 add column flg_nr_incidenti character varying (1) NULL
CONSTRAINT dom_8_scm CHECK (flg_nr_incidenti::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));

ALTER TABLE siig_geo_ln_arco_2 add column flg_nr_corsie character varying (1) NULL
CONSTRAINT dom_9_scm CHECK (flg_nr_corsie::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));
ALTER TABLE siig_geo_ln_arco_2 add column flg_nr_incidenti character varying (1) NULL
CONSTRAINT dom_10_scm CHECK (flg_nr_incidenti::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));

ALTER TABLE siig_geo_ln_arco_3 add column flg_nr_corsie character varying (1) NULL
CONSTRAINT dom_11_scm CHECK (flg_nr_corsie::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));
ALTER TABLE siig_geo_ln_arco_3 add column flg_nr_incidenti character varying (1) NULL
CONSTRAINT dom_12_scm CHECK (flg_nr_incidenti::text = ANY (ARRAY['C'::character varying, 'S'::character varying, 'M'::character varying]::text[]));

