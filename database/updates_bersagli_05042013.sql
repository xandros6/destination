ALTER TABLE siig_geo_bers_non_umano_ln ADD id_bersaglio NUMERIC(6,0);
ALTER TABLE siig_geo_bers_non_umano_pl ADD id_bersaglio NUMERIC(6,0);
ALTER TABLE siig_geo_bers_non_umano_pt ADD id_bersaglio NUMERIC(6,0);
ALTER TABLE siig_geo_bersaglio_umano_pl ADD id_bersaglio NUMERIC(6,0);
ALTER TABLE siig_geo_bersaglio_umano_pt ADD id_bersaglio NUMERIC(6,0);

ALTER TABLE siig_geo_bers_non_umano_ln ADD id_partner VARCHAR(5);
ALTER TABLE siig_geo_bers_non_umano_pl ADD id_partner VARCHAR(5);
ALTER TABLE siig_geo_bers_non_umano_pt ADD id_partner VARCHAR(5);
ALTER TABLE siig_geo_bersaglio_umano_pl ADD id_partner VARCHAR(5);
ALTER TABLE siig_geo_bersaglio_umano_pt ADD id_partner VARCHAR(5);

CREATE INDEX idx_geo_bers_non_umano_ln_bersaglio_partner ON siig_geo_bers_non_umano_ln(id_bersaglio,id_partner);
CREATE INDEX idx_geo_bers_non_umano_pt_bersaglio_partner ON siig_geo_bers_non_umano_pt(id_bersaglio,id_partner);
CREATE INDEX idx_geo_bers_non_umano_pl_bersaglio_partner ON siig_geo_bers_non_umano_pl(id_bersaglio,id_partner);

CREATE INDEX idx_geo_bersaglio_umano_pl_bersaglio_partner ON siig_geo_bersaglio_umano_pl(id_bersaglio,id_partner);
CREATE INDEX idx_geo_bersaglio_umano_pt_bersaglio_partner ON siig_geo_bersaglio_umano_pt(id_bersaglio,id_partner);

ALTER TABLE siig_geo_ln_arco_3 ALTER COLUMN lunghezza TYPE NUMERIC(8,0);