delete from geometry_columns where f_table_name = 'siig_geo_bers_calcrischio_pl';

commit;

INSERT INTO geometry_columns VALUES ('', 'siig_p', 'siig_geo_bers_calcrischio_pl', 'geometria', 2, 32632, 'GEOMETRY');

commit;