ALTER TABLE siig_mtd_d_elaborazione RENAME descrizione_elaborazione  TO descrizione_elaborazione_it;
ALTER TABLE siig_mtd_d_criterio_filtro RENAME descrizione_criterio  TO descrizione_criterio_it;
ALTER TABLE siig_mtd_d_arco RENAME descrizione_arco  TO descrizione_arco_it;
ALTER TABLE siig_mtd_t_formula RENAME descrizione  TO descrizione_it;
ALTER TABLE siig_mtd_t_formula RENAME udm  TO udm_it;
ALTER TABLE siig_mtd_t_parametro RENAME descrizione  TO descrizione_it;

ALTER TABLE siig_mtd_d_elaborazione ADD COLUMN descrizione_elaborazione_it character varying(50);
ALTER TABLE siig_mtd_d_elaborazione ADD COLUMN descrizione_elaborazione_en character varying(50);
ALTER TABLE siig_mtd_d_elaborazione ADD COLUMN descrizione_elaborazione_de character varying(50);
ALTER TABLE siig_mtd_d_elaborazione ADD COLUMN descrizione_elaborazione_fr character varying(50);



ALTER TABLE siig_mtd_d_criterio_filtro ADD COLUMN descrizione_criterio_it character varying(50);
ALTER TABLE siig_mtd_d_criterio_filtro ADD COLUMN descrizione_criterio_en character varying(50);
ALTER TABLE siig_mtd_d_criterio_filtro ADD COLUMN descrizione_criterio_de character varying(50);
ALTER TABLE siig_mtd_d_criterio_filtro ADD COLUMN descrizione_criterio_fr character varying(50);



ALTER TABLE siig_mtd_d_arco ADD COLUMN descrizione_arco_it character varying(20);
ALTER TABLE siig_mtd_d_arco ADD COLUMN descrizione_arco_en character varying(20);
ALTER TABLE siig_mtd_d_arco ADD COLUMN descrizione_arco_de character varying(20);
ALTER TABLE siig_mtd_d_arco ADD COLUMN descrizione_arco_fr character varying(20);



ALTER TABLE siig_mtd_t_formula ADD COLUMN descrizione_it character varying(200);
ALTER TABLE siig_mtd_t_formula ADD COLUMN descrizione_en character varying(200);
ALTER TABLE siig_mtd_t_formula ADD COLUMN descrizione_de character varying(200);
ALTER TABLE siig_mtd_t_formula ADD COLUMN descrizione_fr character varying(200);


ALTER TABLE siig_mtd_t_formula ADD COLUMN udm_it character varying(100);
ALTER TABLE siig_mtd_t_formula ADD COLUMN udm_en character varying(100);
ALTER TABLE siig_mtd_t_formula ADD COLUMN udm_de character varying(100);
ALTER TABLE siig_mtd_t_formula ADD COLUMN udm_fr character varying(100);




ALTER TABLE siig_mtd_t_parametro ADD COLUMN descrizione_it character varying(100);
ALTER TABLE siig_mtd_t_parametro ADD COLUMN descrizione_en character varying(100);
ALTER TABLE siig_mtd_t_parametro ADD COLUMN descrizione_de character varying(100);
ALTER TABLE siig_mtd_t_parametro ADD COLUMN descrizione_fr character varying(100);



create table siig_d_dettaglio (
       id_dettaglio         numeric(2,0) not null,
       descrizione          character varying(50) null
);


alter table siig_d_dettaglio
       add  constraint pk_siig_d_dettaglio primary key (
              id_dettaglio) ;


create table siig_d_ente (
       id_ente              numeric(2,0) not null,
       denominazione        character varying(100) not null
);


alter table siig_d_ente
       add  constraint pk_siig_d_ente primary key (id_ente) ;


create table siig_d_ruolo (
       id_ruolo             numeric(2,0) not null,
       descrizione_ruolo    character varying(100) not null
);


alter table siig_d_ruolo
       add  constraint pk_siig_d_ruolo primary key (id_ruolo) ;


create table siig_t_export (
       id_export            numeric(6,0) not null,
       fk_dettaglio         numeric(2,0) not null,
       fk_utente            numeric(6,0) not null,
       data_richiesta       timestamp without time zone null,
       e_mail               character varying(100) null,
       flg_stato            character varying(1) null,
       xml_richiesta        xml null,
       constraint dom_1_ri  check (flg_stato::text = any (array['R'::character varying::text, 'I'::character varying ::text]))
);


alter table siig_t_export
       add  constraint pk_siig_t_export primary key (id_export) ;


create table siig_t_file (
       id_save              numeric(6,0) not null,
       campo_file           bytea null
);


alter table siig_t_file
       add  constraint pk_siig_t_file primary key (id_save) ;


create table siig_t_save (
       id_save              numeric(6,0) not null,
       fk_utente            numeric(6,0) not null,
       xml_richiesta        xml null,
       data_aggiornamento   timestamp without time zone null,
       nome_elaborazione    character varying(100) null,
       flg_rigenerabile     character varying(1) null,
       constraint dom_1_sn  check (flg_rigenerabile::text = any (array['S'::character varying::text, 'N'::character varying ::text]))
);


alter table siig_t_save
       add  constraint pk_siig_t_save primary key (id_save) ;


create table siig_t_utente (
       id_utente            numeric(6,0) not null,
       fk_ente              numeric(2,0) null,
       fk_ruolo             numeric(2,0) not null,
       nome                 character varying(50) not null,
       cognome              character varying(50) not null,
       c_f                  character varying(12) not null
);


alter table siig_t_utente
       add  constraint pk_siig_t_utente primary key (id_utente)  ;


alter table siig_t_export
       add  constraint fk_siig_t_utente_02
              foreign key (fk_utente)
                             references siig_t_utente ;


alter table siig_t_export
       add  constraint fk_siig_d_dettaglio_01
              foreign key (fk_dettaglio)
                             references siig_d_dettaglio  ;


alter table siig_t_file
       add  constraint fk_siig_t_save_01
              foreign key (id_save)
                             references siig_t_save  ;


alter table siig_t_save
       add  constraint fk_siig_t_utente_03
              foreign key (fk_utente)
                             references siig_t_utente  ;


alter table siig_t_utente
       add  constraint fk_siig_d_ente_01
              foreign key (fk_ente)
                             references siig_d_ente ;


alter table siig_t_utente
       add  constraint fk_siig_d_ruolo_01
              foreign key (fk_ruolo)
                             references siig_d_ruolo  ;

