SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;

CREATE TABLE "siig_p"."siig_p_bersagli_popolazione_residente" (gid serial,
"id_tema" numeric,
"residenti" numeric,
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_popolazione_residente" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_popolazione_turistica" (gid serial,
"id_tema" int2,
"denom" varchar(30),
"nat_code" varchar(6),
"n_ptur_max" numeric,
"n_ptur_med" numeric,
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_popolazione_turistica" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_strutture_sanitarie" (gid serial,
"id_tema" int4,
"denom" varchar(64),
"fk_tipo_ss" int4,
"n_letti_or" numeric,
"flg_lt_or" varchar(1),
"n_letti_dh" numeric,
"flg_lt_dh" varchar(1),
"n_addetti" numeric,
"flg_n_add" varchar(1),
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_strutture_sanitarie" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_strutture_scolastiche_pt" (gid serial,
"id_tema" int4,
"denom" varchar(254),
"fk_gr_scol" int4,
"n_iscritti" int4,
"flg_n_iscr" varchar(254),
"n_addetti" numeric,
"flg_n_add" varchar(254),
"the_geom" geometry('POINT',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_strutture_scolastiche_pt" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_strutture_scolastiche_pl" (gid serial,
"id_tema" int4,
"denom" varchar(254),
"fk_gr_scol" int4,
"n_iscritti" int4,
"flg_n_iscr" varchar(254),
"n_addetti" numeric,
"flg_n_add" varchar(254),
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_strutture_scolastiche_pl" ADD PRIMARY KEY (gid);

CREATE TABLE "siig_p"."siig_p_bersagli_centri_commerciali" (gid serial,
"id_tema" varchar(254),
"denom" varchar(250),
"insegna" varchar(250),
"sup_vend" numeric,
"n_utenti" numeric,
"flg_n_uten" varchar(1),
"n_addetti" numeric,
"flg_n_add" varchar(1),
"the_geom" geometry('MULTIPOLYGON',32632));
ALTER TABLE "siig_p"."siig_p_bersagli_centri_commerciali" ADD PRIMARY KEY (gid);

COMMIT;