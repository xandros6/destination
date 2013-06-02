---------------------------------------------------------------------   
-- SIIG_MTD_D_ARCO  - ok
---------------------------------------------------------------------   
INSERT INTO siig_mtd_d_arco(id_arco, descrizione_arco)
    VALUES (0, 'nessun arco');
INSERT INTO siig_mtd_d_arco(id_arco, descrizione_arco)
    VALUES (1, 'arco1');
INSERT INTO siig_mtd_d_arco(id_arco, descrizione_arco)
    VALUES (2, 'arco2');
INSERT INTO siig_mtd_d_arco(id_arco, descrizione_arco)
    VALUES (3, 'griglia');    
commit;
    
---------------------------------------------------------------------       
-- SIIG_MTD_D_ELABORAZIONE  - ok  
---------------------------------------------------------------------   
INSERT INTO siig_mtd_d_elaborazione(id_elaborazione, descrizione_elaborazione)
    VALUES (1, 'Elaborazione standard');
INSERT INTO siig_mtd_d_elaborazione(id_elaborazione, descrizione_elaborazione)
    VALUES (2, 'Elaborazione personalizzata');
INSERT INTO siig_mtd_d_elaborazione(id_elaborazione, descrizione_elaborazione)
    VALUES (3, 'Simulazione');
INSERT INTO siig_mtd_d_elaborazione(id_elaborazione, descrizione_elaborazione)
    VALUES (4, 'Valutazione del danno');            
commit;    
    
---------------------------------------------------------------------   
-- SIIG_MTD_D_CRITERIO_FILTRO  - ok
---------------------------------------------------------------------   
INSERT INTO siig_mtd_d_criterio_filtro(id_criterio, descrizione_criterio)
    VALUES (1, 'incidente');
INSERT INTO siig_mtd_d_criterio_filtro(id_criterio, descrizione_criterio)
    VALUES (2, 'bersaglio');
commit;

---------------------------------------------------------------------   
-- SIIG_T_BERSAGLIO   record 0 per Bersaglio non presente  - ok 
---------------------------------------------------------------------   
INSERT INTO siig_t_bersaglio(id_bersaglio, flg_umano, descrizione, fp_scen_feriale_diurno, 
            fp_scen_centrale, fp_scen_notturno, fp_scen_festivo_diurno)
    VALUES (0, 0, 'Bersaglio non presente',0 , 0,0 ,0);
commit;

---------------------------------------------------------------------   
-- SIIG_MTD_T_BERSAGLIO - ok 
---------------------------------------------------------------------   
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (0,'-', '-');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
    VALUES (1,'calc_formula_residenti','nr_pers_residenti');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (2,'calc_formula_turisti_medi','nr_turisti_medi');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (3,'calc_formula_turisti_max','nr_turisti_max');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)		
		VALUES (4,'calc_formula_servizi','nr_pers_servizi');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (5,'calc_formula_ospedali','nr_pers_ospedali');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (6,'calc_formula_scuole','nr_pers_scuole');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (7,'calc_formula_distrib','nr_pers_distrib');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (8,'calc_formula_flusso','nr_pers_flusso');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (9,'calc_formula_aree_protette','mq_aree_protette');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (10,'calc_formula_aree_agricole','mq_aree_agricole');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (11,'calc_formula_aree_boscate','mq_aree_boscate');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (12,'calc_formula_acque_superf','mq_acque_superficiali');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (13,'calc_formula_acque_sotterranee','mq_acque_sotterranee');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (14,'calc_formula_beni_culturali','mq_beni_cultural');
INSERT INTO siig_mtd_t_bersaglio(id_bersaglio, col_elab_standard, col_vulnerabilita)
		VALUES (15,'calc_formula_zone_urbanizzate','mq_zone_urbanizzate');
commit;
		
---------------------------------------------------------------------
-- SIIG_MTD_T_PARAMETRO  - ok
---------------------------------------------------------------------     
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (1, 'Cff - capacità  di far fronte', 1, 0, 0, 1, 0, 0);    
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (2, 'Eg1', 1, 0, 1, 1, 1, 0);    
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (3, 'Eg2 - AE esposti/scenario incidentale', 1, 0, 1, 1, 2, 0);    
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (4, 'Eg3 - AE esposti/scenario incidentale', 1, 0, 1, 1, 3, 0);    
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (5, 'Sg2 - morti/ AE esposti', 0, 0, 1, 1, 2, 0);    
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (6, 'Sg3 - morti/ AE esposti', 0, 0, 1, 1, 3, 0);      
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (7, 'Sg4 - morti/ AE esposti', 0, 0, 1, 1, 4, 0);      
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (8, 'Fp', 0, 0, 0, 1, 0, 0);      
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (9, 'Psc - Probabilità  di accadimento dello scenario incidentale', 0, 1, 1, 1, 0, 1);      
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (10, 'Padr - Flussi ADR', 1, 1, 0, 0, 0, 0);      
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (11, 'Pis - Pericolosità  intrinseca della strada', 1, 0, 0, 0, 0, 0);       
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (12, 'E - Bersagli umani potenzialmente esposti', 1, 0, 1, 1, 1, 0);          
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (13, 'E - Bersagli ambientali esposti', 1, 0, 1, 1, 0, 0);         
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (14, 'S - Suscettibilità  antropica', 0, 0, 1, 1, 1, 0);      
INSERT INTO siig_mtd_t_parametro(id_parametro, descrizione, flg_i, flg_j, flg_k, flg_m, punto_g, flg_lieve )
    VALUES (15, 'S - Suscettibilità  ambientale', 0, 0, 1, 1, 0, 0); 

commit;
    
    
----------------------------------------------- 
 -- SIIG_MTD_R_PARAM_BERS_ARCO 
-----------------------------------------------      
-----------------------------------------------
-- parametro 1 -  Cff (i,m)
-----------------------------------------------

INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 1, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 1 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 2, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 2 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 3, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 3 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 4, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 4 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 5, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 5 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 6, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 6 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 7, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 7 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 8, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 8 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 9, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 9 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 10, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 10 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 11, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 11 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 12, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 12 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 13, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 13 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 14, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 14 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 1, 15, 'SIIG_R_ARCO_1_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_1_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 15 ');
    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 1, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 1 ');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 2, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 2');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 3, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 3');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 4, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 4');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 5, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 5');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 6, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 6');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 7, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 7');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 8, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 8');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 9, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 9');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 10, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 10');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 11, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 11');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 12, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 12');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 13, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 13');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 14, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 14');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 2, 15, 'SIIG_R_ARCO_2_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_2_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 15'); 
       
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 1, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 1');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 2, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 2');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 3, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 3');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 4, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 4');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 5, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 5');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 6, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 6');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 7, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 7');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 8, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 8');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 9, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 9');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 10, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 10');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 11, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 11');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 12, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 12');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 13, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 13');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 14, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 14');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (1, 3, 15, 'SIIG_R_ARCO_3_SCEN_TIPOBERS', 'select cff from SIIG_R_ARCO_3_SCEN_TIPOBERS 
    where id_geo_arco = % and id_bersaglio = 15');
commit;

-------------------------------------------------------------------------
-- parametri 2/3/4 -  Eg1 - Eg2 - Eg3 - E(i,j,k,m,g,l)
-------------------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 1, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_1 
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % '); 
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 2, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 3, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 4, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 5, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 6, 'SIIG_T_VULNERABILITA_1', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 7, 'SIIG_T_VULNERABILITA_1', 'select nr_turisti_max from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 8, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 9, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_protette from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 10, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 11, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 12, 'SIIG_T_VULNERABILITA_1', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 13, 'SIIG_T_VULNERABILITA_1', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 14, 'SIIG_T_VULNERABILITA_1', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 1, 15, 'SIIG_T_VULNERABILITA_1', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');
commit;
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 1, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 2, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 3, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 4, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 5, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 6, 'SIIG_T_VULNERABILITA_2', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 7, 'SIIG_T_VULNERABILITA_2', 'select nr_turisti_max from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 8, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 9, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_protette from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 10, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 11, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 12, 'SIIG_T_VULNERABILITA_2', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 13, 'SIIG_T_VULNERABILITA_2', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 14, 'SIIG_T_VULNERABILITA_2', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 2, 15, 'SIIG_T_VULNERABILITA_2', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
commit;    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 1, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_3 
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % '); 
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 2, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 3, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 4, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 5, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 6, 'SIIG_T_VULNERABILITA_3', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 7, 'SIIG_T_VULNERABILITA_3', 'select nr_turisti_max from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 8, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 9, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_protette from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 10, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 11, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 12, 'SIIG_T_VULNERABILITA_3', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 13, 'SIIG_T_VULNERABILITA_3', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 14, 'SIIG_T_VULNERABILITA_3', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (2, 3, 15, 'SIIG_T_VULNERABILITA_3', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');
commit;
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 1, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 2, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 3, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 4, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 5, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 6, 'SIIG_T_VULNERABILITA_1', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 7, 'SIIG_T_VULNERABILITA_1', 'select nr_turisti_max from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 8, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 9, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_protette from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 10, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 11, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 12, 'SIIG_T_VULNERABILITA_1', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 13, 'SIIG_T_VULNERABILITA_1', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 14, 'SIIG_T_VULNERABILITA_1', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 1, 15, 'SIIG_T_VULNERABILITA_1', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
commit;
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 1, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 2, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 3, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 4, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 5, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 6, 'SIIG_T_VULNERABILITA_2', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 7, 'SIIG_T_VULNERABILITA_2', 'select nr_turisti_max from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 8, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 9, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_protette from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 10, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 11, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 12, 'SIIG_T_VULNERABILITA_2', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 13, 'SIIG_T_VULNERABILITA_2', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 14, 'SIIG_T_VULNERABILITA_2', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 2, 15, 'SIIG_T_VULNERABILITA_2', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
commit;
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 1, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_3 
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % '); 
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 2, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 3, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 4, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 5, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 6, 'SIIG_T_VULNERABILITA_3', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 7, 'SIIG_T_VULNERABILITA_3', 'select nr_turisti_max from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 8, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 9, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_protette from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 10, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 11, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 12, 'SIIG_T_VULNERABILITA_3', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 13, 'SIIG_T_VULNERABILITA_3', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 14, 'SIIG_T_VULNERABILITA_3', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (3, 3, 15, 'SIIG_T_VULNERABILITA_3', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');
commit;
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 1, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 2, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 3, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 4, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 5, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 6, 'SIIG_T_VULNERABILITA_1', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 7, 'SIIG_T_VULNERABILITA_1', 'select nr_turisti_max from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 8, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 9, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_protette from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 10, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 11, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 12, 'SIIG_T_VULNERABILITA_1', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 13, 'SIIG_T_VULNERABILITA_1', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 14, 'SIIG_T_VULNERABILITA_1', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 1, 15, 'SIIG_T_VULNERABILITA_1', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
commit;
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 1, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 2, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 3, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 4, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 5, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 6, 'SIIG_T_VULNERABILITA_2', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 7, 'SIIG_T_VULNERABILITA_2', 'select nr_turisti_max from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 8, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 9, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_protette from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 10, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 11, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 12, 'SIIG_T_VULNERABILITA_2', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 13, 'SIIG_T_VULNERABILITA_2', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 14, 'SIIG_T_VULNERABILITA_2', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 2, 15, 'SIIG_T_VULNERABILITA_2', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
commit;
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 1, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_3 
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % '); 
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 2, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 3, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 4, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 5, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 6, 'SIIG_T_VULNERABILITA_3', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 7, 'SIIG_T_VULNERABILITA_3', 'select nr_turisti_max from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 8, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 9, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_protette from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 10, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 11, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 12, 'SIIG_T_VULNERABILITA_3', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 13, 'SIIG_T_VULNERABILITA_3', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 14, 'SIIG_T_VULNERABILITA_3', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (4, 3, 15, 'SIIG_T_VULNERABILITA_3', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_scenario = % and id_sostanza= % and id_bersaglio = %  and flg_lieve = % ');
commit;


--------------------------------------------------------------
-- parametri 5/6/7 - Sg2/3/4  suscettibilità  - S(k,m,g) 
--------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 1, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 2, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 3, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 4, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 5, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 6, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 7, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 8, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 9, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 10, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 11, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 12, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 13, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 14, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (5, 0, 15, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;'); 
    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 1, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 2, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 3, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 4, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 5, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 6, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 7, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 8, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 9, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 10, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 11, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 12, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 13, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 14, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (6, 0, 15, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;'); 
    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 1, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 2, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 3, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 4, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 5, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 6, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 7, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 8, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 9, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 10, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 11, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 12, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 13, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 14, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (7, 0, 15, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = % and id_gravita = %;');
commit;

--------------------------------------------------------------
-- parametro - 8 Fp(m)
--------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 1, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 1');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 2, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 2');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 3, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 3');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 4, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 4');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 5, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 5');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 6, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 6');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 7, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 7');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 8, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 9');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 9, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 9');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 10, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 10');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 11, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 11');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 12, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 12');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 13, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 13');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 14, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 14');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (8, 0, 15, 'SIIG_T_BERSAGLIO', 'select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = 15');  
commit;
    
--------------------------------------------------------------
-- parametro - 9 Psc(j,k)   
--------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (9, 0, 1, 'SIIG_R_SCENARIO_SOSTANZA', 'select psc from SIIG_R_SCENARIO_SOSTANZA 
    where id_scenario = % and id_sostanza = % and flg_lieve = %');  

commit;

--------------------------------------------------------------
-- parametro - 10 Padr(i,j)   
--------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (10, 1, 0, 'SIIG_R_ARCO_1_SOSTANZA', 'select padr from SIIG_R_ARCO_1_SOSTANZA where id_geo_arco = % and id_sostanza = %');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (10, 2, 0, 'SIIG_R_ARCO_2_SOSTANZA', 'select padr from SIIG_R_ARCO_2_SOSTANZA where id_geo_arco = % and id_sostanza = %'); 
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (10, 3, 0, 'SIIG_R_ARCO_3_SOSTANZA', 'select padr from SIIG_R_ARCO_3_SOSTANZA where id_geo_arco = % and id_sostanza = %');  
commit;

--------------------------------------------------------------
-- parametro - 11 Pis = nr_incidenti_elab - Inc(i)
--------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (11, 1, 0, 'SIIG_GEO_LN_ARCO_1', 'select nr_incidenti_elab from SIIG_GEO_LN_ARCO_1 where id_geo_arco = %');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (11, 2, 0, 'SIIG_GEO_LN_ARCO_2', 'select nr_incidenti_elab from SIIG_GEO_LN_ARCO_2 where id_geo_arco = %');
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (11, 3, 0, 'SIIG_GEO_LN_ARCO_3', 'select nr_incidenti_elab from SIIG_GEO_LN_ARCO_3 where id_geo_arco = %'); 
commit;

--------------------------------------------------------------
-- parametro - 12/13 -  'E - Bersagli umani potenzialmente esposti - E(i,j,k,m,g,l) (m=bersagli umani)
--											     Bersagli ambientali esposti           - E(i,j,k,m,g,l) (m=bersagli ambientali)
--------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 1, 1, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_1 
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 1 and id_scenario = % and id_sostanza= % and flg_lieve = % '); 
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 1, 2, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 2 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 1, 3, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 3 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 1, 4, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 4 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 1, 5, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 5 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 1, 6, 'SIIG_T_VULNERABILITA_1', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 6 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 1, 7, 'SIIG_T_VULNERABILITA_1', 'select nr_turisti_max from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 7 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 1, 8, 'SIIG_T_VULNERABILITA_1', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 8 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 1, 9, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_protette from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 9 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 1, 10, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 10 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 1, 11, 'SIIG_T_VULNERABILITA_1', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 11 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 1, 12, 'SIIG_T_VULNERABILITA_1', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 12 and id_scenario = % and id_sostanza= % and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 1, 13, 'SIIG_T_VULNERABILITA_1', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 13 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 1, 14, 'SIIG_T_VULNERABILITA_1', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 14 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 1, 15, 'SIIG_T_VULNERABILITA_1', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_1     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 15 and id_scenario = % and id_sostanza= % and flg_lieve = % ');
commit;
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 2, 1, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 1 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 2, 2, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 2 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 2, 3, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 3 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 2, 4, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 4 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 2, 5, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 5 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 2, 6, 'SIIG_T_VULNERABILITA_2', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 6 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 2, 7, 'SIIG_T_VULNERABILITA_2', 'select nr_turisti_max from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 7 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 2, 8, 'SIIG_T_VULNERABILITA_2', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 8 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 2, 9, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_protette from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 9 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 2, 10, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 10 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 2, 11, 'SIIG_T_VULNERABILITA_2', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 11 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 2, 12, 'SIIG_T_VULNERABILITA_2', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 12 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 2, 13, 'SIIG_T_VULNERABILITA_2', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 13 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 2, 14, 'SIIG_T_VULNERABILITA_2', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 14 and id_scenario = % and id_sostanza= % and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 2, 15, 'SIIG_T_VULNERABILITA_2', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_2     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 15 and id_scenario = % and id_sostanza= % and flg_lieve = % ');   
commit;    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 3, 1, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_scuole from SIIG_T_VULNERABILITA_3 
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 1 and id_scenario = % and id_sostanza= % and flg_lieve = % '); 
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 3, 2, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_ospedali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 2 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 3, 3, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_distrib from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 3 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 3, 4, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_residenti from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 4 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 3, 5, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_servizi from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 5 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 3, 6, 'SIIG_T_VULNERABILITA_3', 'select nr_turisti_medi from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 6 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 3, 7, 'SIIG_T_VULNERABILITA_3', 'select nr_turisti_max from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 7 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 3, 8, 'SIIG_T_VULNERABILITA_3', 'select nr_pers_flusso_buffer from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 8 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (12, 3, 9, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_protette from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 9 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 3, 10, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_agricole from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 10 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 3, 11, 'SIIG_T_VULNERABILITA_3', 'select mq_aree_boscate from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 11 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 3, 12, 'SIIG_T_VULNERABILITA_3', 'select mq_beni_culturali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 12 and id_scenario = % and id_sostanza= % and flg_lieve = % ');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 3, 13, 'SIIG_T_VULNERABILITA_3', 'select mq_zone_urbanizzate from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 13 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 3, 14, 'SIIG_T_VULNERABILITA_3', 'select mq_acque_superficiali from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 14 and id_scenario = % and id_sostanza= % and flg_lieve = % ');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (13, 3, 15, 'SIIG_T_VULNERABILITA_3', 'select mq_acque_sotterranee from SIIG_T_VULNERABILITA_3     
    where id_geo_arco = % and id_distanza = (select fk_distanza from siig_r_area_danno 
    where id_gravita = % and id_bersaglio = 15 and id_scenario = % and id_sostanza= % and flg_lieve = % ');
commit;


----------------------------------------------------------------------
-- parametri 14/15 - S - Suscettibilità  antropica  - S(k,m,g) (m=bersagli umani)
--                     S - Suscettibilità  ambientale - S(k,m) (m=bersagli ambientali)
----------------------------------------------------------------------
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (14, 0, 1, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 1 and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (14, 0, 2, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 2 and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (14, 0, 3, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 3 and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (14, 0, 4, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 4 and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (14, 0, 5, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 5 and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (14, 0, 6, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 6 and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (14, 0, 7, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 7 and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (14, 0, 8, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 8 and id_gravita = %;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (14, 0, 9, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 9 and id_gravita = %;');    

INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (15, 0, 10, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 10 and id_gravita = 5;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (15, 0, 11, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 11 and id_gravita = 5;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (15, 0, 12, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 12 and id_gravita = 5;');   
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (15, 0, 13, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 13 and id_gravita = 5;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (15, 0, 14, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 14 and id_gravita = 5;');    
INSERT INTO siig_mtd_r_param_bers_arco(id_parametro, id_arco, id_bersaglio, nome_tavola, def_select)
    VALUES (15, 0, 15, 'SIIG_R_SCENARIO_GRAVITA', 'select suscettibilita from siig_r_scenario_gravita where id_scenario = % and id_bersaglio = 15 and id_gravita = 5;'); 
commit;    

---------------------------------------------------------------------   


---------------------------------------------------------------------   
-- SIIG_MTD_T_FORMULA 
---------------------------------------------------------------------   
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES  (1, '1', null, 0, null, 0, 0, 0, 0, 1);

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
     VALUES (2, 'Cff - capacità  di far fronte', null, 1, 11, 0, 0, 0, 0, 0); 

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (3, '1 - Cff ', null, 0, null, 0, 0, 0, 0, 0);

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (4, 'ExS (solo sommatoria)','[morti/scenario incidentale] [m2eq con danni/scenario incidentale]', 0, null, 0, 0, 1, 0, 0);

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (5, 'Eg1', '[AE esposti/scenario incidentale]', 0, 0, 0, 0, 1, 0, 0 );            

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (6, 'Sg2', '[morti/ AE esposti]', 0, 0, 0, 0, 1, 0, 0 );    

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (7, 'Eg2', '[AE esposti/scenario incidentale]', 0, 0, 0, 0, 1, 0, 0 );      

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (8, 'Sg3', '[AE esposti/scenario incidentale]', 0, 0, 0, 0, 1, 0, 0 );    
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (9, 'Eg3', '[AE esposti/scenario incidentale]', 0, 0, 0, 0, 1, 0, 0 );          

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (10, 'Sg4', '[AE esposti/scenario incidentale]', 0, 0, 0, 0, 1, 0, 0 );   
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (11, 'ExS (completo)', '[morti/scenario incidentale] [m2eq con danni/scenario incidentale]', 0, 0, 0, 0, 0, 0, 0 ) ;  
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (12, 'Fp', null, 0, 0, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (13, 'Σ(Fp x (ExS) x (1- Cff)) - Magnitudo delle conseguenze antropiche ', '[morti/km/scenario incidentale]', 1, 5, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (14, '∑ (Fp x (ExS) x (1- Cff)) -  Magnitudo delle conseguenze ambientali', '[m2eq con danni/km/scenario incidentale]', 1, 5, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (16, 'Psc - Probabilità di accadimento dello scenario incidentale', '[scenario incidentale/veicoli ADR incidentati]', 1, 9, 0, 0, 0, 0, 0 ) ;
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (17, '∑ (Psc x ∑ (Fp x (ExS) x (1- Cff))) - Danni antropici associati al sicuro incidente TMP', '[morti/veicoli ADR incidentati]', 1, 3, 0, 1, 0, 0, 0 ) ;
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (18, '∑ (Psc x ∑ (Fp x (ExS) x (1- Cff))) - Danni ambientali associati al sicuro incidente TMP', '[m2eq con danni/veicoli ADR incidentati]', 1, 3, 0, 1, 0, 0, 0 ) ;
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (20, 'Padr - Flussi ADR', '[veicoli ADR incidentati/veicoli circolanti incidentati]', 1, 7, 1, 0, 0, 1, 0 ) ;
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (21, '∑ (Padr x ∑(Psc x ∑ (Fp x (ExS) x (1- Cff))))', '[morti/veicoli circolanti incidentati]', 0, 0, 1, 0, 0, 0, 0 ) ;
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (19, '∑ (Padr x ∑(Psc x ∑ (Fp x (ExS) x (1- Cff))))', '[m2eq con danni/veicoli circolanti incidentati]', 0, 0, 1, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (22, 'Pis - Pericolosità intrinseca della strada', '[veicoli circolanti incidentati/km/anno]', 1, 6, 1, 0, 0, 1, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (23, 'Pis - Pericolosità intrinseca cumulata della rete stradale', '[veicoli circolanti incidentati/km2/anno]', 1, 5, 1, 0, 0, 1, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (24, 'R - Rischio sociale', '[morti/km/anno]', 0, 0, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (25, 'R - Rischio ambientale', '[m2eq con danni/km/anno]', 0, 0, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (26, 'R - Rischio', 'scala qualitativa', 1, 1, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (27, 'R - Rischio sociale cumulato', '[morti/km2/anno]', 1, 1, 0, 0, 0, 1, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (28, 'R - Rischio ambientale cumulato', '[m2eq con danni/km2/anno]', 0, 0, 0, 0, 0, 1, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (29, 'R - Rischio cumulato', 'scala qualitativa', 2, 1, 0, 0, 0, 1, 0 ) ;
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (30, 'E - Bersagli umani potenzialmente esposti', '[AE esposti/scenario incidentale]', 0, 0, 0, 1, 1, 0, 0 ) ;
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (31, 'E - Bersagli ambientali esposti', '[m2 esposti/scenario incidentale]', 0, 0, 0, 1, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (32, 'E - Bersagli potenzialmente esposti', 'scala qualitativa', 1, 8, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (33, 'E - Bersagli umani potenzialmente esposti cumulati', '[m2 esposti/scenario incidentale]', 0, 0, 0, 0, 0, 1, 0 ) ;
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (34, 'E - Bersagli ambientali esposti cumulati', '[m2 esposti/scenario incidentale]', 0, 0, 0, 0, 0, 1, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (35, 'E - Bersagli potenzialmente esposti cumulati', 'scala qualitativa', 2, 4, 0, 0, 0, 0, 0 ) ;
    
INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (36, 'S - Suscettibilità antropica', '[morti/AE esposti]', 1, 10, 0, 1, 1, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (37, 'S - Suscettibilità ambientale', '[m2 con danni/m2 esposti]', 1, 10, 0, 1, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (38, 'S - Suscettibilità ', 'non applicabile', 0, 0, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (39, 'Pis x ∑ (Padr x ∑ (Psc x S x (1- Cff))) - Rischio individuale antropico', '[morti/AE esposti/anno]', 1, 2, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (40, 'Pis x ∑ (Padr x ∑ (Psc x S x (1- Cff))) - Rischio individuale ambientale', '[m2 con danni/m2 esposti/anno]', 1, 2, 0, 0, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (42, 'Pis x ∑ (Padr x ∑ (Psc x S x (1- Cff))) - Rischio individuale antropico cumulato', '[morti/AE esposti/anno]', 1, 2, 0, 0, 0, 1, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (43, 'Pis x ∑ (Padr x ∑ (Psc x S x (1- Cff))) - Rischio individuale ambientale cumulato', '[m2 con danni/m2 esposti/anno]', 1, 2, 0, 0, 0, 1, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (45, 'Pis x ∑ (Padr x ∑ (Psc)) - Probabilità incidentale', '[eventi/km/anno]', 1, 4, 1, 1, 0, 0, 0 ) ;

INSERT INTO siig_mtd_t_formula( id_formula, descrizione, udm, flg_visibile, ordine_visibilita, 
            flg_j_sommatoria, flg_k_sommatoria, g_sommatoria, flg_i_grid, flg_costante)
    VALUES (46, 'Pis x ∑ (Padr x ∑ (Psc)) - Probabilità incidentale cumulata', '[eventi/km2/anno]', 1, 3, 0, 0, 0, 1, 0 ) ;

commit;
---------------------------------------------------------------------    


---------------------------------------------------------------------   
-- SIIG_MTD_R_FORMULA_FORMULA  
---------------------------------------------------------------------   
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (3, 1, '-', 1);
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (3, 2, null, 2);

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (4, 33, '*', 1);
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (4, 38, null, 2);

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (11, 4, '-', 1);
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (11, 5, '*', 2);
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (11, 6, '-', 3);
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (11, 7, '*', 4);
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (11, 8, '-', 5);
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (11, 9, '*', 6);
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (11, 10, null, 7);            

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (13, 12, '*', 1);            
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (13, 11, '*', 2);            
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (13, 3, null, 3); 

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (14, 12, '*', 1);            
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (14, 11, '*', 2);            
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (14, 3, null, 3); 

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (17, 16, '*', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (17, 13, null, 2);    

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (18, 16, '*', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (18, 14, null, 2);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (19, 20, '*', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (19, 17, null, 2);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (21, 20, '*', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (21, 18, null, 2);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (23, 22, null, 1);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (24, 22, '*', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (24, 21, null, 2);  
     
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (25, 22, '*', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (25, 21, null, 2);  
    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (26, 24, '+', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (26, 25, null, 2);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (27, 24, null, 1);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (28, 25, null, 1);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (29, 26, null, 1);  
    

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (32, 30, '+', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (32, 31, null, 2);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (33, 30, null, 1);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (34, 31, null, 1);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (35, 32, null, 1);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (38, 36, '+', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (38, 37, null, 2);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (39, 24, '/', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (39, 30, null, 2);  
 
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (40, 25, '/', 1);    
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (40, 31, null, 2);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (42, 39, null, 1);  

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (43, 40, null, 1);  
 
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (45, 22, '*', 1);            
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (45, 20, '*', 2);            
INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (45, 16, null, 3); 

INSERT INTO siig_mtd_r_formula_formula(id_formula, id_formula_figlio, operatore, progressivo_formula)
    VALUES (46, 45, null, 1);  
 
commit;    


---------------------------------------------------------------------   
-- SIIG_MTD_R_FORMULA_PARAMETRO  
---------------------------------------------------------------------   
INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (2, 1, 1, null, 0);


INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (5, 2, 1, null, 0);
    
INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (6, 5, 1, null, 0);

INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (7, 3, 1, null, 0); 
    
INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (8, 6, 1, null, 0);
    
INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (9, 4, 1, null, 0); 
    
INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (10, 7, 1, null, 0); 

INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (12, 8, 1, null, 0); 

INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (16, 9, 1, null, 0); 

INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (20, 10, 1, null, 0); 

INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (22,11, 1, null, 0); 
    
INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (30, 12, 1, null, 0); 

INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (31, 13, 1, null, 0); 
    
INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (36, 14, 1, null, 0); 

INSERT INTO siig_mtd_r_formula_parametro(
            id_formula, id_parametro, numero_ordine, operatore, flg_modificabile)
    VALUES (37, 15, 1, null, 0); 
commit;
       