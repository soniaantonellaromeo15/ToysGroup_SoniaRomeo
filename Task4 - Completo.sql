/* 1) Verificare che i campi definiti come PK siano univoci. In altre parole, scrivi una query per determinare
l’univocità dei valori di ciascuna PK (una query per tabella implementata) */

/* Opzione A - La query individua eventuali valori duplicati del campo "PK" raggruppando i record e filtrando i casi in cui il conteggio è maggiore di 1.
Se la query non restituisce risultati, il vincolo di univocità della PK è rispettato */

select idvendite
from vendite
group by idvendite
having count(*) > 1;

select idprodotti
from prodotti
group by idprodotti
having count(*) > 1;

select idcategoria
from categoria
group by idcategoria
having count(*) > 1;

select IdMercati
from mercati
group by IdMercati
having count(*) > 1;

select IdRegioni
from regioni
group by IdRegioni
having count(*) > 1;

/* Opzione B - Creo una view che conteggia il valore della PK, consentendo una verifica analitica della distribuzione dei valori e l’individuazione di eventuali duplicati */

create view Check_PK_Vendite as
select idvendite,
count(*) as conteggio
from vendite
group by idvendite;

select *
from check_pk_vendite;

create view Check_PK_prodotti as
select idprodotti,
count(*) as conteggio
from prodotti
group by idprodotti;

select *
from check_pk_prodotti;

create view Check_PK_Categoria as
select idcategoria,
count(*) as conteggio
from categoria
group by idcategoria;

select *
from check_pk_categoria;

create view Check_PK_Regioni as
select idregioni,
count(*) as conteggio
from regioni
group by idregioni;

select *
from check_pk_regioni;

create view Check_PK_Mercati as
select idmercati,
count(*) as conteggio
from mercati
group by idmercati;

select *
from check_pk_mercati;

/* 2) Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, il nome del prodotto, la categoria del prodotto, il nome dello stato, il nome della regione di vendita e un campo
booleano valorizzato in base alla condizione che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False) */

select 
v.IdVendite as Codice_Documento,
v.Data as Data,
p.NomeProdotto as Prodotto,
C.NomeCategoria as Categoria,
m.Stato as Stato,
r.NomeRegione AS Area,
DATEDIFF(CURDATE(), v.Data) AS Giorni_dalla_vendita,
CASE
WHEN DATEDIFF(CURDATE(), v.Data) > 180 THEN 'True'
else 'False'
END as Oltre_180_giorni
from vendite v 
join prodotti p
on v.IdProdotto = p.IdProdotti
JOIN categoria C
ON p.IdCategoria = C.IdCategoria
join mercati m
on v.IdMercati = m.IdMercati
join regioni r
on m.IdRegioni = r.IdRegioni
order by v.Data desc;
    
/* Per esprorre i valori richiesti ho effettuato le join tra le tabelle "Vendite, Prodotti, Categoria, Mercati e Regioni". La query rappresenta il numero di giorni trascorsi dalla data di vendita alla data corrente
e, sulla base di tale valore, crea un campo derivato che indica se sono trascorsi più di 180 giorni. Questo consente sia una lettura quantitativa che una classificazione temporale delle transazioni */
    
/* 3) Esporre l’elenco dei prodotti che hanno venduto, in totale, una quantità maggiore della media delle vendite realizzate nell’ultimo anno censito. (ogni valore della condizione deve risultare da una query e
non deve essere inserito a mano). Nel result set devono comparire solo il codice prodotto e il totale venduto. */

select
v.IdProdotto as IdProdotto,
SUM(v.`Quantità`) AS Totale_Venduto
from vendite v
WHERE YEAR(v.`Data`) = (
select MAX(YEAR(`Data`))
from vendite )
group by v.IdProdotto
having SUM(v.`Quantità`) >
(select avg(`Quantità`)
from vendite
WHERE YEAR(`Data`) = (
select MAX(YEAR(`Data`))
from vendite)
);

/* La media è calcolata sulle quantità delle singole vendite, mentre il totale è calcolato per prodotto; il confronto avviene quindi tra il totale venduto di ciascun prodotto e la quantità media venduta per transazione.*/

/* 4) Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. */

select
year(v.Data) as Anno,
p.NomeProdotto As Prodotto,
sum(v.Quantità) AS Quantità,
sum(v.Prezzo * v.Quantità) as Fatturato
from vendite v
join prodotti p
on v.IdProdotto = p.IdProdotti
group by year(v.Data),
p.NomeProdotto
order by fatturato desc;

/*Per rispondere alla richiesta ho aggregato i dati di vendita per prodotto e per anno. Il fatturato è calcolato come somma del prezzo di vendita moltiplicato per la quantità venduta: sum(v.Prezzo * v.Quantità).  
Ho inoltre calcolato la quantità totale venduta per ciascun prodotto, così da fornire un ulteriore dettaglio in merito ai prodotti più richiesti.
Il risultato è ordinato per fatturato decrescente, in modo da evidenziare i prodotti con le migliori performance di vendita. */

/* 5) Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.*/

select
year(v.Data) as Anno,
m.Stato as Stato,
sum(v.Prezzo * v.Quantità) as Fatturato
from vendite v
join mercati m 
on v.IdMercati =m.IdMercati
group by year(v.Data),
m.Stato
order by 
Anno asc,
Fatturato desc;

/* La query calcola il fatturato totale per stato e per anno, sommando il valore delle vendite (prezzo × quantità).
I dati sono raggruppati per anno e stato e ordinati prima per anno e poi per fatturato decrescente, così da evidenziare gli stati con le vendite più elevate. */

/* 6) Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?*/
select
c.NomeCategoria as Categoria,
sum(v.Quantità) AS Totale_Quantità
from vendite v
join prodotti p
on v.IdProdotto = p.IdProdotti
join categoria c
on p.IdCategoria = c.IdCategoria
group by c.NomeCategoria
order by Totale_Quantità desc
limit 1;

/* La query calcola la quantità totale venduta per ciascuna categoria e restituisce la categoria maggiormente richiesta dal mercato,  ordinando i risultati per
 quantità decrescente e limitando a una sola riga. */
 
/* 7) Rispondere alla seguente domanda: quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti.*/

select
p.IdProdotti,
p.NomeProdotto
from prodotti p
left join vendite v
on p.IdProdotti = v.IdProdotto
WHERE v.IdProdotto IS NULL;


Select 
IdProdotti,
NomeProdotto
from prodotti
where IdProdotti not in ( 
select distinct IdProdotto
from vendite);

/* I due approcci individuano i prodotti invenduti:
   - il primo tramite LEFT JOIN e verifica di valori NULL
   - il secondo escludendo i prodotti presenti nella tabella vendite */
   
   /* 8) Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” delle informazioni
utili (codice prodotto, nome prodotto, nome categoria) */

create view Informazioni_Prodotto as
select 
p.IdProdotti as Codice_Prodotto,
p.NomeProdotto as Nome_Prodotto,
c.NomeCategoria as Nome_Categoria
from prodotti p
join categoria c
on p.IdCategoria = c.IdCategoria;

select *
from informazioni_prodotto;

/* La vista espone una versione denormalizzata delle informazioni sui prodotti,  includendo codice prodotto, nome prodotto e categoria,
   semplificando l’analisi e il riutilizzo dei dati. */
   
  /* 9) Creare una vista per le informazioni geografiche. */
  
create view Informazioni_Geografiche as  
select 
m.IdMercati as Codice_Stato,
m.Stato as Stato,
r.NomeRegione as Area
from mercati m
join regioni r
on m.IdRegioni= r.IdRegioni;

select *
from Informazioni_Geografiche

/* La vista espone una versione denormalizzata delle informazioni geografiche, combinando stato e area geografica in un’unica struttura,
   semplificando le analisi territoriali e il riutilizzo dei dati. */