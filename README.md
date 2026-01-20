Sistema di Gestione Inventario e Vendite

Database relazionale per la gestione di vendite, inventario e magazzini multi-sede.

## Team
Progetto sviluppato in collaborazione con [Sonia Antonella Romeo](https://www.linkedin.com/in/sonia-antonella-romeo-318a6313b/)  
**Build Week SQL** - EPICODE Data Analytics Bootcamp

---

## Panoramica del Progetto

Sistema completo per la gestione di:
- **10 negozi** distribuiti sul territorio nazionale
- **4 magazzini** logistici
- **~20 prodotti** suddivisi in 5 categorie
- **Tracciamento vendite** con aggiornamento automatico giacenze

### Funzionalità Implementate
- Registrazione vendite con controllo giacenze
- Monitoraggio soglie di restock per magazzino
- Gestione transazioni atomiche (ACID compliance)
- Query di business intelligence per analisi inventario

---

## Architettura Database

### Schema ER
![SCHEMA E:R](https://github.com/user-attachments/assets/1a008504-61c5-41f1-ae08-b86569bea3d8)
diagram.png)

### Tabelle Principali
- `categoria`: Classificazione prodotti
- `prodotto`: Catalogo con soglie restock
- `magazzino`: Centri logistici (Nord-Ovest, Nord-Est, Centro, Sud)
- `negozio`: Punti vendita fisici
- `giacenzamagazzino`: Tracking disponibilità per magazzino
- `vendite`: Storico transazioni

---

## Use Case Implementati

### 1. Registrazione Vendita
**Scenario:** Vendita di 10 confezioni "Pasta Barilla 500g" presso "Torino Centro"
```sql
START TRANSACTION;

-- Inserimento vendita
INSERT INTO vendite (idnegozio, idprodotto, datavendita, quantitàvenduta)
VALUES (1, 5, CURDATE(), 10);

-- Aggiornamento giacenza magazzino
UPDATE giacenzamagazzino
SET quantitàdisponibile = quantitàdisponibile - 10
WHERE codprodotto = 5 
  AND codmagazzino = (SELECT idmagazzino FROM negozio WHERE idnegozio = 1);

COMMIT;
```

### 2. Monitoraggio Restock
Query per identificare prodotti sotto soglia critica:
```sql
SELECT 
    p.nomeprodotto AS Prodotto,
    m.nomemagazzino AS Magazzino,
    g.quantitàdisponibile AS Giacenza,
    p.sogliaminimarestock AS Soglia,
    CASE 
        WHEN g.quantitàdisponibile = 0 THEN 'ESAURITO'
        WHEN g.quantitàdisponibile < p.sogliaminimarestock THEN 'RIORDINARE'
        ELSE 'DISPONIBILE'
    END AS Stato
FROM prodotto p
JOIN giacenzamagazzino g ON p.idprodotto = g.codprodotto
JOIN magazzino m ON m.idmagazzino = g.codmagazzino
ORDER BY Stato DESC, Giacenza ASC;
```

---

## Dati di Test
- **Categorie:** 5 (Alimentari, Bevande, Casalinghi, Elettronica, Cura Persona)
- **Prodotti:** 20 articoli con codici EAN, prezzi e soglie restock
- **Magazzini:** 4 centri (Logistica Nord-Ovest, Nord-Est, Centro, Sud)
- **Negozi:** 10 punti vendita (Torino, Milano, Bologna, Roma, Napoli...)
- **Vendite simulate:** 30 transazioni

---

## Stack Tecnologico
- **DBMS:** MySQL 8.0
- **Design:** MySQL Workbench (Reverse Engineering)
- **Version Control:** Git/GitHub

---

## 🤝 Contatti
**Simone [Tuo Cognome]**  
[LinkedIn](www.linkedin.com/in/simone-vitale-analyst)

**Sonia Romeo**  
[LinkedIn](https://www.linkedin.com/in/sonia-antonella-romeo-318a6313b/)
```
