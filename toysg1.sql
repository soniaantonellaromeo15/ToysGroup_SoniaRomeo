select*
from categoria;

INSERT INTO categoria (NomeCategoria, Tipologia)
VALUES
('Biciclette',   'Sport'),
('Abbigliamento','Sport'),
('Costruzioni',  'Didattica'),
('Peluches',     'Infanzia');

select*
from categoria;

INSERT INTO prodotti (NomeProdotto, CostoUnitario, IdCategoria)
VALUES
('Bici Junior 16',        120.00, 1),
('Bici Mountain 20',      200.00, 1),
('Casco Bici Kids',        35.00, 2),
('Guanti Bici S',          15.00, 2),
('Kit Mattoncini 200pz',   45.00, 3),
('Castello Mattoncini',    60.00, 3),
('Orsetto Peluche 30cm',   20.00, 4),
('Coniglietto Peluche',    18.00, 4);

select*
from prodotti;

INSERT INTO regioni (NomeRegione)
VALUES
('NordEuropa'),
('SudEuropa'),
('CentroEuropa');

select*
from regioni;

INSERT INTO mercati (Stato, IdRegioni)
VALUES
('Italia',        2),
('Spagna',        2),
('Francia',       1),
('Germania',      1),
('Belgio',        3),
('Paesi Bassi',   3),
('Portogallo',    2),
('Austria',       3);

select*
from mercati;

INSERT INTO vendite (Data, Quantità, Prezzo, IdProdotto, IdMercati)
VALUES
('2024-01-10', 2, 150.00, 1, 1),
('2024-01-15', 1, 150.00, 1, 3),
('2024-02-05', 1, 280.00, 2, 4),
('2024-02-15', 3,  25.00, 4, 1),
('2024-03-01', 1,  50.00, 3, 2),
('2024-03-10', 2,  70.00, 5, 5),
('2024-03-15', 1,  95.00, 6, 6),
('2024-04-01', 4,  30.00, 7, 7),
('2024-04-12', 2,  28.00, 8, 6),
('2024-04-20', 1, 280.00, 2, 1),
('2024-05-04', 3,  25.00, 4, 4),
('2024-05-15', 2,  95.00, 6, 3),
('2024-06-01', 1,  70.00, 5, 1),
('2024-06-12', 5,  30.00, 7, 2),
('2024-06-20', 2,  28.00, 8, 5),
('2024-07-02', 4, 150.00, 1, 1),
('2024-07-15', 2, 280.00, 2, 4),
('2024-07-30', 1,  50.00, 3, 3),
('2024-08-10', 3,  25.00, 4, 6),
('2024-08-20', 2,  95.00, 6, 8);

select*
from vendite;