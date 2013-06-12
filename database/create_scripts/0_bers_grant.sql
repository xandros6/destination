GRANT USAGE ON SCHEMA siig_p TO geoeng;
--GRANT USAGE ON SCHEMA siig_p TO siig_p_rw;
GRANT ALL ON SCHEMA siig_p  TO siig_p ;

ALTER SCHEMA siig_p  OWNER TO siig_p ;

--\set ON_ERROR_STOP ON

SET search_path = siig_p, pg_catalog;
