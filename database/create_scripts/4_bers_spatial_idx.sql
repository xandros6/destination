CREATE INDEX siig_geo_bersaglio_umano_pl_gidx ON siig_geo_bersaglio_umano_pl USING gist  (geometria);
CREATE INDEX siig_geo_bersaglio_umano_pt_gidx ON siig_geo_bersaglio_umano_pt USING gist  (geometria);
CREATE INDEX siig_geo_bers_non_umano_ln_gidx ON siig_geo_bers_non_umano_ln USING gist  (geometria);
CREATE INDEX siig_geo_bers_non_umano_pl_gidx ON siig_geo_bers_non_umano_pl USING gist  (geometria);
CREATE INDEX siig_geo_bers_non_umano_pt_gidx ON siig_geo_bers_non_umano_pt USING gist  (geometria);

CREATE INDEX siig_geo_ln_arco_1_gidx ON siig_geo_ln_arco_1 USING gist  (geometria);
CREATE INDEX siig_geo_ln_arco_2_gidx ON siig_geo_ln_arco_2 USING gist  (geometria);
CREATE INDEX siig_geo_ln_arco_3_gidx ON siig_geo_ln_arco_3 USING gist  (geometria);