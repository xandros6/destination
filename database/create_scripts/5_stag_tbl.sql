
CREATE TABLE siig_t_processo (
	id_processo varchar(20) NOT NULL,
	data_creazione timestamp NOT NULL,
	data_chiusura_a timestamp,
	data_chiusura_b timestamp,
	data_chiusura_c timestamp
);
CREATE TABLE siig_t_log (
	id_tracciamento numeric(3) NOT NULL,
	progressivo numeric(3) NOT NULL,
	codice_log varchar(256),
	descr_errore varchar(1000),
	id_tematico_shape_orig numeric(9)
);
CREATE TABLE siig_t_tracciamento (
	id_tracciamento numeric(3) NOT NULL,
	fk_processo varchar(20) NOT NULL,
	fk_bersaglio numeric(6),
	fk_partner varchar(5),
	codice_partner varchar(2) NOT NULL,
	nome_file varchar(50) NOT NULL,
	data timestamp NOT NULL,
	nr_rec_shape numeric(9) NOT NULL,
	nr_rec_storage numeric(9) NOT NULL,
	nr_rec_scartati numeric(9) NOT NULL,
	nr_rec_scartati_siig numeric(9) NOT NULL,
	data_imp_storage timestamp NOT NULL,
	data_elab timestamp NOT NULL,
	data_imp_siig timestamp,
	flg_tipo_imp char(1)
);
CREATE TABLE siig_geo_bers_calcrischio_pl (
	idgeo numeric(9) NOT NULL,
	id_tematico_shape numeric(9),
	fk_partner varchar(5) NOT NULL,
	fk_bersaglio numeric(6),
	geometria geometry('MULTIPOLYGON', 32632)
);
