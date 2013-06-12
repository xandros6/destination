 ALTER TABLE siig_t_elab_standard_1 ADD COLUMN  calc_formula_territorio numeric(8,0);
 ALTER TABLE siig_t_elab_standard_2 ADD COLUMN  calc_formula_territorio numeric(8,0);
 ALTER TABLE siig_t_elab_standard_3 ADD COLUMN  calc_formula_territorio numeric(8,0);

 ALTER TABLE siig_t_vulnerabilita_1 ADD COLUMN  nr_pers_territorio numeric(7,0);
 ALTER TABLE siig_t_vulnerabilita_2 ADD COLUMN  nr_pers_territorio numeric(7,0);
 ALTER TABLE siig_t_vulnerabilita_3 ADD COLUMN  nr_pers_territorio numeric(7,0);
 
 
delete from siig_mtd_r_formula_formula; 
delete from siig_mtd_r_formula_parametro; 
delete from siig_mtd_r_param_bers_arco; 
delete from siig_mtd_t_formula; 
delete from siig_mtd_t_bersaglio;
commit;

 
ALTER TABLE siig_mtd_r_param_bers_arco ADD COLUMN  flg_j   numeric(1,0); 
ALTER TABLE siig_mtd_r_param_bers_arco ADD COLUMN  flg_k   numeric(1,0); 
ALTER TABLE siig_mtd_r_param_bers_arco ADD COLUMN  punto_g numeric(1,0); 
 
ALTER TABLE siig_mtd_t_parametro DROP COLUMN flg_j;
ALTER TABLE siig_mtd_t_parametro DROP COLUMN flg_k;
ALTER TABLE siig_mtd_t_parametro DROP COLUMN flg_m; 
ALTER TABLE siig_mtd_t_parametro DROP COLUMN punto_g;    


ALTER TABLE siig_mtd_r_param_bers_arco DROP CONSTRAINT pk_siig_mtd_r_param_bers_arco;
ALTER TABLE siig_mtd_r_param_bers_arco ADD CONSTRAINT pk_siig_mtd_r_param_bers_arco PRIMARY KEY(id_parametro, id_arco, id_bersaglio, flg_j, flg_k, punto_g);

ALTER TABLE siig_mtd_t_formula DROP COLUMN g_sommatoria;
ALTER TABLE siig_mtd_t_formula ADD COLUMN  flg_m_sommatoria numeric(1,0);                               