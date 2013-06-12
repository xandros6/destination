delete from geometry_columns where f_table_name = 'siig_geo_bersaglio_umano_pt';
delete from geometry_columns where f_table_name = 'siig_geo_bersaglio_umano_pl';
delete from geometry_columns where f_table_name = 'siig_geo_bersaglio_non_umano_pt';
delete from geometry_columns where f_table_name = 'siig_geo_bersaglio_non_umano_pl';
delete from geometry_columns where f_table_name = 'siig_geo_bersaglio_non_umano_ln';

delete from geometry_columns where f_table_name = 'siig_geo_ln_arco_1';
delete from geometry_columns where f_table_name = 'siig_geo_ln_arco_2';
delete from geometry_columns where f_table_name = 'siig_geo_ln_arco_3';

commit;


INSERT INTO geometry_columns VALUES ('', 'siig_p', 'siig_geo_bersaglio_umano_pt', 'geometria', 2, 32632, 'GEOMETRY');
INSERT INTO geometry_columns VALUES ('', 'siig_p', 'siig_geo_bersaglio_umano_pl', 'geometria', 2, 32632, 'GEOMETRY');
INSERT INTO geometry_columns VALUES ('', 'siig_p', 'siig_geo_bersaglio_non_umano_pt', 'geometria', 2, 32632, 'GEOMETRY');
INSERT INTO geometry_columns VALUES ('', 'siig_p', 'siig_geo_bersaglio_non_umano_pl', 'geometria', 2, 32632, 'GEOMETRY');
INSERT INTO geometry_columns VALUES ('', 'siig_p', 'siig_geo_bersaglio_non_umano_ln', 'geometria', 2, 32632, 'GEOMETRY');

INSERT INTO geometry_columns VALUES ('', 'siig_p', 'siig_geo_ln_arco_1', 'geometria', 2, 32632, 'GEOMETRY');
INSERT INTO geometry_columns VALUES ('', 'siig_p', 'siig_geo_ln_arco_2', 'geometria', 2, 32632, 'GEOMETRY');
INSERT INTO geometry_columns VALUES ('', 'siig_p', 'siig_geo_ln_arco_3', 'geometria', 2, 32632, 'GEOMETRY');

commit;