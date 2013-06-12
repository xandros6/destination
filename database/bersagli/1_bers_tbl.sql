CREATE TABLE siig_geo_bers_non_umano_pt (
	idgeo_bers_non_umano_pt numeric(9) NOT NULL,
	geometria geometry
);
CREATE TABLE siig_d_iucn (
	id_iucn numeric(6) NOT NULL,
	codice_iucn varchar(20),
	descrizione_iucn varchar(1000)
);
CREATE TABLE siig_geo_bers_non_umano_ln (
	idgeo_bers_non_umano_ln numeric(9) NOT NULL,
	geometria geometry
);
CREATE TABLE siig_d_bene_culturale (
	id_tipo_bene numeric(6) NOT NULL,
	cod_bene varchar(20),
	tipologia varchar(250)
);
CREATE TABLE siig_geo_bersaglio_umano_pt (
	idgeo_bersaglio_umano_pt numeric(9) NOT NULL,
	geometria geometry
);
CREATE TABLE siig_d_ateco (
	id_ateco numeric(8) NOT NULL,
	codice_ateco varchar(20),
	descrizione_ateco varchar(1000)
);
CREATE TABLE siig_geo_bers_non_umano_pl (
	idgeo_bers_non_umano_pl numeric(9) NOT NULL,
	geometria geometry
);
CREATE TABLE siig_geo_bersaglio_umano_pl (
	idgeo_bersaglio_umano_pl numeric(9) NOT NULL,
	geometria geometry
);
CREATE TABLE siig_t_bersaglio_umano (
	id_tematico numeric(9) NOT NULL,
	fk_bersaglio_umano_pl numeric(9),
	fk_bersaglio_umano_pt numeric(9),
	fk_tipo_uso numeric(6),
	fk_ateco numeric(8),
	denominazione varchar(250),
	addetti numeric(6),
	iscritti numeric(6),
	utenti numeric(6),
	insegna varchar(250),
	sup_vendita decimal(8,2),
	cod_fisc varchar(16),
	residenti numeric(6),
	letti_day numeric(4),
	letti_o numeric(5),
	nat_code varchar(8),
	pres_max numeric(8),
	pres_med numeric(8),
	flg_letti_ordinari varchar(1) NOT NULL,
	flg_letti_day_h varchar(1) NOT NULL,
	flg_nr_addetti_h varchar(1) NOT NULL,
	flg_nr_iscritti varchar(1) NOT NULL,
	flg_nr_addetti_scuole varchar(1) NOT NULL,
	flg_nr_utenti varchar(1) NOT NULL,
	id_partner varchar(5) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	flg_nr_addetti_comm varchar(1) NOT NULL
);
CREATE TABLE siig_d_classe_clc (
	id_classe_clc numeric(4) NOT NULL,
	codice_clc varchar(6),
	descrizione_clc varchar(1000)
);
CREATE TABLE siig_d_tipo_captazione (
	id_tipo_captazione numeric(6) NOT NULL,
	descrizione varchar(1000)
);
CREATE TABLE siig_t_bersaglio_non_umano (
	id_tematico numeric(9) NOT NULL,
	fk_tipo_captazione numeric(6),
	fk_bers_non_umano_pl numeric(9),
	fk_bers_non_umano_ln numeric(9),
	fk_bers_non_umano_pt numeric(9),
	fk_classe_clc numeric(4),
	fk_iucn numeric(6),
	fk_tipo_bene numeric(6),
	area_buffer numeric(7),
	denominazione varchar(100),
	superficie decimal(9,2),
	denominazione_ente varchar(100),
	profondita_max decimal(5,2),
	quota_pdc numeric(4),
	fk_tipo_uso numeric(6) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	id_partner varchar(5) NOT NULL,
	toponimo_completo varchar(1000),
	descrizione_bene varchar(250)
);
CREATE TABLE siig_d_tipo_uso (
	id_tipo_uso numeric(6) NOT NULL,
	codice_uso varchar(8),
	descrizione_uso varchar(1000)
);
CREATE TABLE siig_d_partner (
	id_partner varchar(5) NOT NULL,
	codice_partner varchar(2),
	partner varchar(50)
);
