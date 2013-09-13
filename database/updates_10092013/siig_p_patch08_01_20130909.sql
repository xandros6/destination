ALTER TABLE siig_t_vulnerabilita_1 DROP COLUMN nr_pers_flusso_buffer;
ALTER TABLE siig_t_vulnerabilita_2 DROP COLUMN nr_pers_flusso_buffer;
ALTER TABLE siig_t_vulnerabilita_3 DROP COLUMN nr_pers_flusso_buffer;

----------------------------------------------------------------------------------


drop table siig_r_dist_arco1scentipobers ;
drop table siig_r_dist_arco2scentipobers ;
drop table siig_r_dist_arco3scentipobers ;

----------------------------------------------------------------------------------


create table siig_r_scen_vuln_1 (
       id_scenario          numeric(9) not null,
       id_geo_arco          numeric(9) not null,
       id_distanza          numeric(2) not null,
       utenti_carr_bersaglio numeric(6) null,
       utenti_carr_sede_inc numeric(6) null
);


alter table siig_r_scen_vuln_1
       add  constraint pk_siig_r_scen_vuln_1 primary key 
              (id_scenario, id_geo_arco, id_distanza) ;


create table siig_r_scen_vuln_2 (
       id_scenario          numeric(9) not null,
       id_geo_arco          numeric(9) not null,
       id_distanza          numeric(2) not null,
       utenti_carr_bersaglio numeric(6) null,
       utenti_carr_sede_inc numeric(6) null
);


alter table siig_r_scen_vuln_2
       add   constraint pk_siig_r_scen_vuln_2 primary key (
              id_scenario, id_geo_arco, id_distanza) ;


create table siig_r_scen_vuln_3 (
       id_scenario          numeric(9) not null,
       id_geo_arco          numeric(9) not null,
       id_distanza          numeric(2) not null,
       utenti_carr_bersaglio numeric(6) null,
       utenti_carr_sede_inc numeric(6) null
);


alter table siig_r_scen_vuln_3
       add  constraint pk_siig_r_scen_vuln_3 primary key (
              id_scenario, id_geo_arco, id_distanza) ;


alter table siig_r_scen_vuln_1
       add   constraint fk_siig_t_vulnerabilita_1_02
              foreign key (id_geo_arco, id_distanza)
                             references siig_t_vulnerabilita_1  ;


alter table siig_r_scen_vuln_1
       add  constraint fk_siig_t_scenario_03
              foreign key (id_scenario)
                             references siig_t_scenario  ;


alter table siig_r_scen_vuln_2
       add  constraint fk_siig_t_scenario_04
              foreign key (id_scenario)
                             references siig_t_scenario  ;


alter table siig_r_scen_vuln_2
       add   constraint fk_siig_t_vulnerabilita_2_02
              foreign key (id_geo_arco, id_distanza)
                             references siig_t_vulnerabilita_2  ;


alter table siig_r_scen_vuln_3
       add   constraint fk_siig_t_vulnerabilita_3_02
              foreign key (id_geo_arco, id_distanza)
                             references siig_t_vulnerabilita_3  ;


alter table siig_r_scen_vuln_3
       add   constraint fk_siig_t_scenario_05
              foreign key (id_scenario)
                             references siig_t_scenario  ;
                             
----------------------------------------------------------------------------------
                             
   ALTER TABLE siig_t_bersaglio_umano
   ADD COLUMN flg_nr_res character varying(1)
   CONSTRAINT dom_s_c62 CHECK (flg_nr_res::text = ANY (ARRAY['C'::character varying::text, 'S'::character varying::text]));

----------------------------------------------------------------------------------
                     
                             
DROP VIEW v_geo_popolazione_residente_pl;

CREATE OR REPLACE VIEW v_geo_popolazione_residente_pl AS 
 SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, 
 				siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pl,
 				CASE
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_residenti_it,  
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_residenti_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_residenti_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_residenti_de, 
 				siig_t_bersaglio_umano.residenti, siig_geo_bersaglio_umano_pl.geometria
   FROM siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pl
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) ON siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl) ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio
  WHERE siig_t_bersaglio_umano.id_bersaglio = 1::numeric;                            





DROP VIEW v_geo_popolazione_residente_pt;

CREATE OR REPLACE VIEW v_geo_popolazione_residente_pt AS 
 SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, 
 				siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pt, 
 				CASE
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_residenti_it,  
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_residenti_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_residenti_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_res::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_residenti_de, 
 				siig_t_bersaglio_umano.residenti, siig_geo_bersaglio_umano_pt.geometria
   FROM siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pt
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) ON siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt) ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio
  WHERE siig_t_bersaglio_umano.id_bersaglio = 1::numeric;