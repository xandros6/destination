CREATE AGGREGATE z_cat (
sfunc = array_append,
basetype = anyelement,
stype = anyarray,
initcond = '{}'
);


--drop AGGREGATE z_cat(anyelement) ;

select pter from siig_d_dissesto;

SELECT z_cat(pter) 
FROM siig_d_dissesto;


SELECT siig_geo_ln_arco_1.id_geo_arco, 
--	siig_d_dissesto.pter, 
	z_cat(pter),
	siig_geo_ln_arco_1.lunghezza, 
	siig_geo_ln_arco_1.nr_corsie,
	siig_geo_ln_arco_1.geometria
FROM siig_d_dissesto INNER JOIN (siig_geo_ln_arco_1 
	INNER JOIN siig_r_arco_1_dissesto 
	ON siig_geo_ln_arco_1.id_geo_arco = siig_r_arco_1_dissesto.id_geo_arco) 
	ON siig_d_dissesto.id_dissesto = siig_r_arco_1_dissesto.id_dissesto
group by siig_geo_ln_arco_1.id_geo_arco,siig_geo_ln_arco_1.lunghezza,siig_geo_ln_arco_1.nr_corsie;



-- v_geo_grafo_ln
create or replace view v_geo_grafo_ln as
SELECT siig_geo_ln_arco_1.id_geo_arco, 
	siig_d_partner.partner_it, 
 z_cat(
  CASE
            WHEN siig_r_tipovei_geoarco1.flg_densita_veicolare::text = 'S'::text THEN 'STIMATA'::text
            WHEN siig_r_tipovei_geoarco1.flg_densita_veicolare::text = 'C'::text THEN 'CALCOLATA'::text
            WHEN siig_r_tipovei_geoarco1.flg_densita_veicolare::text = 'M'::text THEN 'MODELLIZZATA'::text
            ELSE NULL::text
  END) AS tipo_densita_veicolare_leggeri_pesanti_it, 	 
 z_cat(siig_r_tipovei_geoarco1.densita_veicolare) as densita_veicolare, 
 z_cat(
  CASE
            WHEN siig_r_tipovei_geoarco1.velocita_media::text = 'S'::text THEN 'STIMATA'::text
            WHEN siig_r_tipovei_geoarco1.velocita_media::text = 'C'::text THEN 'CALCOLATA'::text
            WHEN siig_r_tipovei_geoarco1.velocita_media::text = 'M'::text THEN 'MODELLIZZATA'::text
            ELSE NULL::text
  END) AS tipo_velocita_media_leggeri_pesanti_it, 	 
 z_cat(siig_r_tipovei_geoarco1.velocita_media) as velocita_media, 
  CASE
            WHEN siig_geo_ln_arco_1.flg_nr_corsie::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_geo_ln_arco_1.flg_nr_corsie::text = 'C'::text THEN 'CALCOLATO'::text
            WHEN siig_geo_ln_arco_1.flg_nr_corsie::text = 'M'::text THEN 'MODELLIZZATO'::text
            ELSE NULL::text
  END as fl_nr_corsie ,	 
  siig_geo_ln_arco_1.nr_corsie,
 CASE
            WHEN siig_geo_ln_arco_1.flg_nr_incidenti::text = 'S'::text THEN 'STIMATO'::text
            WHEN siig_geo_ln_arco_1.flg_nr_incidenti::text = 'C'::text THEN 'CALCOLATO'::text
            WHEN siig_geo_ln_arco_1.flg_nr_incidenti::text = 'M'::text THEN 'MODELLIZZATO'::text
            ELSE NULL::text
  END as flg_nr_incidenti, 	 
  siig_geo_ln_arco_1.nr_incidenti,
  siig_geo_ln_arco_1.nr_incidenti_elab,
  siig_geo_ln_arco_1.lunghezza,
  z_cat(siig_d_dissesto.descrizione_it) elenco_dissesti,
  siig_geo_ln_arco_1.geometria
FROM ((siig_d_partner INNER JOIN siig_geo_ln_arco_1 
	ON siig_d_partner.id_partner = siig_geo_ln_arco_1.fk_partner) 
	INNER JOIN (siig_d_dissesto INNER JOIN siig_r_arco_1_dissesto 
	ON siig_d_dissesto.id_dissesto = siig_r_arco_1_dissesto.id_dissesto) 
	ON siig_geo_ln_arco_1.id_geo_arco = siig_r_arco_1_dissesto.id_geo_arco) 
	INNER JOIN siig_r_tipovei_geoarco1 ON siig_geo_ln_arco_1.id_geo_arco = siig_r_tipovei_geoarco1.id_geo_arco
group by siig_geo_ln_arco_1.id_geo_arco,
	siig_geo_ln_arco_1.geometria,
	siig_geo_ln_arco_1.lunghezza,
	siig_d_partner.partner_it, 
	siig_geo_ln_arco_1.nr_corsie,
	siig_geo_ln_arco_1.flg_nr_corsie, 
	siig_geo_ln_arco_1.flg_nr_incidenti,
	siig_geo_ln_arco_1.nr_incidenti,
	siig_geo_ln_arco_1.nr_incidenti_elab
order by siig_geo_ln_arco_1.id_geo_arco
;