ALTER TABLE siig_t_processo ADD CONSTRAINT pk_siig_t_processo PRIMARY KEY (id_processo);
ALTER TABLE siig_t_log ADD CONSTRAINT pk_siig_t_log PRIMARY KEY (id_tracciamento,progressivo);
ALTER TABLE siig_t_tracciamento ADD CONSTRAINT pk_siig_t_tracciamento PRIMARY KEY (id_tracciamento);
ALTER TABLE siig_t_tracciamento ADD CONSTRAINT dom_c_i6 CHECK (FLG_TIPO_IMP IN ('C','I'));
ALTER TABLE siig_geo_bers_calcrischio_pl ADD CONSTRAINT pk_siig_geo_bers_calcrischio_p PRIMARY KEY (idgeo);

ALTER TABLE siig_t_log ADD CONSTRAINT fk_siig_t_tracciamento_01 FOREIGN KEY (id_tracciamento) REFERENCES siig_t_tracciamento (id_tracciamento) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_tracciamento ADD CONSTRAINT fk_siig_d_partner_03 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner (id_partner) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_tracciamento ADD CONSTRAINT fk_siig_t_bersaglio_10 FOREIGN KEY (fk_bersaglio) REFERENCES siig_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_tracciamento ADD CONSTRAINT fk_siig_t_processo_02 FOREIGN KEY (fk_processo) REFERENCES siig_t_processo (id_processo) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_geo_bers_calcrischio_pl ADD CONSTRAINT fk_siig_t_bersaglio_06 FOREIGN KEY (fk_bersaglio) REFERENCES siig_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_geo_bers_calcrischio_pl ADD CONSTRAINT fk_siig_d_partner_07 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner (id_partner) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

