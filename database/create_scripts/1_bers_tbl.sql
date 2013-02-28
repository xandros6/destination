CREATE TABLE siig_r_arco_2_scen_tipobers (
	id_geo_arco numeric(9) NOT NULL,
	id_scenario numeric(9) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	cff decimal(4,3)
);
CREATE TABLE siig_r_arco_3_dissesto (
	id_dissesto varchar(20) NOT NULL,
	id_geo_arco numeric(9) NOT NULL
);
CREATE TABLE siig_geo_bersaglio_umano_pt (
	idgeo_bersaglio_umano_pt numeric(9) NOT NULL,
	geometria geometry('POINT', 32632)
);
CREATE TABLE siig_t_scenario (
	id_scenario numeric(9) NOT NULL,
	codice varchar(2),
	tipologia varchar(100),
	tempo_di_coda numeric(4)
);
CREATE TABLE siig_d_tipo_veicolo (
	id_tipo_veicolo numeric(2) NOT NULL,
	tipo_veicolo varchar(100) NOT NULL,
	coeff_occupazione decimal(4,2)
);
CREATE TABLE siig_d_classe_clc (
	id_classe_clc numeric(4) NOT NULL,
	codice_clc varchar(6),
	descrizione_clc varchar(1000)
);
CREATE TABLE siig_d_gravita (
	id_gravita numeric(2) NOT NULL,
	fk_bersaglio numeric(6) NOT NULL,
	descrizione varchar(50)
);
CREATE TABLE siig_geo_ln_arco_3 (
	id_geo_arco numeric(9) NOT NULL,
	nr_incidenti numeric(5),
	nr_incidenti_elab numeric(5),
	nr_corsie numeric(2) DEFAULT 2,
	lunghezza numeric(5),
	nr_bers_umani_strada numeric(5),
	id_tematico_shape numeric(9),
	fk_partner varchar(5) NOT NULL,
	geometria geometry('LINESTRING', 32632) NOT NULL
);
CREATE TABLE siig_r_area_danno (
	id_gravita numeric(2) NOT NULL,
	id_scenario numeric(9) NOT NULL,
	id_sostanza numeric(3) NOT NULL,
	id_tipologia_danno numeric(2) NOT NULL,
	flg_lieve numeric(1) DEFAULT 0,
	fk_distanza numeric(2) NOT NULL
);
CREATE TABLE siig_r_arco_3_scen_tipobers (
	id_geo_arco numeric(9) NOT NULL,
	id_scenario numeric(9) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	cff decimal(4,3)
);
CREATE TABLE siig_d_tipo_uso (
	id_tipo_uso numeric(6) NOT NULL,
	codice_uso varchar(8),
	descrizione_uso varchar(1000)
);
CREATE TABLE siig_t_elab_standard_2 (
	flg_lieve numeric(1) DEFAULT 0,
	id_geo_arco numeric(9) NOT NULL,
	id_scenario numeric(9) NOT NULL,
	id_sostanza numeric(3) NOT NULL,
	id_distanza numeric(2) NOT NULL,
	calc_formula_tot numeric(8),
	calc_formula_soc numeric(8),
	calc_formula_amb numeric(8),
	calc_formula_scuole numeric(8),
	calc_formula_ospedali numeric(8),
	calc_formula_distrib numeric(8),
	calc_formula_residenti numeric(8),
	calc_formula_servizi numeric(8),
	calc_formula_turisti_medi numeric(8),
	calc_formula_turisti_max numeric(8),
	calc_formula_flusso numeric(8),
	calc_formula_aree_protette decimal(12,2),
	calc_formula_aree_agricole decimal(12,2),
	calc_formula_aree_boscate decimal(12,2),
	calc_formula_beni_culturali decimal(12,2),
	calc_formula_zone_urbanizzate decimal(12,2),
	calc_formula_acque_superf numeric(14),
	calc_formula_acque_sotterranee numeric(14)
);
CREATE TABLE siig_geo_bers_non_umano_pt (
	idgeo_bers_non_umano_pt numeric(9) NOT NULL,
	geometria geometry('POINT', 32632)
);
CREATE TABLE siig_mtd_r_formula_parametro (
	id_formula numeric(3) NOT NULL,
	id_parametro numeric(4) NOT NULL,
	numero_ordine numeric(2),
	operatore varchar(5)
);
CREATE TABLE siig_geo_bers_non_umano_ln (
	idgeo_bers_non_umano_ln numeric(9) NOT NULL,
	geometria geometry('MULTILINESTRING', 32632)
);
CREATE TABLE siig_d_ateco (
	id_ateco numeric(8) NOT NULL,
	codice_ateco varchar(20),
	descrizione_ateco varchar(1000)
);
CREATE TABLE siig_t_vulnerabilita_2 (
	id_geo_arco numeric(9) NOT NULL,
	id_distanza numeric(2) NOT NULL,
	nr_pers_scuole numeric(7),
	nr_pers_ospedali numeric(7),
	nr_pers_distrib numeric(7),
	nr_pers_residenti numeric(7),
	nr_pers_servizi numeric(7),
	nr_turisti_medi numeric(7),
	nr_turisti_max numeric(7),
	nr_pers_flusso_buffer numeric(7),
	mq_aree_protette decimal(10,2),
	mq_aree_agricole decimal(10,2),
	mq_aree_boscate decimal(10,2),
	mq_beni_culturali decimal(10,2),
	mq_zone_urbanizzate decimal(10,2),
	mq_acque_superficiali numeric(12),
	mq_acque_sotterranee numeric(12)
);
CREATE TABLE siig_r_arco_1_scen_tipobers (
	id_scenario numeric(9) NOT NULL,
	id_geo_arco numeric(9) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	cff decimal(4,3)
);
CREATE TABLE siig_geo_bersaglio_umano_pl (
	idgeo_bersaglio_umano_pl numeric(9) NOT NULL,
	geometria geometry('MULTIPOLYGON', 32632)
);
CREATE TABLE siig_t_vulnerabilita_3 (
	id_geo_arco numeric(9) NOT NULL,
	id_distanza numeric(2) NOT NULL,
	nr_pers_scuole numeric(7),
	nr_pers_ospedali numeric(7),
	nr_pers_distrib numeric(7),
	nr_pers_residenti numeric(7),
	nr_pers_servizi numeric(7),
	nr_turisti_medi numeric(7),
	nr_turisti_max numeric(7),
	nr_pers_flusso_buffer numeric(7),
	mq_aree_protette decimal(10,2),
	mq_aree_agricole decimal(10,2),
	mq_aree_boscate decimal(10,2),
	mq_beni_culturali decimal(10,2),
	mq_zone_urbanizzate decimal(10,2),
	mq_acque_superficiali numeric(12),
	mq_acque_sotterranee numeric(12)
);
CREATE TABLE siig_t_bersaglio_umano (
	id_tematico numeric(9) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	id_partner varchar(5) NOT NULL,
	fk_bersaglio_umano_pl numeric(9),
	fk_bersaglio_umano_pt numeric(9),
	fk_tipo_uso numeric(6),
	fk_ateco numeric(8),
	denominazione varchar(250),
	addetti numeric(6),
	utenti numeric(6),
	iscritti numeric(6),
	insegna varchar(250),
	sup_vendita decimal(8,2),
	cod_fisc varchar(16),
	residenti numeric(6),
	letti_day numeric(4),
	letti_o numeric(5),
	nat_code varchar(8),
	pres_max numeric(8),
	pres_med numeric(8),
	flg_letti_ordinari varchar(1),
	flg_letti_day_h varchar(1),
	flg_nr_addetti_h varchar(1),
	flg_nr_iscritti varchar(1),
	flg_nr_addetti_scuole varchar(1),
	flg_nr_utenti varchar(1),
	flg_nr_addetti_comm varchar(1),
	denominazione_comune varchar(100)
);
CREATE TABLE siig_geo_ln_arco_1 (
	id_geo_arco numeric(9) NOT NULL,
	nr_incidenti numeric(5),
	nr_incidenti_elab numeric(5),
	nr_corsie numeric(2) DEFAULT 2,
	lunghezza numeric(5),
	nr_bers_umani_strada numeric(5),
	id_tematico_shape numeric(9),
	fk_partner varchar(5) NOT NULL,
	geometria geometry('LINESTRING', 32632) NOT NULL
);
CREATE TABLE siig_r_arco_3_sostanza (
	id_geo_arco numeric(9) NOT NULL,
	id_sostanza numeric(3) NOT NULL,
	padr decimal(4,3)
);
CREATE TABLE siig_mtd_t_bersaglio (
	id_bersaglio numeric(6) NOT NULL,
	col_elab_standard varchar(30) NOT NULL,
	col_vulnerabilita varchar(30)
);
CREATE TABLE siig_mtd_t_parametro (
	id_parametro numeric(4) NOT NULL,
	descrizione varchar(30),
	flg_i numeric(1),
	flg_j numeric(1),
	flg_k numeric(1),
	flg_m numeric(1),
	punto_g numeric(1)
);
CREATE TABLE siig_d_iucn (
	id_iucn numeric(6) NOT NULL,
	codice_iucn varchar(20),
	descrizione_iucn varchar(1000)
);
CREATE TABLE siig_mtd_r_formula_criterio (
	id_criterio numeric(2) NOT NULL,
	id_formula numeric(3) NOT NULL,
	flg_obbligatorio numeric(1) DEFAULT 0
);
CREATE TABLE siig_mtd_r_param_bers_arco (
	id_parametro numeric(4) NOT NULL,
	id_arco numeric(2) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	nome_tavola varchar(30) NOT NULL,
	def_select varchar(500)
);
CREATE TABLE siig_t_bersaglio (
	id_bersaglio numeric(6) NOT NULL,
	flg_umano numeric(1) NOT NULL,
	descrizione varchar(100) NOT NULL,
	fp decimal(4,3)
);
CREATE TABLE siig_d_bene_culturale (
	id_tipo_bene numeric(6) NOT NULL,
	cod_bene varchar(20),
	tipologia varchar(250)
);
CREATE TABLE siig_d_tipologia_danno (
	id_tipologia_danno numeric(2) NOT NULL,
	tipologia_danno varchar(100) NOT NULL,
	flg_umano varchar(1) NOT NULL
);
CREATE TABLE siig_r_arco_1_sostanza (
	id_geo_arco numeric(9) NOT NULL,
	id_sostanza numeric(3) NOT NULL,
	padr decimal(4,3)
);
CREATE TABLE siig_d_tipo_trasporto (
	id_tipo_trasporto numeric(6) NOT NULL,
	descrizione varchar(100) NOT NULL
);
CREATE TABLE siig_mtd_t_formula (
	id_formula numeric(3) NOT NULL,
	fk_figlio numeric(3),
	descrizione varchar(200),
	operatore_catena varchar(5),
	udm varchar(50),
	flg_visibile numeric(1) DEFAULT 0,
	flg_j_sommatoria numeric(1) DEFAULT 0,
	flg_k_sommatoria numeric(1) DEFAULT 0,
	g_sommatoria numeric(1) DEFAULT 0,
	flg_i_grid numeric(1) DEFAULT 0,
	flg_costante numeric(1) DEFAULT 0
);
CREATE TABLE siig_r_tipovei_geoarco1 (
	id_tipo_veicolo numeric(2) NOT NULL,
	id_geo_arco numeric(9) NOT NULL,
	densita_veicolare decimal(6,2),
	velocita_media decimal(6,2)
);
CREATE TABLE siig_r_arco_2_dissesto (
	id_dissesto varchar(20) NOT NULL,
	id_geo_arco numeric(9) NOT NULL
);
CREATE TABLE siig_r_dist_arco2scentipobers (
	id_distanza numeric(2) NOT NULL,
	id_geo_arco numeric(9) NOT NULL,
	id_scenario numeric(9) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	utenti_carr_bersaglio numeric(6),
	utenti_carr_sede_inc numeric(6)
);
CREATE TABLE siig_d_distanza (
	id_distanza numeric(2) NOT NULL,
	distanza numeric(6) NOT NULL
);
CREATE TABLE siig_geo_bers_non_umano_pl (
	idgeo_bers_non_umano_pl numeric(9) NOT NULL,
	geometria geometry('MULTIPOLYGON', 32632)
);
CREATE TABLE siig_d_classe_adr (
	id_classe_adr numeric(3) NOT NULL,
	descrizione varchar(100),
	classe varchar(10)
);
CREATE TABLE siig_d_tipo_captazione (
	id_tipo_captazione numeric(6) NOT NULL,
	descrizione varchar(1000)
);
CREATE TABLE siig_d_dissesto (
	id_dissesto varchar(20) NOT NULL,
	descrizione varchar(250),
	pter decimal(4,3)
);
CREATE TABLE siig_t_bersaglio_non_umano (
	id_tematico numeric(9) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	id_partner varchar(5) NOT NULL,
	fk_tipo_uso numeric(6),
	fk_tipo_captazione numeric(6),
	fk_bers_non_umano_pl numeric(9),
	fk_bers_non_umano_ln numeric(9),
	fk_bers_non_umano_pt numeric(9),
	fk_classe_clc numeric(4),
	fk_iucn numeric(6),
	fk_tipo_bene numeric(6),
	area_buffer numeric(7),
	denominazione varchar(250),
	superficie decimal(11,2),
	denominazione_ente varchar(255),
	profondita_max decimal(5,2),
	quota_pdc numeric(4),
	toponimo_completo varchar(1000),
	eliminato_descrizione_bene varchar(250)
);
CREATE TABLE siig_r_scenario_sostanza (
	id_scenario numeric(9) NOT NULL,
	id_sostanza numeric(3) NOT NULL,
	flg_lieve numeric(1) DEFAULT 0,
	psc decimal(4,3)
);
CREATE TABLE siig_r_dist_arco1scentipobers (
	id_distanza numeric(2) NOT NULL,
	id_geo_arco numeric(9) NOT NULL,
	id_scenario numeric(9) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	utenti_carr_bersaglio numeric(6),
	utenti_carr_sede_inc numeric(6)
);
CREATE TABLE siig_r_arco_2_sostanza (
	id_geo_arco numeric(9) NOT NULL,
	id_sostanza numeric(3) NOT NULL,
	padr decimal(4,3)
);
CREATE TABLE siig_r_scenario_gravita (
	id_scenario numeric(9) NOT NULL,
	id_gravita numeric(2) NOT NULL,
	suscettibilita decimal(5,4)
);
CREATE TABLE siig_r_tipovei_geoarco2 (
	id_tipo_veicolo numeric(2) NOT NULL,
	id_geo_arco numeric(9) NOT NULL,
	densita_veicolare decimal(6,2),
	velocita_media decimal(6,2)
);
CREATE TABLE siig_d_stato_fisico (
	id_stato_fisico numeric(2) NOT NULL,
	descrizione varchar(100) NOT NULL
);
CREATE TABLE siig_mtd_r_formula_elab (
	id_elaborazione numeric(2) NOT NULL,
	id_formula numeric(3) NOT NULL
);
CREATE TABLE siig_r_dist_arco3scentipobers (
	id_distanza numeric(2) NOT NULL,
	id_geo_arco numeric(9) NOT NULL,
	id_scenario numeric(9) NOT NULL,
	id_bersaglio numeric(6) NOT NULL,
	utenti_carr_bersaglio numeric(6),
	utenti_carr_sede_inc numeric(6)
);
CREATE TABLE siig_mtd_d_arco (
	id_arco numeric(2) NOT NULL,
	descrizione_arco varchar(20) NOT NULL
);
CREATE TABLE siig_t_vulnerabilita_1 (
	id_geo_arco numeric(9) NOT NULL,
	id_distanza numeric(2) NOT NULL,
	nr_pers_scuole numeric(7),
	nr_pers_ospedali numeric(7),
	nr_pers_distrib numeric(7),
	nr_pers_residenti numeric(7),
	nr_pers_servizi numeric(7),
	nr_turisti_medi numeric(7),
	nr_turisti_max numeric(7),
	nr_pers_flusso_buffer numeric(7),
	mq_aree_protette decimal(10,2),
	mq_aree_agricole decimal(10,2),
	mq_aree_boscate decimal(10,2),
	mq_beni_culturali decimal(10,2),
	mq_zone_urbanizzate decimal(10,2),
	mq_acque_superficiali numeric(12),
	mq_acque_sotterranee numeric(12)
);
CREATE TABLE siig_mtd_d_elaborazione (
	id_elaborazione numeric(2) NOT NULL,
	descrizione_elaborazione varchar(50) NOT NULL
);
CREATE TABLE siig_t_elab_standard_1 (
	flg_lieve numeric(1) DEFAULT 0,
	id_geo_arco numeric(9) NOT NULL,
	id_distanza numeric(2) NOT NULL,
	id_scenario numeric(9) NOT NULL,
	id_sostanza numeric(3) NOT NULL,
	calc_formula_tot numeric(8),
	calc_formula_soc numeric(8),
	calc_formula_amb numeric(8),
	calc_formula_scuole numeric(8),
	calc_formula_ospedali numeric(8),
	calc_formula_distrib numeric(8),
	calc_formula_residenti numeric(8),
	calc_formula_servizi numeric(8),
	calc_formula_turisti_medi numeric(8),
	calc_formula_turisti_max numeric(8),
	calc_formula_flusso numeric(8),
	calc_formula_aree_protette decimal(12,2),
	calc_formula_aree_agricole decimal(12,2),
	calc_formula_aree_boscate decimal(12,2),
	calc_formula_beni_culturali decimal(12,2),
	calc_formula_zone_urbanizzate decimal(12,2),
	calc_formula_acque_superf numeric(14),
	calc_formula_acque_sotterranee numeric(14)
);
CREATE TABLE siig_mtd_d_criterio_filtro (
	id_criterio numeric(2) NOT NULL,
	descrizione_criterio varchar(50) NOT NULL
);
CREATE TABLE siig_r_arco_1_dissesto (
	id_geo_arco numeric(9) NOT NULL,
	id_dissesto varchar(20) NOT NULL
);
CREATE TABLE siig_t_sostanza (
	id_sostanza numeric(3) NOT NULL,
	fk_classe_adr numeric(3) NOT NULL,
	fk_tipo_contenitore numeric(2) NOT NULL,
	fk_tipo_trasporto numeric(6) NOT NULL,
	fk_stato_fisico numeric(2) NOT NULL,
	numero_kemler varchar(5),
	numero_onu varchar(5),
	nome_sostanza varchar(100),
	condizione_operativa varchar(100)
);
CREATE TABLE siig_geo_ln_arco_2 (
	id_geo_arco numeric(9) NOT NULL,
	nr_incidenti numeric(5),
	nr_incidenti_elab numeric(5),
	nr_corsie numeric(2) DEFAULT 2,
	lunghezza numeric(5),
	nr_bers_umani_strada numeric(5),
	id_tematico_shape numeric(9),
	fk_partner varchar(5) NOT NULL,
	geometria geometry('LINESTRING', 32632) NOT NULL
);
CREATE TABLE siig_t_elab_standard_3 (
	flg_lieve numeric(1) DEFAULT 0,
	id_geo_arco numeric(9) NOT NULL,
	id_scenario numeric(9) NOT NULL,
	id_sostanza numeric(3) NOT NULL,
	id_distanza numeric(2) NOT NULL,
	calc_formula_tot numeric(8),
	calc_formula_soc numeric(8),
	calc_formula_amb numeric(8),
	calc_formula_scuole numeric(8),
	calc_formula_ospedali numeric(8),
	calc_formula_distrib numeric(8),
	calc_formula_residenti numeric(8),
	calc_formula_servizi numeric(8),
	calc_formula_turisti_medi numeric(8),
	calc_formula_turisti_max numeric(8),
	calc_formula_flusso numeric(8),
	calc_formula_aree_protette decimal(12,2),
	calc_formula_aree_agricole decimal(12,2),
	calc_formula_aree_boscate decimal(12,2),
	calc_formula_beni_culturali decimal(12,2),
	calc_formula_zone_urbanizzate decimal(12,2),
	calc_formula_acque_superf numeric(14),
	calc_formula_acque_sotterranee numeric(14)
);
CREATE TABLE siig_r_tipovei_geoarco3 (
	id_tipo_veicolo numeric(2) NOT NULL,
	id_geo_arco numeric(9) NOT NULL,
	densita_veicolare decimal(6,2),
	velocita_media decimal(6,2)
);
CREATE TABLE siig_d_partner (
	id_partner varchar(5) NOT NULL,
	codice_partner varchar(2),
	partner varchar(50)
);
CREATE TABLE siig_d_tipo_contenitore (
	id_tipo_contenitore numeric(2) NOT NULL,
	descrizione varchar(100) NOT NULL
);
