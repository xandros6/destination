CREATE TABLE siig_gate_geo_gate (
       id_gate              numeric(3) NOT NULL,
       descrizione          character varying(100) NOT NULL,
       collocazione         character varying(250) NULL,
       GEOMETRIA            geometry(POINT,4326),
       data_inizio_validita timestamp without time zone NULL,
       data_fine_validita   timestamp without time zone NULL
);


ALTER TABLE siig_gate_geo_gate
       ADD  CONSTRAINT PK_siig_gate_geo_gate PRIMARY KEY (id_gate);

CREATE TABLE siig_gate_t_dato (
       id_dato              numeric NOT NULL,
       fk_gate              numeric(3) NOT NULL,
       data_rilevamento     timestamp without time zone NOT NULL,
       ora_fuso_orario      INTEGER NOT NULL,
       minuto_fuso_orario   INTEGER NOT NULL,
       data_ricezione       timestamp without time zone NOT NULL,
       flg_corsia           numeric(1) NOT NULL
                                   CONSTRAINT DOM_0_1_221
                                          CHECK (flg_corsia IN (0,1,2)),
       direzione            character varying(2) NOT NULL
                                   CONSTRAINT DOM_DIREZIONE
                                          CHECK (direzione IN ('N','S', 'E','O','NE','NO','SE', 'SO')),
       codice_kemler        character varying(5) NULL,
       codice_onu           character varying(5) NULL
);

COMMENT ON COLUMN siig_gate_t_dato.data_rilevamento IS 'Comunicata dal gate';
COMMENT ON COLUMN siig_gate_t_dato.data_ricezione IS 'Valorizzato da applicativo';
COMMENT ON COLUMN siig_gate_t_dato.flg_corsia IS '0=corsia di marcia
1=corsia di sorpasso
2=corsia di sorpasso veloce';
COMMENT ON COLUMN siig_gate_t_dato.direzione IS 'valori attesi : 
N,S, E,O,NE,NO,SE, SO';

ALTER TABLE siig_gate_t_dato
       ADD CONSTRAINT PK_siig_gate_t_dato PRIMARY KEY (id_dato) ;

CREATE TABLE siig_gate_t_dato_statistico (
       id_dato              numeric(5) NOT NULL,
       fk_gate              numeric(3) NOT NULL,
       data_stat_inizio     timestamp without time zone NOT NULL,
       data_stat_fine       timestamp without time zone NULL,
       flg_corsia           numeric(1) NOT NULL
                                   CONSTRAINT DOM_0_1_222
                                          CHECK (flg_corsia IN (0,1,2)),
       direzione            character varying(2) NOT NULL
                                   CONSTRAINT DOM_DIREZIONE2
                                          CHECK (direzione IN ('N','S', 'E','O','NE','NO','SE', 'SO')),
       codice_kemler        character varying(5) NULL,
       codice_onu           character varying(5) NULL,
       quantita             numeric(10) NULL
);

COMMENT ON COLUMN siig_gate_t_dato_statistico.data_stat_inizio IS 'Comunicata dal gate';
COMMENT ON COLUMN siig_gate_t_dato_statistico.flg_corsia IS '0=corsia di marcia
1=corsia di sorpasso
2=corsia di sorpasso veloce';
COMMENT ON COLUMN siig_gate_t_dato_statistico.direzione IS 'valori attesi : 
N,S, E,O,NE,NO,SE, SO';

ALTER TABLE siig_gate_t_dato_statistico
       ADD   CONSTRAINT PK_siig_gate_t_dato_statistico PRIMARY KEY (
              id_dato)  ;

CREATE TABLE siig_gate_t_dato_storico (
       id_dato              numeric NOT NULL,
       fk_gate              numeric(3) NOT NULL,
       data_rilevamento     timestamp without time zone NOT NULL,
       ora_fuso_orario      INTEGER NOT NULL,
       minuto_fuso_orario   INTEGER NOT NULL,
       data_ricezione       timestamp without time zone NOT NULL,
       flg_corsia           numeric(1) NOT NULL
                                   CONSTRAINT DOM_0_1_223
                                          CHECK (flg_corsia IN (0,1,2)),
       direzione            character varying(2) NOT NULL
                                   CONSTRAINT DOM_DIREZIONE3
                                          CHECK (direzione IN ('N','S', 'E','O','NE','NO','SE', 'SO')),
       codice_kemler        character varying(5) NULL,
       codice_onu           character varying(5) NULL
);

COMMENT ON COLUMN siig_gate_t_dato_storico.data_rilevamento IS 'Comunicata dal gate';
COMMENT ON COLUMN siig_gate_t_dato_storico.data_ricezione IS 'Valorizzato da applicativo';
COMMENT ON COLUMN siig_gate_t_dato_storico.flg_corsia IS '0=corsia di marcia
1=corsia di sorpasso
2=corsia di sorpasso veloce';
COMMENT ON COLUMN siig_gate_t_dato_storico.direzione IS 'valori attesi : 
N,S, E,O,NE,NO,SE, SO';

ALTER TABLE siig_gate_t_dato_storico
       ADD  CONSTRAINT PK_siig_gate_t_dato_storico PRIMARY KEY (
              id_dato) ;


ALTER TABLE siig_gate_t_dato
       ADD   CONSTRAINT FK_siig_gate_geo_gate_01
              FOREIGN KEY (fk_gate)
                             REFERENCES siig_gate_geo_gate ;


ALTER TABLE siig_gate_t_dato_statistico
       ADD CONSTRAINT FK_siig_gate_geo_gate_03
              FOREIGN KEY (fk_gate)
                             REFERENCES siig_gate_geo_gate ;


ALTER TABLE siig_gate_t_dato_storico
       ADD CONSTRAINT FK_siig_gate_geo_gate_02
              FOREIGN KEY (fk_gate)
                             REFERENCES siig_gate_geo_gate ;



