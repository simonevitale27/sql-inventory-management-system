/* 1) Ogni qual volta un prodotto viene venduto in un negozio, qual è la query da eseguire per aggiornare le tabelle di riferimento?*/

/*Registrare una vendita di 10 confezioni di 'Pasta Barilla 500g' 
presso il negozio di 'Torino Centro' in data odierna e aggiornare la giacenza nel magazzino 'Logistica Nord-Ovest'."*/

INSERT INTO `vendite` (`idnegozio`, `idprodotto`, `datavendita`, `quantitàvenduta`)
VALUES (1, 5, CURDATE(), 10);

UPDATE giacenzamagazzino
SET quantitàdisponibile = quantitàdisponibile - 10
WHERE codprodotto = 5 
AND codmagazzino = (SELECT idmagazzino FROM negozio WHERE idnegozio = 1);

/* Commento: Per visionare le tabelle aggiornate a seguito di una vendita, dobbiamo inserire la 
vendita del prodotto tramite "INSERT INTO" per la tabella "VENDITE" e di contro aggiornare la disponibilità del 
prodotto nel magazzino tramite "UPDATE" nella tabella "GIACENZA MAGAZZINO".*/

/* 2) Quali sono le query da eseguire per verificare quante unità di un prodotto ci sono
 in un dato magazzino e per monitorare le soglie di restock? */
 

 Select 
 p.nomeprodotto as Nome_Prodotto,
 m.nomemagazzino as Magazzino,
 g.quantitàdisponibile as Disponibilità_Magazzino,
 p.sogliaminimarestock as Soglia_Restock
 from prodotto p
 join giacenzamagazzino g
 on p.idprodotto = g.codprodotto
 join magazzino m
 on m.idmagazzino =g.codmagazzino
 order by Nome_Prodotto;
 
 
Select 
 p.nomeprodotto as Nome_Prodotto,
 m.nomemagazzino as Magazzino,
 g.quantitàdisponibile as Disponibilità_Magazzino,
 p.sogliaminimarestock as Soglia_Restock,
 case when g.quantitàdisponibile < p.sogliaminimarestock
 then "RIORDINARE" when g.quantitàdisponibile = 0 then "ESAURITO"
 else "DISPONIBILE" END AS CHECK_RESTOCK
 from prodotto p
 join giacenzamagazzino g
 on p.idprodotto = g.codprodotto
 join magazzino m
 on m.idmagazzino =g.codmagazzino
 order by CHECK_RESTOCK DESC;
 
/* Commento: Con la prima query visioniamo la disponibilità dei prodotti in ogni magazzino e con la seconda query 
verifichiamo quali prodotti hanno bisogno di restock. */


/*QUERY TRANSAZIONE*/

START TRANSACTION;

Select 
 p.nomeprodotto as Nome_Prodotto,
 m.nomemagazzino as Magazzino,
 g.quantitàdisponibile as Disponibilità_Magazzino,
 p.sogliaminimarestock as Soglia_Restock,
 case when g.quantitàdisponibile < p.sogliaminimarestock
 then "RIORDINARE" when g.quantitàdisponibile = 0 then "ESAURITO"
 else "DISPONIBILE" END AS CHECK_RESTOCK
 from prodotto p
 join giacenzamagazzino g
 on p.idprodotto = g.codprodotto
 join magazzino m
 on m.idmagazzino =g.codmagazzino
 order by CHECK_RESTOCK DESC;
 
 INSERT INTO `vendite` (`idnegozio`, `idprodotto`, `datavendita`, `quantitàvenduta`)
VALUES (1, 5, CURDATE(), 10);

UPDATE giacenzamagazzino
SET quantitàdisponibile = quantitàdisponibile - 10
WHERE codprodotto = 5 
AND codmagazzino = (SELECT idmagazzino FROM negozio WHERE idnegozio = 1);

-- se tutto ok: 
COMMIT;

-- per pulire la tabella:
ROLLBACK;

-- per rilevare gli errori in realtà si usano le stored procedures


