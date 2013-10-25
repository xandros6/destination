ALTER TABLE siig_d_dissesto ADD COLUMN dissesti_bolzano character varying(250);




INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('1',1.100,'Dissesti PAI – Esondazioni - pericolo molto elevato (Ee)','PAI  instabilities - Floods - very high risk (Ee)','PAI-Gefahrenzonen - Überschwemmungen - sehr hohe Gefahr (Ee)','Dégradations PAI (plan d''aménagement hydrogéologique) - Inondations - risque très élevé (Ee)','PZP - Pericoli idraulici (IS,DF,Ex) – H4');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('10',1.030,'Dissesti PAI – Frane - frana stabilizzata (Fs)','PAI  instabilities - Landslides - landslide stabilized (Fs)','PAI-Gefahrenzonen - Massenbewegungen - stabilisierte Rutschung (Fs)','Dégradations PAI (plan d''aménagement hydrogéologique) - Glissements de terrain - Glissement de terrain stabilisé (FS)','PZP - Frane (Lx) – H2');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('11',1.050,'Dissesti PAI – Esondazioni -  in assenza di classificazione pericolosità', '','','','PZP - Pericoli idraulici (IS,DF,Ex) - in assenza di classificazione pericolosità');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('12',1.200,'Dissesti PAI – Valanghe -  in assenza di classificazione pericolosità', '','','','PZP – Valanghe (Ax) - in assenza di classificazione pericolosità');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('13',1.100,'Fasce PAI – Fasce fluviali - fascia A (naturale deflusso piena)','PAI Bands - Bands river - Band A (full natural flow)','Flussräume PAI - Flusskorridore - Bereich A (natürlicher Hochwasserabfluss)','Couches PAI - Couches fluviales - couche A (écoulement naturel des crues) ','PZP - Pericoli idraulici (IN) – T=30 anni');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('14',1.050,'Fasce PAI – Fasce fluviali - fascia B (T=200 anni)','PAI Bands - Bands river - band B (T = 200 years)','Flussräume PAI - Flusskorridore - Bereich B (HQ200)','Couches PAI - Couches fluviales - couche B (T=200 ans)','PZP - Pericoli idraulici (IN) – T=100 anni');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('15',1.030,'Fasce PAI – Fasce fluviali - fascia C (T=500 anni)','PAI Bands - Bands river - C band (T = 500 years)','Flussräume PAI - Flusskorridore - Bereich C (HQ500)','Couches PAI - Couches fluviales - couche C (T=500 ans)','PZP - Pericoli idraulici (IN) – T=200-300 anni');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('16',1.050,'Dissesti PAI – Conoidi -  in assenza di classificazione pericolosità', '','','','PZP - Frane (Lx) - in assenza di classificazione pericolosità');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('17',1.050,'Dissesti PAI – Frane -  in assenza di classificazione pericolosità','','','','PZP - Frane (Lx) - in assenza di classificazione pericolosità');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('18',1.050,'Dissesti PAI – Fasce fluviali -  in assenza di classificazione pericolosità','','','','PZP - Pericoli idraulici (IN) - in assenza di classificazione pericolosità');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('2',1.050,'Dissesti PAI – Esondazioni - pericolo elevato (Eb)','PAI Instability - Floods - high hazard (Eb)','PAI-Gefahrenzonen - Überschwemmungen - hohe Gefahr (Eb)','Dégradations PAI - Inondations - risque élevé (Eb)','PZP - Pericoli idraulici (IS,DF,Ex) – H3');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('3',1.030,'Dissesti PAI – Esondazioni - pericolo medio (Em)','PAI Instability - Floods - medium hazard (Em)','PAI-Gefahrenzonen - Überflutungen - mittlere Gefahr (Em)','Dégradations PAI - Inondations - risque moyen (Em)','PZP - Pericoli idraulici (IS,DF,Ex) – H2');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('4',1.100,'Dissesti PAI – Valanghe - pericolo elevato (Va)','PAI Instability - Avalanche - high hazard (Va)','PAI-Gefahrenzonen - Lawinen - hohe Gefahr (Va)','Dégradations PAI - Avalanches - risque élevé (Va)','PZP – Valanghe (Ax ) H3/H4');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('5',1.100,'Dissesti PAI – Conoidi - area non protetta (Ca)','PAI Instability - cones - unprotected area (Ca)','PAI-Gefahrenzonen - Schwemmkegel - ungeschützte Zone (Ca)','Dégradations PAI - Cônes de déjections - zone non protégée','PZP - Frane (Lx) – H4');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('6',1.050,'Dissesti PAI – Conoidi - area parzialmente protetta (Cp)','PAI Instability - cones - partially protected area (Cp)','PAI-Gefahrenzonen - Schwemmkegel - teilweise geschützte Zone (Cp)','Dégradations PAI - Cônes de déjections - zone partiellement protégée','PZP - Frane (Lx) – H3');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('7',1.030,'Dissesti PAI – Conoidi - area protetta (Cn)','PAI Instability - cones - protected area (Cn)','PAI-Gefahrenzonen - Schwemmkegel - geschützte Zone (Cn)','Dégradations PAI - Cônes de déjections - zone protégée','PZP - Frane (Lx) – H2');

INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('8',1.100,'Dissesti PAI – Frane - frana attiva (Fa)','PAI Instability - Landslides - active landslide (Fa)','PAI-Gefahrenzonen - Massenbewegungen - aktive Rutschung (Fa)','Dégradations PAI - Glissements de terrain - glissement actif (Fa)','PZP - Frane (Lx) – H4');
INSERT INTO siig_d_dissesto(
            id_dissesto, pter, descrizione_it, descrizione_en, descrizione_de, 
            descrizione_fr, dissesti_bolzano)
    VALUES ('9',1.050,'Dissesti PAI – Frane - frana quiescente (Fq)','PAI Instability - Landslides - landslide quiescent (Fq)','PAI-Gefahrenzonen - Massenbewegungen - ruhende Rutschung (Fq)','Dégradations PAI - Glissements de terrain - glissement inactif (Fq)','PZP - Frane (Lx) – H3');

