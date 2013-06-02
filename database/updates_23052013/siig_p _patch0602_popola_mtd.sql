
---------------------------------------------------------------------   
-- SIIG_MTD_T_BERSAGLIO - ok 
---------------------------------------------------------------------   
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (0, '-', '-');
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (1, 'calc_formula_residenti', 'nr_pers_residenti');
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (2, 'calc_formula_turisti_medi', 'nr_turisti_medi');    
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (3, 'calc_formula_turisti_max', 'nr_turisti_max');  
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (4, 'calc_formula_servizi', 'nr_pers_servizi');  
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (5, 'calc_formula_ospedali', 'nr_pers_ospedali');    
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (6, 'calc_formula_scuole', 'nr_pers_scuole');   
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (7, 'calc_formula_distrib', 'nr_pers_distrib');    
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (8, 'calc_formula_flusso', 'nr_pers_flusso');      
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (9, 'calc_formula_territorio', 'nr_pers_territorio'); 
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (10, 'calc_formula_zone_urbanizzate', 'mq_zone_urbanizzate');    
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (11, 'calc_formula_aree_boscate', 'mq_aree_boscate');        
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (12, 'calc_formula_aree_protette', 'mq_aree_protette');      
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (13, 'calc_formula_aree_agricole', 'mq_aree_agricole');       
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (14, 'calc_formula_acque_sotterranee', 'mq_acque_sotterranee');       
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (15, 'calc_formula_acque_superf', 'mq_acque_superficiali');
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (16, 'calc_formula_beni_culturali', 'mq_beni_culturali'); 
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (98, 'calc_formula_soc', '-');  
 INSERT INTO siig_mtd_t_bersaglio( id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (99, 'calc_formula_amb', '-');  
commit;

		
		
---------------------------------------------------------------------
-- SIIG_MTD_T_PARAMETRO  non serve ricaricare i dati, basta cancellare le colonne obsolete
---------------------------------------------------------------------     



    
----------------------------------------------- 
 -- SIIG_MTD_R_PARAM_BERS_ARCO 
-----------------------------------------------      

-----------------------------------------------
-- parametro 1 -  Cff (i,m)
-----------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 1, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 1', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 2, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 2 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 3, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 3 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 4, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 4 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 5, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 5 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 6, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 6 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 7, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 7 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 8, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 8 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 9, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 9 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 10, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 10 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 11, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 11 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 12, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 12 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 13, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 13 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 14, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 14 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 15, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 15 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 16, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 16 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 98, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select avg(cff) from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio in(1,2,3,4,5,6,7,8,9) ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 1, 99, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select avg(cff) from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio in(10,11,12,13,14,15,16) ', 0,0,0);
    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 1, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 1', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 2, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 2 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 3, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 3 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 4, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 4 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 5, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 5 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 6, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 6 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 7, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 7 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 8, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 8 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 9, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 9 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 10, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 10 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 11, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 11 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 12, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 12 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 13, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 13 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 14, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 14 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 15, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 15 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 16, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 16 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 98, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select avg(cff) from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio in(1,2,3,4,5,6,7,8,9) ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 2, 99, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select avg(cff) from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio in(10,11,12,13,14,15,16) ', 0,0,0);
    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 1, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 1', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 2, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 2 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 3, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 3 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 4, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 4 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 5, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 5 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 6, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 6 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 7, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 7 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 8, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 8 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 9, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 9 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 10, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 10 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 11, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 11 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 12, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 12 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 13, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 13 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 14, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 14 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 15, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 15 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 16, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 16 ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 98, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select avg(cff) from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio in(1,2,3,4,5,6,7,8,9) ', 0,0,0);
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (1, 3, 99, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select avg(cff) from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio in(10,11,12,13,14,15,16) ', 0,0,0);    
commit;


--------------------------------------------------------------
-- parametro - 8 Fp(m)
--------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 1, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 1', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 2, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 2', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 3, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 3', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 4, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 4', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 5, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 5', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 6, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 6', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 7, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 7', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 8, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 9', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 9, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 9', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 10, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 10', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 11, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 11', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 12, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 12', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 13, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 13', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 14, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 14', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 15, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 15', 0,0,0);   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (8, 0, 16, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 16', 0,0,0); 
commit;


--------------------------------------------------------------
-- parametro - 10 Padr(i,j)   
--------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (10, 1, 0, 'SIIG_R_ARCO_1_SOSTANZA', 'select padr from SIIG_R_ARCO_1_SOSTANZA where id_geo_arco = % and id_sostanza = %', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (10, 2, 0, 'SIIG_R_ARCO_2_SOSTANZA', 'select padr from SIIG_R_ARCO_2_SOSTANZA where id_geo_arco = % and id_sostanza = %', 0,0,0);  
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (10, 3, 0, 'SIIG_R_ARCO_3_SOSTANZA', 'select padr from SIIG_R_ARCO_3_SOSTANZA where id_geo_arco = % and id_sostanza = %', 0,0,0);   


INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (10, 1, 0, 'SIIG_R_ARCO_1_SOSTANZA', '-', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (10, 2, 0, 'SIIG_R_ARCO_2_SOSTANZA', '-', 0,0,0);     
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select, flg_j, flg_k, punto_g)
    VALUES (10, 3, 0, 'SIIG_R_ARCO_3_SOSTANZA', '-', 0,0,0);     


commit;



---------------------------------------------------------------------   
-- SIIG_MTD_T_FORMULA 
---------------------------------------------------------------------   

INSERT INTO siig_mtd_t_formula( id_formula, descrizione_it, udm_it, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, flg_i_grid, flg_costante,  flg_m_sommatoria)
    VALUES  (1, '1', null, 0, null, 0, 0, 0, 1, 0);

INSERT INTO siig_mtd_t_formula( id_formula, descrizione_it, udm_it, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, flg_i_grid, flg_costante,  flg_m_sommatoria)
     VALUES (2, 'Cff - capacità  di far fronte', null, 1, 11, 0, 0, 0, 0, 0); 

INSERT INTO siig_mtd_t_formula( id_formula, descrizione_it, udm_it, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, flg_i_grid, flg_costante,  flg_m_sommatoria)
    VALUES (3, '1 - Cff ', null, 0, null, 0, 0, 0, 0, 0);

INSERT INTO siig_mtd_t_formula( id_formula, descrizione_it, udm_it, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, flg_i_grid, flg_costante,  flg_m_sommatoria)
    VALUES (12, 'Fp', null, 0, 0, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione_it, udm_it, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, flg_i_grid, flg_costante,  flg_m_sommatoria)
    VALUES (20, 'Padr - Flussi ADR', '[veicoli ADR incidentati/veicoli circolanti incidentati]', 1, 7, 1, 0, 1, 0 ,0) ;

commit;
---------------------------------------------------------------------    


---------------------------------------------------------------------   
-- SIIG_MTD_R_FORMULA_FORMULA  
---------------------------------------------------------------------   
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (3, 1, '-', 1);
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (3, 2, null, 2);

commit;    


---------------------------------------------------------------------   
-- SIIG_MTD_R_FORMULA_PARAMETRO  
---------------------------------------------------------------------   
INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (2, 1, 1, null, 0);

INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (12, 8, 1, null, 0); 

INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (20, 10, 1, null, 0); 

commit;
       