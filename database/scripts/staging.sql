--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: siig_p; Type: SCHEMA; Schema: -; Owner: siig_p
--

CREATE SCHEMA siig_p;


ALTER SCHEMA siig_p OWNER TO siig_p;

SET search_path = siig_p, pg_catalog;

--
-- Name: nmul(numeric); Type: AGGREGATE; Schema: siig_p; Owner: siig_p
--

CREATE AGGREGATE nmul(numeric) (
    SFUNC = numeric_mul,
    STYPE = numeric
);


ALTER AGGREGATE siig_p.nmul(numeric) OWNER TO siig_p;

--
-- Name: z_cat(anyelement); Type: AGGREGATE; Schema: siig_p; Owner: siig_p
--

CREATE AGGREGATE z_cat(anyelement) (
    SFUNC = array_append,
    STYPE = anyarray,
    INITCOND = '{}'
);


ALTER AGGREGATE siig_p.z_cat(anyelement) OWNER TO siig_p;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: AO_BNU-AAGR_C_20130730_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "AO_BNU-AAGR_C_20130730_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "SUPERFICIE" double precision,
    "FK_CLC" integer,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."AO_BNU-AAGR_C_20130730_02" OWNER TO siig_p;

--
-- Name: AO_BNU-AAGR_C_20130730_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "AO_BNU-AAGR_C_20130730_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."AO_BNU-AAGR_C_20130730_02_fid_seq" OWNER TO siig_p;

--
-- Name: AO_BNU-AAGR_C_20130730_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "AO_BNU-AAGR_C_20130730_02_fid_seq" OWNED BY "AO_BNU-AAGR_C_20130730_02".fid;


--
-- Name: AO_BNU-ABOSC_C_20130730_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "AO_BNU-ABOSC_C_20130730_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "FK_CLC" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."AO_BNU-ABOSC_C_20130730_02" OWNER TO siig_p;

--
-- Name: AO_BNU-ABOSC_C_20130730_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "AO_BNU-ABOSC_C_20130730_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."AO_BNU-ABOSC_C_20130730_02_fid_seq" OWNER TO siig_p;

--
-- Name: AO_BNU-ABOSC_C_20130730_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "AO_BNU-ABOSC_C_20130730_02_fid_seq" OWNED BY "AO_BNU-ABOSC_C_20130730_02".fid;


--
-- Name: AO_BNU-APROT_C_20130822_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "AO_BNU-APROT_C_20130822_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "FK_IUCN" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "DEN_ENT_IT" character varying,
    "DEN_ENT_EN" character varying,
    "DEN_ENT_DE" character varying,
    "DEN_ENT_FR" character varying,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."AO_BNU-APROT_C_20130822_02" OWNER TO siig_p;

--
-- Name: AO_BNU-APROT_C_20130822_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "AO_BNU-APROT_C_20130822_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."AO_BNU-APROT_C_20130822_02_fid_seq" OWNER TO siig_p;

--
-- Name: AO_BNU-APROT_C_20130822_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "AO_BNU-APROT_C_20130822_02_fid_seq" OWNED BY "AO_BNU-APROT_C_20130822_02".fid;


--
-- Name: AO_BNU-ASUP_C_20130821_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "AO_BNU-ASUP_C_20130821_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "FK_CLC" integer,
    "SUPERFICIE" double precision,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "TOPON_IT" character varying,
    "TOPON_EN" character varying,
    "TOPON_DE" character varying,
    "TOPON_FR" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."AO_BNU-ASUP_C_20130821_02" OWNER TO siig_p;

--
-- Name: AO_BNU-ASUP_C_20130821_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "AO_BNU-ASUP_C_20130821_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."AO_BNU-ASUP_C_20130821_02_fid_seq" OWNER TO siig_p;

--
-- Name: AO_BNU-ASUP_C_20130821_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "AO_BNU-ASUP_C_20130821_02_fid_seq" OWNED BY "AO_BNU-ASUP_C_20130821_02".fid;


--
-- Name: AO_BU-ACOMM_C_20130822_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "AO_BU-ACOMM_C_20130822_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "INSEGNA_IT" character varying,
    "INSEGNA_EN" character varying,
    "INSEGNA_DE" character varying,
    "INSEGNA_FR" character varying,
    "SUP_VEND" double precision,
    "N_UTENTI" double precision,
    "FLG_N_UTEN" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."AO_BU-ACOMM_C_20130822_02" OWNER TO siig_p;

--
-- Name: AO_BU-ACOMM_C_20130822_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "AO_BU-ACOMM_C_20130822_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."AO_BU-ACOMM_C_20130822_02_fid_seq" OWNER TO siig_p;

--
-- Name: AO_BU-ACOMM_C_20130822_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "AO_BU-ACOMM_C_20130822_02_fid_seq" OWNED BY "AO_BU-ACOMM_C_20130822_02".fid;


--
-- Name: AO_BU-ASAN_C_20130909_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "AO_BU-ASAN_C_20130909_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "AREA" double precision,
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "FK_TIPOUSO" integer,
    "N_LETTI_OR" integer,
    "FLG_LT_OR" character varying,
    "N_LETTI_DH" integer,
    "FLG_LT_DH" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."AO_BU-ASAN_C_20130909_02" OWNER TO siig_p;

--
-- Name: AO_BU-ASAN_C_20130909_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "AO_BU-ASAN_C_20130909_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."AO_BU-ASAN_C_20130909_02_fid_seq" OWNER TO siig_p;

--
-- Name: AO_BU-ASAN_C_20130909_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "AO_BU-ASAN_C_20130909_02_fid_seq" OWNED BY "AO_BU-ASAN_C_20130909_02".fid;


--
-- Name: AO_C_Grafo_20130704; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "AO_C_Grafo_20130704" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiLineString,32632),
    "ID_SEGM_01" bigint,
    "ID_SEGM_05" bigint,
    "ID_SEGM_10" bigint,
    "ID_ORIG" bigint,
    "PTERR" character varying,
    "LUNGHEZZA" double precision,
    "VELOCITA" character varying,
    "DESCR" character varying,
    "CATEGORIA" character varying,
    "HIERARCHY" integer,
    "TGM" character varying,
    "FLG_TGM" character varying,
    "FLG_VELOC" character varying,
    "N_CORSIE" integer,
    "FLG_N_CORS" character varying,
    "INCIDENT" integer,
    "FLG_N_INC" character varying,
    "CFF" double precision,
    "PADR" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTILINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."AO_C_Grafo_20130704" OWNER TO siig_p;

--
-- Name: AO_C_Grafo_20130704_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "AO_C_Grafo_20130704_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."AO_C_Grafo_20130704_fid_seq" OWNER TO siig_p;

--
-- Name: AO_C_Grafo_20130704_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "AO_C_Grafo_20130704_fid_seq" OWNED BY "AO_C_Grafo_20130704".fid;


--
-- Name: BZ_BNU-AAGR_C_20130904_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BNU-AAGR_C_20130904_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon),
    "ID_TEMA" integer,
    "FK_CLC" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BNU-AAGR_C_20130904_02" OWNER TO siig_p;

--
-- Name: BZ_BNU-AAGR_C_20130904_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BNU-AAGR_C_20130904_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BNU-AAGR_C_20130904_02_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BNU-AAGR_C_20130904_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BNU-AAGR_C_20130904_02_fid_seq" OWNED BY "BZ_BNU-AAGR_C_20130904_02".fid;


--
-- Name: BZ_BNU-ABOSC_C_20130904_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BNU-ABOSC_C_20130904_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon),
    "ID_TEMA" integer,
    "FK_CLC" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BNU-ABOSC_C_20130904_02" OWNER TO siig_p;

--
-- Name: BZ_BNU-ABOSC_C_20130904_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BNU-ABOSC_C_20130904_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BNU-ABOSC_C_20130904_02_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BNU-ABOSC_C_20130904_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BNU-ABOSC_C_20130904_02_fid_seq" OWNED BY "BZ_BNU-ABOSC_C_20130904_02".fid;


--
-- Name: BZ_BNU-APROT_C_20130906_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BNU-APROT_C_20130906_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon),
    "OBJECTID" integer,
    "DENOM_IT" character varying,
    "DENOM_DE" character varying,
    "DEN_ENT_IT" character varying,
    "DEN_ENT_DE" character varying,
    "ID_TEMA" double precision,
    "FK_IUCN" double precision,
    "DENOM_EN" character varying,
    "DENOM_FR" character varying,
    "DEN_ENT_EN" character varying,
    "DEN_ENT_FR" character varying,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BNU-APROT_C_20130906_02" OWNER TO siig_p;

--
-- Name: BZ_BNU-APROT_C_20130906_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BNU-APROT_C_20130906_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BNU-APROT_C_20130906_02_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BNU-APROT_C_20130906_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BNU-APROT_C_20130906_02_fid_seq" OWNED BY "BZ_BNU-APROT_C_20130906_02".fid;


--
-- Name: BZ_BNU-ASOTT_C_20130521_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BNU-ASOTT_C_20130521_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point),
    "QUOTA" integer,
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_DE" character varying,
    "DENOM_EN" character varying,
    "DENOM_FR" character varying,
    "PROF_MAX" double precision,
    "SUPERFICIE" double precision,
    "FK_TIPO_CP" integer,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BNU-ASOTT_C_20130521_01" OWNER TO siig_p;

--
-- Name: BZ_BNU-ASOTT_C_20130521_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BNU-ASOTT_C_20130521_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BNU-ASOTT_C_20130521_01_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BNU-ASOTT_C_20130521_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BNU-ASOTT_C_20130521_01_fid_seq" OWNED BY "BZ_BNU-ASOTT_C_20130521_01".fid;


--
-- Name: BZ_BNU-ASOTT_C_20130521_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BNU-ASOTT_C_20130521_02" (
    fid integer NOT NULL,
    the_geom public.geometry(Point),
    "QUOTA" integer,
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_DE" character varying,
    "DENOM_EN" character varying,
    "DENOM_FR" character varying,
    "PROF_MAX" double precision,
    "SUPERFICIE" double precision,
    "FK_TIPO_CP" integer,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BNU-ASOTT_C_20130521_02" OWNER TO siig_p;

--
-- Name: BZ_BNU-ASOTT_C_20130521_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BNU-ASOTT_C_20130521_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BNU-ASOTT_C_20130521_02_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BNU-ASOTT_C_20130521_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BNU-ASOTT_C_20130521_02_fid_seq" OWNED BY "BZ_BNU-ASOTT_C_20130521_02".fid;


--
-- Name: BZ_BNU-ASUP_C_20130904_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BNU-ASUP_C_20130904_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_DE" character varying,
    "DENOM_EN" character varying,
    "DENOM_FR" character varying,
    "TOPON_IT" character varying,
    "TOPON_DE" character varying,
    "TOPON_EN" character varying,
    "TOPON_FR" character varying,
    "SUPERFICIE" double precision,
    "FK_CLC" integer,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BNU-ASUP_C_20130904_02" OWNER TO siig_p;

--
-- Name: BZ_BNU-ASUP_C_20130904_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BNU-ASUP_C_20130904_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BNU-ASUP_C_20130904_02_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BNU-ASUP_C_20130904_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BNU-ASUP_C_20130904_02_fid_seq" OWNED BY "BZ_BNU-ASUP_C_20130904_02".fid;


--
-- Name: BZ_BNU-BCULT_C_20130524_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BNU-BCULT_C_20130524_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon),
    "OBJECTID" integer,
    "FK_BCULT" integer,
    "DESC_IT" character varying,
    "DESC_DE" character varying,
    "DESC_EN" character varying,
    "DESC_FR" character varying,
    "SUPERFICIE" double precision,
    "ID_TEMA" integer,
    "Shape_Leng" double precision,
    "Shape_Area" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BNU-BCULT_C_20130524_02" OWNER TO siig_p;

--
-- Name: BZ_BNU-BCULT_C_20130524_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BNU-BCULT_C_20130524_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BNU-BCULT_C_20130524_02_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BNU-BCULT_C_20130524_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BNU-BCULT_C_20130524_02_fid_seq" OWNED BY "BZ_BNU-BCULT_C_20130524_02".fid;


--
-- Name: BZ_BNU-ZURB_C_20130904_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BNU-ZURB_C_20130904_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon),
    "ID_TEMA" integer,
    "FK_CLC" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BNU-ZURB_C_20130904_02" OWNER TO siig_p;

--
-- Name: BZ_BNU-ZURB_C_20130904_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BNU-ZURB_C_20130904_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BNU-ZURB_C_20130904_02_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BNU-ZURB_C_20130904_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BNU-ZURB_C_20130904_02_fid_seq" OWNED BY "BZ_BNU-ZURB_C_20130904_02".fid;


--
-- Name: BZ_BU-ACOMM_C_20130906_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-ACOMM_C_20130906_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon),
    "OBJECTID" integer,
    "SHAPE_Area" double precision,
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "DENOM_EN" character varying,
    "INSEGNA_IT" character varying,
    "INSEGNA_DE" character varying,
    "INSEGNA_EN" character varying,
    "INSEGNA_FR" character varying,
    "SUP_VEND" double precision,
    "N_UTENTI" double precision,
    "N_ADDETTI" double precision,
    "FLG_N_UTEN" character varying,
    "FLG_N_ADD" character varying,
    "N_ADDETTI_NORM" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BU-ACOMM_C_20130906_02" OWNER TO siig_p;

--
-- Name: BZ_BU-ACOMM_C_20130906_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BU-ACOMM_C_20130906_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BU-ACOMM_C_20130906_02_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BU-ACOMM_C_20130906_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BU-ACOMM_C_20130906_02_fid_seq" OWNED BY "BZ_BU-ACOMM_C_20130906_02".fid;


--
-- Name: BZ_BU-AIND_C_20130903_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-AIND_C_20130903_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "COD_FISC" character varying,
    "ID_TEMA" integer,
    "N_ADDETTI" double precision,
    "FK_ATECO" integer,
    "DENOM_DE" character varying,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_FR" character varying,
    "FLG_NR_AD" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BU-AIND_C_20130903_01" OWNER TO siig_p;

--
-- Name: BZ_BU-AIND_C_20130903_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BU-AIND_C_20130903_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BU-AIND_C_20130903_01_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BU-AIND_C_20130903_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BU-AIND_C_20130903_01_fid_seq" OWNED BY "BZ_BU-AIND_C_20130903_01".fid;


--
-- Name: BZ_BU-AIND_C_20130903_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-AIND_C_20130903_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "COD_FISC" character varying,
    "ID_TEMA" integer,
    "N_ADDETTI" double precision,
    "FK_ATECO" integer,
    "DENOM_DE" character varying,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_FR" character varying,
    "FLG_NR_AD" character varying
);


ALTER TABLE siig_p."BZ_BU-AIND_C_20130903_02" OWNER TO siig_p;

--
-- Name: BZ_BU-ASAN_C_20130606_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-ASAN_C_20130606_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_DE" character varying,
    "N_LETTI_OR" integer,
    "FK_TIPOUSO" integer,
    "FLG_LT_OR" character varying,
    "N_LETTI_DH" integer,
    "FLG_LT_DH" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BU-ASAN_C_20130606_01" OWNER TO siig_p;

--
-- Name: BZ_BU-ASAN_C_20130606_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BU-ASAN_C_20130606_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BU-ASAN_C_20130606_01_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BU-ASAN_C_20130606_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BU-ASAN_C_20130606_01_fid_seq" OWNED BY "BZ_BU-ASAN_C_20130606_01".fid;


--
-- Name: BZ_BU-ASAN_C_20130606_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-ASAN_C_20130606_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_DE" character varying,
    "N_LETTI_OR" integer,
    "FK_TIPOUSO" integer,
    "FLG_LT_OR" character varying,
    "N_LETTI_DH" integer,
    "FLG_LT_DH" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying
);


ALTER TABLE siig_p."BZ_BU-ASAN_C_20130606_02" OWNER TO siig_p;

--
-- Name: BZ_BU-ASCOL_C_20130531_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-ASCOL_C_20130531_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "FK_TIPOUSO" integer,
    "N_ISCRITTI" integer,
    "FLG_N_ISCR" character varying,
    "N_ADDETTI" integer,
    "FLG_N_ADD" character varying,
    "DENOM_DE" character varying,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_FR" character varying,
    "ID_TEMA" integer,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BU-ASCOL_C_20130531_01" OWNER TO siig_p;

--
-- Name: BZ_BU-ASCOL_C_20130531_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BU-ASCOL_C_20130531_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BU-ASCOL_C_20130531_01_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BU-ASCOL_C_20130531_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BU-ASCOL_C_20130531_01_fid_seq" OWNED BY "BZ_BU-ASCOL_C_20130531_01".fid;


--
-- Name: BZ_BU-ASCOL_C_20130531_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-ASCOL_C_20130531_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "FK_TIPOUSO" integer,
    "N_ISCRITTI" integer,
    "FLG_N_ISCR" character varying,
    "N_ADDETTI" integer,
    "FLG_N_ADD" character varying,
    "DENOM_DE" character varying,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_FR" character varying,
    "ID_TEMA" integer
);


ALTER TABLE siig_p."BZ_BU-ASCOL_C_20130531_02" OWNER TO siig_p;

--
-- Name: BZ_BU-PRES_C_20130903_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-PRES_C_20130903_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "ID_TEMA" integer,
    "RESIDENTI" double precision,
    "FLG_N_RES" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BU-PRES_C_20130903_01" OWNER TO siig_p;

--
-- Name: BZ_BU-PRES_C_20130903_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BU-PRES_C_20130903_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BU-PRES_C_20130903_01_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BU-PRES_C_20130903_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BU-PRES_C_20130903_01_fid_seq" OWNED BY "BZ_BU-PRES_C_20130903_01".fid;


--
-- Name: BZ_BU-PRES_C_20130903_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-PRES_C_20130903_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "RESIDENTI" double precision,
    "FLG_N_RES" character varying
);


ALTER TABLE siig_p."BZ_BU-PRES_C_20130903_02" OWNER TO siig_p;

--
-- Name: BZ_BU-PTUR_C_20130604_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_BU-PTUR_C_20130604_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon),
    "NAT_CODE" integer,
    "DEN_COM_DE" character varying,
    "DEN_COM_IT" character varying,
    "DEN_COM_EN" character varying,
    "DEN_COM_FR" character varying,
    "ID_TEMA" integer,
    "N_PTUR_MAX" double precision,
    "N_PTUR_MED" double precision,
    "FLG_TUR_MD" character varying,
    "FLG_TUR_MX" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_BU-PTUR_C_20130604_02" OWNER TO siig_p;

--
-- Name: BZ_BU-PTUR_C_20130604_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_BU-PTUR_C_20130604_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_BU-PTUR_C_20130604_02_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_BU-PTUR_C_20130604_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_BU-PTUR_C_20130604_02_fid_seq" OWNED BY "BZ_BU-PTUR_C_20130604_02".fid;


--
-- Name: BZ_C_Grafo_20130807; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_C_Grafo_20130807" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiLineString),
    "FLG_TGM" character varying,
    "N_CORSIE" integer,
    "TGM" character varying,
    "VELOCITA" character varying,
    "ID_ORIG" integer,
    "ID_SEGM_01" integer,
    "ID_SEGM_05" integer,
    "ID_SEGM_10" integer,
    "FLG_VELOC" character varying,
    "FLG_N_CORS" character varying,
    "FLG_N_INC" character varying,
    "PTERR" character varying,
    "INCIDENT" double precision,
    "ID_DISSEST" character varying,
    "LUNGHEZZA" integer,
    "CFF" double precision,
    "PADR" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTILINESTRING'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_C_Grafo_20130807" OWNER TO siig_p;

--
-- Name: BZ_C_Grafo_20130807_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_C_Grafo_20130807_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_C_Grafo_20130807_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_C_Grafo_20130807_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_C_Grafo_20130807_fid_seq" OWNED BY "BZ_C_Grafo_20130807".fid;


--
-- Name: BZ_C_Grafo_20130917; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "BZ_C_Grafo_20130917" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiLineString),
    "FLG_TGM" character varying,
    "N_CORSIE" integer,
    "TGM" character varying,
    "VELOCITA" character varying,
    "ID_ORIG" integer,
    "ID_SEGM_01" integer,
    "ID_SEGM_05" integer,
    "ID_SEGM_10" integer,
    "FLG_VELOC" character varying,
    "FLG_N_CORS" character varying,
    "FLG_N_INC" character varying,
    "INCIDENT" double precision,
    "PTERR" character varying,
    "LUNGHEZZA" integer,
    "PADR" character varying,
    "CFF" character varying,
    "PTERR_WRONG" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTILINESTRING'::text) OR (the_geom IS NULL)))
);


ALTER TABLE siig_p."BZ_C_Grafo_20130917" OWNER TO siig_p;

--
-- Name: BZ_C_Grafo_20130917_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "BZ_C_Grafo_20130917_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."BZ_C_Grafo_20130917_fid_seq" OWNER TO siig_p;

--
-- Name: BZ_C_Grafo_20130917_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "BZ_C_Grafo_20130917_fid_seq" OWNED BY "BZ_C_Grafo_20130917".fid;


--
-- Name: RL_BNU-AAGR_C_20130909_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BNU-AAGR_C_20130909_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "FK_CLC" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BNU-AAGR_C_20130909_02" OWNER TO siig_p;

--
-- Name: RL_BNU-AAGR_C_20130909_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BNU-AAGR_C_20130909_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BNU-AAGR_C_20130909_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BNU-AAGR_C_20130909_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BNU-AAGR_C_20130909_02_fid_seq" OWNED BY "RL_BNU-AAGR_C_20130909_02".fid;


--
-- Name: RL_BNU-ABOSC_C_20130909_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BNU-ABOSC_C_20130909_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "FK_CLC" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BNU-ABOSC_C_20130909_02" OWNER TO siig_p;

--
-- Name: RL_BNU-ABOSC_C_20130909_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BNU-ABOSC_C_20130909_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BNU-ABOSC_C_20130909_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BNU-ABOSC_C_20130909_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BNU-ABOSC_C_20130909_02_fid_seq" OWNED BY "RL_BNU-ABOSC_C_20130909_02".fid;


--
-- Name: RL_BNU-APROT_C_20130909_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BNU-APROT_C_20130909_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "DEN_ENT_IT" character varying,
    "DEN_ENT_EN" character varying,
    "DEN_ENT_DE" character varying,
    "DEN_ENT_FR" character varying,
    "FK_IUCN" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BNU-APROT_C_20130909_02" OWNER TO siig_p;

--
-- Name: RL_BNU-APROT_C_20130909_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BNU-APROT_C_20130909_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BNU-APROT_C_20130909_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BNU-APROT_C_20130909_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BNU-APROT_C_20130909_02_fid_seq" OWNED BY "RL_BNU-APROT_C_20130909_02".fid;


--
-- Name: RL_BNU-ASOTT_C_20130716_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BNU-ASOTT_C_20130716_02" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "PROF_MAX" double precision,
    "QUOTA" integer,
    "FK_TIPO_CP" integer,
    "SUPERFIFIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BNU-ASOTT_C_20130716_02" OWNER TO siig_p;

--
-- Name: RL_BNU-ASOTT_C_20130716_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BNU-ASOTT_C_20130716_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BNU-ASOTT_C_20130716_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BNU-ASOTT_C_20130716_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BNU-ASOTT_C_20130716_02_fid_seq" OWNED BY "RL_BNU-ASOTT_C_20130716_02".fid;


--
-- Name: RL_BNU-ASUP_C_20130909_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BNU-ASUP_C_20130909_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "FK_CLC" integer,
    "SUPERFICIE" double precision,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "TOPON_IT" character varying,
    "TOPON_EN" character varying,
    "TOPON_DE" character varying,
    "TOPON_FR" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BNU-ASUP_C_20130909_02" OWNER TO siig_p;

--
-- Name: RL_BNU-ASUP_C_20130909_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BNU-ASUP_C_20130909_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BNU-ASUP_C_20130909_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BNU-ASUP_C_20130909_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BNU-ASUP_C_20130909_02_fid_seq" OWNED BY "RL_BNU-ASUP_C_20130909_02".fid;


--
-- Name: RL_BNU-BCULT_C_20130909_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BNU-BCULT_C_20130909_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "ID_TEMA" integer,
    "DESC_IT" character varying,
    "DESC_EN" character varying,
    "DESC_DE" character varying,
    "DESC_FR" character varying,
    "FK_BCULT" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BNU-BCULT_C_20130909_01" OWNER TO siig_p;

--
-- Name: RL_BNU-BCULT_C_20130909_1_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BNU-BCULT_C_20130909_1_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BNU-BCULT_C_20130909_1_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BNU-BCULT_C_20130909_1_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BNU-BCULT_C_20130909_1_fid_seq" OWNED BY "RL_BNU-BCULT_C_20130909_01".fid;


--
-- Name: RL_BNU-ZURB_C_20130909_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BNU-ZURB_C_20130909_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "FK_CLC" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BNU-ZURB_C_20130909_02" OWNER TO siig_p;

--
-- Name: RL_BNU-ZURB_C_20130909_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BNU-ZURB_C_20130909_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BNU-ZURB_C_20130909_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BNU-ZURB_C_20130909_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BNU-ZURB_C_20130909_02_fid_seq" OWNED BY "RL_BNU-ZURB_C_20130909_02".fid;


--
-- Name: RL_BU-ACOMM_C_20130909_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BU-ACOMM_C_20130909_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "INSEGNA_IT" character varying,
    "INSEGNA_EN" character varying,
    "INSEGNA_DE" character varying,
    "INSEGNA_FR" character varying,
    "SUP_VEND" double precision,
    "N_UTENTI" integer,
    "FLG_N_UTEN" character varying,
    "N_ADDETTI" integer,
    "FLG_N_ADD" character varying,
    "N_ADDETTI_NORM" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BU-ACOMM_C_20130909_02" OWNER TO siig_p;

--
-- Name: RL_BU-ACOMM_C_20130909_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BU-ACOMM_C_20130909_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BU-ACOMM_C_20130909_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BU-ACOMM_C_20130909_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BU-ACOMM_C_20130909_02_fid_seq" OWNED BY "RL_BU-ACOMM_C_20130909_02".fid;


--
-- Name: RL_BU-AIND_C_20130624_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BU-AIND_C_20130624_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "COD_FISC" character varying,
    "FK_ATECO" integer,
    "N_ADDETTI" integer,
    "FLG_NR_AD" character varying,
    "N_ADDETTI_NORM" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BU-AIND_C_20130624_02" OWNER TO siig_p;

--
-- Name: RL_BU-AIND_C_20130624_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BU-AIND_C_20130624_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BU-AIND_C_20130624_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BU-AIND_C_20130624_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BU-AIND_C_20130624_02_fid_seq" OWNED BY "RL_BU-AIND_C_20130624_02".fid;


--
-- Name: RL_BU-ASAN_C_20130909_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BU-ASAN_C_20130909_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "N_LETTI_OR" integer,
    "FLG_LT_OR" character varying,
    "N_LETTI_DH" integer,
    "FLG_LT_DH" character varying,
    "N_ADDETTI" integer,
    "FLG_N_ADD" character varying,
    "FK_TIPOUSO" integer,
    "N_ADDETTI_NORM" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BU-ASAN_C_20130909_02" OWNER TO siig_p;

--
-- Name: RL_BU-ASAN_C_20130909_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BU-ASAN_C_20130909_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BU-ASAN_C_20130909_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BU-ASAN_C_20130909_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BU-ASAN_C_20130909_02_fid_seq" OWNED BY "RL_BU-ASAN_C_20130909_02".fid;


--
-- Name: RL_BU-PRES_C_20130624_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_BU-PRES_C_20130624_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "RESIDENTI" integer,
    "RESIDENTI_NORM" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_BU-PRES_C_20130624_02" OWNER TO siig_p;

--
-- Name: RL_BU-PRES_C_20130624_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_BU-PRES_C_20130624_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_BU-PRES_C_20130624_02_fid_seq" OWNER TO siig_p;

--
-- Name: RL_BU-PRES_C_20130624_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_BU-PRES_C_20130624_02_fid_seq" OWNED BY "RL_BU-PRES_C_20130624_02".fid;


--
-- Name: RL_C_Grafo_20130918; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RL_C_Grafo_20130918" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiLineString,32632),
    "TGM" character varying,
    "FLG_TGM" character varying,
    "VELOCITA" character varying,
    "FLG_VELOC" character varying,
    "FLG_N_CORS" character varying,
    "FLG_N_INC" character varying,
    "PTERR" character varying,
    "PADR" character varying,
    "N_CORSIE" integer,
    "ID_SEGM_01" integer,
    "ID_SEGM_05" integer,
    "ID_SEGM_10" integer,
    "ID_ORIG" integer,
    "LUNGHEZZA" integer,
    "CFF" double precision,
    "INCIDENT" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTILINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RL_C_Grafo_20130918" OWNER TO siig_p;

--
-- Name: RL_C_Grafo_20130918_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RL_C_Grafo_20130918_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RL_C_Grafo_20130918_fid_seq" OWNER TO siig_p;

--
-- Name: RL_C_Grafo_20130918_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RL_C_Grafo_20130918_fid_seq" OWNED BY "RL_C_Grafo_20130918".fid;


--
-- Name: RP_BNU-AAGR_20121217_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BNU-AAGR_20121217_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" bigint,
    "FK_CLC" bigint,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BNU-AAGR_20121217_02" OWNER TO siig_p;

--
-- Name: RP_BNU-AAGR_20121217_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BNU-AAGR_20121217_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BNU-AAGR_20121217_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BNU-AAGR_20121217_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BNU-AAGR_20121217_02_fid_seq" OWNED BY "RP_BNU-AAGR_20121217_02".fid;


--
-- Name: RP_BNU-ABOSC_20121217_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BNU-ABOSC_20121217_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" bigint,
    "FK_CLC" bigint,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BNU-ABOSC_20121217_02" OWNER TO siig_p;

--
-- Name: RP_BNU-ABOSC_20121217_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BNU-ABOSC_20121217_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BNU-ABOSC_20121217_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BNU-ABOSC_20121217_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BNU-ABOSC_20121217_02_fid_seq" OWNED BY "RP_BNU-ABOSC_20121217_02".fid;


--
-- Name: RP_BNU-APROT_20130424_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BNU-APROT_20130424_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" double precision,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "DEN_ENT_IT" character varying,
    "DEN_ENT_EN" character varying,
    "DEN_ENT_DE" character varying,
    "DEN_ENT_FR" character varying,
    "FK_IUCN" double precision,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BNU-APROT_20130424_02" OWNER TO siig_p;

--
-- Name: RP_BNU-APROT_20130424_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BNU-APROT_20130424_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BNU-APROT_20130424_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BNU-APROT_20130424_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BNU-APROT_20130424_02_fid_seq" OWNED BY "RP_BNU-APROT_20130424_02".fid;


--
-- Name: RP_BNU-ASOTT_20130424_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BNU-ASOTT_20130424_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "ID_TIPO" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "PROF_MAX" double precision,
    "QUOTA" integer,
    "FK_TIPO_CP" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BNU-ASOTT_20130424_01" OWNER TO siig_p;

--
-- Name: RP_BNU-ASOTT_20130424_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BNU-ASOTT_20130424_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BNU-ASOTT_20130424_01_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BNU-ASOTT_20130424_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BNU-ASOTT_20130424_01_fid_seq" OWNED BY "RP_BNU-ASOTT_20130424_01".fid;


--
-- Name: RP_BNU-ASUP_20130424_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BNU-ASUP_20130424_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "FK_CLC" integer,
    "TOPON_IT" character varying,
    "TOPON_EN" character varying,
    "TOPON_DE" character varying,
    "TOPON_FR" character varying,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BNU-ASUP_20130424_02" OWNER TO siig_p;

--
-- Name: RP_BNU-ASUP_20130424_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BNU-ASUP_20130424_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BNU-ASUP_20130424_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BNU-ASUP_20130424_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BNU-ASUP_20130424_02_fid_seq" OWNED BY "RP_BNU-ASUP_20130424_02".fid;


--
-- Name: RP_BNU-BCULT_20130424_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BNU-BCULT_20130424_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "ID_TEMA" integer,
    "DESC_IT" character varying,
    "DESC_EN" character varying,
    "DESC_DE" character varying,
    "DESC_FR" character varying,
    "FK_BCULT" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BNU-BCULT_20130424_01" OWNER TO siig_p;

--
-- Name: RP_BNU-BCULT_20130424_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BNU-BCULT_20130424_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BNU-BCULT_20130424_01_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BNU-BCULT_20130424_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BNU-BCULT_20130424_01_fid_seq" OWNED BY "RP_BNU-BCULT_20130424_01".fid;


--
-- Name: RP_BNU-BCULT_20130424_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BNU-BCULT_20130424_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DESC_IT" character varying,
    "DESC_EN" character varying,
    "DESC_DE" character varying,
    "DESC_FR" character varying,
    "FK_BCULT" integer,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BNU-BCULT_20130424_02" OWNER TO siig_p;

--
-- Name: RP_BNU-BCULT_20130424_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BNU-BCULT_20130424_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BNU-BCULT_20130424_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BNU-BCULT_20130424_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BNU-BCULT_20130424_02_fid_seq" OWNED BY "RP_BNU-BCULT_20130424_02".fid;


--
-- Name: RP_BNU-ZURB_20121207_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BNU-ZURB_20121207_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" bigint,
    "FK_CLC" bigint,
    "SUPERFICIE" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BNU-ZURB_20121207_02" OWNER TO siig_p;

--
-- Name: RP_BNU-ZURB_20121207_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BNU-ZURB_20121207_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BNU-ZURB_20121207_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BNU-ZURB_20121207_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BNU-ZURB_20121207_02_fid_seq" OWNED BY "RP_BNU-ZURB_20121207_02".fid;


--
-- Name: RP_BU-ACOMM_20130424_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BU-ACOMM_20130424_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "INSEGNA_IT" character varying,
    "INSEGNA_EN" character varying,
    "INSEGNA_DE" character varying,
    "INSEGNA_FR" character varying,
    "SUP_VEND" double precision,
    "N_UTENTI" double precision,
    "FLG_N_UTEN" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BU-ACOMM_20130424_02" OWNER TO siig_p;

--
-- Name: RP_BU-ACOMM_20130424_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BU-ACOMM_20130424_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BU-ACOMM_20130424_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BU-ACOMM_20130424_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BU-ACOMM_20130424_02_fid_seq" OWNED BY "RP_BU-ACOMM_20130424_02".fid;


--
-- Name: RP_BU-AIND_20130424_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BU-AIND_20130424_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "COD_FISC" character varying,
    "FK_ATECO" integer,
    "N_ADDETTI" double precision,
    "FLG_NR_ADD" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BU-AIND_20130424_01" OWNER TO siig_p;

--
-- Name: RP_BU-AIND_20130424_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BU-AIND_20130424_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BU-AIND_20130424_01_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BU-AIND_20130424_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BU-AIND_20130424_01_fid_seq" OWNED BY "RP_BU-AIND_20130424_01".fid;


--
-- Name: RP_BU-ASAN_20130424_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BU-ASAN_20130424_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "FK_TIPOUSO" integer,
    "N_LETTI_OR" double precision,
    "FLG_LT_OR" character varying,
    "N_LETTI_DH" double precision,
    "FLG_LT_DH" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BU-ASAN_20130424_02" OWNER TO siig_p;

--
-- Name: RP_BU-ASAN_20130424_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BU-ASAN_20130424_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BU-ASAN_20130424_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BU-ASAN_20130424_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BU-ASAN_20130424_02_fid_seq" OWNED BY "RP_BU-ASAN_20130424_02".fid;


--
-- Name: RP_BU-ASCOL_20130424_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BU-ASCOL_20130424_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "FK_TIPOUSO" integer,
    "N_ISCRITTI" double precision,
    "FLG_N_ISCR" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BU-ASCOL_20130424_01" OWNER TO siig_p;

--
-- Name: RP_BU-ASCOL_20130424_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BU-ASCOL_20130424_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BU-ASCOL_20130424_01_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BU-ASCOL_20130424_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BU-ASCOL_20130424_01_fid_seq" OWNED BY "RP_BU-ASCOL_20130424_01".fid;


--
-- Name: RP_BU-ASCOL_20130424_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BU-ASCOL_20130424_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "FK_TIPOUSO" integer,
    "N_ISCRITTI" double precision,
    "FLG_N_ISCR" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BU-ASCOL_20130424_02" OWNER TO siig_p;

--
-- Name: RP_BU-ASCOL_20130424_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BU-ASCOL_20130424_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BU-ASCOL_20130424_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BU-ASCOL_20130424_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BU-ASCOL_20130424_02_fid_seq" OWNED BY "RP_BU-ASCOL_20130424_02".fid;


--
-- Name: RP_BU-PRES_20121217_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BU-PRES_20121217_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" double precision,
    "RESIDENTI" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BU-PRES_20121217_02" OWNER TO siig_p;

--
-- Name: RP_BU-PRES_20121217_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BU-PRES_20121217_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BU-PRES_20121217_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BU-PRES_20121217_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BU-PRES_20121217_02_fid_seq" OWNED BY "RP_BU-PRES_20121217_02".fid;


--
-- Name: RP_BU-PTUR_20120122_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_BU-PTUR_20120122_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "ID_TEMA" integer,
    "DENOM" character varying,
    "NAT_CODE" character varying,
    "N_PTUR_MAX" double precision,
    "N_PTUR_MED" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_BU-PTUR_20120122_02" OWNER TO siig_p;

--
-- Name: RP_BU-PTUR_20120122_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_BU-PTUR_20120122_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_BU-PTUR_20120122_02_fid_seq" OWNER TO siig_p;

--
-- Name: RP_BU-PTUR_20120122_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_BU-PTUR_20120122_02_fid_seq" OWNED BY "RP_BU-PTUR_20120122_02".fid;


--
-- Name: RP_C_Grafo_20130424; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "RP_C_Grafo_20130424" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiLineString,32632),
    "ID_ORIG" integer,
    "ID_SEGM_01" integer,
    "ID_SEGM_05" integer,
    "ID_SEGM_10" integer,
    "TGM" character varying,
    "FLG_TGM" character varying,
    "VELOCITA" character varying,
    "FLG_VELOC" character varying,
    "N_CORSIE" integer,
    "FLG_N_CORS" character varying,
    "INCIDENT" integer,
    "FLG_N_INC" character varying,
    "PTERR" character varying,
    "LUNGHEZZA" integer,
    "CFF" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTILINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."RP_C_Grafo_20130424" OWNER TO siig_p;

--
-- Name: RP_C_Grafo_20130424_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "RP_C_Grafo_20130424_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."RP_C_Grafo_20130424_fid_seq" OWNER TO siig_p;

--
-- Name: RP_C_Grafo_20130424_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "RP_C_Grafo_20130424_fid_seq" OWNED BY "RP_C_Grafo_20130424".fid;


--
-- Name: TI_BNU-ASOTT_C_20130617_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "TI_BNU-ASOTT_C_20130617_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "SUPERFICIE" double precision,
    "ID_TEMA" integer,
    "FK_TIPO_CP" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "QUOTA" integer,
    "PROF_MAX" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."TI_BNU-ASOTT_C_20130617_01" OWNER TO siig_p;

--
-- Name: TI_BNU-ASOTT_C_20130617_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "TI_BNU-ASOTT_C_20130617_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."TI_BNU-ASOTT_C_20130617_01_fid_seq" OWNER TO siig_p;

--
-- Name: TI_BNU-ASOTT_C_20130617_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "TI_BNU-ASOTT_C_20130617_01_fid_seq" OWNED BY "TI_BNU-ASOTT_C_20130617_01".fid;


--
-- Name: TI_BNU-BCULT_C_20130617_01; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "TI_BNU-BCULT_C_20130617_01" (
    fid integer NOT NULL,
    the_geom public.geometry(Point,32632),
    "SUPERFICIE" double precision,
    "ID_TEMA" integer,
    "FK_BCULT" integer,
    "DESC_IT" character varying,
    "DESC_EN" character varying,
    "DESC_DE" character varying,
    "DESC_FR" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."TI_BNU-BCULT_C_20130617_01" OWNER TO siig_p;

--
-- Name: TI_BNU-BCULT_C_20130617_01_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "TI_BNU-BCULT_C_20130617_01_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."TI_BNU-BCULT_C_20130617_01_fid_seq" OWNER TO siig_p;

--
-- Name: TI_BNU-BCULT_C_20130617_01_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "TI_BNU-BCULT_C_20130617_01_fid_seq" OWNED BY "TI_BNU-BCULT_C_20130617_01".fid;


--
-- Name: TI_BNU-ZURB_C_20130617_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "TI_BNU-ZURB_C_20130617_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "SUPERFICIE" double precision,
    "FK_CLC" integer,
    "ID_TEMA" integer,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."TI_BNU-ZURB_C_20130617_02" OWNER TO siig_p;

--
-- Name: TI_BNU-ZURB_C_20130617_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "TI_BNU-ZURB_C_20130617_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."TI_BNU-ZURB_C_20130617_02_fid_seq" OWNER TO siig_p;

--
-- Name: TI_BNU-ZURB_C_20130617_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "TI_BNU-ZURB_C_20130617_02_fid_seq" OWNED BY "TI_BNU-ZURB_C_20130617_02".fid;


--
-- Name: TI_BU-ACOMM_C_20130617_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "TI_BU-ACOMM_C_20130617_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "INSEGNA_EN" character varying,
    "INSEGNA_DE" character varying,
    "INSEGNA_FR" character varying,
    "SUP_VEND" double precision,
    "N_UTENTI" integer,
    "FLG_N_UTEN" character varying,
    "N_ADDETTI" integer,
    "FLG_N_ADD" character varying,
    "ID_TEMA" integer,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "INSEGNA_IT" character varying,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."TI_BU-ACOMM_C_20130617_02" OWNER TO siig_p;

--
-- Name: TI_BU-ACOMM_C_20130617_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "TI_BU-ACOMM_C_20130617_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."TI_BU-ACOMM_C_20130617_02_fid_seq" OWNER TO siig_p;

--
-- Name: TI_BU-ACOMM_C_20130617_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "TI_BU-ACOMM_C_20130617_02_fid_seq" OWNED BY "TI_BU-ACOMM_C_20130617_02".fid;


--
-- Name: TI_BU-ASAN_C_20130617_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "TI_BU-ASAN_C_20130617_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "N_LETTI_OR" double precision,
    "FLG_LT_OR" character varying,
    "FLG_LT_DH" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying,
    "ID_TEMA" double precision,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "N_LETTI_DH" double precision,
    "FK_TIPO_US" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."TI_BU-ASAN_C_20130617_02" OWNER TO siig_p;

--
-- Name: TI_BU-ASAN_C_20130617_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "TI_BU-ASAN_C_20130617_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."TI_BU-ASAN_C_20130617_02_fid_seq" OWNER TO siig_p;

--
-- Name: TI_BU-ASAN_C_20130617_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "TI_BU-ASAN_C_20130617_02_fid_seq" OWNED BY "TI_BU-ASAN_C_20130617_02".fid;


--
-- Name: TI_BU-ASCOL_C_20130617_02; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE "TI_BU-ASCOL_C_20130617_02" (
    fid integer NOT NULL,
    the_geom public.geometry(MultiPolygon,32632),
    "N_ISCRITTI" double precision,
    "FLG_N_ISCR" character varying,
    "N_ADDETTI" double precision,
    "FLG_N_ADD" character varying,
    "ID_TEMA" double precision,
    "DENOM_IT" character varying,
    "DENOM_EN" character varying,
    "DENOM_DE" character varying,
    "DENOM_FR" character varying,
    "FK_TIPO_US" double precision,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 32632))
);


ALTER TABLE siig_p."TI_BU-ASCOL_C_20130617_02" OWNER TO siig_p;

--
-- Name: TI_BU-ASCOL_C_20130617_02_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE "TI_BU-ASCOL_C_20130617_02_fid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p."TI_BU-ASCOL_C_20130617_02_fid_seq" OWNER TO siig_p;

--
-- Name: TI_BU-ASCOL_C_20130617_02_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE "TI_BU-ASCOL_C_20130617_02_fid_seq" OWNED BY "TI_BU-ASCOL_C_20130617_02".fid;


--
-- Name: arcsingestionprocess_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE arcsingestionprocess_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.arcsingestionprocess_seq OWNER TO siig_p;

--
-- Name: process_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE process_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.process_seq OWNER TO siig_p;

--
-- Name: regioni; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE regioni (
    gid integer NOT NULL,
    cod_reg integer,
    nome_reg character varying(60),
    shape_leng numeric,
    shape_area numeric,
    geom public.geometry(MultiPolygon,32632)
);


ALTER TABLE siig_p.regioni OWNER TO siig_p;

--
-- Name: regioni_gid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE regioni_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.regioni_gid_seq OWNER TO siig_p;

--
-- Name: regioni_gid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE regioni_gid_seq OWNED BY regioni.gid;


--
-- Name: riskcomputation_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE riskcomputation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.riskcomputation_seq OWNER TO siig_p;

--
-- Name: roadarc_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE roadarc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.roadarc_seq OWNER TO siig_p;

--
-- Name: siig_d_ateco; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_ateco (
    id_ateco numeric(8,0) NOT NULL,
    descrizione_ateco_it character varying(1000),
    descrizione_ateco_en character varying(1000),
    descrizione_ateco_de character varying(1000),
    descrizione_ateco_fr character varying(1000)
);


ALTER TABLE siig_p.siig_d_ateco OWNER TO siig_p;

--
-- Name: siig_d_bene_culturale; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_bene_culturale (
    id_tipo_bene numeric(6,0) NOT NULL,
    tipologia_it character varying(250),
    tipologia_en character varying(250),
    tipologia_de character varying(250),
    tipologia_fr character varying(250)
);


ALTER TABLE siig_p.siig_d_bene_culturale OWNER TO siig_p;

--
-- Name: siig_d_classe_adr; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_classe_adr (
    id_classe_adr numeric(3,0) NOT NULL,
    classe character varying(10),
    descrizione_it character varying(100),
    descrizione_en character varying(100),
    descrizione_de character varying(100),
    descrizione_fr character varying(100)
);


ALTER TABLE siig_p.siig_d_classe_adr OWNER TO siig_p;

--
-- Name: siig_d_classe_clc; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_classe_clc (
    id_classe_clc numeric(4,0) NOT NULL,
    codice_clc character varying(6),
    descrizione_clc_it character varying(1000),
    descrizione_clc_en character varying(1000),
    descrizione_clc_de character varying(1000),
    descrizione_clc_fr character varying(1000)
);


ALTER TABLE siig_p.siig_d_classe_clc OWNER TO siig_p;

--
-- Name: siig_d_dissesto; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_dissesto (
    id_dissesto character varying(20) NOT NULL,
    pter numeric(4,3),
    descrizione_it character varying(250),
    descrizione_en character varying(250),
    descrizione_de character varying(250),
    descrizione_fr character varying(250),
    dissesti_bolzano character varying(250)
);


ALTER TABLE siig_p.siig_d_dissesto OWNER TO siig_p;

--
-- Name: siig_d_distanza; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_distanza (
    id_distanza numeric(4,0) NOT NULL,
    distanza numeric(6,0) NOT NULL
);


ALTER TABLE siig_p.siig_d_distanza OWNER TO siig_p;

--
-- Name: siig_d_gravita; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_gravita (
    id_gravita numeric(2,0) NOT NULL,
    descrizione_it character varying(50),
    descrizione_en character varying(50),
    descrizione_de character varying(50),
    descrizione_fr character varying(50)
);


ALTER TABLE siig_p.siig_d_gravita OWNER TO siig_p;

--
-- Name: siig_d_iucn; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_iucn (
    id_iucn numeric(6,0) NOT NULL,
    descrizione_iucn_it character varying(1000),
    descrizione_iucn_en character varying(1000),
    descrizione_iucn_de character varying(1000),
    descrizione_iucn_fr character varying(1000)
);


ALTER TABLE siig_p.siig_d_iucn OWNER TO siig_p;

--
-- Name: siig_d_partner; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_partner (
    id_partner character varying(5) NOT NULL,
    codice_partner character varying(2),
    partner_it character varying(50),
    partner_en character varying(50),
    partner_de character varying(50),
    partner_fr character varying(50)
);


ALTER TABLE siig_p.siig_d_partner OWNER TO siig_p;

--
-- Name: siig_d_stato_fisico; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_stato_fisico (
    id_stato_fisico numeric(2,0) NOT NULL,
    descrizione_it character varying(100),
    descrizione_en character varying(100),
    descrizione_de character varying(100),
    descrizione_fr character varying(100)
);


ALTER TABLE siig_p.siig_d_stato_fisico OWNER TO siig_p;

--
-- Name: siig_d_tipo_captazione; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_tipo_captazione (
    id_tipo_captazione numeric(6,0) NOT NULL,
    descrizione_it character varying(1000),
    descrizione_en character varying(1000),
    descrizione_de character varying(1000),
    descrizione_fr character varying(1000)
);


ALTER TABLE siig_p.siig_d_tipo_captazione OWNER TO siig_p;

--
-- Name: siig_d_tipo_contenitore; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_tipo_contenitore (
    id_tipo_contenitore numeric(2,0) NOT NULL,
    descrizione_it character varying(100),
    descrizione_en character varying(100),
    descrizione_de character varying(100),
    descrizione_fr character varying(100)
);


ALTER TABLE siig_p.siig_d_tipo_contenitore OWNER TO siig_p;

--
-- Name: siig_d_tipo_trasporto; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_tipo_trasporto (
    id_tipo_trasporto numeric(6,0) NOT NULL,
    descrizione_it character varying(100),
    descrizione_en character varying(100),
    descrizione_de character varying(100),
    descrizione_fr character varying(100)
);


ALTER TABLE siig_p.siig_d_tipo_trasporto OWNER TO siig_p;

--
-- Name: siig_d_tipo_uso; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_tipo_uso (
    id_tipo_uso numeric(6,0) NOT NULL,
    descrizione_uso_it character varying(1000),
    descrizione_uso_en character varying(1000),
    descrizione_uso_de character varying(1000),
    descrizione_uso_fr character varying(1000)
);


ALTER TABLE siig_p.siig_d_tipo_uso OWNER TO siig_p;

--
-- Name: siig_d_tipo_variabile; Type: TABLE; Schema: siig_p; Owner: postgres; Tablespace: 
--

CREATE TABLE siig_d_tipo_variabile (
    id_tipo_variabile numeric(2,0) NOT NULL,
    tipo_variabile character varying(50) NOT NULL
);


ALTER TABLE siig_p.siig_d_tipo_variabile OWNER TO postgres;

--
-- Name: siig_d_tipo_veicolo; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_tipo_veicolo (
    id_tipo_veicolo numeric(2,0) NOT NULL,
    coeff_occupazione numeric(4,2),
    tipo_veicolo_it character varying(100),
    tipo_veicolo_en character varying(100),
    tipo_veicolo_de character varying(100),
    tipo_veicolo_fr character varying(100)
);


ALTER TABLE siig_p.siig_d_tipo_veicolo OWNER TO siig_p;

--
-- Name: siig_d_tipologia_danno; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_d_tipologia_danno (
    id_tipologia_danno numeric(2,0) NOT NULL,
    tipologia_danno character varying(100) NOT NULL,
    flg_umano character varying(1) NOT NULL,
    CONSTRAINT dom_u_n6 CHECK (((flg_umano)::text = ANY (ARRAY[('U'::character varying)::text, ('N'::character varying)::text])))
);


ALTER TABLE siig_p.siig_d_tipologia_danno OWNER TO siig_p;

--
-- Name: siig_geo_bers_calcrischio_pl; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_bers_calcrischio_pl (
    idgeo numeric(9,0) NOT NULL,
    id_tematico_shape numeric(9,0),
    fk_partner character varying(5) NOT NULL,
    fk_bersaglio numeric(6,0),
    geometria public.geometry(MultiPolygon,32632)
);


ALTER TABLE siig_p.siig_geo_bers_calcrischio_pl OWNER TO siig_p;

--
-- Name: siig_geo_bers_non_umano_ln; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_bers_non_umano_ln (
    idgeo_bers_non_umano_ln numeric(9,0) NOT NULL,
    geometria public.geometry(MultiLineString,32632),
    id_partner character varying(5),
    id_bersaglio numeric(6,0)
);


ALTER TABLE siig_p.siig_geo_bers_non_umano_ln OWNER TO siig_p;

--
-- Name: siig_geo_bers_non_umano_pl; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_bers_non_umano_pl (
    idgeo_bers_non_umano_pl numeric(9,0) NOT NULL,
    geometria public.geometry(MultiPolygon,32632),
    id_partner character varying(5),
    id_bersaglio numeric(6,0)
);


ALTER TABLE siig_p.siig_geo_bers_non_umano_pl OWNER TO siig_p;

--
-- Name: siig_geo_bers_non_umano_pt; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_bers_non_umano_pt (
    idgeo_bers_non_umano_pt numeric(9,0) NOT NULL,
    geometria public.geometry(Point,32632),
    id_partner character varying(5),
    id_bersaglio numeric(6,0)
);


ALTER TABLE siig_p.siig_geo_bers_non_umano_pt OWNER TO siig_p;

--
-- Name: siig_geo_bersaglio_umano_pl; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_bersaglio_umano_pl (
    idgeo_bersaglio_umano_pl numeric(9,0) NOT NULL,
    geometria public.geometry(MultiPolygon,32632),
    id_partner character varying(5),
    id_bersaglio numeric(6,0)
);


ALTER TABLE siig_p.siig_geo_bersaglio_umano_pl OWNER TO siig_p;

--
-- Name: siig_geo_bersaglio_umano_pt; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_bersaglio_umano_pt (
    idgeo_bersaglio_umano_pt numeric(9,0) NOT NULL,
    geometria public.geometry(Point,32632),
    id_partner character varying(5),
    id_bersaglio numeric(6,0)
);


ALTER TABLE siig_p.siig_geo_bersaglio_umano_pt OWNER TO siig_p;

--
-- Name: siig_geo_grid; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_grid (
    gid numeric(9,0) NOT NULL,
    geometria public.geometry(Polygon,32632)
);


ALTER TABLE siig_p.siig_geo_grid OWNER TO siig_p;

--
-- Name: siig_geo_ln_arco_1; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_ln_arco_1 (
    id_geo_arco numeric(9,0) NOT NULL,
    nr_incidenti numeric(5,0),
    nr_incidenti_elab double precision,
    nr_corsie numeric(2,0) DEFAULT 2,
    lunghezza numeric(5,0),
    nr_bers_umani_strada numeric(5,0),
    id_tematico_shape numeric(9,0),
    fk_partner character varying(5) NOT NULL,
    geometria public.geometry(MultiLineString,32632) NOT NULL,
    id_origine numeric(9,0),
    flg_nr_corsie character varying(1),
    flg_nr_incidenti character varying(1),
    CONSTRAINT dom_7_scm CHECK (((flg_nr_corsie)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text]))),
    CONSTRAINT dom_8_scm CHECK (((flg_nr_incidenti)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text])))
);


ALTER TABLE siig_p.siig_geo_ln_arco_1 OWNER TO siig_p;

--
-- Name: siig_geo_ln_arco_2; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_ln_arco_2 (
    id_geo_arco numeric(9,0) NOT NULL,
    nr_incidenti numeric(5,0),
    nr_incidenti_elab double precision,
    nr_corsie numeric(2,0) DEFAULT 2,
    lunghezza numeric(5,0),
    nr_bers_umani_strada numeric(5,0),
    id_tematico_shape numeric(9,0),
    fk_partner character varying(5) NOT NULL,
    geometria public.geometry(MultiLineString,32632) NOT NULL,
    id_origine numeric(9,0),
    flg_nr_corsie character varying(1),
    flg_nr_incidenti character varying(1),
    CONSTRAINT dom_10_scm CHECK (((flg_nr_incidenti)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text]))),
    CONSTRAINT dom_9_scm CHECK (((flg_nr_corsie)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text])))
);


ALTER TABLE siig_p.siig_geo_ln_arco_2 OWNER TO siig_p;

--
-- Name: siig_geo_ln_arco_3; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_ln_arco_3 (
    id_geo_arco numeric(9,0) NOT NULL,
    nr_incidenti numeric(5,0),
    nr_incidenti_elab double precision,
    nr_corsie numeric(2,0) DEFAULT 2,
    lunghezza numeric(8,0),
    nr_bers_umani_strada numeric(5,0),
    id_tematico_shape numeric(9,0),
    fk_partner character varying(5) NOT NULL,
    geometria public.geometry(MultiLineString,32632) NOT NULL,
    id_origine numeric(9,0),
    flg_nr_corsie character varying(1),
    flg_nr_incidenti character varying(1),
    CONSTRAINT dom_11_scm CHECK (((flg_nr_corsie)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text]))),
    CONSTRAINT dom_12_scm CHECK (((flg_nr_incidenti)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text])))
);


ALTER TABLE siig_p.siig_geo_ln_arco_3 OWNER TO siig_p;

--
-- Name: siig_geo_ln_arcotest_1; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_ln_arcotest_1 (
    fid integer NOT NULL,
    id_geo_arco numeric NOT NULL,
    nr_incidenti numeric,
    nr_incidenti_elab double precision,
    nr_corsie numeric,
    lunghezza numeric,
    nr_bers_umani_strada numeric,
    id_tematico_shape numeric,
    fk_partner character varying NOT NULL,
    geometria public.geometry(MultiLineString,32632) NOT NULL,
    id_origine numeric,
    flg_nr_corsie character varying,
    flg_nr_incidenti character varying,
    CONSTRAINT enforce_dims_geometria CHECK ((public.st_ndims(geometria) = 2)),
    CONSTRAINT enforce_geotype_geometria CHECK (((public.geometrytype(geometria) = 'MULTILINESTRING'::text) OR (geometria IS NULL))),
    CONSTRAINT enforce_srid_geometria CHECK ((public.st_srid(geometria) = 32632))
);


ALTER TABLE siig_p.siig_geo_ln_arcotest_1 OWNER TO siig_p;

--
-- Name: siig_geo_ln_arcotest_1_fid_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE siig_geo_ln_arcotest_1_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.siig_geo_ln_arcotest_1_fid_seq OWNER TO siig_p;

--
-- Name: siig_geo_ln_arcotest_1_fid_seq; Type: SEQUENCE OWNED BY; Schema: siig_p; Owner: siig_p
--

ALTER SEQUENCE siig_geo_ln_arcotest_1_fid_seq OWNED BY siig_geo_ln_arcotest_1.fid;


--
-- Name: siig_geo_pl_arco_3; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_geo_pl_arco_3 (
    id_geo_arco numeric(9,0) NOT NULL,
    nr_incidenti numeric(5,0),
    nr_incidenti_elab numeric(10,0),
    nr_corsie numeric(2,0) DEFAULT 2,
    lunghezza numeric(8,0),
    nr_bers_umani_strada numeric(5,0),
    id_tematico_shape numeric(9,0),
    fk_partner character varying(5) NOT NULL,
    geometria public.geometry(Polygon,32632),
    id_origine numeric(9,0),
    flg_nr_corsie character varying(1),
    flg_nr_incidenti character varying(1),
    CONSTRAINT dom_11_scm CHECK (((flg_nr_corsie)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text]))),
    CONSTRAINT dom_12_scm CHECK (((flg_nr_incidenti)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text])))
);


ALTER TABLE siig_p.siig_geo_pl_arco_3 OWNER TO siig_p;

--
-- Name: siig_mtd_d_arco; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_d_arco (
    id_arco numeric(2,0) NOT NULL,
    descrizione_arco character varying(20) NOT NULL
);


ALTER TABLE siig_p.siig_mtd_d_arco OWNER TO siig_p;

--
-- Name: siig_mtd_d_criterio_filtro; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_d_criterio_filtro (
    id_criterio numeric(2,0) NOT NULL,
    descrizione_criterio character varying(50) NOT NULL
);


ALTER TABLE siig_p.siig_mtd_d_criterio_filtro OWNER TO siig_p;

--
-- Name: siig_mtd_d_elaborazione; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_d_elaborazione (
    id_elaborazione numeric(2,0) NOT NULL,
    descrizione_elaborazione character varying(50) NOT NULL
);


ALTER TABLE siig_p.siig_mtd_d_elaborazione OWNER TO siig_p;

--
-- Name: siig_mtd_r_formula_criterio; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_r_formula_criterio (
    id_criterio numeric(2,0) NOT NULL,
    id_formula numeric(3,0) NOT NULL,
    flg_obbligatorio numeric(1,0) DEFAULT 0,
    flg_aggregabile numeric(1,0) DEFAULT 0,
    CONSTRAINT dom_01710 CHECK ((flg_obbligatorio = ANY (ARRAY[(0)::numeric, (1)::numeric])))
);


ALTER TABLE siig_p.siig_mtd_r_formula_criterio OWNER TO siig_p;

--
-- Name: siig_mtd_r_formula_elab; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_r_formula_elab (
    id_elaborazione numeric(2,0) NOT NULL,
    id_formula numeric(3,0) NOT NULL
);


ALTER TABLE siig_p.siig_mtd_r_formula_elab OWNER TO siig_p;

--
-- Name: siig_mtd_r_formula_formula; Type: TABLE; Schema: siig_p; Owner: postgres; Tablespace: 
--

CREATE TABLE siig_mtd_r_formula_formula (
    id_formula numeric(3,0) NOT NULL,
    id_formula_figlio numeric(3,0) NOT NULL,
    operatore character varying(5),
    progressivo_formula numeric(2,0)
);


ALTER TABLE siig_p.siig_mtd_r_formula_formula OWNER TO postgres;

--
-- Name: siig_mtd_r_formula_parametro; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_r_formula_parametro (
    id_formula numeric(3,0) NOT NULL,
    id_parametro numeric(4,0) NOT NULL,
    numero_ordine numeric(2,0),
    operatore character varying(5),
    flg_modificabile numeric(1,0)
);


ALTER TABLE siig_p.siig_mtd_r_formula_parametro OWNER TO siig_p;

--
-- Name: siig_mtd_r_param_bers_arco; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_r_param_bers_arco (
    id_parametro numeric(4,0) NOT NULL,
    id_arco numeric(2,0) NOT NULL,
    id_bersaglio numeric(6,0) NOT NULL,
    nome_tavola character varying(30) NOT NULL,
    def_select character varying(500)
);


ALTER TABLE siig_p.siig_mtd_r_param_bers_arco OWNER TO siig_p;

--
-- Name: siig_mtd_t_bersaglio; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_t_bersaglio (
    id_bersaglio numeric(6,0) NOT NULL,
    col_elab_standard character varying(30) NOT NULL,
    col_vulnerabilita character varying(30)
);


ALTER TABLE siig_p.siig_mtd_t_bersaglio OWNER TO siig_p;

--
-- Name: siig_mtd_t_formula; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_t_formula (
    id_formula numeric(3,0) NOT NULL,
    flg_visibile numeric(1,0) DEFAULT 0,
    flg_i_grid numeric(1,0) DEFAULT 0,
    ordine_visibilita numeric(3,0),
    descrizione_it character varying(200),
    descrizione_en character varying(200),
    descrizione_de character varying(200),
    descrizione_fr character varying(200),
    udm_it character varying(100),
    udm_en character varying(100),
    udm_de character varying(100),
    udm_fr character varying(100),
    formula character varying(4000),
    flg_i numeric(1,0),
    flg_m numeric(1,0),
    flg_g numeric(1,0),
    tema_low double precision,
    tema_medium double precision,
    tema_max double precision,
    CONSTRAINT dom_01714 CHECK ((flg_i_grid = ANY (ARRAY[(0)::numeric, (1)::numeric, (2)::numeric]))),
    CONSTRAINT dom_0_1_22 CHECK ((flg_visibile = ANY (ARRAY[(0)::numeric, (1)::numeric, (2)::numeric, (3)::numeric])))
);


ALTER TABLE siig_p.siig_mtd_t_formula OWNER TO siig_p;

--
-- Name: siig_mtd_t_parametro; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_mtd_t_parametro (
    id_parametro numeric(4,0) NOT NULL,
    descrizione character varying(100),
    flg_i numeric(1,0),
    flg_j numeric(1,0),
    flg_k numeric(1,0),
    flg_m numeric(1,0),
    punto_g numeric(1,0),
    flg_lieve numeric(1,0)
);


ALTER TABLE siig_p.siig_mtd_t_parametro OWNER TO siig_p;

--
-- Name: siig_r_arco_1_dissesto; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_arco_1_dissesto (
    id_geo_arco numeric(9,0) NOT NULL,
    id_dissesto character varying(20) NOT NULL,
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_r_arco_1_dissesto OWNER TO siig_p;

--
-- Name: siig_r_arco_1_scen_tipobers; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_arco_1_scen_tipobers (
    id_geo_arco numeric(9,0) NOT NULL,
    id_bersaglio numeric(6,0) NOT NULL,
    fk_partner character varying(5),
    cff double precision
);


ALTER TABLE siig_p.siig_r_arco_1_scen_tipobers OWNER TO siig_p;

--
-- Name: siig_r_arco_1_sostanza; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_arco_1_sostanza (
    id_geo_arco numeric(9,0) NOT NULL,
    id_sostanza numeric(3,0) NOT NULL,
    padr numeric(4,3),
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_r_arco_1_sostanza OWNER TO siig_p;

--
-- Name: siig_r_arco_2_dissesto; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_arco_2_dissesto (
    id_dissesto character varying(20) NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_r_arco_2_dissesto OWNER TO siig_p;

--
-- Name: siig_r_arco_2_scen_tipobers; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_arco_2_scen_tipobers (
    id_geo_arco numeric(9,0) NOT NULL,
    id_bersaglio numeric(6,0) NOT NULL,
    cff numeric(4,3),
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_r_arco_2_scen_tipobers OWNER TO siig_p;

--
-- Name: siig_r_arco_2_sostanza; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_arco_2_sostanza (
    id_geo_arco numeric(9,0) NOT NULL,
    id_sostanza numeric(3,0) NOT NULL,
    padr numeric(4,3),
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_r_arco_2_sostanza OWNER TO siig_p;

--
-- Name: siig_r_arco_3_dissesto; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_arco_3_dissesto (
    id_dissesto character varying(20) NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_r_arco_3_dissesto OWNER TO siig_p;

--
-- Name: siig_r_arco_3_scen_tipobers; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_arco_3_scen_tipobers (
    id_geo_arco numeric(9,0) NOT NULL,
    id_bersaglio numeric(6,0) NOT NULL,
    cff numeric(6,3),
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_r_arco_3_scen_tipobers OWNER TO siig_p;

--
-- Name: siig_r_arco_3_sostanza; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_arco_3_sostanza (
    id_geo_arco numeric(9,0) NOT NULL,
    id_sostanza numeric(3,0) NOT NULL,
    padr numeric(4,3),
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_r_arco_3_sostanza OWNER TO siig_p;

--
-- Name: siig_r_area_danno; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_area_danno (
    id_gravita numeric(2,0) NOT NULL,
    id_scenario numeric(9,0) NOT NULL,
    id_sostanza numeric(3,0) NOT NULL,
    flg_lieve numeric(1,0) DEFAULT 0 NOT NULL,
    fk_distanza numeric(4,0) NOT NULL,
    id_bersaglio numeric(6,0) NOT NULL,
    CONSTRAINT dom_01716 CHECK ((flg_lieve = ANY (ARRAY[(0)::numeric, (1)::numeric])))
);


ALTER TABLE siig_p.siig_r_area_danno OWNER TO siig_p;

--
-- Name: siig_r_scen_vuln_1; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_scen_vuln_1 (
    id_scenario numeric(9,0) NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    id_distanza numeric(2,0) NOT NULL,
    utenti_carr_bersaglio numeric(6,0),
    utenti_carr_sede_inc numeric(6,0)
);


ALTER TABLE siig_p.siig_r_scen_vuln_1 OWNER TO siig_p;

--
-- Name: siig_r_scen_vuln_2; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_scen_vuln_2 (
    id_scenario numeric(9,0) NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    id_distanza numeric(2,0) NOT NULL,
    utenti_carr_bersaglio numeric(6,0),
    utenti_carr_sede_inc numeric(6,0)
);


ALTER TABLE siig_p.siig_r_scen_vuln_2 OWNER TO siig_p;

--
-- Name: siig_r_scen_vuln_3; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_scen_vuln_3 (
    id_scenario numeric(9,0) NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    id_distanza numeric(2,0) NOT NULL,
    utenti_carr_bersaglio numeric(6,0),
    utenti_carr_sede_inc numeric(6,0)
);


ALTER TABLE siig_p.siig_r_scen_vuln_3 OWNER TO siig_p;

--
-- Name: siig_r_scenario_gravita; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_scenario_gravita (
    id_scenario numeric(9,0) NOT NULL,
    id_gravita numeric(2,0) NOT NULL,
    suscettibilita numeric(5,4),
    id_bersaglio numeric(6,0) NOT NULL
);


ALTER TABLE siig_p.siig_r_scenario_gravita OWNER TO siig_p;

--
-- Name: siig_r_scenario_sostanza; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_scenario_sostanza (
    id_scenario numeric(9,0) NOT NULL,
    id_sostanza numeric(3,0) NOT NULL,
    flg_lieve numeric(1,0) DEFAULT 0 NOT NULL,
    psc numeric(4,3),
    CONSTRAINT dom_01717 CHECK ((flg_lieve = ANY (ARRAY[(0)::numeric, (1)::numeric])))
);


ALTER TABLE siig_p.siig_r_scenario_sostanza OWNER TO siig_p;

--
-- Name: siig_r_tipovei_geoarco1; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_tipovei_geoarco1 (
    id_tipo_veicolo numeric(2,0) NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    densita_veicolare numeric(8,2),
    velocita_media numeric(8,2),
    fk_partner character varying(5) NOT NULL,
    flg_velocita character varying(1),
    flg_densita_veicolare character varying(1),
    CONSTRAINT dom_1_scm CHECK (((flg_velocita)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text]))),
    CONSTRAINT dom_2_scm CHECK (((flg_densita_veicolare)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text])))
);


ALTER TABLE siig_p.siig_r_tipovei_geoarco1 OWNER TO siig_p;

--
-- Name: siig_r_tipovei_geoarco2; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_tipovei_geoarco2 (
    id_tipo_veicolo numeric(2,0) NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    densita_veicolare numeric(8,2),
    velocita_media numeric(8,2),
    fk_partner character varying(5),
    flg_velocita character varying(1),
    flg_densita_veicolare character varying(1),
    CONSTRAINT dom_3_scm CHECK (((flg_velocita)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text]))),
    CONSTRAINT dom_4_scm CHECK (((flg_densita_veicolare)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text])))
);


ALTER TABLE siig_p.siig_r_tipovei_geoarco2 OWNER TO siig_p;

--
-- Name: siig_r_tipovei_geoarco3; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_r_tipovei_geoarco3 (
    id_tipo_veicolo numeric(2,0) NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    densita_veicolare numeric(8,2),
    velocita_media numeric(8,2),
    fk_partner character varying(5),
    flg_velocita character varying(1),
    flg_densita_veicolare character varying(1),
    CONSTRAINT dom_5_scm CHECK (((flg_velocita)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text]))),
    CONSTRAINT dom_6_scm CHECK (((flg_densita_veicolare)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text, ('M'::character varying)::text])))
);


ALTER TABLE siig_p.siig_r_tipovei_geoarco3 OWNER TO siig_p;

--
-- Name: siig_t_bersaglio; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_bersaglio (
    id_bersaglio numeric(6,0) NOT NULL,
    flg_umano numeric(1,0) NOT NULL,
    fp_scen_centrale numeric(4,3),
    fp_scen_feriale_diurno numeric(4,3),
    fp_scen_notturno numeric(4,3),
    fp_scen_festivo_diurno numeric(4,3),
    descrizione_it character varying(100),
    descrizione_en character varying(100),
    descrizione_de character varying(100),
    descrizione_fr character varying(100),
    CONSTRAINT dom_01718 CHECK ((flg_umano = ANY (ARRAY[(0)::numeric, (1)::numeric])))
);


ALTER TABLE siig_p.siig_t_bersaglio OWNER TO siig_p;

--
-- Name: siig_t_bersaglio_non_umano; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_bersaglio_non_umano (
    id_tematico numeric(9,0) NOT NULL,
    id_bersaglio numeric(6,0) NOT NULL,
    id_partner character varying(5) NOT NULL,
    fk_tipo_uso numeric(6,0),
    fk_tipo_captazione numeric(6,0),
    fk_bers_non_umano_pl numeric(9,0),
    fk_bers_non_umano_ln numeric(9,0),
    fk_bers_non_umano_pt numeric(9,0),
    fk_classe_clc numeric(4,0),
    fk_iucn numeric(6,0),
    fk_tipo_bene numeric(6,0),
    area_buffer numeric(7,0),
    denominazione_it character varying(250),
    superficie numeric(11,2),
    denominazione_ente_it character varying(255),
    profondita_max numeric(10,2),
    quota_pdc numeric(4,0),
    toponimo_completo_it character varying(1000),
    eliminato_descrizione_bene character varying(250),
    denominazione_en character varying(250),
    denominazione_de character varying(250),
    denominazione_fr character varying(250),
    denominazione_ente_en character varying(250),
    denominazione_ente_de character varying(250),
    denominazione_ente_fr character varying(250),
    toponimo_completo_en character varying(250),
    toponimo_completo_de character varying(250),
    toponimo_completo_fr character varying(250)
);


ALTER TABLE siig_p.siig_t_bersaglio_non_umano OWNER TO siig_p;

--
-- Name: siig_t_bersaglio_umano; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_bersaglio_umano (
    id_tematico numeric(9,0) NOT NULL,
    id_bersaglio numeric(6,0) NOT NULL,
    id_partner character varying(5) NOT NULL,
    fk_bersaglio_umano_pl numeric(9,0),
    fk_bersaglio_umano_pt numeric(9,0),
    fk_tipo_uso numeric(6,0),
    fk_ateco numeric(8,0),
    denominazione_it character varying(250),
    addetti numeric(6,0),
    utenti numeric(6,0),
    iscritti numeric(6,0),
    insegna_it character varying(250),
    sup_vendita numeric(8,2),
    cod_fisc character varying(16),
    residenti numeric(6,0),
    letti_day numeric(4,0),
    letti_o numeric(5,0),
    nat_code character varying(8),
    pres_max numeric(8,0),
    pres_med numeric(8,0),
    flg_letti_ordinari character varying(1),
    flg_letti_day_h character varying(1),
    flg_nr_addetti_h character varying(1),
    flg_nr_iscritti character varying(1),
    flg_nr_addetti_scuole character varying(1),
    flg_nr_utenti character varying(1),
    flg_nr_addetti_comm character varying(1),
    denominazione_comune_it character varying(100),
    denominazione_en character varying(250),
    denominazione_de character varying(250),
    denominazione_fr character varying(250),
    denominazione_comune_en character varying(100),
    denominazione_comune_de character varying(100),
    denominazione_comune_fr character varying(100),
    insegna_en character varying(250),
    insegna_de character varying(250),
    insegna_fr character varying(250),
    flg_nr_addetti_ind character varying(1),
    flg_nr_res character varying(1),
    CONSTRAINT dom_s_c50 CHECK (((flg_letti_ordinari)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text]))),
    CONSTRAINT dom_s_c51 CHECK (((flg_letti_day_h)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text]))),
    CONSTRAINT dom_s_c52 CHECK (((flg_nr_addetti_h)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text]))),
    CONSTRAINT dom_s_c53 CHECK (((flg_nr_iscritti)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text]))),
    CONSTRAINT dom_s_c54 CHECK (((flg_nr_addetti_scuole)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text]))),
    CONSTRAINT dom_s_c55 CHECK (((flg_nr_utenti)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text]))),
    CONSTRAINT dom_s_c56 CHECK (((flg_nr_addetti_comm)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text]))),
    CONSTRAINT dom_s_c57 CHECK (((flg_nr_addetti_ind)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text]))),
    CONSTRAINT dom_s_c62 CHECK (((flg_nr_res)::text = ANY (ARRAY[('C'::character varying)::text, ('S'::character varying)::text])))
);


ALTER TABLE siig_p.siig_t_bersaglio_umano OWNER TO siig_p;

--
-- Name: siig_t_elab_standard_1; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_elab_standard_1 (
    flg_lieve numeric(1,0) DEFAULT 0 NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    id_distanza numeric(4,0) NOT NULL,
    id_scenario numeric(9,0) NOT NULL,
    id_sostanza numeric(3,0) NOT NULL,
    calc_formula_tot numeric(8,0),
    calc_formula_soc numeric(15,4),
    calc_formula_amb numeric(15,4),
    calc_formula_scuole numeric(8,0),
    calc_formula_ospedali numeric(8,0),
    calc_formula_distrib numeric(8,0),
    calc_formula_residenti numeric(8,0),
    calc_formula_servizi numeric(8,0),
    calc_formula_turisti_medi numeric(8,0),
    calc_formula_turisti_max numeric(8,0),
    calc_formula_flusso numeric(8,0),
    calc_formula_aree_protette numeric(12,2),
    calc_formula_aree_agricole numeric(12,2),
    calc_formula_aree_boscate numeric(12,2),
    calc_formula_beni_culturali numeric(12,2),
    calc_formula_zone_urbanizzate numeric(12,2),
    calc_formula_acque_superf numeric(14,0),
    calc_formula_acque_sotterranee numeric(14,0),
    fk_partner character varying(5),
    CONSTRAINT dom_01719 CHECK ((flg_lieve = ANY (ARRAY[(0)::numeric, (1)::numeric])))
);


ALTER TABLE siig_p.siig_t_elab_standard_1 OWNER TO siig_p;

--
-- Name: siig_t_elab_standard_2; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_elab_standard_2 (
    flg_lieve numeric(1,0) DEFAULT 0 NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    id_scenario numeric(9,0) NOT NULL,
    id_sostanza numeric(3,0) NOT NULL,
    id_distanza numeric(4,0) NOT NULL,
    calc_formula_tot numeric(8,0),
    calc_formula_soc numeric(15,4),
    calc_formula_amb numeric(15,4),
    calc_formula_scuole numeric(8,0),
    calc_formula_ospedali numeric(8,0),
    calc_formula_distrib numeric(8,0),
    calc_formula_residenti numeric(8,0),
    calc_formula_servizi numeric(8,0),
    calc_formula_turisti_medi numeric(8,0),
    calc_formula_turisti_max numeric(8,0),
    calc_formula_flusso numeric(8,0),
    calc_formula_aree_protette numeric(12,2),
    calc_formula_aree_agricole numeric(12,2),
    calc_formula_aree_boscate numeric(12,2),
    calc_formula_beni_culturali numeric(12,2),
    calc_formula_zone_urbanizzate numeric(12,2),
    calc_formula_acque_superf numeric(14,0),
    calc_formula_acque_sotterranee numeric(14,0),
    fk_partner character varying(5),
    CONSTRAINT dom_01720 CHECK ((flg_lieve = ANY (ARRAY[(0)::numeric, (1)::numeric])))
);


ALTER TABLE siig_p.siig_t_elab_standard_2 OWNER TO siig_p;

--
-- Name: siig_t_elab_standard_3; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_elab_standard_3 (
    flg_lieve numeric(1,0) DEFAULT 0 NOT NULL,
    id_geo_arco numeric(9,0) NOT NULL,
    id_scenario numeric(9,0) NOT NULL,
    id_sostanza numeric(3,0) NOT NULL,
    id_distanza numeric(4,0) NOT NULL,
    calc_formula_tot numeric(8,0),
    calc_formula_soc numeric(15,4),
    calc_formula_amb numeric(15,4),
    calc_formula_scuole numeric(8,0),
    calc_formula_ospedali numeric(8,0),
    calc_formula_distrib numeric(8,0),
    calc_formula_residenti numeric(8,0),
    calc_formula_servizi numeric(8,0),
    calc_formula_turisti_medi numeric(8,0),
    calc_formula_turisti_max numeric(8,0),
    calc_formula_flusso numeric(8,0),
    calc_formula_aree_protette numeric(12,2),
    calc_formula_aree_agricole numeric(12,2),
    calc_formula_aree_boscate numeric(12,2),
    calc_formula_beni_culturali numeric(12,2),
    calc_formula_zone_urbanizzate numeric(12,2),
    calc_formula_acque_superf numeric(14,0),
    calc_formula_acque_sotterranee numeric(14,0),
    fk_partner character varying(5),
    CONSTRAINT dom_01721 CHECK ((flg_lieve = ANY (ARRAY[(0)::numeric, (1)::numeric])))
);


ALTER TABLE siig_p.siig_t_elab_standard_3 OWNER TO siig_p;

--
-- Name: siig_t_log; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_log (
    id_tracciamento numeric(6,0) NOT NULL,
    progressivo numeric(7,0) NOT NULL,
    codice_log character varying(256),
    descr_errore character varying(1000),
    id_tematico_shape_orig numeric(9,0)
);


ALTER TABLE siig_p.siig_t_log OWNER TO siig_p;

--
-- Name: siig_t_processo; Type: TABLE; Schema: siig_p; Owner: postgres; Tablespace: 
--

CREATE TABLE siig_t_processo (
    data_creazione timestamp without time zone NOT NULL,
    data_chiusura_a timestamp without time zone,
    data_chiusura_b timestamp without time zone,
    data_chiusura_c timestamp without time zone,
    id_processo numeric(6,0) NOT NULL
);


ALTER TABLE siig_p.siig_t_processo OWNER TO postgres;

--
-- Name: siig_t_scenario; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_scenario (
    id_scenario numeric(9,0) NOT NULL,
    codice character varying(2),
    tipologia character varying(100),
    tempo_di_coda numeric(4,0)
);


ALTER TABLE siig_p.siig_t_scenario OWNER TO siig_p;

--
-- Name: siig_t_sostanza; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_sostanza (
    id_sostanza numeric(3,0) NOT NULL,
    fk_classe_adr numeric(3,0) NOT NULL,
    fk_tipo_contenitore numeric(2,0) NOT NULL,
    fk_tipo_trasporto numeric(6,0) NOT NULL,
    fk_stato_fisico numeric(2,0) NOT NULL,
    numero_kemler character varying(5),
    numero_onu character varying(5),
    nome_sostanza character varying(100),
    condizione_operativa character varying(100)
);


ALTER TABLE siig_p.siig_t_sostanza OWNER TO siig_p;

--
-- Name: siig_t_tracciamento; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_tracciamento (
    id_tracciamento numeric(6,0) NOT NULL,
    fk_bersaglio numeric(6,0),
    fk_partner character varying(5),
    codice_partner character varying(2) NOT NULL,
    nome_file character varying(50) NOT NULL,
    data timestamp without time zone NOT NULL,
    nr_rec_shape numeric(9,0) NOT NULL,
    nr_rec_storage numeric(9,0) NOT NULL,
    nr_rec_scartati numeric(9,0) NOT NULL,
    nr_rec_scartati_siig numeric(9,0) NOT NULL,
    data_imp_storage timestamp without time zone NOT NULL,
    data_elab timestamp without time zone NOT NULL,
    data_imp_siig timestamp without time zone,
    flg_tipo_imp character(1),
    fk_processo numeric(6,0) NOT NULL,
    CONSTRAINT dom_c_i6 CHECK ((flg_tipo_imp = ANY (ARRAY['C'::bpchar, 'I'::bpchar])))
);


ALTER TABLE siig_p.siig_t_tracciamento OWNER TO siig_p;

--
-- Name: siig_t_variabile; Type: TABLE; Schema: siig_p; Owner: postgres; Tablespace: 
--

CREATE TABLE siig_t_variabile (
    id_variabile numeric(3,0) NOT NULL,
    fk_tipo_variabile numeric(2,0) NOT NULL,
    descrizione_it character varying(100) NOT NULL,
    descrizione_en character varying(100) NOT NULL,
    descrizione_de character varying(100) NOT NULL,
    descrizione_fr character varying(100) NOT NULL,
    coefficiente numeric(6,3)
);


ALTER TABLE siig_p.siig_t_variabile OWNER TO postgres;

--
-- Name: siig_t_vulnerabilita_1; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_vulnerabilita_1 (
    id_geo_arco numeric(9,0) NOT NULL,
    id_distanza numeric(4,0) NOT NULL,
    nr_pers_scuole numeric(7,0),
    nr_pers_ospedali numeric(7,0),
    nr_pers_distrib numeric(7,0),
    nr_pers_residenti numeric(7,0),
    nr_pers_servizi numeric(7,0),
    nr_turisti_medi numeric(7,0),
    nr_turisti_max numeric(7,0),
    mq_aree_protette numeric(10,2),
    mq_aree_agricole numeric(10,2),
    mq_aree_boscate numeric(10,2),
    mq_beni_culturali numeric(10,2),
    mq_zone_urbanizzate numeric(10,2),
    mq_acque_superficiali numeric(12,0),
    mq_acque_sotterranee numeric(12,0),
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_t_vulnerabilita_1 OWNER TO siig_p;

--
-- Name: siig_t_vulnerabilita_2; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_vulnerabilita_2 (
    id_geo_arco numeric(9,0) NOT NULL,
    id_distanza numeric(4,0) NOT NULL,
    nr_pers_scuole numeric(7,0),
    nr_pers_ospedali numeric(7,0),
    nr_pers_distrib numeric(7,0),
    nr_pers_residenti numeric(7,0),
    nr_pers_servizi numeric(7,0),
    nr_turisti_medi numeric(7,0),
    nr_turisti_max numeric(7,0),
    mq_aree_protette numeric(10,2),
    mq_aree_agricole numeric(10,2),
    mq_aree_boscate numeric(10,2),
    mq_beni_culturali numeric(10,2),
    mq_zone_urbanizzate numeric(10,2),
    mq_acque_superficiali numeric(12,0),
    mq_acque_sotterranee numeric(12,0),
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_t_vulnerabilita_2 OWNER TO siig_p;

--
-- Name: siig_t_vulnerabilita_3; Type: TABLE; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE TABLE siig_t_vulnerabilita_3 (
    id_geo_arco numeric(9,0) NOT NULL,
    id_distanza numeric(4,0) NOT NULL,
    nr_pers_scuole numeric(7,0),
    nr_pers_ospedali numeric(7,0),
    nr_pers_distrib numeric(7,0),
    nr_pers_residenti numeric(7,0),
    nr_pers_servizi numeric(7,0),
    nr_turisti_medi numeric(7,0),
    nr_turisti_max numeric(7,0),
    mq_aree_protette numeric(10,2),
    mq_aree_agricole numeric(10,2),
    mq_aree_boscate numeric(10,2),
    mq_beni_culturali numeric(10,2),
    mq_zone_urbanizzate numeric(10,2),
    mq_acque_superficiali numeric(12,0),
    mq_acque_sotterranee numeric(12,0),
    fk_partner character varying(5)
);


ALTER TABLE siig_p.siig_t_vulnerabilita_3 OWNER TO siig_p;

--
-- Name: targetingestionprocess_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE targetingestionprocess_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.targetingestionprocess_seq OWNER TO siig_p;

--
-- Name: trace_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE trace_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.trace_seq OWNER TO siig_p;

--
-- Name: v_geo_acque_sotterranee_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_acque_sotterranee_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, siig_t_bersaglio_non_umano.denominazione_it, siig_t_bersaglio_non_umano.denominazione_en, siig_t_bersaglio_non_umano.denominazione_fr, siig_t_bersaglio_non_umano.denominazione_de, siig_t_bersaglio_non_umano.profondita_max, siig_t_bersaglio_non_umano.quota_pdc, siig_d_tipo_captazione.descrizione_it AS tipo_captazione_it, siig_d_tipo_captazione.descrizione_en AS tipo_captazione_en, siig_d_tipo_captazione.descrizione_fr AS tipo_captazione_fr, siig_d_tipo_captazione.descrizione_de AS tipo_captazione_de, siig_t_bersaglio_non_umano.superficie, siig_geo_bers_non_umano_pl.geometria FROM (siig_d_tipo_captazione RIGHT JOIN (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_geo_bers_non_umano_pl JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) ON ((siig_d_tipo_captazione.id_tipo_captazione = siig_t_bersaglio_non_umano.fk_tipo_captazione))) WHERE (siig_t_bersaglio_non_umano.id_bersaglio = (14)::numeric);


ALTER TABLE siig_p.v_geo_acque_sotterranee_pl OWNER TO siig_p;

--
-- Name: v_geo_acque_sotterranee_pt; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_acque_sotterranee_pt AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_pt, siig_t_bersaglio_non_umano.denominazione_it, siig_t_bersaglio_non_umano.denominazione_en, siig_t_bersaglio_non_umano.denominazione_fr, siig_t_bersaglio_non_umano.denominazione_de, siig_t_bersaglio_non_umano.profondita_max, siig_t_bersaglio_non_umano.quota_pdc, siig_d_tipo_captazione.descrizione_it AS tipo_captazione_it, siig_d_tipo_captazione.descrizione_en AS tipo_captazione_en, siig_d_tipo_captazione.descrizione_fr AS tipo_captazione_fr, siig_d_tipo_captazione.descrizione_de AS tipo_captazione_de, siig_t_bersaglio_non_umano.superficie, siig_geo_bers_non_umano_pt.geometria FROM (siig_d_tipo_captazione RIGHT JOIN (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_geo_bers_non_umano_pt JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_pt.idgeo_bers_non_umano_pt = siig_t_bersaglio_non_umano.fk_bers_non_umano_pt))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) ON ((siig_d_tipo_captazione.id_tipo_captazione = siig_t_bersaglio_non_umano.fk_tipo_captazione))) WHERE (siig_t_bersaglio_non_umano.id_bersaglio = (14)::numeric);


ALTER TABLE siig_p.v_geo_acque_sotterranee_pt OWNER TO siig_p;

--
-- Name: v_geo_acque_superficiali_ln; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_acque_superficiali_ln AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_ln, siig_t_bersaglio_non_umano.denominazione_it, siig_t_bersaglio_non_umano.denominazione_en, siig_t_bersaglio_non_umano.denominazione_fr, siig_t_bersaglio_non_umano.denominazione_de, siig_d_classe_clc.codice_clc, siig_d_classe_clc.descrizione_clc_it, siig_d_classe_clc.descrizione_clc_en, siig_d_classe_clc.descrizione_clc_fr, siig_d_classe_clc.descrizione_clc_de, siig_t_bersaglio_non_umano.superficie, siig_t_bersaglio_non_umano.toponimo_completo_it, siig_t_bersaglio_non_umano.toponimo_completo_en, siig_t_bersaglio_non_umano.toponimo_completo_fr, siig_t_bersaglio_non_umano.toponimo_completo_de, siig_geo_bers_non_umano_ln.geometria FROM (siig_d_classe_clc RIGHT JOIN (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_geo_bers_non_umano_ln JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_ln.idgeo_bers_non_umano_ln = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) ON ((siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc))) WHERE (siig_t_bersaglio_non_umano.id_bersaglio = (15)::numeric);


ALTER TABLE siig_p.v_geo_acque_superficiali_ln OWNER TO siig_p;

--
-- Name: v_geo_acque_superficiali_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_acque_superficiali_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, siig_t_bersaglio_non_umano.denominazione_it, siig_t_bersaglio_non_umano.denominazione_en, siig_t_bersaglio_non_umano.denominazione_fr, siig_t_bersaglio_non_umano.denominazione_de, siig_d_classe_clc.codice_clc, siig_d_classe_clc.descrizione_clc_it, siig_d_classe_clc.descrizione_clc_en, siig_d_classe_clc.descrizione_clc_fr, siig_d_classe_clc.descrizione_clc_de, siig_t_bersaglio_non_umano.superficie, siig_t_bersaglio_non_umano.toponimo_completo_it, siig_t_bersaglio_non_umano.toponimo_completo_en, siig_t_bersaglio_non_umano.toponimo_completo_fr, siig_t_bersaglio_non_umano.toponimo_completo_de, siig_geo_bers_non_umano_pl.geometria FROM (siig_d_classe_clc RIGHT JOIN (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_geo_bers_non_umano_pl JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) ON ((siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc))) WHERE (siig_t_bersaglio_non_umano.id_bersaglio = (15)::numeric);


ALTER TABLE siig_p.v_geo_acque_superficiali_pl OWNER TO siig_p;

--
-- Name: v_geo_aree_agricole_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_aree_agricole_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, siig_d_classe_clc.codice_clc, siig_d_classe_clc.descrizione_clc_it, siig_d_classe_clc.descrizione_clc_en, siig_d_classe_clc.descrizione_clc_fr, siig_d_classe_clc.descrizione_clc_de, siig_t_bersaglio_non_umano.superficie, siig_geo_bers_non_umano_pl.geometria FROM (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_d_classe_clc RIGHT JOIN (siig_geo_bers_non_umano_pl JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl))) ON ((siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) WHERE (siig_t_bersaglio_non_umano.id_bersaglio = (13)::numeric);


ALTER TABLE siig_p.v_geo_aree_agricole_pl OWNER TO siig_p;

--
-- Name: v_geo_aree_boscate_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_aree_boscate_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, siig_d_classe_clc.codice_clc, siig_d_classe_clc.descrizione_clc_it, siig_d_classe_clc.descrizione_clc_en, siig_d_classe_clc.descrizione_clc_fr, siig_d_classe_clc.descrizione_clc_de, siig_t_bersaglio_non_umano.superficie, siig_geo_bers_non_umano_pl.geometria FROM (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_d_classe_clc RIGHT JOIN (siig_geo_bers_non_umano_pl JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl))) ON ((siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) WHERE (siig_t_bersaglio_non_umano.id_bersaglio = (11)::numeric);


ALTER TABLE siig_p.v_geo_aree_boscate_pl OWNER TO siig_p;

--
-- Name: v_geo_aree_protette_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_aree_protette_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, siig_t_bersaglio_non_umano.denominazione_it, siig_t_bersaglio_non_umano.denominazione_en, siig_t_bersaglio_non_umano.denominazione_fr, siig_t_bersaglio_non_umano.denominazione_de, siig_t_bersaglio_non_umano.denominazione_ente_it, siig_t_bersaglio_non_umano.denominazione_ente_en, siig_t_bersaglio_non_umano.denominazione_ente_fr, siig_t_bersaglio_non_umano.denominazione_ente_de, siig_t_bersaglio_non_umano.superficie, siig_d_iucn.descrizione_iucn_it, siig_d_iucn.descrizione_iucn_en, siig_d_iucn.descrizione_iucn_fr, siig_d_iucn.descrizione_iucn_de, siig_geo_bers_non_umano_pl.geometria FROM (siig_d_iucn RIGHT JOIN (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_geo_bers_non_umano_pl JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) ON ((siig_d_iucn.id_iucn = siig_t_bersaglio_non_umano.fk_iucn))) WHERE ((siig_t_bersaglio_non_umano.id_bersaglio = (12)::numeric) OR (siig_t_bersaglio_non_umano.id_bersaglio = (11)::numeric));


ALTER TABLE siig_p.v_geo_aree_protette_pl OWNER TO siig_p;

--
-- Name: v_geo_beni_culturali_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_beni_culturali_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, siig_t_bersaglio_non_umano.denominazione_it AS denominazione_bene_it, siig_t_bersaglio_non_umano.denominazione_en AS denominazione_bene_en, siig_t_bersaglio_non_umano.denominazione_fr AS denominazione_bene_fr, siig_t_bersaglio_non_umano.denominazione_de AS denominazione_bene_de, siig_d_bene_culturale.tipologia_it, siig_d_bene_culturale.tipologia_en, siig_d_bene_culturale.tipologia_fr, siig_d_bene_culturale.tipologia_de, siig_t_bersaglio_non_umano.superficie, siig_geo_bers_non_umano_pl.geometria FROM (siig_d_bene_culturale RIGHT JOIN (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_geo_bers_non_umano_pl JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) ON ((siig_d_bene_culturale.id_tipo_bene = siig_t_bersaglio_non_umano.fk_tipo_bene))) WHERE (siig_t_bersaglio_non_umano.id_bersaglio = (16)::numeric);


ALTER TABLE siig_p.v_geo_beni_culturali_pl OWNER TO siig_p;

--
-- Name: v_geo_beni_culturali_pt; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_beni_culturali_pt AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_pt, siig_t_bersaglio_non_umano.denominazione_it AS denominazione_bene_it, siig_t_bersaglio_non_umano.denominazione_en AS denominazione_bene_en, siig_t_bersaglio_non_umano.denominazione_fr AS denominazione_bene_fr, siig_t_bersaglio_non_umano.denominazione_de AS denominazione_bene_de, siig_d_bene_culturale.tipologia_it, siig_d_bene_culturale.tipologia_en, siig_d_bene_culturale.tipologia_fr, siig_d_bene_culturale.tipologia_de, siig_t_bersaglio_non_umano.superficie, siig_geo_bers_non_umano_pt.geometria FROM (siig_d_bene_culturale RIGHT JOIN (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_geo_bers_non_umano_pt JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_pt.idgeo_bers_non_umano_pt = siig_t_bersaglio_non_umano.fk_bers_non_umano_pt))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) ON ((siig_d_bene_culturale.id_tipo_bene = siig_t_bersaglio_non_umano.fk_tipo_bene))) WHERE (siig_t_bersaglio_non_umano.id_bersaglio = (16)::numeric);


ALTER TABLE siig_p.v_geo_beni_culturali_pt OWNER TO siig_p;

--
-- Name: v_geo_commercio_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_commercio_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pl, siig_t_bersaglio_umano.denominazione_it, siig_t_bersaglio_umano.denominazione_en, siig_t_bersaglio_umano.denominazione_fr, siig_t_bersaglio_umano.denominazione_de, siig_t_bersaglio_umano.insegna_it, siig_t_bersaglio_umano.insegna_en, siig_t_bersaglio_umano.insegna_fr, siig_t_bersaglio_umano.insegna_de, siig_t_bersaglio_umano.sup_vendita, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_utenti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_utenti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_utenti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_utenti_de, siig_t_bersaglio_umano.utenti, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_addetti_commercio_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_addetti_commercio_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_addetti_commercio_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_addetti_commercio_de, siig_t_bersaglio_umano.addetti, siig_geo_bersaglio_umano_pl.geometria FROM (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pl JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (7)::numeric);


ALTER TABLE siig_p.v_geo_commercio_pl OWNER TO siig_p;

--
-- Name: v_geo_commercio_pt; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_commercio_pt AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pt, siig_t_bersaglio_umano.denominazione_it, siig_t_bersaglio_umano.denominazione_en, siig_t_bersaglio_umano.denominazione_fr, siig_t_bersaglio_umano.denominazione_de, siig_t_bersaglio_umano.insegna_it, siig_t_bersaglio_umano.insegna_en, siig_t_bersaglio_umano.insegna_fr, siig_t_bersaglio_umano.insegna_de, siig_t_bersaglio_umano.sup_vendita, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_utenti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_utenti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_utenti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_utenti)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_utenti_de, siig_t_bersaglio_umano.utenti, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_addetti_commercio_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_addetti_commercio_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_addetti_commercio_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_comm)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_addetti_commercio_de, siig_t_bersaglio_umano.addetti, siig_geo_bersaglio_umano_pt.geometria FROM (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pt JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (7)::numeric);


ALTER TABLE siig_p.v_geo_commercio_pt OWNER TO siig_p;

--
-- Name: v_geo_industria_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_industria_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pl, siig_t_bersaglio_umano.denominazione_it, siig_t_bersaglio_umano.denominazione_en, siig_t_bersaglio_umano.denominazione_fr, siig_t_bersaglio_umano.denominazione_de, siig_t_bersaglio_umano.cod_fisc, siig_d_ateco.descrizione_ateco_it, siig_d_ateco.descrizione_ateco_en, siig_d_ateco.descrizione_ateco_fr, siig_d_ateco.descrizione_ateco_de, siig_t_bersaglio_umano.addetti, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_addetti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_addetti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_addetti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_addetti_de, siig_geo_bersaglio_umano_pl.geometria FROM (siig_d_ateco RIGHT JOIN (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pl JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) ON ((siig_d_ateco.id_ateco = siig_t_bersaglio_umano.fk_ateco))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (4)::numeric);


ALTER TABLE siig_p.v_geo_industria_pl OWNER TO siig_p;

--
-- Name: v_geo_industria_pt; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_industria_pt AS
    SELECT siig_t_bersaglio_umano.id_tematico, siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.fk_bersaglio_umano_pt, siig_t_bersaglio_umano.denominazione_it, siig_t_bersaglio_umano.denominazione_en, siig_t_bersaglio_umano.denominazione_fr, siig_t_bersaglio_umano.denominazione_de, siig_t_bersaglio_umano.cod_fisc, siig_d_ateco.descrizione_ateco_it, siig_d_ateco.descrizione_ateco_en, siig_d_ateco.descrizione_ateco_fr, siig_d_ateco.descrizione_ateco_de, siig_t_bersaglio_umano.addetti, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_addetti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_addetti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_addetti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_ind)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_addetti_de, siig_geo_bersaglio_umano_pt.geometria FROM (siig_d_ateco RIGHT JOIN (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pt JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) ON ((siig_d_ateco.id_ateco = siig_t_bersaglio_umano.fk_ateco))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (4)::numeric);


ALTER TABLE siig_p.v_geo_industria_pt OWNER TO siig_p;

--
-- Name: v_geo_ospedale_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_ospedale_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pl, siig_t_bersaglio_umano.denominazione_it, siig_t_bersaglio_umano.denominazione_en, siig_t_bersaglio_umano.denominazione_fr, siig_t_bersaglio_umano.denominazione_de, siig_d_tipo_uso.descrizione_uso_it, siig_d_tipo_uso.descrizione_uso_en, siig_d_tipo_uso.descrizione_uso_fr, siig_d_tipo_uso.descrizione_uso_de, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_addetti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_addetti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_addetti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_addetti_de, siig_t_bersaglio_umano.addetti, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_numero_letti_day_h_it, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_numero_letti_day_h_en, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_numero_letti_day_h_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_numero_letti_day_h_de, siig_t_bersaglio_umano.letti_day AS nr_letti_dh, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_numero_letti_ordinari_it, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_numero_letti_ordinari_en, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_numero_letti_ordinari_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_numero_letti_ordinari_de, siig_t_bersaglio_umano.letti_o AS letti_ordinari, siig_geo_bersaglio_umano_pl.geometria FROM (siig_d_tipo_uso RIGHT JOIN (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pl JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) ON ((siig_d_tipo_uso.id_tipo_uso = siig_t_bersaglio_umano.fk_tipo_uso))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (5)::numeric);


ALTER TABLE siig_p.v_geo_ospedale_pl OWNER TO siig_p;

--
-- Name: v_geo_ospedale_pt; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_ospedale_pt AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pt, siig_t_bersaglio_umano.denominazione_it, siig_t_bersaglio_umano.denominazione_en, siig_t_bersaglio_umano.denominazione_fr, siig_t_bersaglio_umano.denominazione_de, siig_d_tipo_uso.descrizione_uso_it, siig_d_tipo_uso.descrizione_uso_en, siig_d_tipo_uso.descrizione_uso_fr, siig_d_tipo_uso.descrizione_uso_de, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_addetti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_addetti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_addetti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_h)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_addetti_de, siig_t_bersaglio_umano.addetti, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_numero_letti_day_h_it, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_numero_letti_day_h_en, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_numero_letti_day_h_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_letti_day_h)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_numero_letti_day_h_de, siig_t_bersaglio_umano.letti_day AS nr_letti_dh, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_numero_letti_ordinari_it, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_numero_letti_ordinari_en, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_numero_letti_ordinari_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_letti_ordinari)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_numero_letti_ordinari_de, siig_geo_bersaglio_umano_pt.geometria FROM (siig_d_tipo_uso RIGHT JOIN (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pt JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) ON ((siig_d_tipo_uso.id_tipo_uso = siig_t_bersaglio_umano.fk_tipo_uso))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (5)::numeric);


ALTER TABLE siig_p.v_geo_ospedale_pt OWNER TO siig_p;

--
-- Name: v_geo_popolazione_residente_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_popolazione_residente_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pl, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_residenti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_residenti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_residenti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_residenti_de, siig_t_bersaglio_umano.residenti, siig_geo_bersaglio_umano_pl.geometria FROM (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pl JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (1)::numeric);


ALTER TABLE siig_p.v_geo_popolazione_residente_pl OWNER TO siig_p;

--
-- Name: v_geo_popolazione_residente_pt; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_popolazione_residente_pt AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pt, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_residenti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_residenti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_residenti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_res)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_residenti_de, siig_t_bersaglio_umano.residenti, siig_geo_bersaglio_umano_pt.geometria FROM (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pt JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (1)::numeric);


ALTER TABLE siig_p.v_geo_popolazione_residente_pt OWNER TO siig_p;

--
-- Name: v_geo_popolazione_turistica_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_popolazione_turistica_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pl, siig_t_bersaglio_umano.denominazione_comune_it, siig_t_bersaglio_umano.denominazione_comune_en, siig_t_bersaglio_umano.denominazione_comune_fr, siig_t_bersaglio_umano.denominazione_comune_de, siig_t_bersaglio_umano.nat_code, siig_t_bersaglio_umano.pres_max, siig_t_bersaglio_umano.pres_med, siig_geo_bersaglio_umano_pl.geometria FROM (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pl JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (2)::numeric);


ALTER TABLE siig_p.v_geo_popolazione_turistica_pl OWNER TO siig_p;

--
-- Name: v_geo_scuola_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_scuola_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pl, siig_t_bersaglio_umano.denominazione_it, siig_t_bersaglio_umano.denominazione_en, siig_t_bersaglio_umano.denominazione_fr, siig_t_bersaglio_umano.denominazione_de, siig_d_tipo_uso.descrizione_uso_it, siig_d_tipo_uso.descrizione_uso_en, siig_d_tipo_uso.descrizione_uso_fr, siig_d_tipo_uso.descrizione_uso_de, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_iscritti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_iscritti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_iscritti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_iscritti_de, siig_t_bersaglio_umano.iscritti, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_addetti_scuole_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_addetti_scuole_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_addetti_scuole_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_addetti_scuole_de, siig_t_bersaglio_umano.addetti, siig_geo_bersaglio_umano_pl.geometria FROM (siig_d_tipo_uso RIGHT JOIN (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pl JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pl.idgeo_bersaglio_umano_pl = siig_t_bersaglio_umano.fk_bersaglio_umano_pl))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) ON ((siig_d_tipo_uso.id_tipo_uso = siig_t_bersaglio_umano.fk_tipo_uso))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (6)::numeric);


ALTER TABLE siig_p.v_geo_scuola_pl OWNER TO siig_p;

--
-- Name: v_geo_scuola_pt; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_scuola_pt AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_umano.id_tematico, siig_t_bersaglio_umano.fk_bersaglio_umano_pt, siig_t_bersaglio_umano.denominazione_it, siig_t_bersaglio_umano.denominazione_en, siig_t_bersaglio_umano.denominazione_fr, siig_t_bersaglio_umano.denominazione_de, siig_d_tipo_uso.descrizione_uso_it, siig_d_tipo_uso.descrizione_uso_en, siig_d_tipo_uso.descrizione_uso_fr, siig_d_tipo_uso.descrizione_uso_de, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_iscritti_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_iscritti_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_iscritti_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_iscritti)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_iscritti_de, siig_t_bersaglio_umano.iscritti, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'S'::text) THEN 'STIMATO'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'C'::text) THEN 'CALCOLATO'::text ELSE NULL::text END AS fonte_addetti_scuole_it, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'S'::text) THEN 'ESTIMATED'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'C'::text) THEN 'CALCULATED'::text ELSE NULL::text END AS fonte_addetti_scuole_en, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'S'::text) THEN 'ESTIMÉ'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'C'::text) THEN 'CALCULÉ'::text ELSE NULL::text END AS fonte_addetti_scuole_fr, CASE WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'S'::text) THEN 'Geschätzt'::text WHEN ((siig_t_bersaglio_umano.flg_nr_addetti_scuole)::text = 'C'::text) THEN 'Berechnet'::text ELSE NULL::text END AS fonte_addetti_scuole_de, siig_t_bersaglio_umano.addetti, siig_geo_bersaglio_umano_pt.geometria FROM (siig_d_tipo_uso RIGHT JOIN (siig_t_bersaglio JOIN (siig_geo_bersaglio_umano_pt JOIN (siig_d_partner JOIN siig_t_bersaglio_umano ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_umano.id_partner)::text))) ON ((siig_geo_bersaglio_umano_pt.idgeo_bersaglio_umano_pt = siig_t_bersaglio_umano.fk_bersaglio_umano_pt))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_umano.id_bersaglio))) ON ((siig_d_tipo_uso.id_tipo_uso = siig_t_bersaglio_umano.fk_tipo_uso))) WHERE (siig_t_bersaglio_umano.id_bersaglio = (6)::numeric);


ALTER TABLE siig_p.v_geo_scuola_pt OWNER TO siig_p;

--
-- Name: v_geo_zone_urbanizzate_pl; Type: VIEW; Schema: siig_p; Owner: siig_p
--

CREATE VIEW v_geo_zone_urbanizzate_pl AS
    SELECT siig_d_partner.partner_it, siig_d_partner.partner_en, siig_d_partner.partner_fr, siig_d_partner.partner_de, siig_t_bersaglio_non_umano.id_tematico, siig_t_bersaglio_non_umano.fk_bers_non_umano_pl, siig_d_classe_clc.codice_clc, siig_d_classe_clc.descrizione_clc_it, siig_d_classe_clc.descrizione_clc_en, siig_d_classe_clc.descrizione_clc_fr, siig_d_classe_clc.descrizione_clc_de, siig_t_bersaglio_non_umano.superficie, siig_geo_bers_non_umano_pl.geometria FROM (siig_t_bersaglio JOIN (siig_d_partner JOIN (siig_d_classe_clc RIGHT JOIN (siig_geo_bers_non_umano_pl JOIN siig_t_bersaglio_non_umano ON ((siig_geo_bers_non_umano_pl.idgeo_bers_non_umano_pl = siig_t_bersaglio_non_umano.fk_bers_non_umano_pl))) ON ((siig_d_classe_clc.id_classe_clc = siig_t_bersaglio_non_umano.fk_classe_clc))) ON (((siig_d_partner.id_partner)::text = (siig_t_bersaglio_non_umano.id_partner)::text))) ON ((siig_t_bersaglio.id_bersaglio = siig_t_bersaglio_non_umano.id_bersaglio))) WHERE (siig_t_bersaglio_non_umano.id_bersaglio = (10)::numeric);


ALTER TABLE siig_p.v_geo_zone_urbanizzate_pl OWNER TO siig_p;

--
-- Name: vulnerabilitycomputation_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE vulnerabilitycomputation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.vulnerabilitycomputation_seq OWNER TO siig_p;

--
-- Name: zeroremovalcomputation_seq; Type: SEQUENCE; Schema: siig_p; Owner: siig_p
--

CREATE SEQUENCE zeroremovalcomputation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE siig_p.zeroremovalcomputation_seq OWNER TO siig_p;

--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "AO_BNU-AAGR_C_20130730_02" ALTER COLUMN fid SET DEFAULT nextval('"AO_BNU-AAGR_C_20130730_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "AO_BNU-ABOSC_C_20130730_02" ALTER COLUMN fid SET DEFAULT nextval('"AO_BNU-ABOSC_C_20130730_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "AO_BNU-APROT_C_20130822_02" ALTER COLUMN fid SET DEFAULT nextval('"AO_BNU-APROT_C_20130822_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "AO_BNU-ASUP_C_20130821_02" ALTER COLUMN fid SET DEFAULT nextval('"AO_BNU-ASUP_C_20130821_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "AO_BU-ACOMM_C_20130822_02" ALTER COLUMN fid SET DEFAULT nextval('"AO_BU-ACOMM_C_20130822_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "AO_BU-ASAN_C_20130909_02" ALTER COLUMN fid SET DEFAULT nextval('"AO_BU-ASAN_C_20130909_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "AO_C_Grafo_20130704" ALTER COLUMN fid SET DEFAULT nextval('"AO_C_Grafo_20130704_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BNU-AAGR_C_20130904_02" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BNU-AAGR_C_20130904_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BNU-ABOSC_C_20130904_02" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BNU-ABOSC_C_20130904_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BNU-APROT_C_20130906_02" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BNU-APROT_C_20130906_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BNU-ASOTT_C_20130521_01" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BNU-ASOTT_C_20130521_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BNU-ASOTT_C_20130521_02" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BNU-ASOTT_C_20130521_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BNU-ASUP_C_20130904_02" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BNU-ASUP_C_20130904_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BNU-BCULT_C_20130524_02" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BNU-BCULT_C_20130524_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BNU-ZURB_C_20130904_02" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BNU-ZURB_C_20130904_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BU-ACOMM_C_20130906_02" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BU-ACOMM_C_20130906_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BU-AIND_C_20130903_01" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BU-AIND_C_20130903_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BU-ASAN_C_20130606_01" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BU-ASAN_C_20130606_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BU-ASCOL_C_20130531_01" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BU-ASCOL_C_20130531_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BU-PRES_C_20130903_01" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BU-PRES_C_20130903_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_BU-PTUR_C_20130604_02" ALTER COLUMN fid SET DEFAULT nextval('"BZ_BU-PTUR_C_20130604_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_C_Grafo_20130807" ALTER COLUMN fid SET DEFAULT nextval('"BZ_C_Grafo_20130807_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "BZ_C_Grafo_20130917" ALTER COLUMN fid SET DEFAULT nextval('"BZ_C_Grafo_20130917_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BNU-AAGR_C_20130909_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BNU-AAGR_C_20130909_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BNU-ABOSC_C_20130909_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BNU-ABOSC_C_20130909_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BNU-APROT_C_20130909_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BNU-APROT_C_20130909_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BNU-ASOTT_C_20130716_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BNU-ASOTT_C_20130716_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BNU-ASUP_C_20130909_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BNU-ASUP_C_20130909_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BNU-BCULT_C_20130909_01" ALTER COLUMN fid SET DEFAULT nextval('"RL_BNU-BCULT_C_20130909_1_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BNU-ZURB_C_20130909_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BNU-ZURB_C_20130909_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BU-ACOMM_C_20130909_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BU-ACOMM_C_20130909_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BU-AIND_C_20130624_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BU-AIND_C_20130624_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BU-ASAN_C_20130909_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BU-ASAN_C_20130909_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_BU-PRES_C_20130624_02" ALTER COLUMN fid SET DEFAULT nextval('"RL_BU-PRES_C_20130624_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RL_C_Grafo_20130918" ALTER COLUMN fid SET DEFAULT nextval('"RL_C_Grafo_20130918_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BNU-AAGR_20121217_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BNU-AAGR_20121217_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BNU-ABOSC_20121217_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BNU-ABOSC_20121217_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BNU-APROT_20130424_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BNU-APROT_20130424_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BNU-ASOTT_20130424_01" ALTER COLUMN fid SET DEFAULT nextval('"RP_BNU-ASOTT_20130424_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BNU-ASUP_20130424_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BNU-ASUP_20130424_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BNU-BCULT_20130424_01" ALTER COLUMN fid SET DEFAULT nextval('"RP_BNU-BCULT_20130424_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BNU-BCULT_20130424_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BNU-BCULT_20130424_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BNU-ZURB_20121207_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BNU-ZURB_20121207_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BU-ACOMM_20130424_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BU-ACOMM_20130424_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BU-AIND_20130424_01" ALTER COLUMN fid SET DEFAULT nextval('"RP_BU-AIND_20130424_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BU-ASAN_20130424_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BU-ASAN_20130424_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BU-ASCOL_20130424_01" ALTER COLUMN fid SET DEFAULT nextval('"RP_BU-ASCOL_20130424_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BU-ASCOL_20130424_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BU-ASCOL_20130424_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BU-PRES_20121217_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BU-PRES_20121217_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_BU-PTUR_20120122_02" ALTER COLUMN fid SET DEFAULT nextval('"RP_BU-PTUR_20120122_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "RP_C_Grafo_20130424" ALTER COLUMN fid SET DEFAULT nextval('"RP_C_Grafo_20130424_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "TI_BNU-ASOTT_C_20130617_01" ALTER COLUMN fid SET DEFAULT nextval('"TI_BNU-ASOTT_C_20130617_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "TI_BNU-BCULT_C_20130617_01" ALTER COLUMN fid SET DEFAULT nextval('"TI_BNU-BCULT_C_20130617_01_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "TI_BNU-ZURB_C_20130617_02" ALTER COLUMN fid SET DEFAULT nextval('"TI_BNU-ZURB_C_20130617_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "TI_BU-ACOMM_C_20130617_02" ALTER COLUMN fid SET DEFAULT nextval('"TI_BU-ACOMM_C_20130617_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "TI_BU-ASAN_C_20130617_02" ALTER COLUMN fid SET DEFAULT nextval('"TI_BU-ASAN_C_20130617_02_fid_seq"'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY "TI_BU-ASCOL_C_20130617_02" ALTER COLUMN fid SET DEFAULT nextval('"TI_BU-ASCOL_C_20130617_02_fid_seq"'::regclass);


--
-- Name: gid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY regioni ALTER COLUMN gid SET DEFAULT nextval('regioni_gid_seq'::regclass);


--
-- Name: fid; Type: DEFAULT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_geo_ln_arcotest_1 ALTER COLUMN fid SET DEFAULT nextval('siig_geo_ln_arcotest_1_fid_seq'::regclass);


--
-- Name: AO_BNU-AAGR_C_20130730_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "AO_BNU-AAGR_C_20130730_02"
    ADD CONSTRAINT "AO_BNU-AAGR_C_20130730_02_pkey" PRIMARY KEY (fid);


--
-- Name: AO_BNU-ABOSC_C_20130730_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "AO_BNU-ABOSC_C_20130730_02"
    ADD CONSTRAINT "AO_BNU-ABOSC_C_20130730_02_pkey" PRIMARY KEY (fid);


--
-- Name: AO_BNU-APROT_C_20130822_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "AO_BNU-APROT_C_20130822_02"
    ADD CONSTRAINT "AO_BNU-APROT_C_20130822_02_pkey" PRIMARY KEY (fid);


--
-- Name: AO_BNU-ASUP_C_20130821_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "AO_BNU-ASUP_C_20130821_02"
    ADD CONSTRAINT "AO_BNU-ASUP_C_20130821_02_pkey" PRIMARY KEY (fid);


--
-- Name: AO_BU-ACOMM_C_20130822_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "AO_BU-ACOMM_C_20130822_02"
    ADD CONSTRAINT "AO_BU-ACOMM_C_20130822_02_pkey" PRIMARY KEY (fid);


--
-- Name: AO_BU-ASAN_C_20130909_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "AO_BU-ASAN_C_20130909_02"
    ADD CONSTRAINT "AO_BU-ASAN_C_20130909_02_pkey" PRIMARY KEY (fid);


--
-- Name: AO_C_Grafo_20130704_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "AO_C_Grafo_20130704"
    ADD CONSTRAINT "AO_C_Grafo_20130704_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BNU-AAGR_C_20130904_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BNU-AAGR_C_20130904_02"
    ADD CONSTRAINT "BZ_BNU-AAGR_C_20130904_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BNU-ABOSC_C_20130904_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BNU-ABOSC_C_20130904_02"
    ADD CONSTRAINT "BZ_BNU-ABOSC_C_20130904_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BNU-APROT_C_20130906_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BNU-APROT_C_20130906_02"
    ADD CONSTRAINT "BZ_BNU-APROT_C_20130906_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BNU-ASOTT_C_20130521_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BNU-ASOTT_C_20130521_01"
    ADD CONSTRAINT "BZ_BNU-ASOTT_C_20130521_01_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BNU-ASOTT_C_20130521_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BNU-ASOTT_C_20130521_02"
    ADD CONSTRAINT "BZ_BNU-ASOTT_C_20130521_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BNU-ASUP_C_20130904_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BNU-ASUP_C_20130904_02"
    ADD CONSTRAINT "BZ_BNU-ASUP_C_20130904_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BNU-BCULT_C_20130524_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BNU-BCULT_C_20130524_02"
    ADD CONSTRAINT "BZ_BNU-BCULT_C_20130524_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BNU-ZURB_C_20130904_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BNU-ZURB_C_20130904_02"
    ADD CONSTRAINT "BZ_BNU-ZURB_C_20130904_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-ACOMM_C_20130906_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-ACOMM_C_20130906_02"
    ADD CONSTRAINT "BZ_BU-ACOMM_C_20130906_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-AIND_C_20130903_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-AIND_C_20130903_01"
    ADD CONSTRAINT "BZ_BU-AIND_C_20130903_01_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-AIND_C_20130903_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-AIND_C_20130903_02"
    ADD CONSTRAINT "BZ_BU-AIND_C_20130903_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-ASAN_C_20130606_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-ASAN_C_20130606_01"
    ADD CONSTRAINT "BZ_BU-ASAN_C_20130606_01_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-ASAN_C_20130606_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-ASAN_C_20130606_02"
    ADD CONSTRAINT "BZ_BU-ASAN_C_20130606_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-ASCOL_C_20130531_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-ASCOL_C_20130531_01"
    ADD CONSTRAINT "BZ_BU-ASCOL_C_20130531_01_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-ASCOL_C_20130531_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-ASCOL_C_20130531_02"
    ADD CONSTRAINT "BZ_BU-ASCOL_C_20130531_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-PRES_C_20130903_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-PRES_C_20130903_01"
    ADD CONSTRAINT "BZ_BU-PRES_C_20130903_01_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-PRES_C_20130903_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-PRES_C_20130903_02"
    ADD CONSTRAINT "BZ_BU-PRES_C_20130903_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_BU-PTUR_C_20130604_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_BU-PTUR_C_20130604_02"
    ADD CONSTRAINT "BZ_BU-PTUR_C_20130604_02_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_C_Grafo_20130807_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_C_Grafo_20130807"
    ADD CONSTRAINT "BZ_C_Grafo_20130807_pkey" PRIMARY KEY (fid);


--
-- Name: BZ_C_Grafo_20130917_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "BZ_C_Grafo_20130917"
    ADD CONSTRAINT "BZ_C_Grafo_20130917_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BNU-AAGR_C_20130909_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BNU-AAGR_C_20130909_02"
    ADD CONSTRAINT "RL_BNU-AAGR_C_20130909_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BNU-ABOSC_C_20130909_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BNU-ABOSC_C_20130909_02"
    ADD CONSTRAINT "RL_BNU-ABOSC_C_20130909_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BNU-APROT_C_20130909_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BNU-APROT_C_20130909_02"
    ADD CONSTRAINT "RL_BNU-APROT_C_20130909_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BNU-ASOTT_C_20130716_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BNU-ASOTT_C_20130716_02"
    ADD CONSTRAINT "RL_BNU-ASOTT_C_20130716_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BNU-ASUP_C_20130909_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BNU-ASUP_C_20130909_02"
    ADD CONSTRAINT "RL_BNU-ASUP_C_20130909_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BNU-BCULT_C_20130909_1_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BNU-BCULT_C_20130909_01"
    ADD CONSTRAINT "RL_BNU-BCULT_C_20130909_1_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BNU-ZURB_C_20130909_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BNU-ZURB_C_20130909_02"
    ADD CONSTRAINT "RL_BNU-ZURB_C_20130909_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BU-ACOMM_C_20130909_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BU-ACOMM_C_20130909_02"
    ADD CONSTRAINT "RL_BU-ACOMM_C_20130909_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BU-AIND_C_20130624_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BU-AIND_C_20130624_02"
    ADD CONSTRAINT "RL_BU-AIND_C_20130624_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BU-ASAN_C_20130909_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BU-ASAN_C_20130909_02"
    ADD CONSTRAINT "RL_BU-ASAN_C_20130909_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_BU-PRES_C_20130624_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_BU-PRES_C_20130624_02"
    ADD CONSTRAINT "RL_BU-PRES_C_20130624_02_pkey" PRIMARY KEY (fid);


--
-- Name: RL_C_Grafo_20130918_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RL_C_Grafo_20130918"
    ADD CONSTRAINT "RL_C_Grafo_20130918_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BNU-AAGR_20121217_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BNU-AAGR_20121217_02"
    ADD CONSTRAINT "RP_BNU-AAGR_20121217_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BNU-ABOSC_20121217_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BNU-ABOSC_20121217_02"
    ADD CONSTRAINT "RP_BNU-ABOSC_20121217_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BNU-APROT_20130424_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BNU-APROT_20130424_02"
    ADD CONSTRAINT "RP_BNU-APROT_20130424_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BNU-ASOTT_20130424_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BNU-ASOTT_20130424_01"
    ADD CONSTRAINT "RP_BNU-ASOTT_20130424_01_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BNU-ASUP_20130424_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BNU-ASUP_20130424_02"
    ADD CONSTRAINT "RP_BNU-ASUP_20130424_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BNU-BCULT_20130424_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BNU-BCULT_20130424_01"
    ADD CONSTRAINT "RP_BNU-BCULT_20130424_01_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BNU-BCULT_20130424_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BNU-BCULT_20130424_02"
    ADD CONSTRAINT "RP_BNU-BCULT_20130424_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BNU-ZURB_20121207_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BNU-ZURB_20121207_02"
    ADD CONSTRAINT "RP_BNU-ZURB_20121207_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BU-ACOMM_20130424_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BU-ACOMM_20130424_02"
    ADD CONSTRAINT "RP_BU-ACOMM_20130424_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BU-AIND_20130424_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BU-AIND_20130424_01"
    ADD CONSTRAINT "RP_BU-AIND_20130424_01_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BU-ASAN_20130424_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BU-ASAN_20130424_02"
    ADD CONSTRAINT "RP_BU-ASAN_20130424_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BU-ASCOL_20130424_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BU-ASCOL_20130424_01"
    ADD CONSTRAINT "RP_BU-ASCOL_20130424_01_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BU-ASCOL_20130424_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BU-ASCOL_20130424_02"
    ADD CONSTRAINT "RP_BU-ASCOL_20130424_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BU-PRES_20121217_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BU-PRES_20121217_02"
    ADD CONSTRAINT "RP_BU-PRES_20121217_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_BU-PTUR_20120122_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_BU-PTUR_20120122_02"
    ADD CONSTRAINT "RP_BU-PTUR_20120122_02_pkey" PRIMARY KEY (fid);


--
-- Name: RP_C_Grafo_20130424_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "RP_C_Grafo_20130424"
    ADD CONSTRAINT "RP_C_Grafo_20130424_pkey" PRIMARY KEY (fid);


--
-- Name: TI_BNU-ASOTT_C_20130617_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "TI_BNU-ASOTT_C_20130617_01"
    ADD CONSTRAINT "TI_BNU-ASOTT_C_20130617_01_pkey" PRIMARY KEY (fid);


--
-- Name: TI_BNU-BCULT_C_20130617_01_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "TI_BNU-BCULT_C_20130617_01"
    ADD CONSTRAINT "TI_BNU-BCULT_C_20130617_01_pkey" PRIMARY KEY (fid);


--
-- Name: TI_BNU-ZURB_C_20130617_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "TI_BNU-ZURB_C_20130617_02"
    ADD CONSTRAINT "TI_BNU-ZURB_C_20130617_02_pkey" PRIMARY KEY (fid);


--
-- Name: TI_BU-ACOMM_C_20130617_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "TI_BU-ACOMM_C_20130617_02"
    ADD CONSTRAINT "TI_BU-ACOMM_C_20130617_02_pkey" PRIMARY KEY (fid);


--
-- Name: TI_BU-ASAN_C_20130617_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "TI_BU-ASAN_C_20130617_02"
    ADD CONSTRAINT "TI_BU-ASAN_C_20130617_02_pkey" PRIMARY KEY (fid);


--
-- Name: TI_BU-ASCOL_C_20130617_02_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY "TI_BU-ASCOL_C_20130617_02"
    ADD CONSTRAINT "TI_BU-ASCOL_C_20130617_02_pkey" PRIMARY KEY (fid);


--
-- Name: pk_siig_d_ateco; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_ateco
    ADD CONSTRAINT pk_siig_d_ateco PRIMARY KEY (id_ateco);


--
-- Name: pk_siig_d_bene_culturale; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_bene_culturale
    ADD CONSTRAINT pk_siig_d_bene_culturale PRIMARY KEY (id_tipo_bene);


--
-- Name: pk_siig_d_classe_adr; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_classe_adr
    ADD CONSTRAINT pk_siig_d_classe_adr PRIMARY KEY (id_classe_adr);


--
-- Name: pk_siig_d_classe_clc; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_classe_clc
    ADD CONSTRAINT pk_siig_d_classe_clc PRIMARY KEY (id_classe_clc);


--
-- Name: pk_siig_d_dissesto; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_dissesto
    ADD CONSTRAINT pk_siig_d_dissesto PRIMARY KEY (id_dissesto);


--
-- Name: pk_siig_d_distanza; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_distanza
    ADD CONSTRAINT pk_siig_d_distanza PRIMARY KEY (id_distanza);


--
-- Name: pk_siig_d_gravita; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_gravita
    ADD CONSTRAINT pk_siig_d_gravita PRIMARY KEY (id_gravita);


--
-- Name: pk_siig_d_iucn; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_iucn
    ADD CONSTRAINT pk_siig_d_iucn PRIMARY KEY (id_iucn);


--
-- Name: pk_siig_d_partner; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_partner
    ADD CONSTRAINT pk_siig_d_partner PRIMARY KEY (id_partner);


--
-- Name: pk_siig_d_stato_fisico; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_stato_fisico
    ADD CONSTRAINT pk_siig_d_stato_fisico PRIMARY KEY (id_stato_fisico);


--
-- Name: pk_siig_d_tipo_captazione; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_tipo_captazione
    ADD CONSTRAINT pk_siig_d_tipo_captazione PRIMARY KEY (id_tipo_captazione);


--
-- Name: pk_siig_d_tipo_contenitore; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_tipo_contenitore
    ADD CONSTRAINT pk_siig_d_tipo_contenitore PRIMARY KEY (id_tipo_contenitore);


--
-- Name: pk_siig_d_tipo_trasporto; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_tipo_trasporto
    ADD CONSTRAINT pk_siig_d_tipo_trasporto PRIMARY KEY (id_tipo_trasporto);


--
-- Name: pk_siig_d_tipo_uso; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_tipo_uso
    ADD CONSTRAINT pk_siig_d_tipo_uso PRIMARY KEY (id_tipo_uso);


--
-- Name: pk_siig_d_tipo_variabile; Type: CONSTRAINT; Schema: siig_p; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY siig_d_tipo_variabile
    ADD CONSTRAINT pk_siig_d_tipo_variabile PRIMARY KEY (id_tipo_variabile);


--
-- Name: pk_siig_d_tipo_veicolo; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_tipo_veicolo
    ADD CONSTRAINT pk_siig_d_tipo_veicolo PRIMARY KEY (id_tipo_veicolo);


--
-- Name: pk_siig_d_tipologia_danno; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_d_tipologia_danno
    ADD CONSTRAINT pk_siig_d_tipologia_danno PRIMARY KEY (id_tipologia_danno);


--
-- Name: pk_siig_geo_bers_calcrischio_p; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_bers_calcrischio_pl
    ADD CONSTRAINT pk_siig_geo_bers_calcrischio_p PRIMARY KEY (idgeo);


--
-- Name: pk_siig_geo_bers_non_umano_ln; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_bers_non_umano_ln
    ADD CONSTRAINT pk_siig_geo_bers_non_umano_ln PRIMARY KEY (idgeo_bers_non_umano_ln);


--
-- Name: pk_siig_geo_bers_non_umano_pl; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_bers_non_umano_pl
    ADD CONSTRAINT pk_siig_geo_bers_non_umano_pl PRIMARY KEY (idgeo_bers_non_umano_pl);


--
-- Name: pk_siig_geo_bers_non_umano_pt; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_bers_non_umano_pt
    ADD CONSTRAINT pk_siig_geo_bers_non_umano_pt PRIMARY KEY (idgeo_bers_non_umano_pt);


--
-- Name: pk_siig_geo_bersaglio_umano_pl; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_bersaglio_umano_pl
    ADD CONSTRAINT pk_siig_geo_bersaglio_umano_pl PRIMARY KEY (idgeo_bersaglio_umano_pl);


--
-- Name: pk_siig_geo_bersaglio_umano_pt; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_bersaglio_umano_pt
    ADD CONSTRAINT pk_siig_geo_bersaglio_umano_pt PRIMARY KEY (idgeo_bersaglio_umano_pt);


--
-- Name: pk_siig_geo_ln_arco_1; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_ln_arco_1
    ADD CONSTRAINT pk_siig_geo_ln_arco_1 PRIMARY KEY (id_geo_arco);


--
-- Name: pk_siig_geo_ln_arco_2; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_ln_arco_2
    ADD CONSTRAINT pk_siig_geo_ln_arco_2 PRIMARY KEY (id_geo_arco);


--
-- Name: pk_siig_geo_ln_arco_3; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_ln_arco_3
    ADD CONSTRAINT pk_siig_geo_ln_arco_3 PRIMARY KEY (id_geo_arco);


--
-- Name: pk_siig_mtd_d_arco; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_d_arco
    ADD CONSTRAINT pk_siig_mtd_d_arco PRIMARY KEY (id_arco);


--
-- Name: pk_siig_mtd_d_criterio_filtro; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_d_criterio_filtro
    ADD CONSTRAINT pk_siig_mtd_d_criterio_filtro PRIMARY KEY (id_criterio);


--
-- Name: pk_siig_mtd_d_elaborazione; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_d_elaborazione
    ADD CONSTRAINT pk_siig_mtd_d_elaborazione PRIMARY KEY (id_elaborazione);


--
-- Name: pk_siig_mtd_r_formula_criterio; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_r_formula_criterio
    ADD CONSTRAINT pk_siig_mtd_r_formula_criterio PRIMARY KEY (id_criterio, id_formula);


--
-- Name: pk_siig_mtd_r_formula_elab; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_r_formula_elab
    ADD CONSTRAINT pk_siig_mtd_r_formula_elab PRIMARY KEY (id_elaborazione, id_formula);


--
-- Name: pk_siig_mtd_r_formula_formula; Type: CONSTRAINT; Schema: siig_p; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_r_formula_formula
    ADD CONSTRAINT pk_siig_mtd_r_formula_formula PRIMARY KEY (id_formula, id_formula_figlio);


--
-- Name: pk_siig_mtd_r_formula_parametr; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_r_formula_parametro
    ADD CONSTRAINT pk_siig_mtd_r_formula_parametr PRIMARY KEY (id_formula, id_parametro);


--
-- Name: pk_siig_mtd_r_param_bers_arco; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_r_param_bers_arco
    ADD CONSTRAINT pk_siig_mtd_r_param_bers_arco PRIMARY KEY (id_parametro, id_arco, id_bersaglio);


--
-- Name: pk_siig_mtd_t_bersaglio; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_t_bersaglio
    ADD CONSTRAINT pk_siig_mtd_t_bersaglio PRIMARY KEY (id_bersaglio);


--
-- Name: pk_siig_mtd_t_formula; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_t_formula
    ADD CONSTRAINT pk_siig_mtd_t_formula PRIMARY KEY (id_formula);


--
-- Name: pk_siig_mtd_t_parametro; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_mtd_t_parametro
    ADD CONSTRAINT pk_siig_mtd_t_parametro PRIMARY KEY (id_parametro);


--
-- Name: pk_siig_r_arco_1_dissesto; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_arco_1_dissesto
    ADD CONSTRAINT pk_siig_r_arco_1_dissesto PRIMARY KEY (id_geo_arco, id_dissesto);


--
-- Name: pk_siig_r_arco_1_scen_tipobers; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_arco_1_scen_tipobers
    ADD CONSTRAINT pk_siig_r_arco_1_scen_tipobers PRIMARY KEY (id_geo_arco, id_bersaglio);


--
-- Name: pk_siig_r_arco_1_sostanza; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_arco_1_sostanza
    ADD CONSTRAINT pk_siig_r_arco_1_sostanza PRIMARY KEY (id_geo_arco, id_sostanza);


--
-- Name: pk_siig_r_arco_2_dissesto; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_arco_2_dissesto
    ADD CONSTRAINT pk_siig_r_arco_2_dissesto PRIMARY KEY (id_dissesto, id_geo_arco);


--
-- Name: pk_siig_r_arco_2_scen_tipobers; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_arco_2_scen_tipobers
    ADD CONSTRAINT pk_siig_r_arco_2_scen_tipobers PRIMARY KEY (id_geo_arco, id_bersaglio);


--
-- Name: pk_siig_r_arco_2_sostanza; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_arco_2_sostanza
    ADD CONSTRAINT pk_siig_r_arco_2_sostanza PRIMARY KEY (id_geo_arco, id_sostanza);


--
-- Name: pk_siig_r_arco_3_dissesto; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_arco_3_dissesto
    ADD CONSTRAINT pk_siig_r_arco_3_dissesto PRIMARY KEY (id_dissesto, id_geo_arco);


--
-- Name: pk_siig_r_arco_3_scen_tipobers; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_arco_3_scen_tipobers
    ADD CONSTRAINT pk_siig_r_arco_3_scen_tipobers PRIMARY KEY (id_geo_arco, id_bersaglio);


--
-- Name: pk_siig_r_arco_3_sostanza; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_arco_3_sostanza
    ADD CONSTRAINT pk_siig_r_arco_3_sostanza PRIMARY KEY (id_geo_arco, id_sostanza);


--
-- Name: pk_siig_r_area_danno; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_area_danno
    ADD CONSTRAINT pk_siig_r_area_danno PRIMARY KEY (id_gravita, id_scenario, id_bersaglio, id_sostanza, flg_lieve);


--
-- Name: pk_siig_r_scen_vuln_1; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_scen_vuln_1
    ADD CONSTRAINT pk_siig_r_scen_vuln_1 PRIMARY KEY (id_scenario, id_geo_arco, id_distanza);


--
-- Name: pk_siig_r_scen_vuln_2; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_scen_vuln_2
    ADD CONSTRAINT pk_siig_r_scen_vuln_2 PRIMARY KEY (id_scenario, id_geo_arco, id_distanza);


--
-- Name: pk_siig_r_scen_vuln_3; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_scen_vuln_3
    ADD CONSTRAINT pk_siig_r_scen_vuln_3 PRIMARY KEY (id_scenario, id_geo_arco, id_distanza);


--
-- Name: pk_siig_r_scenario_gravita; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_scenario_gravita
    ADD CONSTRAINT pk_siig_r_scenario_gravita PRIMARY KEY (id_scenario, id_bersaglio, id_gravita);


--
-- Name: pk_siig_r_scenario_sostanza; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_scenario_sostanza
    ADD CONSTRAINT pk_siig_r_scenario_sostanza PRIMARY KEY (id_scenario, id_sostanza, flg_lieve);


--
-- Name: pk_siig_r_tipovei_geoarco1; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_tipovei_geoarco1
    ADD CONSTRAINT pk_siig_r_tipovei_geoarco1 PRIMARY KEY (id_tipo_veicolo, id_geo_arco);


--
-- Name: pk_siig_r_tipovei_geoarco2; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_tipovei_geoarco2
    ADD CONSTRAINT pk_siig_r_tipovei_geoarco2 PRIMARY KEY (id_tipo_veicolo, id_geo_arco);


--
-- Name: pk_siig_r_tipovei_geoarco3; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_r_tipovei_geoarco3
    ADD CONSTRAINT pk_siig_r_tipovei_geoarco3 PRIMARY KEY (id_tipo_veicolo, id_geo_arco);


--
-- Name: pk_siig_t_bersaglio; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_bersaglio
    ADD CONSTRAINT pk_siig_t_bersaglio PRIMARY KEY (id_bersaglio);


--
-- Name: pk_siig_t_bersaglio_non_umano; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT pk_siig_t_bersaglio_non_umano PRIMARY KEY (id_tematico, id_bersaglio, id_partner);


--
-- Name: pk_siig_t_bersaglio_umano; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_bersaglio_umano
    ADD CONSTRAINT pk_siig_t_bersaglio_umano PRIMARY KEY (id_tematico, id_bersaglio, id_partner);


--
-- Name: pk_siig_t_elab_standard_1; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_elab_standard_1
    ADD CONSTRAINT pk_siig_t_elab_standard_1 PRIMARY KEY (flg_lieve, id_geo_arco, id_distanza, id_scenario, id_sostanza);


--
-- Name: pk_siig_t_elab_standard_2; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_elab_standard_2
    ADD CONSTRAINT pk_siig_t_elab_standard_2 PRIMARY KEY (flg_lieve, id_geo_arco, id_scenario, id_sostanza, id_distanza);


--
-- Name: pk_siig_t_elab_standard_3; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_elab_standard_3
    ADD CONSTRAINT pk_siig_t_elab_standard_3 PRIMARY KEY (flg_lieve, id_geo_arco, id_scenario, id_sostanza, id_distanza);


--
-- Name: pk_siig_t_log; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_log
    ADD CONSTRAINT pk_siig_t_log PRIMARY KEY (id_tracciamento, progressivo);


--
-- Name: pk_siig_t_processo; Type: CONSTRAINT; Schema: siig_p; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY siig_t_processo
    ADD CONSTRAINT pk_siig_t_processo PRIMARY KEY (id_processo);


--
-- Name: pk_siig_t_scenario; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_scenario
    ADD CONSTRAINT pk_siig_t_scenario PRIMARY KEY (id_scenario);


--
-- Name: pk_siig_t_sostanza; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_sostanza
    ADD CONSTRAINT pk_siig_t_sostanza PRIMARY KEY (id_sostanza);


--
-- Name: pk_siig_t_tracciamento; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_tracciamento
    ADD CONSTRAINT pk_siig_t_tracciamento PRIMARY KEY (id_tracciamento);


--
-- Name: pk_siig_t_variabile; Type: CONSTRAINT; Schema: siig_p; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY siig_t_variabile
    ADD CONSTRAINT pk_siig_t_variabile PRIMARY KEY (id_variabile);


--
-- Name: pk_siig_t_vulnerabilita_1; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_vulnerabilita_1
    ADD CONSTRAINT pk_siig_t_vulnerabilita_1 PRIMARY KEY (id_geo_arco, id_distanza);


--
-- Name: pk_siig_t_vulnerabilita_2; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_vulnerabilita_2
    ADD CONSTRAINT pk_siig_t_vulnerabilita_2 PRIMARY KEY (id_geo_arco, id_distanza);


--
-- Name: pk_siig_t_vulnerabilita_3; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_t_vulnerabilita_3
    ADD CONSTRAINT pk_siig_t_vulnerabilita_3 PRIMARY KEY (id_geo_arco, id_distanza);


--
-- Name: regioni_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY regioni
    ADD CONSTRAINT regioni_pkey PRIMARY KEY (gid);


--
-- Name: siig_geo_griid_pk; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_grid
    ADD CONSTRAINT siig_geo_griid_pk PRIMARY KEY (gid);


--
-- Name: siig_geo_ln_arcotest_1_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_ln_arcotest_1
    ADD CONSTRAINT siig_geo_ln_arcotest_1_pkey PRIMARY KEY (fid);


--
-- Name: siig_geo_pl_arco_3_pkey; Type: CONSTRAINT; Schema: siig_p; Owner: siig_p; Tablespace: 
--

ALTER TABLE ONLY siig_geo_pl_arco_3
    ADD CONSTRAINT siig_geo_pl_arco_3_pkey PRIMARY KEY (id_geo_arco);


--
-- Name: idx_bers_non_umano_geo_ln; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_bers_non_umano_geo_ln ON siig_t_bersaglio_non_umano USING btree (fk_bers_non_umano_ln);


--
-- Name: idx_bers_non_umano_geo_pl; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_bers_non_umano_geo_pl ON siig_t_bersaglio_non_umano USING btree (fk_bers_non_umano_pl);


--
-- Name: idx_bers_non_umano_geo_pt; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_bers_non_umano_geo_pt ON siig_t_bersaglio_non_umano USING btree (fk_bers_non_umano_pt);


--
-- Name: idx_bers_umano_geo_pl; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_bers_umano_geo_pl ON siig_t_bersaglio_umano USING btree (fk_bersaglio_umano_pl);


--
-- Name: idx_bers_umano_geo_pt; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_bers_umano_geo_pt ON siig_t_bersaglio_umano USING btree (fk_bersaglio_umano_pt);


--
-- Name: idx_bersaglio_non_umano_bersaglio_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_bersaglio_non_umano_bersaglio_partner ON siig_t_bersaglio_non_umano USING btree (id_bersaglio, id_partner);


--
-- Name: idx_bersaglio_umano_bersaglio_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_bersaglio_umano_bersaglio_partner ON siig_t_bersaglio_umano USING btree (id_bersaglio, id_partner);


--
-- Name: idx_dissesto_1_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_dissesto_1_partner ON siig_r_arco_1_dissesto USING btree (fk_partner);


--
-- Name: idx_dissesto_2_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_dissesto_2_partner ON siig_r_arco_2_dissesto USING btree (fk_partner);


--
-- Name: idx_dissesto_3_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_dissesto_3_partner ON siig_r_arco_3_dissesto USING btree (fk_partner);


--
-- Name: idx_dissesto_geo_arco_1; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_dissesto_geo_arco_1 ON siig_r_arco_1_dissesto USING btree (id_geo_arco);


--
-- Name: idx_dissesto_geo_arco_2; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_dissesto_geo_arco_2 ON siig_r_arco_2_dissesto USING btree (id_geo_arco);


--
-- Name: idx_dissesto_geo_arco_3; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_dissesto_geo_arco_3 ON siig_r_arco_3_dissesto USING btree (id_geo_arco);


--
-- Name: idx_geo_arco_1_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_geo_arco_1_partner ON siig_geo_ln_arco_1 USING btree (fk_partner);


--
-- Name: idx_geo_arco_1_tipovei_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_geo_arco_1_tipovei_partner ON siig_r_tipovei_geoarco1 USING btree (fk_partner);


--
-- Name: idx_geo_arco_2_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_geo_arco_2_partner ON siig_geo_ln_arco_2 USING btree (fk_partner);


--
-- Name: idx_geo_arco_2_tipovei_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_geo_arco_2_tipovei_partner ON siig_r_tipovei_geoarco2 USING btree (fk_partner);


--
-- Name: idx_geo_arco_3_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_geo_arco_3_partner ON siig_geo_ln_arco_3 USING btree (fk_partner);


--
-- Name: idx_geo_arco_3_tipovei_partner; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_geo_arco_3_tipovei_partner ON siig_r_tipovei_geoarco3 USING btree (fk_partner);


--
-- Name: idx_tipovei_geo_arco_1; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_tipovei_geo_arco_1 ON siig_r_tipovei_geoarco1 USING btree (id_geo_arco);


--
-- Name: idx_tipovei_geo_arco_2; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_tipovei_geo_arco_2 ON siig_r_tipovei_geoarco2 USING btree (id_geo_arco);


--
-- Name: idx_tipovei_geo_arco_3; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX idx_tipovei_geo_arco_3 ON siig_r_tipovei_geoarco3 USING btree (id_geo_arco);


--
-- Name: regioni_geom_gist; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX regioni_geom_gist ON regioni USING gist (geom);


--
-- Name: siig_geo_bers_calcrischio_pl_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_bers_calcrischio_pl_gidx ON siig_geo_bers_calcrischio_pl USING gist (geometria);


--
-- Name: siig_geo_bers_non_umano_ln_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_bers_non_umano_ln_gidx ON siig_geo_bers_non_umano_ln USING gist (geometria);


--
-- Name: siig_geo_bers_non_umano_pl_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_bers_non_umano_pl_gidx ON siig_geo_bers_non_umano_pl USING gist (geometria);


--
-- Name: siig_geo_bers_non_umano_pt_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_bers_non_umano_pt_gidx ON siig_geo_bers_non_umano_pt USING gist (geometria);


--
-- Name: siig_geo_bersaglio_umano_pl_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_bersaglio_umano_pl_gidx ON siig_geo_bersaglio_umano_pl USING gist (geometria);


--
-- Name: siig_geo_bersaglio_umano_pt_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_bersaglio_umano_pt_gidx ON siig_geo_bersaglio_umano_pt USING gist (geometria);


--
-- Name: siig_geo_grid_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_grid_gidx ON siig_geo_grid USING gist (geometria);


--
-- Name: siig_geo_ln_arco_1_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_ln_arco_1_gidx ON siig_geo_ln_arco_1 USING gist (geometria);


--
-- Name: siig_geo_ln_arco_2_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_ln_arco_2_gidx ON siig_geo_ln_arco_2 USING gist (geometria);


--
-- Name: siig_geo_ln_arco_3_gidx; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX siig_geo_ln_arco_3_gidx ON siig_geo_ln_arco_3 USING gist (geometria);


--
-- Name: spatial_AO_BNU-AAGR_C_20130730_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_AO_BNU-AAGR_C_20130730_02_the_geom" ON "AO_BNU-AAGR_C_20130730_02" USING gist (the_geom);


--
-- Name: spatial_AO_BNU-ABOSC_C_20130730_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_AO_BNU-ABOSC_C_20130730_02_the_geom" ON "AO_BNU-ABOSC_C_20130730_02" USING gist (the_geom);


--
-- Name: spatial_AO_BNU-APROT_C_20130822_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_AO_BNU-APROT_C_20130822_02_the_geom" ON "AO_BNU-APROT_C_20130822_02" USING gist (the_geom);


--
-- Name: spatial_AO_BNU-ASUP_C_20130821_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_AO_BNU-ASUP_C_20130821_02_the_geom" ON "AO_BNU-ASUP_C_20130821_02" USING gist (the_geom);


--
-- Name: spatial_AO_BU-ACOMM_C_20130822_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_AO_BU-ACOMM_C_20130822_02_the_geom" ON "AO_BU-ACOMM_C_20130822_02" USING gist (the_geom);


--
-- Name: spatial_AO_BU-ASAN_C_20130909_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_AO_BU-ASAN_C_20130909_02_the_geom" ON "AO_BU-ASAN_C_20130909_02" USING gist (the_geom);


--
-- Name: spatial_AO_C_Grafo_20130704_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_AO_C_Grafo_20130704_the_geom" ON "AO_C_Grafo_20130704" USING gist (the_geom);


--
-- Name: spatial_BZ_BNU-AAGR_C_20130904_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BNU-AAGR_C_20130904_02_the_geom" ON "BZ_BNU-AAGR_C_20130904_02" USING gist (the_geom);


--
-- Name: spatial_BZ_BNU-ABOSC_C_20130904_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BNU-ABOSC_C_20130904_02_the_geom" ON "BZ_BNU-ABOSC_C_20130904_02" USING gist (the_geom);


--
-- Name: spatial_BZ_BNU-APROT_C_20130906_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BNU-APROT_C_20130906_02_the_geom" ON "BZ_BNU-APROT_C_20130906_02" USING gist (the_geom);


--
-- Name: spatial_BZ_BNU-ASOTT_C_20130521_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BNU-ASOTT_C_20130521_01_the_geom" ON "BZ_BNU-ASOTT_C_20130521_01" USING gist (the_geom);


--
-- Name: spatial_BZ_BNU-ASOTT_C_20130521_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BNU-ASOTT_C_20130521_02_the_geom" ON "BZ_BNU-ASOTT_C_20130521_02" USING gist (the_geom);


--
-- Name: spatial_BZ_BNU-ASUP_C_20130904_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BNU-ASUP_C_20130904_02_the_geom" ON "BZ_BNU-ASUP_C_20130904_02" USING gist (the_geom);


--
-- Name: spatial_BZ_BNU-BCULT_C_20130524_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BNU-BCULT_C_20130524_02_the_geom" ON "BZ_BNU-BCULT_C_20130524_02" USING gist (the_geom);


--
-- Name: spatial_BZ_BNU-ZURB_C_20130904_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BNU-ZURB_C_20130904_02_the_geom" ON "BZ_BNU-ZURB_C_20130904_02" USING gist (the_geom);


--
-- Name: spatial_BZ_BU-ACOMM_C_20130906_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BU-ACOMM_C_20130906_02_the_geom" ON "BZ_BU-ACOMM_C_20130906_02" USING gist (the_geom);


--
-- Name: spatial_BZ_BU-AIND_C_20130903_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BU-AIND_C_20130903_01_the_geom" ON "BZ_BU-AIND_C_20130903_01" USING gist (the_geom);


--
-- Name: spatial_BZ_BU-ASAN_C_20130606_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BU-ASAN_C_20130606_01_the_geom" ON "BZ_BU-ASAN_C_20130606_01" USING gist (the_geom);


--
-- Name: spatial_BZ_BU-ASCOL_C_20130531_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BU-ASCOL_C_20130531_01_the_geom" ON "BZ_BU-ASCOL_C_20130531_01" USING gist (the_geom);


--
-- Name: spatial_BZ_BU-PRES_C_20130903_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BU-PRES_C_20130903_01_the_geom" ON "BZ_BU-PRES_C_20130903_01" USING gist (the_geom);


--
-- Name: spatial_BZ_BU-PTUR_C_20130604_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_BU-PTUR_C_20130604_02_the_geom" ON "BZ_BU-PTUR_C_20130604_02" USING gist (the_geom);


--
-- Name: spatial_BZ_C_Grafo_20130807_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_C_Grafo_20130807_the_geom" ON "BZ_C_Grafo_20130807" USING gist (the_geom);


--
-- Name: spatial_BZ_C_Grafo_20130917_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_BZ_C_Grafo_20130917_the_geom" ON "BZ_C_Grafo_20130917" USING gist (the_geom);


--
-- Name: spatial_RL_BNU-AAGR_C_20130909_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BNU-AAGR_C_20130909_02_the_geom" ON "RL_BNU-AAGR_C_20130909_02" USING gist (the_geom);


--
-- Name: spatial_RL_BNU-ABOSC_C_20130909_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BNU-ABOSC_C_20130909_02_the_geom" ON "RL_BNU-ABOSC_C_20130909_02" USING gist (the_geom);


--
-- Name: spatial_RL_BNU-APROT_C_20130909_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BNU-APROT_C_20130909_02_the_geom" ON "RL_BNU-APROT_C_20130909_02" USING gist (the_geom);


--
-- Name: spatial_RL_BNU-ASOTT_C_20130716_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BNU-ASOTT_C_20130716_02_the_geom" ON "RL_BNU-ASOTT_C_20130716_02" USING gist (the_geom);


--
-- Name: spatial_RL_BNU-ASUP_C_20130909_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BNU-ASUP_C_20130909_02_the_geom" ON "RL_BNU-ASUP_C_20130909_02" USING gist (the_geom);


--
-- Name: spatial_RL_BNU-BCULT_C_20130909_1_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BNU-BCULT_C_20130909_1_the_geom" ON "RL_BNU-BCULT_C_20130909_01" USING gist (the_geom);


--
-- Name: spatial_RL_BNU-ZURB_C_20130909_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BNU-ZURB_C_20130909_02_the_geom" ON "RL_BNU-ZURB_C_20130909_02" USING gist (the_geom);


--
-- Name: spatial_RL_BU-ACOMM_C_20130909_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BU-ACOMM_C_20130909_02_the_geom" ON "RL_BU-ACOMM_C_20130909_02" USING gist (the_geom);


--
-- Name: spatial_RL_BU-AIND_C_20130624_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BU-AIND_C_20130624_02_the_geom" ON "RL_BU-AIND_C_20130624_02" USING gist (the_geom);


--
-- Name: spatial_RL_BU-ASAN_C_20130909_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BU-ASAN_C_20130909_02_the_geom" ON "RL_BU-ASAN_C_20130909_02" USING gist (the_geom);


--
-- Name: spatial_RL_BU-PRES_C_20130624_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_BU-PRES_C_20130624_02_the_geom" ON "RL_BU-PRES_C_20130624_02" USING gist (the_geom);


--
-- Name: spatial_RL_C_Grafo_20130918_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RL_C_Grafo_20130918_the_geom" ON "RL_C_Grafo_20130918" USING gist (the_geom);


--
-- Name: spatial_RP_BNU-AAGR_20121217_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BNU-AAGR_20121217_02_the_geom" ON "RP_BNU-AAGR_20121217_02" USING gist (the_geom);


--
-- Name: spatial_RP_BNU-ABOSC_20121217_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BNU-ABOSC_20121217_02_the_geom" ON "RP_BNU-ABOSC_20121217_02" USING gist (the_geom);


--
-- Name: spatial_RP_BNU-APROT_20130424_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BNU-APROT_20130424_02_the_geom" ON "RP_BNU-APROT_20130424_02" USING gist (the_geom);


--
-- Name: spatial_RP_BNU-ASOTT_20130424_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BNU-ASOTT_20130424_01_the_geom" ON "RP_BNU-ASOTT_20130424_01" USING gist (the_geom);


--
-- Name: spatial_RP_BNU-ASUP_20130424_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BNU-ASUP_20130424_02_the_geom" ON "RP_BNU-ASUP_20130424_02" USING gist (the_geom);


--
-- Name: spatial_RP_BNU-BCULT_20130424_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BNU-BCULT_20130424_01_the_geom" ON "RP_BNU-BCULT_20130424_01" USING gist (the_geom);


--
-- Name: spatial_RP_BNU-BCULT_20130424_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BNU-BCULT_20130424_02_the_geom" ON "RP_BNU-BCULT_20130424_02" USING gist (the_geom);


--
-- Name: spatial_RP_BNU-ZURB_20121207_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BNU-ZURB_20121207_02_the_geom" ON "RP_BNU-ZURB_20121207_02" USING gist (the_geom);


--
-- Name: spatial_RP_BU-ACOMM_20130424_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BU-ACOMM_20130424_02_the_geom" ON "RP_BU-ACOMM_20130424_02" USING gist (the_geom);


--
-- Name: spatial_RP_BU-AIND_20130424_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BU-AIND_20130424_01_the_geom" ON "RP_BU-AIND_20130424_01" USING gist (the_geom);


--
-- Name: spatial_RP_BU-ASAN_20130424_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BU-ASAN_20130424_02_the_geom" ON "RP_BU-ASAN_20130424_02" USING gist (the_geom);


--
-- Name: spatial_RP_BU-ASCOL_20130424_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BU-ASCOL_20130424_01_the_geom" ON "RP_BU-ASCOL_20130424_01" USING gist (the_geom);


--
-- Name: spatial_RP_BU-ASCOL_20130424_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BU-ASCOL_20130424_02_the_geom" ON "RP_BU-ASCOL_20130424_02" USING gist (the_geom);


--
-- Name: spatial_RP_BU-PRES_20121217_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BU-PRES_20121217_02_the_geom" ON "RP_BU-PRES_20121217_02" USING gist (the_geom);


--
-- Name: spatial_RP_BU-PTUR_20120122_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_BU-PTUR_20120122_02_the_geom" ON "RP_BU-PTUR_20120122_02" USING gist (the_geom);


--
-- Name: spatial_RP_C_Grafo_20130424_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_RP_C_Grafo_20130424_the_geom" ON "RP_C_Grafo_20130424" USING gist (the_geom);


--
-- Name: spatial_TI_BNU-ASOTT_C_20130617_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_TI_BNU-ASOTT_C_20130617_01_the_geom" ON "TI_BNU-ASOTT_C_20130617_01" USING gist (the_geom);


--
-- Name: spatial_TI_BNU-BCULT_C_20130617_01_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_TI_BNU-BCULT_C_20130617_01_the_geom" ON "TI_BNU-BCULT_C_20130617_01" USING gist (the_geom);


--
-- Name: spatial_TI_BNU-ZURB_C_20130617_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_TI_BNU-ZURB_C_20130617_02_the_geom" ON "TI_BNU-ZURB_C_20130617_02" USING gist (the_geom);


--
-- Name: spatial_TI_BU-ACOMM_C_20130617_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_TI_BU-ACOMM_C_20130617_02_the_geom" ON "TI_BU-ACOMM_C_20130617_02" USING gist (the_geom);


--
-- Name: spatial_TI_BU-ASAN_C_20130617_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_TI_BU-ASAN_C_20130617_02_the_geom" ON "TI_BU-ASAN_C_20130617_02" USING gist (the_geom);


--
-- Name: spatial_TI_BU-ASCOL_C_20130617_02_the_geom; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX "spatial_TI_BU-ASCOL_C_20130617_02_the_geom" ON "TI_BU-ASCOL_C_20130617_02" USING gist (the_geom);


--
-- Name: spatial_siig_geo_ln_arcotest_1_geometria; Type: INDEX; Schema: siig_p; Owner: siig_p; Tablespace: 
--

CREATE INDEX spatial_siig_geo_ln_arcotest_1_geometria ON siig_geo_ln_arcotest_1 USING gist (geometria);


--
-- Name: fk_siig_d_ateco_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_umano
    ADD CONSTRAINT fk_siig_d_ateco_01 FOREIGN KEY (fk_ateco) REFERENCES siig_d_ateco(id_ateco);


--
-- Name: fk_siig_d_bene_culturale_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT fk_siig_d_bene_culturale_01 FOREIGN KEY (fk_tipo_bene) REFERENCES siig_d_bene_culturale(id_tipo_bene);


--
-- Name: fk_siig_d_bersaglio_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_3_scen_tipobers
    ADD CONSTRAINT fk_siig_d_bersaglio_02 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio(id_bersaglio);


--
-- Name: fk_siig_d_bersaglio_04; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_1_scen_tipobers
    ADD CONSTRAINT fk_siig_d_bersaglio_04 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio(id_bersaglio);


--
-- Name: fk_siig_d_bersaglio_07; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_2_scen_tipobers
    ADD CONSTRAINT fk_siig_d_bersaglio_07 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio(id_bersaglio);


--
-- Name: fk_siig_d_classe_adr_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_sostanza
    ADD CONSTRAINT fk_siig_d_classe_adr_01 FOREIGN KEY (fk_classe_adr) REFERENCES siig_d_classe_adr(id_classe_adr);


--
-- Name: fk_siig_d_classe_clc_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT fk_siig_d_classe_clc_01 FOREIGN KEY (fk_classe_clc) REFERENCES siig_d_classe_clc(id_classe_clc);


--
-- Name: fk_siig_d_dissesto_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_1_dissesto
    ADD CONSTRAINT fk_siig_d_dissesto_01 FOREIGN KEY (id_dissesto) REFERENCES siig_d_dissesto(id_dissesto);


--
-- Name: fk_siig_d_dissesto_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_3_dissesto
    ADD CONSTRAINT fk_siig_d_dissesto_02 FOREIGN KEY (id_dissesto) REFERENCES siig_d_dissesto(id_dissesto);


--
-- Name: fk_siig_d_dissesto_03; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_2_dissesto
    ADD CONSTRAINT fk_siig_d_dissesto_03 FOREIGN KEY (id_dissesto) REFERENCES siig_d_dissesto(id_dissesto);


--
-- Name: fk_siig_d_distanza_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_vulnerabilita_1
    ADD CONSTRAINT fk_siig_d_distanza_01 FOREIGN KEY (id_distanza) REFERENCES siig_d_distanza(id_distanza);


--
-- Name: fk_siig_d_distanza_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_area_danno
    ADD CONSTRAINT fk_siig_d_distanza_02 FOREIGN KEY (fk_distanza) REFERENCES siig_d_distanza(id_distanza);


--
-- Name: fk_siig_d_distanza_03; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_vulnerabilita_3
    ADD CONSTRAINT fk_siig_d_distanza_03 FOREIGN KEY (id_distanza) REFERENCES siig_d_distanza(id_distanza);


--
-- Name: fk_siig_d_distanza_04; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_vulnerabilita_2
    ADD CONSTRAINT fk_siig_d_distanza_04 FOREIGN KEY (id_distanza) REFERENCES siig_d_distanza(id_distanza);


--
-- Name: fk_siig_d_gravita_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scenario_gravita
    ADD CONSTRAINT fk_siig_d_gravita_01 FOREIGN KEY (id_gravita) REFERENCES siig_d_gravita(id_gravita);


--
-- Name: fk_siig_d_gravita_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_area_danno
    ADD CONSTRAINT fk_siig_d_gravita_02 FOREIGN KEY (id_gravita) REFERENCES siig_d_gravita(id_gravita);


--
-- Name: fk_siig_d_iucn_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT fk_siig_d_iucn_01 FOREIGN KEY (fk_iucn) REFERENCES siig_d_iucn(id_iucn);


--
-- Name: fk_siig_d_partner_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_umano
    ADD CONSTRAINT fk_siig_d_partner_01 FOREIGN KEY (id_partner) REFERENCES siig_d_partner(id_partner);


--
-- Name: fk_siig_d_partner_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT fk_siig_d_partner_02 FOREIGN KEY (id_partner) REFERENCES siig_d_partner(id_partner);


--
-- Name: fk_siig_d_partner_03; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_tracciamento
    ADD CONSTRAINT fk_siig_d_partner_03 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner(id_partner);


--
-- Name: fk_siig_d_partner_04; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_geo_ln_arco_1
    ADD CONSTRAINT fk_siig_d_partner_04 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner(id_partner);


--
-- Name: fk_siig_d_partner_05; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_geo_ln_arco_2
    ADD CONSTRAINT fk_siig_d_partner_05 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner(id_partner);


--
-- Name: fk_siig_d_partner_06; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_geo_ln_arco_3
    ADD CONSTRAINT fk_siig_d_partner_06 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner(id_partner);


--
-- Name: fk_siig_d_partner_07; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_geo_pl_arco_3
    ADD CONSTRAINT fk_siig_d_partner_07 FOREIGN KEY (fk_partner) REFERENCES siig_d_partner(id_partner);


--
-- Name: fk_siig_d_stato_fisico_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_sostanza
    ADD CONSTRAINT fk_siig_d_stato_fisico_01 FOREIGN KEY (fk_stato_fisico) REFERENCES siig_d_stato_fisico(id_stato_fisico);


--
-- Name: fk_siig_d_tipo_captazione_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT fk_siig_d_tipo_captazione_01 FOREIGN KEY (fk_tipo_captazione) REFERENCES siig_d_tipo_captazione(id_tipo_captazione);


--
-- Name: fk_siig_d_tipo_contenitore_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_sostanza
    ADD CONSTRAINT fk_siig_d_tipo_contenitore_01 FOREIGN KEY (fk_tipo_contenitore) REFERENCES siig_d_tipo_contenitore(id_tipo_contenitore);


--
-- Name: fk_siig_d_tipo_trasporto_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_sostanza
    ADD CONSTRAINT fk_siig_d_tipo_trasporto_01 FOREIGN KEY (fk_tipo_trasporto) REFERENCES siig_d_tipo_trasporto(id_tipo_trasporto);


--
-- Name: fk_siig_d_tipo_uso_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_umano
    ADD CONSTRAINT fk_siig_d_tipo_uso_01 FOREIGN KEY (fk_tipo_uso) REFERENCES siig_d_tipo_uso(id_tipo_uso);


--
-- Name: fk_siig_d_tipo_variabile_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: postgres
--

ALTER TABLE ONLY siig_t_variabile
    ADD CONSTRAINT fk_siig_d_tipo_variabile_01 FOREIGN KEY (fk_tipo_variabile) REFERENCES siig_d_tipo_variabile(id_tipo_variabile);


--
-- Name: fk_siig_d_tipo_veicolo_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_tipovei_geoarco1
    ADD CONSTRAINT fk_siig_d_tipo_veicolo_01 FOREIGN KEY (id_tipo_veicolo) REFERENCES siig_d_tipo_veicolo(id_tipo_veicolo);


--
-- Name: fk_siig_d_tipo_veicolo_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_tipovei_geoarco2
    ADD CONSTRAINT fk_siig_d_tipo_veicolo_02 FOREIGN KEY (id_tipo_veicolo) REFERENCES siig_d_tipo_veicolo(id_tipo_veicolo);


--
-- Name: fk_siig_d_tipo_veicolo_03; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_tipovei_geoarco3
    ADD CONSTRAINT fk_siig_d_tipo_veicolo_03 FOREIGN KEY (id_tipo_veicolo) REFERENCES siig_d_tipo_veicolo(id_tipo_veicolo);


--
-- Name: fk_siig_r_scenario_sost_04; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_area_danno
    ADD CONSTRAINT fk_siig_r_scenario_sost_04 FOREIGN KEY (id_scenario, id_sostanza, flg_lieve) REFERENCES siig_r_scenario_sostanza(id_scenario, id_sostanza, flg_lieve);


--
-- Name: fk_siig_t_bersaglio_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_umano
    ADD CONSTRAINT fk_siig_t_bersaglio_01 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio(id_bersaglio);


--
-- Name: fk_siig_t_bersaglio_08; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT fk_siig_t_bersaglio_08 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio(id_bersaglio);


--
-- Name: fk_siig_t_bersaglio_10; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_tracciamento
    ADD CONSTRAINT fk_siig_t_bersaglio_10 FOREIGN KEY (fk_bersaglio) REFERENCES siig_t_bersaglio(id_bersaglio);


--
-- Name: fk_siig_t_bersaglio_11; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scenario_gravita
    ADD CONSTRAINT fk_siig_t_bersaglio_11 FOREIGN KEY (id_bersaglio) REFERENCES siig_t_bersaglio(id_bersaglio);


--
-- Name: fk_siig_t_processo_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_tracciamento
    ADD CONSTRAINT fk_siig_t_processo_02 FOREIGN KEY (fk_processo) REFERENCES siig_t_processo(id_processo);


--
-- Name: fk_siig_t_scenario_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scenario_sostanza
    ADD CONSTRAINT fk_siig_t_scenario_01 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario(id_scenario);


--
-- Name: fk_siig_t_scenario_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scenario_gravita
    ADD CONSTRAINT fk_siig_t_scenario_02 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario(id_scenario);


--
-- Name: fk_siig_t_scenario_03; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scen_vuln_1
    ADD CONSTRAINT fk_siig_t_scenario_03 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario(id_scenario);


--
-- Name: fk_siig_t_scenario_04; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scen_vuln_2
    ADD CONSTRAINT fk_siig_t_scenario_04 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario(id_scenario);


--
-- Name: fk_siig_t_scenario_05; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scen_vuln_3
    ADD CONSTRAINT fk_siig_t_scenario_05 FOREIGN KEY (id_scenario) REFERENCES siig_t_scenario(id_scenario);


--
-- Name: fk_siig_t_sostanza_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scenario_sostanza
    ADD CONSTRAINT fk_siig_t_sostanza_01 FOREIGN KEY (id_sostanza) REFERENCES siig_t_sostanza(id_sostanza);


--
-- Name: fk_siig_t_sostanza_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_2_sostanza
    ADD CONSTRAINT fk_siig_t_sostanza_02 FOREIGN KEY (id_sostanza) REFERENCES siig_t_sostanza(id_sostanza);


--
-- Name: fk_siig_t_sostanza_03; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_3_sostanza
    ADD CONSTRAINT fk_siig_t_sostanza_03 FOREIGN KEY (id_sostanza) REFERENCES siig_t_sostanza(id_sostanza);


--
-- Name: fk_siig_t_sostanza_04; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_1_sostanza
    ADD CONSTRAINT fk_siig_t_sostanza_04 FOREIGN KEY (id_sostanza) REFERENCES siig_t_sostanza(id_sostanza);


--
-- Name: fk_siig_t_tracciamento_01; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_log
    ADD CONSTRAINT fk_siig_t_tracciamento_01 FOREIGN KEY (id_tracciamento) REFERENCES siig_t_tracciamento(id_tracciamento);


--
-- Name: fk_siig_t_vulnerabilita_1_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scen_vuln_1
    ADD CONSTRAINT fk_siig_t_vulnerabilita_1_02 FOREIGN KEY (id_geo_arco, id_distanza) REFERENCES siig_t_vulnerabilita_1(id_geo_arco, id_distanza);


--
-- Name: fk_siig_t_vulnerabilita_2_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scen_vuln_2
    ADD CONSTRAINT fk_siig_t_vulnerabilita_2_02 FOREIGN KEY (id_geo_arco, id_distanza) REFERENCES siig_t_vulnerabilita_2(id_geo_arco, id_distanza);


--
-- Name: fk_siig_t_vulnerabilita_3_02; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_scen_vuln_3
    ADD CONSTRAINT fk_siig_t_vulnerabilita_3_02 FOREIGN KEY (id_geo_arco, id_distanza) REFERENCES siig_t_vulnerabilita_3(id_geo_arco, id_distanza);


--
-- Name: siig_r_arco_1_dissesto_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_1_dissesto
    ADD CONSTRAINT siig_r_arco_1_dissesto_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_arco_1_scen_tipobers_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_1_scen_tipobers
    ADD CONSTRAINT siig_r_arco_1_scen_tipobers_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_arco_1_sostanza_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_1_sostanza
    ADD CONSTRAINT siig_r_arco_1_sostanza_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_arco_2_dissesto_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_2_dissesto
    ADD CONSTRAINT siig_r_arco_2_dissesto_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_arco_2_scen_tipobers_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_2_scen_tipobers
    ADD CONSTRAINT siig_r_arco_2_scen_tipobers_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_arco_2_sostanza_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_2_sostanza
    ADD CONSTRAINT siig_r_arco_2_sostanza_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_arco_3_dissesto_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_3_dissesto
    ADD CONSTRAINT siig_r_arco_3_dissesto_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_pl_arco_3(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_arco_3_scen_tipobers_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_3_scen_tipobers
    ADD CONSTRAINT siig_r_arco_3_scen_tipobers_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_pl_arco_3(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_arco_3_sostanza_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_arco_3_sostanza
    ADD CONSTRAINT siig_r_arco_3_sostanza_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_pl_arco_3(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_tipovei_geoarco1_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_tipovei_geoarco1
    ADD CONSTRAINT siig_r_tipovei_geoarco1_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_tipovei_geoarco2_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_tipovei_geoarco2
    ADD CONSTRAINT siig_r_tipovei_geoarco2_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_r_tipovei_geoarco3_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_r_tipovei_geoarco3
    ADD CONSTRAINT siig_r_tipovei_geoarco3_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_pl_arco_3(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_t_bersaglio_non_umano_fk_bers_non_umano_ln_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT siig_t_bersaglio_non_umano_fk_bers_non_umano_ln_fkey FOREIGN KEY (fk_bers_non_umano_ln) REFERENCES siig_geo_bers_non_umano_ln(idgeo_bers_non_umano_ln) ON DELETE SET NULL;


--
-- Name: siig_t_bersaglio_non_umano_fk_bers_non_umano_pl_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT siig_t_bersaglio_non_umano_fk_bers_non_umano_pl_fkey FOREIGN KEY (fk_bers_non_umano_pl) REFERENCES siig_geo_bers_non_umano_pl(idgeo_bers_non_umano_pl) ON DELETE SET NULL;


--
-- Name: siig_t_bersaglio_non_umano_fk_bers_non_umano_pt_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_non_umano
    ADD CONSTRAINT siig_t_bersaglio_non_umano_fk_bers_non_umano_pt_fkey FOREIGN KEY (fk_bers_non_umano_pt) REFERENCES siig_geo_bers_non_umano_pt(idgeo_bers_non_umano_pt) ON DELETE SET NULL;


--
-- Name: siig_t_bersaglio_umano_fk_bersaglio_umano_pl_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_umano
    ADD CONSTRAINT siig_t_bersaglio_umano_fk_bersaglio_umano_pl_fkey FOREIGN KEY (fk_bersaglio_umano_pl) REFERENCES siig_geo_bersaglio_umano_pl(idgeo_bersaglio_umano_pl) ON DELETE SET NULL;


--
-- Name: siig_t_bersaglio_umano_fk_bersaglio_umano_pt_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_bersaglio_umano
    ADD CONSTRAINT siig_t_bersaglio_umano_fk_bersaglio_umano_pt_fkey FOREIGN KEY (fk_bersaglio_umano_pt) REFERENCES siig_geo_bersaglio_umano_pt(idgeo_bersaglio_umano_pt) ON DELETE SET NULL;


--
-- Name: siig_t_elab_standard_1_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_elab_standard_1
    ADD CONSTRAINT siig_t_elab_standard_1_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_t_elab_standard_2_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_elab_standard_2
    ADD CONSTRAINT siig_t_elab_standard_2_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_t_elab_standard_3_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_elab_standard_3
    ADD CONSTRAINT siig_t_elab_standard_3_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_pl_arco_3(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_t_vulnerabilita_1_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_vulnerabilita_1
    ADD CONSTRAINT siig_t_vulnerabilita_1_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_1(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_t_vulnerabilita_2_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_vulnerabilita_2
    ADD CONSTRAINT siig_t_vulnerabilita_2_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_ln_arco_2(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_t_vulnerabilita_3_id_geo_arco_fkey; Type: FK CONSTRAINT; Schema: siig_p; Owner: siig_p
--

ALTER TABLE ONLY siig_t_vulnerabilita_3
    ADD CONSTRAINT siig_t_vulnerabilita_3_id_geo_arco_fkey FOREIGN KEY (id_geo_arco) REFERENCES siig_geo_pl_arco_3(id_geo_arco) ON DELETE CASCADE;


--
-- Name: siig_p; Type: ACL; Schema: -; Owner: siig_p
--

REVOKE ALL ON SCHEMA siig_p FROM PUBLIC;
REVOKE ALL ON SCHEMA siig_p FROM siig_p;
GRANT ALL ON SCHEMA siig_p TO siig_p;


--
-- PostgreSQL database dump complete
--

