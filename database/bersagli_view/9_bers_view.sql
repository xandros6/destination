

CREATE OR REPLACE VIEW v_geo_acque_superficiali_pl AS 
 SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
                 siig_t_bersaglio_non_umano.id_tematico, 
                 siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, 
                 siig_t_bersaglio_non_umano.denominazione_it, 
                 siig_t_bersaglio_non_umano.denominazione_en, 
                 siig_t_bersaglio_non_umano.denominazione_fr, 
                 siig_t_bersaglio_non_umano.denominazione_de,  
                 siig_d_classe_clc.codice_clc, 
                 siig_d_classe_clc.descrizione_clc_it, 
                 siig_d_classe_clc.descrizione_clc_en, 
                 siig_d_classe_clc.descrizione_clc_fr, 
                 siig_d_classe_clc.descrizione_clc_de,  
                 siig_t_bersaglio_non_umano.superficie, 
                 siig_t_bersaglio_non_umano.toponimo_completo_it, 
                 siig_t_bersaglio_non_umano.toponimo_completo_en, 
                 siig_t_bersaglio_non_umano.toponimo_completo_fr, 
                 siig_t_bersaglio_non_umano.toponimo_completo_de,
                 siig_geo_bers_non_umano_pl.geometria
   FROM siig_d_classe_clc
   RIGHT JOIN (siig_t_bersaglio
   INNER JOIN (siig_d_partner
   INNER JOIN (siig_geo_bers_non_umano_pl
   INNER JOIN siig_t_bersaglio_non_umano
   ON siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl) 
   ON siig_d_partner.id_partner::text = siig_t_bersaglio_non_umano.id_partner::text) 
   ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio) 
   ON siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc
  WHERE siig_t_bersaglio_non_umano.id_bersaglio = 15::numeric;    
  
  CREATE OR REPLACE VIEW v_geo_acque_superficiali_ln AS
 SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
                 siig_t_bersaglio_non_umano.id_tematico, 
                 siig_t_bersaglio_non_umano.fk_bers_non_umano_ln, 
                 siig_t_bersaglio_non_umano.denominazione_it, 
                 siig_t_bersaglio_non_umano.denominazione_en, 
                 siig_t_bersaglio_non_umano.denominazione_fr, 
                 siig_t_bersaglio_non_umano.denominazione_de,  
                 siig_d_classe_clc.codice_clc, 
                 siig_d_classe_clc.descrizione_clc_it, 
                 siig_d_classe_clc.descrizione_clc_en, 
                 siig_d_classe_clc.descrizione_clc_fr, 
                 siig_d_classe_clc.descrizione_clc_de, 
                 siig_t_bersaglio_non_umano.superficie, 
                 siig_t_bersaglio_non_umano.toponimo_completo_it, 
                 siig_t_bersaglio_non_umano.toponimo_completo_en, 
                 siig_t_bersaglio_non_umano.toponimo_completo_fr, 
                 siig_t_bersaglio_non_umano.toponimo_completo_de, 
                 siig_geo_bers_non_umano_ln.geometria
   FROM siig_d_classe_clc
   RIGHT JOIN (siig_t_bersaglio
   JOIN (siig_d_partner
   JOIN (siig_geo_bers_non_umano_ln
   JOIN siig_t_bersaglio_non_umano  
     ON siig_geo_bers_non_umano_ln.idgeo_bers_non_umano_ln = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl) 
     ON siig_d_partner.id_partner::text = siig_t_bersaglio_non_umano.id_partner::text) 
     ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio) 
     ON siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc
  WHERE siig_t_bersaglio_non_umano.id_bersaglio = 15::numeric;
    
CREATE OR REPLACE VIEW v_geo_aree_agricole_pl  AS 
  SELECT siig_d_partner.partner_it, 
            siig_d_partner.partner_en, 
            siig_d_partner.partner_fr, 
            siig_d_partner.partner_de, 
               siig_t_bersaglio_non_umano.id_tematico, 
               siig_t_bersaglio_non_umano.fk_bers_non_umano_pl,  
               siig_d_classe_clc.codice_clc, 
               siig_d_classe_clc.descrizione_clc_it, 
             siig_d_classe_clc.descrizione_clc_en, 
             siig_d_classe_clc.descrizione_clc_fr, 
             siig_d_classe_clc.descrizione_clc_de,
               siig_t_bersaglio_non_umano.superficie, 
               siig_geo_bers_non_umano_pl.geometria
  FROM siig_t_bersaglio 
  INNER JOIN (siig_d_partner 
  INNER JOIN (siig_d_classe_clc 
  RIGHT JOIN (siig_geo_bers_non_umano_pl 
  INNER JOIN siig_t_bersaglio_non_umano 
  ON siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl) 
  ON siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc) 
  ON siig_d_partner.id_partner = siig_t_bersaglio_non_umano.id_partner) 
  ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio
  WHERE siig_t_bersaglio_non_umano.id_bersaglio = 13::numeric;  


CREATE OR REPLACE VIEW v_geo_aree_boscate_pl AS 
  SELECT siig_d_partner.partner_it, 
            siig_d_partner.partner_en, 
            siig_d_partner.partner_fr, 
            siig_d_partner.partner_de, 
               siig_t_bersaglio_non_umano.id_tematico, 
               siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, 
               siig_d_classe_clc.codice_clc, 
               siig_d_classe_clc.descrizione_clc_it, 
             siig_d_classe_clc.descrizione_clc_en, 
             siig_d_classe_clc.descrizione_clc_fr, 
             siig_d_classe_clc.descrizione_clc_de, 
               siig_t_bersaglio_non_umano.superficie, 
               siig_geo_bers_non_umano_pl.geometria
  FROM siig_t_bersaglio 
  INNER JOIN (siig_d_partner 
  INNER JOIN (siig_d_classe_clc 
  RIGHT JOIN (siig_geo_bers_non_umano_pl 
  INNER JOIN siig_t_bersaglio_non_umano 
  ON siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl) 
  ON siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc) 
  ON siig_d_partner.id_partner = siig_t_bersaglio_non_umano.id_partner) 
  ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio
  WHERE siig_t_bersaglio_non_umano.id_bersaglio = 11::numeric;  


CREATE OR REPLACE VIEW v_geo_aree_protette_pl AS
    SELECT siig_d_partner.partner_it, 
        siig_d_partner.partner_en, 
        siig_d_partner.partner_fr, 
        siig_d_partner.partner_de,  
                 siig_t_bersaglio_non_umano.id_tematico, 
                 siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, 
                 siig_t_bersaglio_non_umano.denominazione_it, 
                 siig_t_bersaglio_non_umano.denominazione_en, 
                 siig_t_bersaglio_non_umano.denominazione_fr, 
                 siig_t_bersaglio_non_umano.denominazione_de, 
                 siig_t_bersaglio_non_umano.denominazione_ente_it, 
                 siig_t_bersaglio_non_umano.denominazione_ente_en, 
                 siig_t_bersaglio_non_umano.denominazione_ente_fr, 
                 siig_t_bersaglio_non_umano.denominazione_ente_de, 
                 siig_t_bersaglio_non_umano.superficie, 
                 siig_d_iucn.descrizione_iucn_it, 
                 siig_d_iucn.descrizione_iucn_en, 
                 siig_d_iucn.descrizione_iucn_fr, 
                 siig_d_iucn.descrizione_iucn_de, 
                 siig_geo_bers_non_umano_pl.geometria
    FROM siig_d_iucn 
    RIGHT JOIN (siig_t_bersaglio 
    INNER JOIN (siig_d_partner 
    INNER JOIN (siig_geo_bers_non_umano_pl 
    INNER JOIN siig_t_bersaglio_non_umano 
    ON siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl) 
    ON siig_d_partner.id_partner = siig_t_bersaglio_non_umano.id_partner) 
    ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio) 
    ON siig_d_iucn.id_iucn = siig_t_bersaglio_non_umano.fk_iucn
    WHERE (((siig_t_bersaglio_non_umano.id_bersaglio)=12)) 
    OR (((siig_t_bersaglio_non_umano.id_bersaglio)=11));
    
    
CREATE OR REPLACE VIEW v_geo_beni_culturali_pl AS 
  SELECT siig_d_partner.partner_it, 
        siig_d_partner.partner_en, 
        siig_d_partner.partner_fr, 
        siig_d_partner.partner_de,  
               siig_t_bersaglio_non_umano.id_tematico, 
               siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, 
               siig_t_bersaglio_non_umano.denominazione denominazione_bene_it,       
               siig_t_bersaglio_non_umano.denominazione denominazione_bene_en,       
               siig_t_bersaglio_non_umano.denominazione denominazione_bene_fr,       
               siig_t_bersaglio_non_umano.denominazione denominazione_bene_de,       
         siig_d_bene_culturale.tipologia_it,        
         siig_d_bene_culturale.tipologia_en,        
         siig_d_bene_culturale.tipologia_fr,        
         siig_d_bene_culturale.tipologia_de,        
         siig_t_bersaglio_non_umano.superficie,
         siig_geo_bers_non_umano_pl.geometria
    FROM siig_d_bene_culturale 
    RIGHT JOIN (siig_t_bersaglio 
    INNER JOIN (siig_d_partner 
    INNER JOIN (siig_geo_bers_non_umano_pl 
    INNER JOIN siig_t_bersaglio_non_umano 
    ON siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl) 
    ON siig_d_partner.id_partner = siig_t_bersaglio_non_umano.id_partner) 
    ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio) 
    ON siig_d_bene_culturale.id_tipo_bene = siig_t_bersaglio_non_umano.fk_tipo_bene
    WHERE (((siig_t_bersaglio_non_umano.id_bersaglio)=16));

  CREATE OR REPLACE VIEW v_geo_beni_culturali_pt AS 
  SELECT siig_d_partner.partner_it, 
        siig_d_partner.partner_en, 
        siig_d_partner.partner_fr, 
        siig_d_partner.partner_de,  
               siig_t_bersaglio_non_umano.id_tematico, 
               siig_t_bersaglio_non_umano.fk_bers_non_umano_pt,
               siig_t_bersaglio_non_umano.denominazione denominazione_bene_it,       
               siig_t_bersaglio_non_umano.denominazione denominazione_bene_en,       
               siig_t_bersaglio_non_umano.denominazione denominazione_bene_fr,       
               siig_t_bersaglio_non_umano.denominazione denominazione_bene_de,                        
         siig_d_bene_culturale.tipologia_it,        
         siig_d_bene_culturale.tipologia_en,        
         siig_d_bene_culturale.tipologia_fr,        
         siig_d_bene_culturale.tipologia_de,
         siig_t_bersaglio_non_umano.superficie,
         siig_geo_bers_non_umano_pt.geometria
    FROM siig_d_bene_culturale 
    RIGHT JOIN (siig_t_bersaglio 
    INNER JOIN (siig_d_partner 
    INNER JOIN (siig_geo_bers_non_umano_pt 
    INNER JOIN siig_t_bersaglio_non_umano 
    ON siig_geo_bers_non_umano_pt.idgeo_bers_non_umano_pt = siig_t_bersaglio_non_umano.fk_bers_non_umano_pt) 
    ON siig_d_partner.id_partner = siig_t_bersaglio_non_umano.id_partner) 
    ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio) 
    ON siig_d_bene_culturale.id_tipo_bene = siig_t_bersaglio_non_umano.fk_tipo_bene
    WHERE (((siig_t_bersaglio_non_umano.id_bersaglio)=16));
    
    

CREATE OR REPLACE VIEW v_geo_commercio_pl AS 
 SELECT siig_d_partner.partner_it, 
        siig_d_partner.partner_en, 
        siig_d_partner.partner_fr, 
        siig_d_partner.partner_de, 
        siig_t_bersaglio_umano.id_tematico, 
        siig_t_bersaglio_umano.fk_bersaglio_umano_pl, 
        siig_t_bersaglio_umano.denominazione_it, 
        siig_t_bersaglio_umano.denominazione_en, 
        siig_t_bersaglio_umano.denominazione_fr, 
        siig_t_bersaglio_umano.denominazione_de, 
        siig_t_bersaglio_umano.insegna_it, 
        siig_t_bersaglio_umano.insegna_en, 
        siig_t_bersaglio_umano.insegna_fr, 
        siig_t_bersaglio_umano.insegna_de, 
        siig_t_bersaglio_umano.sup_vendita, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_utenti_it, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_utenti_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_utenti_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_utenti_de, 
        siig_t_bersaglio_umano.utenti, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_addetti_commercio_it,
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_addetti_commercio_en,
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_addetti_commercio_fr,
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_addetti_commercio_de,
        siig_t_bersaglio_umano.addetti, 
        siig_geo_bersaglio_umano_pl.geometria
   FROM siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pl
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano 
     ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) 
     ON siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl) 
     ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio
  WHERE siig_t_bersaglio_umano.id_bersaglio = 7::numeric;
  
CREATE OR REPLACE VIEW v_geo_commercio_pt AS 
 SELECT siig_d_partner.partner_it, 
        siig_d_partner.partner_en, 
        siig_d_partner.partner_fr, 
        siig_d_partner.partner_de, 
        siig_t_bersaglio_umano.id_tematico, 
        siig_t_bersaglio_umano.fk_bersaglio_umano_pt, 
        siig_t_bersaglio_umano.denominazione_it, 
        siig_t_bersaglio_umano.denominazione_en, 
        siig_t_bersaglio_umano.denominazione_fr, 
        siig_t_bersaglio_umano.denominazione_de, 
        siig_t_bersaglio_umano.insegna_it, 
        siig_t_bersaglio_umano.insegna_en, 
        siig_t_bersaglio_umano.insegna_fr, 
        siig_t_bersaglio_umano.insegna_de, 
        siig_t_bersaglio_umano.sup_vendita, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_utenti_it, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_utenti_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_utenti_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_utenti::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_utenti_de, 
        siig_t_bersaglio_umano.utenti, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_addetti_commercio_it,
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_addetti_commercio_en,
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_addetti_commercio_fr,
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_comm::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_addetti_commercio_de,
        siig_t_bersaglio_umano.addetti, 
        siig_geo_bersaglio_umano_pt.geometria
   FROM siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pt
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano 
     ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) 
     ON siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt) 
     ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio
  WHERE siig_t_bersaglio_umano.id_bersaglio = 7::numeric;

CREATE OR REPLACE VIEW v_geo_industria_pl AS 
 SELECT siig_d_partner.partner_it, 
        siig_d_partner.partner_en, 
        siig_d_partner.partner_fr, 
        siig_d_partner.partner_de, 
               siig_t_bersaglio_umano.id_tematico, 
                 siig_t_bersaglio_umano.fk_bersaglio_umano_pl, 
                 siig_t_bersaglio_umano.denominazione_it, 
                 siig_t_bersaglio_umano.denominazione_en, 
                 siig_t_bersaglio_umano.denominazione_fr, 
                 siig_t_bersaglio_umano.denominazione_de, 
                 siig_t_bersaglio_umano.cod_fisc, 
                 siig_d_ateco.descrizione_ateco_it, 
                 siig_d_ateco.descrizione_ateco_en, 
                 siig_d_ateco.descrizione_ateco_fr, 
                 siig_d_ateco.descrizione_ateco_de, 
                 siig_t_bersaglio_umano.addetti, 
                CASE
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'S'::text THEN 'STIMATO'::text
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'C'::text THEN 'CALCOLATO'::text
                    ELSE NULL::text
                END AS fonte_addetti_it,
                CASE
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'S'::text THEN 'ESTIMATED'::text
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'C'::text THEN 'CALCULATED'::text
                    ELSE NULL::text
                END AS fonte_addetti_en,
                CASE
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'S'::text THEN 'ESTIMÉ'::text
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'C'::text THEN 'CALCULÉ'::text
                    ELSE NULL::text
                END AS fonte_addetti_fr,
                CASE
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'S'::text THEN 'Geschätzt'::text
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'C'::text THEN 'Berechnet'::text
                    ELSE NULL::text
                END AS fonte_addetti_de,
                 siig_geo_bersaglio_umano_pl.geometria
   FROM siig_d_ateco
   RIGHT JOIN (siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pl
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) 
     ON siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl) 
     ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio) 
     ON siig_d_ateco.id_ateco = siig_t_bersaglio_umano.fk_ateco
  WHERE siig_t_bersaglio_umano.id_bersaglio = 4::numeric;

CREATE OR REPLACE VIEW v_geo_industria_pt AS 
 SELECT siig_t_bersaglio_umano.id_tematico, 
                siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de,                  
                 siig_t_bersaglio_umano.fk_bersaglio_umano_pt, 
                 siig_t_bersaglio_umano.denominazione_it, 
                 siig_t_bersaglio_umano.denominazione_en, 
                 siig_t_bersaglio_umano.denominazione_fr, 
                 siig_t_bersaglio_umano.denominazione_de, 
                 siig_t_bersaglio_umano.cod_fisc, 
                 siig_d_ateco.descrizione_ateco_it, 
                 siig_d_ateco.descrizione_ateco_en, 
                 siig_d_ateco.descrizione_ateco_fr, 
                 siig_d_ateco.descrizione_ateco_de, 
                 siig_t_bersaglio_umano.addetti, 
                CASE
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'S'::text THEN 'STIMATO'::text
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'C'::text THEN 'CALCOLATO'::text
                    ELSE NULL::text
                END AS fonte_addetti_it,
                CASE
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'S'::text THEN 'ESTIMATED'::text
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'C'::text THEN 'CALCULATED'::text
                    ELSE NULL::text
                END AS fonte_addetti_en,
                CASE
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'S'::text THEN 'ESTIMÉ'::text
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'C'::text THEN 'CALCULÉ'::text
                    ELSE NULL::text
                END AS fonte_addetti_fr,
                CASE
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'S'::text THEN 'Geschätzt'::text
                    WHEN siig_t_bersaglio_umano.flg_nr_addetti_ind::text = 'C'::text THEN 'Berechnet'::text
                    ELSE NULL::text
                END AS fonte_addetti_de,
                 siig_geo_bersaglio_umano_pt.geometria
   FROM siig_d_ateco
   RIGHT JOIN (siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pt
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) 
     ON siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt) 
     ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio) 
     ON siig_d_ateco.id_ateco = siig_t_bersaglio_umano.fk_ateco
  WHERE siig_t_bersaglio_umano.id_bersaglio = 4::numeric;


CREATE OR REPLACE VIEW v_geo_ospedale_pl AS 
 SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de,
                siig_t_bersaglio_umano.id_tematico, 
                siig_t_bersaglio_umano.fk_bersaglio_umano_pl,
                siig_t_bersaglio_umano.denominazione_it, 
                 siig_t_bersaglio_umano.denominazione_en, 
                 siig_t_bersaglio_umano.denominazione_fr, 
                 siig_t_bersaglio_umano.denominazione_de,                
                siig_d_tipo_uso.descrizione_uso_it, 
                siig_d_tipo_uso.descrizione_uso_en, 
                siig_d_tipo_uso.descrizione_uso_fr, 
                siig_d_tipo_uso.descrizione_uso_de, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_addetti_it, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_addetti_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_addetti_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_addetti_de, 
        siig_t_bersaglio_umano.addetti, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_numero_letti_day_h_it, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_numero_letti_day_h_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_numero_letti_day_h_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_numero_letti_day_h_de, 
        siig_t_bersaglio_umano.letti_day AS nr_letti_dh, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_numero_letti_ordinari_it, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_numero_letti_ordinari_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_numero_letti_ordinari_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_numero_letti_ordinari_de, 
        siig_t_bersaglio_umano.letti_o AS letti_ordinari, 
        siig_geo_bersaglio_umano_pl.geometria
   FROM siig_d_tipo_uso
   RIGHT JOIN (siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pl
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) ON siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl) ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio) ON siig_d_tipo_uso.id_tipo_uso = siig_t_bersaglio_umano.fk_tipo_uso
  WHERE siig_t_bersaglio_umano.id_bersaglio = 5::numeric;

CREATE OR REPLACE VIEW v_geo_ospedale_pt AS 
 SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
                 siig_t_bersaglio_umano.id_tematico, 
                 siig_t_bersaglio_umano.fk_bersaglio_umano_pt, 
                 siig_t_bersaglio_umano.denominazione_it, 
                 siig_t_bersaglio_umano.denominazione_en, 
                 siig_t_bersaglio_umano.denominazione_fr, 
                 siig_t_bersaglio_umano.denominazione_de, 
                siig_d_tipo_uso.descrizione_uso_it, 
                siig_d_tipo_uso.descrizione_uso_en, 
                siig_d_tipo_uso.descrizione_uso_fr, 
                siig_d_tipo_uso.descrizione_uso_de, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_addetti_it, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_addetti_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_addetti_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_h::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_addetti_de, 
        siig_t_bersaglio_umano.addetti, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_numero_letti_day_h_it, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_numero_letti_day_h_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_numero_letti_day_h_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_letti_day_h::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_numero_letti_day_h_de, 
        siig_t_bersaglio_umano.letti_day AS nr_letti_dh, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
        END AS fonte_numero_letti_ordinari_it, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
        END AS fonte_numero_letti_ordinari_en, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
        END AS fonte_numero_letti_ordinari_fr, 
        CASE
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_letti_ordinari::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
        END AS fonte_numero_letti_ordinari_de, 
        siig_geo_bersaglio_umano_pt.geometria
   FROM siig_d_tipo_uso
   RIGHT JOIN (siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pt
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano 
       ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) 
       ON siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt) 
       ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio) 
       ON siig_d_tipo_uso.id_tipo_uso = siig_t_bersaglio_umano.fk_tipo_uso
  WHERE siig_t_bersaglio_umano.id_bersaglio = 5::numeric;
  
CREATE OR REPLACE VIEW v_geo_popolazione_residente_pl AS 
 SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
                siig_t_bersaglio_umano.id_tematico, 
                 siig_t_bersaglio_umano.fk_bersaglio_umano_pl, 
                siig_t_bersaglio_umano.residenti, 
                 siig_geo_bersaglio_umano_pl.geometria
   FROM siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pl
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) 
        ON siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl) 
        ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio
  WHERE siig_t_bersaglio_umano.id_bersaglio = 1::numeric;



CREATE OR REPLACE VIEW v_geo_popolazione_residente_pt AS 
 SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
                siig_t_bersaglio_umano.id_tematico, 
                 siig_t_bersaglio_umano.fk_bersaglio_umano_pt, 
                siig_t_bersaglio_umano.residenti, 
                 siig_geo_bersaglio_umano_pt.geometria
   FROM siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pt
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) 
        ON siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt) 
        ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio
  WHERE siig_t_bersaglio_umano.id_bersaglio = 1::numeric;



CREATE OR REPLACE VIEW v_geo_popolazione_turistica_pl AS 
 SELECT siig_d_partner.partner_it,
        siig_d_partner.partner_en, 
        siig_d_partner.partner_fr, 
        siig_d_partner.partner_de, 
 siig_t_bersaglio_umano.id_tematico, 
                 siig_t_bersaglio_umano.fk_bersaglio_umano_pl, 
                 siig_t_bersaglio_umano.denominazione_comune_it, 
                 siig_t_bersaglio_umano.denominazione_comune_en, 
                 siig_t_bersaglio_umano.denominazione_comune_fr, 
                 siig_t_bersaglio_umano.denominazione_comune_de, 
                 siig_t_bersaglio_umano.nat_code, 
                 siig_t_bersaglio_umano.pres_max, 
                siig_t_bersaglio_umano.pres_med, 
                 siig_geo_bersaglio_umano_pl.geometria
   FROM siig_t_bersaglio
   JOIN (siig_geo_bersaglio_umano_pl
   JOIN (siig_d_partner
   JOIN siig_t_bersaglio_umano ON siig_d_partner.id_partner::text = siig_t_bersaglio_umano.id_partner::text) ON siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl) ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio
  WHERE siig_t_bersaglio_umano.id_bersaglio = 2::numeric;



CREATE OR REPLACE VIEW v_geo_scuola_pl AS 
   SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
                siig_t_bersaglio_umano.id_tematico, 
                siig_t_bersaglio_umano.fk_bersaglio_umano_pl, 
                siig_t_bersaglio_umano.denominazione_it, 
                siig_t_bersaglio_umano.denominazione_en, 
                siig_t_bersaglio_umano.denominazione_fr, 
                siig_t_bersaglio_umano.denominazione_de, 
                siig_d_tipo_uso.descrizione_uso_it, 
                siig_d_tipo_uso.descrizione_uso_en, 
                siig_d_tipo_uso.descrizione_uso_fr, 
                siig_d_tipo_uso.descrizione_uso_de, 
                  CASE
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
            END AS fonte_iscritti_it,
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
            END AS fonte_iscritti_en, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
            END AS fonte_iscritti_fr, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
            END AS fonte_iscritti_de, 
            siig_t_bersaglio_umano.iscritti, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
            END AS fonte_addetti_scuole_it, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
            END AS fonte_addetti_scuole_en, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
            END AS fonte_addetti_scuole_fr, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
            END AS fonte_addetti_scuole_de, 
            siig_t_bersaglio_umano.addetti, 
            siig_geo_bersaglio_umano_pl.geometria
     FROM  siig_d_tipo_uso
     RIGHT JOIN (siig_t_bersaglio
         INNER JOIN (siig_geo_bersaglio_umano_pl 
         INNER JOIN (siig_d_partner 
         INNER JOIN siig_t_bersaglio_umano 
            ON siig_d_partner.id_partner = siig_t_bersaglio_umano.id_partner) 
            ON siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl) 
            ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio) 
            ON siig_d_tipo_uso.id_tipo_uso = siig_t_bersaglio_umano.fk_tipo_uso
    WHERE (((siig_t_bersaglio_umano.id_bersaglio)=6));      
      


CREATE OR REPLACE VIEW v_geo_scuola_pt AS 
   SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
                siig_t_bersaglio_umano.id_tematico, 
                siig_t_bersaglio_umano.fk_bersaglio_umano_pt, 
                siig_t_bersaglio_umano.denominazione_it, 
                siig_t_bersaglio_umano.denominazione_en, 
                siig_t_bersaglio_umano.denominazione_fr, 
                siig_t_bersaglio_umano.denominazione_de, 
                siig_d_tipo_uso.descrizione_uso_it, 
                siig_d_tipo_uso.descrizione_uso_en, 
                siig_d_tipo_uso.descrizione_uso_fr, 
                siig_d_tipo_uso.descrizione_uso_de, 
                  CASE
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
            END AS fonte_iscritti_it,
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
            END AS fonte_iscritti_en, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
            END AS fonte_iscritti_fr, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_iscritti::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
            END AS fonte_iscritti_de, 
            siig_t_bersaglio_umano.iscritti, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'C'::text THEN 'CALCOLATO'::text
            ELSE NULL::text
            END AS fonte_addetti_scuole_it, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'S'::text THEN 'ESTIMATED'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'C'::text THEN 'CALCULATED'::text
            ELSE NULL::text
            END AS fonte_addetti_scuole_en, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'S'::text THEN 'ESTIMÉ'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'C'::text THEN 'CALCULÉ'::text
            ELSE NULL::text
            END AS fonte_addetti_scuole_fr, 
            CASE
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'S'::text THEN 'Geschätzt'::text
            WHEN siig_t_bersaglio_umano.flg_nr_addetti_scuole::text = 'C'::text THEN 'Berechnet'::text
            ELSE NULL::text
            END AS fonte_addetti_scuole_de, 
            siig_t_bersaglio_umano.addetti, 
            siig_geo_bersaglio_umano_pt.geometria
        FROM siig_d_tipo_uso
                RIGHT JOIN (siig_t_bersaglio 
                    INNER JOIN (siig_geo_bersaglio_umano_pt INNER JOIN 
                    (siig_d_partner INNER JOIN siig_t_bersaglio_umano 
                    ON siig_d_partner.id_partner = siig_t_bersaglio_umano.id_partner) 
                    ON siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt) 
                    ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio) 
                    ON siig_d_tipo_uso.id_tipo_uso = siig_t_bersaglio_umano.fk_tipo_uso
        WHERE (((siig_t_bersaglio_umano.id_bersaglio)=6));       
     

CREATE OR REPLACE VIEW v_geo_zone_urbanizzate_pl AS 
  SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
               siig_t_bersaglio_non_umano.id_tematico, 
               siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, 
               siig_d_classe_clc.codice_clc, 
               siig_d_classe_clc.descrizione_clc_it, 
               siig_d_classe_clc.descrizione_clc_en, 
               siig_d_classe_clc.descrizione_clc_fr, 
               siig_d_classe_clc.descrizione_clc_de, 
               siig_t_bersaglio_non_umano.superficie, 
               siig_geo_bers_non_umano_pl.geometria
  FROM siig_t_bersaglio 
  INNER JOIN (siig_d_partner 
  INNER JOIN (siig_d_classe_clc 
  RIGHT JOIN (siig_geo_bers_non_umano_pl 
  INNER JOIN siig_t_bersaglio_non_umano 
  ON siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl) 
  ON siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc) 
  ON siig_d_partner.id_partner = siig_t_bersaglio_non_umano.id_partner) 
  ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio
  WHERE siig_t_bersaglio_non_umano.id_bersaglio = 10::numeric;  

CREATE OR REPLACE VIEW v_geo_acque_sotterranee_pl as
    SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
                 siig_t_bersaglio_non_umano.id_tematico, 
                 siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, 
                 siig_t_bersaglio_non_umano.denominazione_it, 
                 siig_t_bersaglio_non_umano.denominazione_en, 
                 siig_t_bersaglio_non_umano.denominazione_fr, 
                 siig_t_bersaglio_non_umano.denominazione_de, 
                 siig_t_bersaglio_non_umano.profondita_max, 
                 siig_t_bersaglio_non_umano.quota_pdc, 
                 siig_d_tipo_captazione.descrizione_it AS tipo_captazione_it, 
                 siig_d_tipo_captazione.descrizione_en AS tipo_captazione_en, 
                 siig_d_tipo_captazione.descrizione_fr AS tipo_captazione_fr, 
                 siig_d_tipo_captazione.descrizione_de AS tipo_captazione_de, 
                 siig_t_bersaglio_non_umano.superficie, 
                 siig_geo_bers_non_umano_pl.geometria
    FROM siig_d_tipo_captazione 
    RIGHT JOIN (siig_t_bersaglio 
    INNER JOIN (siig_d_partner 
    INNER JOIN (siig_geo_bers_non_umano_pl 
    INNER JOIN siig_t_bersaglio_non_umano 
    ON siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl) 
    ON siig_d_partner.id_partner = siig_t_bersaglio_non_umano.id_partner) 
    ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio) 
    ON siig_d_tipo_captazione.id_tipo_captazione = siig_t_bersaglio_non_umano.fk_tipo_captazione
    WHERE (((siig_t_bersaglio_non_umano.id_bersaglio)=14));   

CREATE OR REPLACE VIEW v_geo_acque_sotterranee_pt as
    SELECT siig_d_partner.partner_it, 
                siig_d_partner.partner_en, 
                siig_d_partner.partner_fr, 
                siig_d_partner.partner_de, 
                 siig_t_bersaglio_non_umano.id_tematico, 
                 siig_t_bersaglio_non_umano.fk_bers_non_umano_pt, 
                 siig_t_bersaglio_non_umano.denominazione_it, 
                 siig_t_bersaglio_non_umano.denominazione_en, 
                 siig_t_bersaglio_non_umano.denominazione_fr, 
                 siig_t_bersaglio_non_umano.denominazione_de, 
                 siig_t_bersaglio_non_umano.profondita_max, 
                 siig_t_bersaglio_non_umano.quota_pdc, 
                 siig_d_tipo_captazione.descrizione_it AS tipo_captazione_it, 
                 siig_d_tipo_captazione.descrizione_en AS tipo_captazione_en, 
                 siig_d_tipo_captazione.descrizione_fr AS tipo_captazione_fr, 
                 siig_d_tipo_captazione.descrizione_de AS tipo_captazione_de,  
                 siig_t_bersaglio_non_umano.superficie, 
                 siig_geo_bers_non_umano_pt.geometria
    FROM siig_d_tipo_captazione 
    RIGHT JOIN (siig_t_bersaglio 
    INNER JOIN (siig_d_partner 
    INNER JOIN (siig_geo_bers_non_umano_pt 
    INNER JOIN siig_t_bersaglio_non_umano 
    ON siig_geo_bers_non_umano_pt.idgeo_bers_non_umano_pt = siig_t_bersaglio_non_umano.fk_bers_non_umano_pt) 
    ON siig_d_partner.id_partner = siig_t_bersaglio_non_umano.id_partner) 
    ON siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio) 
    ON siig_d_tipo_captazione.id_tipo_captazione = siig_t_bersaglio_non_umano.fk_tipo_captazione
    WHERE (((siig_t_bersaglio_non_umano.id_bersaglio)=14)); 
    
    
  

    
        

    