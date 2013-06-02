-------------------------------------------------------------------------------------
-- modifiche del 09/04/2013 - richieste da Antonello
-------------------------------------------------------------------------------------

alter table SIIG_R_DIST_ARCO1SCENTIPOBERS drop constraint FK_SIIG_R_ARC_1SCENTIPOBER_01;

alter table SIIG_R_DIST_ARCO1SCENTIPOBERS drop constraint PK_SIIG_R_DIST_ARCO1SCENTIPOBE;

alter table SIIG_R_DIST_ARCO1SCENTIPOBERS drop column id_scenario;

alter table SIIG_R_DIST_ARCO1SCENTIPOBERS add CONSTRAINT 
            PK_SIIG_R_DIST_ARCO1SCENTIPOBE PRIMARY KEY (ID_DISTANZA, ID_GEO_ARCO, ID_BERSAGLIO);

alter table SIIG_R_ARCO_1_SCEN_TIPOBERS drop constraint FK_SIIG_T_SCENARIO_03;

alter table SIIG_R_ARCO_1_SCEN_TIPOBERS drop constraint pk_SIIG_R_ARCO_1_SCEN_TIPOBERS;

alter table SIIG_R_ARCO_1_SCEN_TIPOBERS drop column id_scenario;

alter table SIIG_R_ARCO_1_SCEN_TIPOBERS add CONSTRAINT 
            PK_SIIG_R_ARCO_1_SCEN_TIPOBERS PRIMARY KEY (ID_GEO_ARCO, ID_BERSAGLIO);
            
alter table SIIG_R_DIST_ARCO2SCENTIPOBERS drop constraint FK_SIIG_R_ARC_2SCENTIPOBER_02;

alter table SIIG_R_DIST_ARCO2SCENTIPOBERS drop constraint PK_SIIG_R_DIST_ARCO2SCENTIPOBE;

alter table SIIG_R_DIST_ARCO2SCENTIPOBERS drop column id_scenario;

alter table SIIG_R_DIST_ARCO2SCENTIPOBERS add CONSTRAINT 
            PK_SIIG_R_DIST_ARCO2SCENTIPOBE PRIMARY KEY (ID_DISTANZA, ID_GEO_ARCO, ID_BERSAGLIO);
            
alter table SIIG_R_ARCO_2_SCEN_TIPOBERS drop constraint FK_SIIG_T_SCENARIO_04;

alter table SIIG_R_ARCO_2_SCEN_TIPOBERS drop constraint pk_SIIG_R_ARCO_2_SCEN_TIPOBERS;

alter table SIIG_R_ARCO_2_SCEN_TIPOBERS drop column id_scenario;

alter table SIIG_R_ARCO_2_SCEN_TIPOBERS add CONSTRAINT 
            PK_SIIG_R_ARCO_2_SCEN_TIPOBERS PRIMARY KEY (ID_GEO_ARCO, ID_BERSAGLIO);

alter table SIIG_R_DIST_ARCO3SCENTIPOBERS drop constraint FK_SIIG_R_ARC_3SCENTIPOBER_01;

alter table SIIG_R_DIST_ARCO3SCENTIPOBERS drop constraint PK_SIIG_R_DIST_ARCO3SCENTIPOBE;

alter table SIIG_R_DIST_ARCO3SCENTIPOBERS drop column id_scenario;

alter table SIIG_R_DIST_ARCO3SCENTIPOBERS add CONSTRAINT 
            PK_SIIG_R_DIST_ARCO3SCENTIPOBE PRIMARY KEY (ID_DISTANZA, ID_GEO_ARCO, ID_BERSAGLIO);

alter table SIIG_R_ARCO_3_SCEN_TIPOBERS drop constraint FK_SIIG_T_SCENARIO_05;

alter table SIIG_R_ARCO_3_SCEN_TIPOBERS drop constraint pk_SIIG_R_ARCO_3_SCEN_TIPOBERS;

alter table SIIG_R_ARCO_3_SCEN_TIPOBERS drop column id_scenario;

alter table SIIG_R_ARCO_3_SCEN_TIPOBERS add CONSTRAINT 
            PK_SIIG_R_ARCO_3_SCEN_TIPOBERS PRIMARY KEY (ID_GEO_ARCO, ID_BERSAGLIO);                                                                                                                                                                                               
                                                                                           
-------------------------------------------------------------------------------------                                           
 alter table siig_d_gravita drop CONSTRAINT fk_siig_d_bersaglio_09;
 alter table siig_d_gravita drop Column fk_bersaglio;
------------------------------------------------------------------------------------- 

alter table siig_r_area_danno drop CONSTRAINT pk_siig_r_area_danno ;
alter table siig_r_area_danno drop column id_tipologia_danno;
alter table siig_r_area_danno add column id_bersaglio numeric(6,0);
alter table siig_r_area_danno add CONSTRAINT 
            pk_siig_r_area_danno PRIMARY KEY (id_gravita, id_scenario, id_bersaglio, id_sostanza,flg_lieve);

------------------------------------------------------------------------
ALTER TABLE siig_d_distanza ALTER COLUMN id_distanza TYPE numeric(4,0);

ALTER TABLE siig_r_dist_arco1scentipobers ALTER COLUMN id_distanza TYPE numeric(4,0);
ALTER TABLE siig_r_dist_arco2scentipobers ALTER COLUMN id_distanza TYPE numeric(4,0); 
ALTER TABLE siig_r_dist_arco3scentipobers ALTER COLUMN id_distanza TYPE numeric(4,0); 

ALTER TABLE siig_t_vulnerabilita_1 ALTER COLUMN id_distanza TYPE numeric(4,0);
ALTER TABLE siig_t_vulnerabilita_2 ALTER COLUMN id_distanza TYPE numeric(4,0);
ALTER TABLE siig_t_vulnerabilita_3 ALTER COLUMN id_distanza TYPE numeric(4,0); 

ALTER TABLE siig_r_area_danno ALTER COLUMN fk_distanza TYPE numeric(4,0);  

ALTER TABLE siig_t_elab_standard_1 ALTER COLUMN id_distanza TYPE numeric(4,0); 
ALTER TABLE siig_t_elab_standard_2 ALTER COLUMN id_distanza TYPE numeric(4,0);
ALTER TABLE siig_t_elab_standard_3 ALTER COLUMN id_distanza TYPE numeric(4,0); 

------------------------------------------------------------------------

alter table SIIG_R_SCENARIO_GRAVITA drop constraint pk_SIIG_R_SCENARIO_GRAVITA;
alter table SIIG_R_SCENARIO_GRAVITA add column id_bersaglio numeric(6,0);

alter table SIIG_R_SCENARIO_GRAVITA add CONSTRAINT 
            PK_SIIG_R_SCENARIO_GRAVITA PRIMARY KEY (ID_scenario, ID_BERSAGLIO, id_gravita);

ALTER TABLE SIIG_R_SCENARIO_GRAVITA ADD CONSTRAINT FK_SIIG_T_BERSAGLIO_11
              FOREIGN KEY (ID_BERSAGLIO) REFERENCES SIIG_T_BERSAGLIO  ;



              
----------------------------------------------------------------
-- MODIFICHE ALLE TAVOLE DI METADATI DELLA FORMULA
----------------------------------------------------------------

ALTER TABLE siig_mtd_t_formula DROP CONSTRAINT fk_siig_mtd_formula_02;
alter table siig_mtd_t_formula drop column fk_figlio;
alter table siig_mtd_t_formula drop column operatore_catena;
alter table siig_mtd_t_formula add column ordine_visibilita NUMERIC(3,0);

CREATE TABLE SIIG_MTD_R_FORMULA_FORMULA (
       ID_FORMULA           numeric(3,0) NOT NULL,
       ID_FORMULA_FIGLIO    numeric(3,0) NOT NULL,
       OPERATORE            character varying(5) NULL,
       PROGRESSIVO_FORMULA  numeric(2,0) NULL
);


ALTER TABLE SIIG_MTD_R_FORMULA_FORMULA
       ADD CONSTRAINT PK_SIIG_MTD_R_FORMULA_FORMULA PRIMARY KEY (ID_FORMULA, ID_FORMULA_FIGLIO);

ALTER TABLE SIIG_MTD_R_FORMULA_FORMULA ADD CONSTRAINT FK_SIIG_MTD_T_FORMULA_05 
      FOREIGN KEY (ID_FORMULA_FIGLIO) REFERENCES SIIG_MTD_T_FORMULA ;

ALTER TABLE SIIG_MTD_R_FORMULA_FORMULA ADD  CONSTRAINT FK_SIIG_MTD_T_FORMULA_02
      FOREIGN KEY (ID_FORMULA) REFERENCES SIIG_MTD_T_FORMULA ;

ALTER TABLE siig_mtd_t_parametro  add column  flg_lieve numeric(1);     

alter table SIIG_MTD_R_FORMULA_PARAMETRO add column FLG_MODIFICABILE NUMERIC(1,0);

ALTER TABLE siig_mtd_t_parametro ALTER COLUMN descrizione TYPE character varying(100);

ALTER TABLE siig_mtd_t_formula ALTER COLUMN udm TYPE character varying(100);
