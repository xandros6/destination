
--\set ON_ERROR_STOP ON

ALTER TABLE siig_r_arco_2_scen_tipobers ADD CONSTRAINT pk_siig_r_arco_2_scen_tipobers PRIMARY KEY (id_geo_arco,id_scenario,id_bersaglio);
ALTER TABLE siig_r_arco_3_dissesto ADD CONSTRAINT pk_siig_r_arco_3_dissesto PRIMARY KEY (id_dissesto,id_geo_arco);
ALTER TABLE siig_geo_bersaglio_umano_pt ADD CONSTRAINT pk_siig_geo_bersaglio_umano_pt PRIMARY KEY (idgeo_bersaglio_umano_pt);
ALTER TABLE siig_t_scenario ADD CONSTRAINT pk_siig_t_scenario PRIMARY KEY (id_scenario);
ALTER TABLE siig_d_tipo_veicolo ADD CONSTRAINT pk_siig_d_tipo_veicolo PRIMARY KEY (id_tipo_veicolo);
ALTER TABLE siig_d_classe_clc ADD CONSTRAINT pk_siig_d_classe_clc PRIMARY KEY (id_classe_clc);
ALTER TABLE siig_d_gravita ADD CONSTRAINT pk_siig_d_gravita PRIMARY KEY (id_gravita);
ALTER TABLE siig_geo_ln_arco_3 ADD CONSTRAINT pk_siig_geo_ln_arco_3 PRIMARY KEY (id_geo_arco);
ALTER TABLE siig_r_area_danno ADD CONSTRAINT pk_siig_r_area_danno PRIMARY KEY (id_gravita,id_scenario,id_sostanza,id_tipologia_danno,flg_lieve);
ALTER TABLE siig_r_area_danno ADD CONSTRAINT dom_01716 CHECK (FLG_LIEVE IN (0,1));
ALTER TABLE siig_r_arco_3_scen_tipobers ADD CONSTRAINT pk_siig_r_arco_3_scen_tipobers PRIMARY KEY (id_geo_arco,id_scenario,id_bersaglio);
ALTER TABLE siig_d_tipo_uso ADD CONSTRAINT pk_siig_d_tipo_uso PRIMARY KEY (id_tipo_uso);
ALTER TABLE siig_t_elab_standard_2 ADD CONSTRAINT pk_siig_t_elab_standard_2 PRIMARY KEY (flg_lieve,id_geo_arco,id_scenario,id_sostanza,id_distanza);
ALTER TABLE siig_t_elab_standard_2 ADD CONSTRAINT dom_01720 CHECK (FLG_LIEVE IN (0,1));
ALTER TABLE siig_geo_bers_non_umano_pt ADD CONSTRAINT pk_siig_geo_bers_non_umano_pt PRIMARY KEY (idgeo_bers_non_umano_pt);
ALTER TABLE siig_mtd_r_formula_parametro ADD CONSTRAINT pk_siig_mtd_r_formula_parametr PRIMARY KEY (id_formula,id_parametro);
ALTER TABLE siig_geo_bers_non_umano_ln ADD CONSTRAINT pk_siig_geo_bers_non_umano_ln PRIMARY KEY (idgeo_bers_non_umano_ln);
ALTER TABLE siig_d_ateco ADD CONSTRAINT pk_siig_d_ateco PRIMARY KEY (id_ateco);
ALTER TABLE siig_t_vulnerabilita_2 ADD CONSTRAINT pk_siig_t_vulnerabilita_2 PRIMARY KEY (id_geo_arco,id_distanza);
ALTER TABLE siig_r_arco_1_scen_tipobers ADD CONSTRAINT pk_siig_r_arco_1_scen_tipobers PRIMARY KEY (id_scenario,id_geo_arco,id_bersaglio);
ALTER TABLE siig_geo_bersaglio_umano_pl ADD CONSTRAINT pk_siig_geo_bersaglio_umano_pl PRIMARY KEY (idgeo_bersaglio_umano_pl);
ALTER TABLE siig_t_vulnerabilita_3 ADD CONSTRAINT pk_siig_t_vulnerabilita_3 PRIMARY KEY (id_geo_arco,id_distanza);
ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT pk_siig_t_bersaglio_umano PRIMARY KEY (id_tematico,id_bersaglio,id_partner);
ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT dom_s_c56 CHECK (FLG_NR_ADDETTI_COMM IN ('C','S'));
ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT dom_s_c53 CHECK (FLG_NR_ISCRITTI IN ('C','S'));
ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT dom_s_c50 CHECK (FLG_LETTI_ORDINARI IN ('C','S'));
ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT dom_s_c55 CHECK (FLG_NR_UTENTI IN ('C','S'));
ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT dom_s_c52 CHECK (FLG_NR_ADDETTI_H IN ('C','S'));
ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT dom_s_c54 CHECK (FLG_NR_ADDETTI_SCUOLE IN ('C','S'));
ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT dom_s_c51 CHECK (FLG_LETTI_DAY_H IN ('C','S'));
ALTER TABLE siig_geo_ln_arco_1 ADD CONSTRAINT pk_siig_geo_ln_arco_1 PRIMARY KEY (id_geo_arco);
ALTER TABLE siig_r_arco_3_sostanza ADD CONSTRAINT pk_siig_r_arco_3_sostanza PRIMARY KEY (id_geo_arco,id_sostanza);
ALTER TABLE siig_mtd_t_bersaglio ADD CONSTRAINT pk_siig_mtd_t_bersaglio PRIMARY KEY (id_bersaglio);
ALTER TABLE siig_mtd_t_parametro ADD CONSTRAINT pk_siig_mtd_t_parametro PRIMARY KEY (id_parametro);
ALTER TABLE siig_d_iucn ADD CONSTRAINT pk_siig_d_iucn PRIMARY KEY (id_iucn);
ALTER TABLE siig_mtd_r_formula_criterio ADD CONSTRAINT pk_siig_mtd_r_formula_criterio PRIMARY KEY (id_criterio,id_formula);
ALTER TABLE siig_mtd_r_formula_criterio ADD CONSTRAINT dom_01710 CHECK (FLG_OBBLIGATORIO IN (0,1));
ALTER TABLE siig_mtd_r_param_bers_arco ADD CONSTRAINT pk_siig_mtd_r_param_bers_arco PRIMARY KEY (id_parametro,id_arco,id_bersaglio);
ALTER TABLE siig_t_bersaglio ADD CONSTRAINT pk_siig_t_bersaglio PRIMARY KEY (id_bersaglio);
ALTER TABLE siig_t_bersaglio ADD CONSTRAINT dom_01718 CHECK (FLG_UMANO IN (0,1));
ALTER TABLE siig_d_bene_culturale ADD CONSTRAINT pk_siig_d_bene_culturale PRIMARY KEY (id_tipo_bene);
ALTER TABLE siig_d_tipologia_danno ADD CONSTRAINT pk_siig_d_tipologia_danno PRIMARY KEY (id_tipologia_danno);
ALTER TABLE siig_d_tipologia_danno ADD CONSTRAINT dom_u_n6 CHECK (FLG_UMANO IN ('U','N'));
ALTER TABLE siig_r_arco_1_sostanza ADD CONSTRAINT pk_siig_r_arco_1_sostanza PRIMARY KEY (id_geo_arco,id_sostanza);
ALTER TABLE siig_d_tipo_trasporto ADD CONSTRAINT pk_siig_d_tipo_trasporto PRIMARY KEY (id_tipo_trasporto);
ALTER TABLE siig_mtd_t_formula ADD CONSTRAINT pk_siig_mtd_t_formula PRIMARY KEY (id_formula);
ALTER TABLE siig_mtd_t_formula ADD CONSTRAINT dom_01714 CHECK (FLG_I_GRID IN (0,1));
ALTER TABLE siig_mtd_t_formula ADD CONSTRAINT dom_01715 CHECK (FLG_COSTANTE IN (0,1));
ALTER TABLE siig_mtd_t_formula ADD CONSTRAINT dom_01713 CHECK (G_SOMMATORIA IN (0,1));
ALTER TABLE siig_mtd_t_formula ADD CONSTRAINT dom_01712 CHECK (FLG_K_SOMMATORIA IN (0,1));
ALTER TABLE siig_mtd_t_formula ADD CONSTRAINT dom_01711 CHECK (FLG_J_SOMMATORIA IN (0,1));
ALTER TABLE siig_mtd_t_formula ADD CONSTRAINT dom_0_1_22 CHECK (FLG_VISIBILE IN (0,1,2));
ALTER TABLE siig_r_tipovei_geoarco1 ADD CONSTRAINT pk_siig_r_tipovei_geoarco1 PRIMARY KEY (id_tipo_veicolo,id_geo_arco);
ALTER TABLE siig_r_arco_2_dissesto ADD CONSTRAINT pk_siig_r_arco_2_dissesto PRIMARY KEY (id_dissesto,id_geo_arco);
ALTER TABLE siig_r_dist_arco2scentipobers ADD CONSTRAINT pk_siig_r_dist_arco2scentipobe PRIMARY KEY (id_distanza,id_geo_arco,id_scenario,id_bersaglio);
ALTER TABLE siig_d_distanza ADD CONSTRAINT pk_siig_d_distanza PRIMARY KEY (id_distanza);
ALTER TABLE siig_geo_bers_non_umano_pl ADD CONSTRAINT pk_siig_geo_bers_non_umano_pl PRIMARY KEY (idgeo_bers_non_umano_pl);
ALTER TABLE siig_d_classe_adr ADD CONSTRAINT pk_siig_d_classe_adr PRIMARY KEY (id_classe_adr);
ALTER TABLE siig_d_tipo_captazione ADD CONSTRAINT pk_siig_d_tipo_captazione PRIMARY KEY (id_tipo_captazione);
ALTER TABLE siig_d_dissesto ADD CONSTRAINT pk_siig_d_dissesto PRIMARY KEY (id_dissesto);
ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT pk_siig_t_bersaglio_non_umano PRIMARY KEY (id_tematico,id_bersaglio,id_partner);
ALTER TABLE siig_r_scenario_sostanza ADD CONSTRAINT pk_siig_r_scenario_sostanza PRIMARY KEY (id_scenario,id_sostanza,flg_lieve);
ALTER TABLE siig_r_scenario_sostanza ADD CONSTRAINT dom_01717 CHECK (FLG_LIEVE IN (0,1));
ALTER TABLE siig_r_dist_arco1scentipobers ADD CONSTRAINT pk_siig_r_dist_arco1scentipobe PRIMARY KEY (id_distanza,id_geo_arco,id_scenario,id_bersaglio);
ALTER TABLE siig_r_arco_2_sostanza ADD CONSTRAINT pk_siig_r_arco_2_sostanza PRIMARY KEY (id_geo_arco,id_sostanza);
ALTER TABLE siig_r_scenario_gravita ADD CONSTRAINT pk_siig_r_scenario_gravita PRIMARY KEY (id_scenario,id_gravita);
ALTER TABLE siig_r_tipovei_geoarco2 ADD CONSTRAINT pk_siig_r_tipovei_geoarco2 PRIMARY KEY (id_tipo_veicolo,id_geo_arco);
ALTER TABLE siig_d_stato_fisico ADD CONSTRAINT pk_siig_d_stato_fisico PRIMARY KEY (id_stato_fisico);
ALTER TABLE siig_mtd_r_formula_elab ADD CONSTRAINT pk_siig_mtd_r_formula_elab PRIMARY KEY (id_elaborazione,id_formula);
ALTER TABLE siig_r_dist_arco3scentipobers ADD CONSTRAINT pk_siig_r_dist_arco3scentipobe PRIMARY KEY (id_distanza,id_geo_arco,id_scenario,id_bersaglio);
ALTER TABLE siig_mtd_d_arco ADD CONSTRAINT pk_siig_mtd_d_arco PRIMARY KEY (id_arco);
ALTER TABLE siig_t_vulnerabilita_1 ADD CONSTRAINT pk_siig_t_vulnerabilita_1 PRIMARY KEY (id_geo_arco,id_distanza);
ALTER TABLE siig_mtd_d_elaborazione ADD CONSTRAINT pk_siig_mtd_d_elaborazione PRIMARY KEY (id_elaborazione);
ALTER TABLE siig_t_elab_standard_1 ADD CONSTRAINT pk_siig_t_elab_standard_1 PRIMARY KEY (flg_lieve,id_geo_arco,id_distanza,id_scenario,id_sostanza);
ALTER TABLE siig_t_elab_standard_1 ADD CONSTRAINT dom_01719 CHECK (FLG_LIEVE IN (0,1));
ALTER TABLE siig_mtd_d_criterio_filtro ADD CONSTRAINT pk_siig_mtd_d_criterio_filtro PRIMARY KEY (id_criterio);
ALTER TABLE siig_r_arco_1_dissesto ADD CONSTRAINT pk_siig_r_arco_1_dissesto PRIMARY KEY (id_geo_arco,id_dissesto);
ALTER TABLE siig_t_sostanza ADD CONSTRAINT pk_siig_t_sostanza PRIMARY KEY (id_sostanza);
ALTER TABLE siig_geo_ln_arco_2 ADD CONSTRAINT pk_siig_geo_ln_arco_2 PRIMARY KEY (id_geo_arco);
ALTER TABLE siig_t_elab_standard_3 ADD CONSTRAINT pk_siig_t_elab_standard_3 PRIMARY KEY (flg_lieve,id_geo_arco,id_scenario,id_sostanza,id_distanza);
ALTER TABLE siig_t_elab_standard_3 ADD CONSTRAINT dom_01721 CHECK (FLG_LIEVE IN (0,1));
ALTER TABLE siig_r_tipovei_geoarco3 ADD CONSTRAINT pk_siig_r_tipovei_geoarco3 PRIMARY KEY (id_tipo_veicolo,id_geo_arco);
ALTER TABLE siig_d_partner ADD CONSTRAINT pk_siig_d_partner PRIMARY KEY (id_partner);
ALTER TABLE siig_d_tipo_contenitore ADD CONSTRAINT pk_siig_d_tipo_contenitore PRIMARY KEY (id_tipo_contenitore);
ALTER TABLE siig_r_arco_2_scen_tipobers ADD CONSTRAINT fk_siig_d_bersaglio_07 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_2_scen_tipobers ADD CONSTRAINT fk_siig_t_scenario_04 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario (id_scenario) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_2_scen_tipobers ADD CONSTRAINT fk_siig_geo_arco_2_02 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_3_dissesto ADD CONSTRAINT fk_siig_geo_arco_3_06 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_3 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_3_dissesto ADD CONSTRAINT fk_siig_d_dissesto_02 FOREIGN KEY (id_dissesto) REFERENCES siig_d_dissesto (id_dissesto) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_d_gravita ADD CONSTRAINT fk_siig_d_bersaglio_09 FOREIGN KEY (fk_bersaglio) REFERENCES siig_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_geo_ln_arco_3 ADD CONSTRAINT fk_siig_d_partner_06 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner (id_partner) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_area_danno ADD CONSTRAINT fk_siig_d_tipologia_danno_01 FOREIGN KEY (id_tipologia_danno) REFERENCES siig_d_tipologia_danno (id_tipologia_danno) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_area_danno ADD CONSTRAINT fk_siig_r_scenario_sost_04 FOREIGN KEY (id_scenario,id_sostanza,flg_lieve) REFERENCES siig_r_scenario_sostanza (id_scenario,id_sostanza,flg_lieve) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_area_danno ADD CONSTRAINT fk_siig_d_distanza_02 FOREIGN KEY (fk_distanza) REFERENCES siig_d_distanza (id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_area_danno ADD CONSTRAINT fk_siig_d_gravita_02 FOREIGN KEY (id_gravita) REFERENCES siig_d_gravita (id_gravita) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_3_scen_tipobers ADD CONSTRAINT fk_siig_geo_arco_3_03 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_3 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_3_scen_tipobers ADD CONSTRAINT fk_siig_t_scenario_05 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario (id_scenario) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_3_scen_tipobers ADD CONSTRAINT fk_siig_d_bersaglio_02 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_elab_standard_2 ADD CONSTRAINT fk_siig_r_scenario_sost_02 FOREIGN KEY (id_scenario,id_sostanza,flg_lieve) REFERENCES siig_r_scenario_sostanza (id_scenario,id_sostanza,flg_lieve) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_elab_standard_2 ADD CONSTRAINT fk_siig_t_vulnerabilita_2_01 FOREIGN KEY (id_geo_arco,id_distanza) REFERENCES siig_t_vulnerabilita_2 (id_geo_arco,id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_r_formula_parametro ADD CONSTRAINT fk_siig_mtd_t_parametro_01 FOREIGN KEY (id_parametro) REFERENCES siig_mtd_t_parametro (id_parametro) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_r_formula_parametro ADD CONSTRAINT fk_siig_mtd_formula_03 FOREIGN KEY (id_formula) REFERENCES siig_mtd_t_formula (id_formula) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_vulnerabilita_2 ADD CONSTRAINT fk_siig_d_distanza_04 FOREIGN KEY (id_distanza) REFERENCES siig_d_distanza (id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_vulnerabilita_2 ADD CONSTRAINT fk_siig_geo_arco_2_01 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_1_scen_tipobers ADD CONSTRAINT fk_siig_d_bersaglio_04 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_1_scen_tipobers ADD CONSTRAINT fk_siig_geo_arco_1_05 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_1_scen_tipobers ADD CONSTRAINT fk_siig_t_scenario_03 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario (id_scenario) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_vulnerabilita_3 ADD CONSTRAINT fk_siig_d_distanza_03 FOREIGN KEY (id_distanza) REFERENCES siig_d_distanza (id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_vulnerabilita_3 ADD CONSTRAINT fk_siig_geo_arco_3_01 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_3 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT fk_siig_t_bersaglio_01 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT fk_siig_d_partner_01 FOREIGN KEY (id_partner) REFERENCES siig_d_partner (id_partner) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT fk_siig_geo_bers_umano_pl_01 FOREIGN KEY (fk_bersaglio_umano_pl) REFERENCES siig_geo_bersaglio_umano_pl (idgeo_bersaglio_umano_pl) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT fk_siig_geo_bers_umano_pt_01 FOREIGN KEY (fk_bersaglio_umano_pt) REFERENCES siig_geo_bersaglio_umano_pt (idgeo_bersaglio_umano_pt) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT fk_siig_d_tipo_uso_01 FOREIGN KEY (fk_tipo_uso) REFERENCES siig_d_tipo_uso (id_tipo_uso) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_umano ADD CONSTRAINT fk_siig_d_ateco_01 FOREIGN KEY (fk_ateco) REFERENCES siig_d_ateco (id_ateco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_geo_ln_arco_1 ADD CONSTRAINT fk_siig_d_partner_04 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner (id_partner) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_3_sostanza ADD CONSTRAINT fk_siig_t_sostanza_03 FOREIGN KEY (id_sostanza) REFERENCES siig_t_sostanza (id_sostanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_3_sostanza ADD CONSTRAINT fk_siig_geo_arco_3_02 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_3 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_t_bersaglio ADD CONSTRAINT fk_siig_d_bersaglio_05 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_r_formula_criterio ADD CONSTRAINT fk_siig_mtd_formula_04 FOREIGN KEY (id_formula) REFERENCES siig_mtd_t_formula (id_formula) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_r_formula_criterio ADD CONSTRAINT fk_siig_mtd_d_criter_filtro_01 FOREIGN KEY (id_criterio) REFERENCES siig_mtd_d_criterio_filtro (id_criterio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_r_param_bers_arco ADD CONSTRAINT fk_siig_mtd_d_arco_01 FOREIGN KEY (id_arco) REFERENCES siig_mtd_d_arco (id_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_r_param_bers_arco ADD CONSTRAINT fk_siig_mtd_t_bersaglio_01 FOREIGN KEY (id_bersaglio) REFERENCES siig_mtd_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_r_param_bers_arco ADD CONSTRAINT fk_siig_mtd_parametro_02 FOREIGN KEY (id_parametro) REFERENCES siig_mtd_t_parametro (id_parametro) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_1_sostanza ADD CONSTRAINT fk_siig_t_sostanza_04 FOREIGN KEY (id_sostanza) REFERENCES siig_t_sostanza (id_sostanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_1_sostanza ADD CONSTRAINT fk_siig_geo_arco_1_03 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_t_formula ADD CONSTRAINT fk_siig_mtd_formula_02 FOREIGN KEY (fk_figlio) REFERENCES siig_mtd_t_formula (id_formula) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_tipovei_geoarco1 ADD CONSTRAINT fk_siig_geo_arco_1_01 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_tipovei_geoarco1 ADD CONSTRAINT fk_siig_d_tipo_veicolo_01 FOREIGN KEY (id_tipo_veicolo) REFERENCES siig_d_tipo_veicolo (id_tipo_veicolo) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_2_dissesto ADD CONSTRAINT fk_siig_geo_arco_2_05 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_2_dissesto ADD CONSTRAINT fk_siig_d_dissesto_03 FOREIGN KEY (id_dissesto) REFERENCES siig_d_dissesto (id_dissesto) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_dist_arco2scentipobers ADD CONSTRAINT fk_siig_r_arc_2scentipober_01 FOREIGN KEY (id_geo_arco,id_scenario,id_bersaglio) REFERENCES siig_r_arco_2_scen_tipobers (id_geo_arco,id_scenario,id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_dist_arco2scentipobers ADD CONSTRAINT fk_siig_d_distanza_05 FOREIGN KEY (id_distanza) REFERENCES siig_d_distanza (id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_d_partner_02 FOREIGN KEY (id_partner) REFERENCES siig_d_partner (id_partner) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_t_bersaglio_08 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio (id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_d_tipo_uso_02 FOREIGN KEY (fk_tipo_uso) REFERENCES siig_d_tipo_uso (id_tipo_uso) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_d_tipo_captazione_01 FOREIGN KEY (fk_tipo_captazione) REFERENCES siig_d_tipo_captazione (id_tipo_captazione) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_d_bene_culturale_01 FOREIGN KEY (fk_tipo_bene) REFERENCES siig_d_bene_culturale (id_tipo_bene) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_geo_bers_non_um_pl_01 FOREIGN KEY (fk_bers_non_umano_pl) REFERENCES siig_geo_bers_non_umano_pl (idgeo_bers_non_umano_pl) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_geo_bers_non_um_ln_01 FOREIGN KEY (fk_bers_non_umano_ln) REFERENCES siig_geo_bers_non_umano_ln (idgeo_bers_non_umano_ln) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_geo_bers_non_um_pt_01 FOREIGN KEY (fk_bers_non_umano_pt) REFERENCES siig_geo_bers_non_umano_pt (idgeo_bers_non_umano_pt) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_d_iucn_01 FOREIGN KEY (fk_iucn) REFERENCES siig_d_iucn (id_iucn) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_bersaglio_non_umano ADD CONSTRAINT fk_siig_d_classe_clc_01 FOREIGN KEY (fk_classe_clc) REFERENCES siig_d_classe_clc (id_classe_clc) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_scenario_sostanza ADD CONSTRAINT fk_siig_t_sostanza_01 FOREIGN KEY (id_sostanza) REFERENCES siig_t_sostanza (id_sostanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_scenario_sostanza ADD CONSTRAINT fk_siig_t_scenario_01 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario (id_scenario) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_dist_arco1scentipobers ADD CONSTRAINT fk_siig_r_arc_1scentipober_01 FOREIGN KEY (id_scenario,id_geo_arco,id_bersaglio) REFERENCES siig_r_arco_1_scen_tipobers (id_scenario,id_geo_arco,id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_dist_arco1scentipobers ADD CONSTRAINT fk_siig_d_distanza_07 FOREIGN KEY (id_distanza) REFERENCES siig_d_distanza (id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_2_sostanza ADD CONSTRAINT fk_siig_geo_arco_2_03 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_2_sostanza ADD CONSTRAINT fk_siig_t_sostanza_02 FOREIGN KEY (id_sostanza) REFERENCES siig_t_sostanza (id_sostanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_scenario_gravita ADD CONSTRAINT fk_siig_d_gravita_01 FOREIGN KEY (id_gravita) REFERENCES siig_d_gravita (id_gravita) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_scenario_gravita ADD CONSTRAINT fk_siig_t_scenario_02 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario (id_scenario) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_tipovei_geoarco2 ADD CONSTRAINT fk_siig_d_tipo_veicolo_02 FOREIGN KEY (id_tipo_veicolo) REFERENCES siig_d_tipo_veicolo (id_tipo_veicolo) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_tipovei_geoarco2 ADD CONSTRAINT fk_siig_geo_arco_2_04 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_r_formula_elab ADD CONSTRAINT fk_siig_mtd_formula_01 FOREIGN KEY (id_formula) REFERENCES siig_mtd_t_formula (id_formula) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_mtd_r_formula_elab ADD CONSTRAINT fk_siig_mtd_d_elaborazione_01 FOREIGN KEY (id_elaborazione) REFERENCES siig_mtd_d_elaborazione (id_elaborazione) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_dist_arco3scentipobers ADD CONSTRAINT fk_siig_r_arc_3scentipober_01 FOREIGN KEY (id_geo_arco,id_scenario,id_bersaglio) REFERENCES siig_r_arco_3_scen_tipobers (id_geo_arco,id_scenario,id_bersaglio) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_dist_arco3scentipobers ADD CONSTRAINT fk_siig_d_distanza_06 FOREIGN KEY (id_distanza) REFERENCES siig_d_distanza (id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_vulnerabilita_1 ADD CONSTRAINT fk_siig_d_distanza_01 FOREIGN KEY (id_distanza) REFERENCES siig_d_distanza (id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_vulnerabilita_1 ADD CONSTRAINT fk_siig_geo_arco_1_02 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_elab_standard_1 ADD CONSTRAINT fk_siig_r_scenario_sost_03 FOREIGN KEY (id_scenario,id_sostanza,flg_lieve) REFERENCES siig_r_scenario_sostanza (id_scenario,id_sostanza,flg_lieve) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_elab_standard_1 ADD CONSTRAINT fk_siig_t_vulnerabilita_1_02 FOREIGN KEY (id_geo_arco,id_distanza) REFERENCES siig_t_vulnerabilita_1 (id_geo_arco,id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_1_dissesto ADD CONSTRAINT fk_siig_d_dissesto_01 FOREIGN KEY (id_dissesto) REFERENCES siig_d_dissesto (id_dissesto) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_arco_1_dissesto ADD CONSTRAINT fk_siig_geo_arco_1_06 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_sostanza ADD CONSTRAINT fk_siig_d_classe_adr_01 FOREIGN KEY (fk_classe_adr) REFERENCES siig_d_classe_adr (id_classe_adr) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_sostanza ADD CONSTRAINT fk_siig_d_tipo_contenitore_01 FOREIGN KEY (fk_tipo_contenitore) REFERENCES siig_d_tipo_contenitore (id_tipo_contenitore) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_sostanza ADD CONSTRAINT fk_siig_d_stato_fisico_01 FOREIGN KEY (fk_stato_fisico) REFERENCES siig_d_stato_fisico (id_stato_fisico) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_sostanza ADD CONSTRAINT fk_siig_d_tipo_trasporto_01 FOREIGN KEY (fk_tipo_trasporto) REFERENCES siig_d_tipo_trasporto (id_tipo_trasporto) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_geo_ln_arco_2 ADD CONSTRAINT fk_siig_d_partner_05 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner (id_partner) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_elab_standard_3 ADD CONSTRAINT fk_siig_r_scenario_sost_01 FOREIGN KEY (id_scenario,id_sostanza,flg_lieve) REFERENCES siig_r_scenario_sostanza (id_scenario,id_sostanza,flg_lieve) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_t_elab_standard_3 ADD CONSTRAINT fk_siig_t_vulnerabilita_3_01 FOREIGN KEY (id_geo_arco,id_distanza) REFERENCES siig_t_vulnerabilita_3 (id_geo_arco,id_distanza) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_tipovei_geoarco3 ADD CONSTRAINT fk_siig_geo_arco_3_05 FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_3 (id_geo_arco) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE siig_r_tipovei_geoarco3 ADD CONSTRAINT fk_siig_d_tipo_veicolo_03 FOREIGN KEY (id_tipo_veicolo) REFERENCES siig_d_tipo_veicolo (id_tipo_veicolo) ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;

