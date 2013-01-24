SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;

CREATE TABLE "siig_p"."siig_p_bersagli_aree_agricole" (gid serial,
"id_tema" numeric(10,0),
"fk_clc" numeric(10,0),
"superficie" float8,
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_aree_agricole" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_aree_boscate" (gid serial,
"id_tema" numeric(10,0),
"fk_clc" numeric(10,0),
"superficie" float8,
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_aree_boscate" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_zone_urbanizzate" (gid serial,
"id_tema" numeric(10,0),
"fk_clc" numeric(10,0),
"superficie" float8,
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_zone_urbanizzate" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_aree_protette" (gid serial,
"id_tema" numeric(10,0),
"denom" varchar(250),
"denom_ente" varchar(250),
"fk_iucn" numeric(10,0),
"superficie" float8,
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_aree_protette" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_acque_superficiali_pl" (gid serial,
"id_tema" float8,
"denom" varchar(50),
"fk_clc" float8,
"toponimo" varchar(250),
"superficie" numeric,
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_acque_superficiali_pl" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_acque_superficiali_ln" (gid serial,
"id_tema" float8,
"denom" varchar(50),
"fk_clc" float8,
"toponimo" varchar(250),
"superficie" numeric,
"the_geom" geometry('MULTILINESTRING',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_acque_superficiali_ln" ADD PRIMARY KEY (gid);


        
CREATE TABLE "siig_p"."siig_p_bersagli_acque_sotterranee_pt" (gid serial,
"id_tipo" int4,
"denom" varchar(60),
"prof_max" float8,
"quota" int4,
"fk_tipo_cp" int4,
"superficie" numeric,
"the_geom" geometry('POINT',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_acque_sotterranee_pt" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_acque_sotterranee_pl" (gid serial,
"id_tipo" int4,
"denom" varchar(60),
"prof_max" float8,
"quota" int4,
"fk_tipo_cp" int4,
"superficie" numeric,
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_acque_sotterranee_pl" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_beni_culturali_pt" (gid serial,
"id_tema" int4,
"desc_" varchar(30),
"fk_bcult" int2,
"superficie" numeric,
"the_geom" geometry('POINT',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_beni_culturali_pt" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_beni_culturali_pl" (gid serial,
"id_tema" int4,
"desc_" varchar(30),
"fk_bcult" int2,
"superficie" numeric,
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_beni_culturali_pl" ADD PRIMARY KEY (gid);

COMMIT;