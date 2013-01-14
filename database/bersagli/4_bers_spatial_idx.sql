CREATE INDEX siig_geo_bersaglio_umano_pl_gidx ON siig_geo_bersaglio_umano_pl USING gist  (geometria);
CREATE INDEX siig_geo_bersaglio_umano_pt_gidx ON siig_geo_bersaglio_umano_pt USING gist  (geometria);
CREATE INDEX siig_geo_bers_non_umano_ln_gidx ON siig_geo_bers_non_umano_ln USING gist  (geometria);
CREATE INDEX siig_geo_bers_non_umano_pl_gidx ON siig_geo_bers_non_umano_pl USING gist  (geometria);
CREATE INDEX siig_geo_bers_non_umano_pt_gidx ON siig_geo_bers_non_umano_pt USING gist  (geometria);