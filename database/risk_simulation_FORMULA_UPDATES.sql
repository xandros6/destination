(bersaglio) CFF: select id_geo_arco,avg(cff) from siig_r_arco_%livello%_scen_tipobers where id_geo_arco in (%id_geo_arco%) and id_bersaglio in (%id_bersaglio%) group by id_geo_arco

(sostanza) PADR: select id_geo_arco,padr from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %id_sostanza%

(indcidenti) PIS: select id_geo_arco,nr_incidenti_elab/lunghezza*1000*(1) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco


-- Cff
select id_geo_arco,avg(cff) from (select id_geo_arco,id_bersaglio,fk_partner,cff from siig_r_arco_%livello%_scen_tipobers where id_geo_arco in (%id_geo_arco%) and id_bersaglio in (%id_bersaglio%) %cff%)) x group by id_geo_arco
select id_geo_arco,avg(cff) from siig_r_arco_%livello%_scen_tipobers where id_geo_arco in (%id_geo_arco%) and id_bersaglio in (%id_bersaglio%) group by id_geo_arco

-- Psc
select sum(psc) from (select id_sostanza,psc from siig_r_scenario_sostanza where id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%) %psc%) x
select sum(psc) from siig_r_scenario_sostanza where id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%)

-- Padr
select id_geo_arco,%padr% as padr from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %id_sostanza%
select id_geo_arco,padr from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %id_sostanza%

-- Pis
select * from (select id_geo_arco,%formula(117)%*(%formula(111)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco %pis%) x
select id_geo_arco,%formula(117)%*(%formula(111)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) 

select * from (select id_geo_arco,%formula(117)%*1000*(%formula(112)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco %pis%) x
select id_geo_arco,%formula(117)%*1000*(%formula(112)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) 

select * from (select id_geo_arco,%formula(117)%*1000*(%formula(116)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco %pis%) x
select id_geo_arco,%formula(117)%*1000*(%formula(116)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) 

select * from (select id_geo_arco,%formula(118)%*(%formula(116)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco %pis%) x
select id_geo_arco,%formula(118)%*(%formula(116)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) 

2;	"Cff - capacità  di far fronte";															"select id_geo_arco,avg(cff) from siig_r_arco_%livello%_scen_tipobers where id_geo_arco in (%id_geo_arco%) and id_bersaglio in (%id_bersaglio%) group by id_geo_arco"
13;	"S(Fp x (ExS) x (1- Cff)) - Magnitudo delle conseguenze antropiche ";						"select id_geo_arco,(%formula(107,id_gravita,4)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco"
14;	"? (Fp x (ExS) x (1- Cff)) -  Magnitudo delle conseguenze ambientali";						"select id_geo_arco,(%formula(108)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco"
16;	"Psc - Probabilità di accadimento dello scenario incidentale";								"select sum(psc) from siig_r_scenario_sostanza where id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%)"
17;	"? (Psc x ? (Fp x (ExS) x (1- Cff))) - Danni antropici associati al sicuro incidente TMP";	"select id_geo_arco,(%formula(109)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) "
18;	"? (Psc x ? (Fp x (ExS) x (1- Cff))) - Danni ambientali associati al sicuro incidente TMP";	"select id_geo_arco,(%formula(110)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) "
19;	"? (Padr x ?(Psc x ? (Fp x (ExS) x (1- Cff))) -antropico";									"select id_geo_arco,(%formula(111)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) "
20;	"Padr - Flussi ADR";																		"select id_geo_arco,padr from siig_r_arco_%livello%_sostanza where id_geo_arco in (%id_geo_arco%) and id_sostanza = %id_sostanza%"
21;	"? (Padr x ?(Psc x ? (Fp x (ExS) x (1- Cff)))) -ambientale";								"select id_geo_arco,(%formula(112)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) "
22;	"Pis - Pericolosità intrinseca della strada";	
23;	"Pis - Pericolosità intrinseca cumulata della rete stradale";
26;	"R - Rischio";																				"select id_geo_arco,nr_incidenti_elab/lunghezza*1000*((%formula(111)%) + (%formula(112)%)) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco"
29;	"R - Rischio cumulato";																		"select id_geo_arco,nr_incidenti_elab/5*((%formula(111)%) + (%formula(112)%)) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco"
32;	"E - Bersagli potenzialmente esposti";														"select id_geo_arco,(%formula(100)%+%formula(101)%) from siig_geo_ln_arco_%livello% where id_geo_arco in (%id_geo_arco%) group by id_geo_arco"
36;	"S - Suscettibilità antropica";																"select (%formula(38)%)"
37;	"S - Suscettibilità ambientale";															"select (%formula(38,id_gravita,5)%)"
38;	"S - Suscettibilità";																		"select suscettibilita from siig_r_scenario_gravita where id_scenario = %id_scenario% and id_bersaglio = %id_bersaglio% and id_gravita = %id_gravita%"
39;	"Pis x ? (Padr x ? (Psc x S x (1- Cff))) - Rischio individuale antropico";					"select id_geo_arco,nr_incidenti_elab/lunghezza*1000*(%formula(111)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) "
40;	"Pis x ? (Padr x ? (Psc x S x (1- Cff))) - Rischio individuale ambientale";					"select id_geo_arco,nr_incidenti_elab/lunghezza*1000*(%formula(112)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) "
45;	"Pis x ? (Padr x ? (Psc)) - Probabilità incidentale";										"select id_geo_arco,nr_incidenti_elab/lunghezza*1000*(%formula(116)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) "
46;	"Pis x ? (Padr x ? (Psc)) - Probabilità incidentale cumulata";								"select id_geo_arco,nr_incidenti_elab/5*(%formula(116)%) from siig_geo_ln_arco_%livello%  where id_geo_arco in (%id_geo_arco%) "
100;"E - antropico";																			"(%formula(102,field,nr_pers_residenti,id_gravita,4,id_bersaglio,1)%*%bersaglio(1)%)+(%formula(102,field,nr_turisti_max,id_gravita,4,id_bersaglio,2)%*%bersaglio(2)%)+(%formula(102,field,nr_pers_servizi,id_gravita,4,id_bersaglio,4)%*%bersaglio(4)%)+(%formula(102,field,nr_pers_ospedali,id_gravita,4,id_bersaglio,5)%*%bersaglio(5)%)+(%formula(102,field,nr_pers_scuole,id_gravita,4,id_bersaglio,6)%*%bersaglio(6)%)+(%formula(102,field,nr_pers_distrib,id_gravita,4,id_bersaglio,7)%*%bersaglio(7)%)"
101;"E - ambientale";																			"(%formula(102,field,mq_zone_urbanizzate,id_gravita,5,id_bersaglio,10)%*%bersaglio(10)%)+(%formula(102,field,mq_aree_boscate,id_gravita,5,id_bersaglio,11)%*%bersaglio(11)%)+(%formula(102,field,mq_aree_protette,id_gravita,5,id_bersaglio,12)%*%bersaglio(12)%)+(%formula(102,field,mq_aree_agricole,id_gravita,5,id_bersaglio,13)%*%bersaglio(13)%)+(%formula(102,field,mq_acque_sotterranee,id_gravita,5,id_bersaglio,14)%*%bersaglio(14)%)+(%formula(102,field,mq_acque_superficiali,id_gravita,5,id_bersaglio,15)%*%bersaglio(15)%)+(%formula(102,field,mq_beni_culturali,id_gravita,5,id_bersaglio,16)%*%bersaglio(16)%)"
102;"E - formula base";																			"(select %field% from siig_t_vulnerabilita_%livello% where siig_t_vulnerabilita_%livello%.id_geo_arco=siig_geo_ln_arco_%livello%.id_geo_arco and id_distanza = (select max(fk_distanza) from siig_r_area_danno where id_gravita = %id_gravita% and id_bersaglio = %id_bersaglio% and id_scenario in (%id_scenario%) and id_sostanza in (%id_sostanza%) and flg_lieve in (%flg_lieve%)))"
104;"1-Cff";																					"1-(select cff from siig_r_arco_%livello%_scen_tipobers where siig_r_arco_%livello%_scen_tipobers.id_geo_arco=siig_geo_ln_arco_%livello%.id_geo_arco and id_bersaglio in (%id_bersaglio%))"
105;"(1-Cff) x S x E x Fp - ambientale";														" (%formula(104,id_bersaglio,%id_bersaglio%)%) * (%formula(113,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,5)%) * (%formula(106,id_bersaglio,%id_bersaglio%)%)"
106;"Fp";																						"select fp_scen_centrale from siig_t_bersaglio where id_bersaglio = %id_bersaglio%"
107;"? (Fp x (ExS) x (1- Cff)))) - antropico";													" (%formula(115,field,nr_pers_residenti,id_bersaglio,1)%*%bersaglio(1)%)+(%formula(115,field,nr_turisti_max,id_bersaglio,2)%*%bersaglio(2)%)+(%formula(115,field,nr_pers_servizi,id_bersaglio,4)%*%bersaglio(4)%)+(%formula(115,field,nr_pers_ospedali,id_bersaglio,5)%*%bersaglio(5)%)+(%formula(115,field,nr_pers_scuole,id_bersaglio,6)%*%bersaglio(6)%)+(%formula(115,field,nr_pers_distrib,id_bersaglio,7)%*%bersaglio(7)%)"
108;"? (Fp x (ExS) x (1- Cff)))) - ambientale";													"(%formula(105,field,mq_zone_urbanizzate,id_bersaglio,10)%*%bersaglio(10)%)+(%formula(105,field,mq_aree_boscate,id_bersaglio,11)%*%bersaglio(11)%)+(%formula(105,field,mq_aree_protette,id_bersaglio,12)%*%bersaglio(12)%)+(%formula(105,field,mq_aree_agricole,id_bersaglio,13)%*%bersaglio(13)%)+(%formula(105,field,mq_acque_sotterranee,id_bersaglio,14)%*%bersaglio(14)%)+(%formula(105,field,mq_acque_superficiali,id_bersaglio,15)%*%bersaglio(15)%)+(%formula(105,field,mq_beni_culturali,id_bersaglio,16)%*%bersaglio(16)%)"
109;"? (Psc x ? (Fp x (ExS) x (1- Cff))) - antropico";											"(select sum(siig_r_scenario_sostanza.psc * (%formula(107,id_gravita,4,id_scenario,siig_r_scenario_sostanza.id_scenario,flg_lieve,siig_r_scenario_sostanza.flg_lieve)%)) from siig_r_scenario_sostanza  where siig_r_scenario_sostanza.id_sostanza = %id_sostanza% and siig_r_scenario_sostanza.id_scenario in (%id_scenario%) and flg_lieve in (%flg_lieve%))"
110;"? (Psc x ? (Fp x (ExS) x (1- Cff))) - ambientale";											"(select sum(siig_r_scenario_sostanza.psc * (%formula(108,id_scenario,siig_r_scenario_sostanza.id_scenario,flg_lieve,siig_r_scenario_sostanza.flg_lieve)%)) from siig_r_scenario_sostanza  where siig_r_scenario_sostanza.id_sostanza = %id_sostanza% and siig_r_scenario_sostanza.id_scenario in (%id_scenario%) and flg_lieve in (%flg_lieve%))"
111;"? (Padr x ?(Psc x ? (Fp x (ExS) x (1- Cff))) - base antropico";							"(select sum(padr * (%formula(109,id_sostanza,siig_r_arco_%livello%_sostanza.id_sostanza)%)) from siig_r_arco_%livello%_sostanza where siig_r_arco_%livello%_sostanza.id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco and id_sostanza in (%id_sostanza%))"
112;"? (Padr x ?(Psc x ? (Fp x (ExS) x (1- Cff))) - base ambientale";							"(select sum(padr * (%formula(110,id_sostanza,siig_r_arco_%livello%_sostanza.id_sostanza)%)) from siig_r_arco_%livello%_sostanza where siig_r_arco_%livello%_sostanza.id_geo_arco = siig_geo_ln_arco_%livello%.id_geo_arco and id_sostanza in (%id_sostanza%))"
113;"E x S -base";																				"(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,%id_gravita%)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,%id_gravita%)%)"
114;"E x S - antropico";																		"(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,1)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,1)%)+(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,2)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,2)%)+(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,3)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,3)%)+(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,4)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,4)%)-(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,1)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,2)%)-(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,2)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,3)%)-(%formula(102,id_bersaglio,%id_bersaglio%,field,%field%,id_gravita,3)%)*(%formula(38,id_bersaglio,%id_bersaglio%,id_gravita,4)%)"
115;"(1-Cff) x S x E x Fp - antropico";															"(%formula(104,id_bersaglio,%id_bersaglio%)%) * (%formula(114,id_bersaglio,%id_bersaglio%,field,%field%)%) * (%formula(106,id_bersaglio,%id_bersaglio%)%)"
116;"? (Padr x ? (Psc))";																		"select sum(padr * (%formula(16)%)) from siig_r_arco_%livello%_sostanza where id_sostanza in (%id_sostanza%) and  siig_r_arco_%livello%_sostanza.id_geo_arco =  siig_geo_ln_arco_%livello%.id_geo_arco"
