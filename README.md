# Explicacions
Tot està fet (diriem), però res funciona. No sabem com es connecta frontend amb backend i viceversa.  

## DataBase

Per a aquesta part del projecte hem volgut utilitzar SQL i SQLite, doncs tots tres participants del grup vam fer Bases de Dades i utilitzavem aquest llenguatge. Per si sol funciona com esperavem: hi ha diferents taules per totes les dades diferents que necessitem. 

Ara però, no hem estat capaços de lligar aquesta part amb la part de FrontEnd(html). És per això que, per a la presentació del projecte, hem decidit introduir manualment les dades del pacient al fitxer html per a que, almenys, visualment sigui atractiu.

## Algorisme
La idea inicial era utilitzar machine learning per crear un model que, en el cas d'usuari pacient, aquest pogués entrar els símptomes que estava patint en aquell moment i en base al seu historial, medicaments, edat i sexe, pogués indicar-li si havia d'anar directament a urgències o si podia esperar a una visita amb el seu metge especialista. Malauradament, no se'ns ha posat a disposició cap font de dades per tal d'entrenar aquest model i no sabriem com fer-ho d'una altra manera. El fitxer alg1.py mostra un esquelet de com iniciariem aquest model i funcions i llibraries per entrenar-lo, així que ens han faltat les dades per poder entrenar-lo i verue si aquest model seria fiable.

simptomes.py faria la consulta per coneixer els símptomes propis de la malaltia pulmonar intersticial difusa que pateix el pacient que ha escanejat el qr per tal de mostrar per la interfície els símptomes que és més probable que estigui experimentant per agilitzar la interacció.

alg2.py és l'inici d'un algorisme que segueix el procediment del PPT proporcionat i hagués estat interessant poder interactuar amb la interfície per arribar a desenvolupar-lo correctament i idealment combinar-lo amb machine learning per poder tenir en compte altres factors que poguessin afectar al diagnòstic i donar una recomanació d'actuació al metge mésàmplia i acurada.

## FrontEnd

Per aquesta part vam decidir utilitzar HTML ja que era un llenguatge força fàcil d'aprendre en un parell de dies. Hem fet diverses pestanyes seguint un esquema que ens vam fer que està guardat a Data anomenat vista1 i vista2. En si fa una mica el que esperàvem, però al no saber lligar-ho amb la database no és funcional. 

## Conclusió

Mai haviem fet un projecte així ni participat a cap Hackaton així que com a primera experiència està força bé. A part, cap dels tres havia tocat cap dels llenguatges utilitzats. 

Ara només toca entrenar-nos per a la Hackaton del maig. 