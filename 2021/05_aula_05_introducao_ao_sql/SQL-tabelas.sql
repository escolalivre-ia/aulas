-- Script

-- Criando banco de dados

CREATE DATABASE dw;

USE dw;

-- Criando tabelas

CREATE TABLE D_PRODUTO
( 
  IdProduto varchar(2) NOT NULL, 
  Nome_produto varchar(200) NOT NULL, 
  Categoria varchar(200) NULL,
  Marca varchar(200) NULL,
  CONSTRAINT pkproduto PRIMARY KEY (IdProduto)
);

CREATE TABLE D_DATA
( 
  IdData varchar(2) NOT NULL, 
  Data_venda date NOT NULL, 
  Semestre int NULL,
  Ano int NULL,
  CONSTRAINT pkdata PRIMARY KEY (IdData)
);

CREATE TABLE D_LOJA
( 
  IdLoja varchar(2) NOT NULL, 
  Nome_loja varchar(200) NULL,
  CONSTRAINT pkloja PRIMARY KEY (IdLoja)
);

CREATE TABLE F_VENDA
( 
  IdProduto varchar(2) NOT NULL,
  IdLoja varchar(2) NOT NULL,
  IdData varchar(2) NOT NULL ,
  Valor int NOT NULL, 
  Quantidade int NULL,
  CONSTRAINT fkproduto FOREIGN KEY (IdProduto) REFERENCES D_PRODUTO(IdProduto),
  CONSTRAINT fkloja FOREIGN KEY (IdLoja) REFERENCES D_LOJA(IdLoja),
  CONSTRAINT fkdata FOREIGN KEY (IdData) REFERENCES D_DATA(IdData)
);

-- inserindo os elementos

INSERT INTO D_LOJA
 (IdLoja, Nome_loja)
VALUES ('l1', 'Central');

INSERT INTO D_LOJA
 (IdLoja, Nome_loja)
VALUES ('l2', 'Baixada');

INSERT INTO D_PRODUTO
 (IdProduto, Nome_produto, Categoria, Marca)
VALUES ('p1', 'Geladeira', 'Eletrodoméstico', 'Frozen');

INSERT INTO D_PRODUTO
 (IdProduto, Nome_produto, Categoria, Marca)
VALUES ('p2', 'Celular', 'Telefonia', 'Radar');

INSERT INTO D_PRODUTO
 (IdProduto, Nome_produto, Categoria, Marca)
VALUES ('p3', 'Pneu', 'Automotivo', 'Frota');

INSERT INTO D_DATA
 (IdData, Data_venda, Semestre, Ano)
VALUES ('d1', '2015-02-01', 1, 2015);

INSERT INTO D_DATA
 (IdData, Data_venda, Semestre, Ano)
VALUES ('d2', '2017-07-10', 2, 2017);

INSERT INTO D_DATA
 (IdData, Data_venda, Semestre, Ano)
VALUES ('d3', '2018-11-06', 2, 2018);

INSERT INTO D_DATA
 (IdData, Data_venda, Semestre, Ano)
VALUES ('d4', '2017-12-25', 2, 2017);

INSERT INTO D_DATA
 (IdData, Data_venda, Semestre, Ano)
VALUES ('d5', '2017-02-01', 1, 2017);

INSERT INTO D_DATA
 (IdData, Data_venda, Semestre, Ano)
VALUES ('d6', '2018-11-06', 2, 2018);

INSERT INTO D_DATA
 (IdData, Data_venda, Semestre, Ano)
VALUES ('d7', '2016-03-09', 1, 2016);

INSERT INTO F_VENDA 
(IdLoja, IdProduto, IdData, Valor, Quantidade)
VALUES ('l1', 'p1', 'd1', 1000, 2);

INSERT INTO F_VENDA 
(IdLoja, IdProduto, IdData, Valor, Quantidade)
VALUES ('l2', 'p1', 'd2', 1000, 1);

INSERT INTO F_VENDA 
(IdLoja, IdProduto, IdData, Valor, Quantidade)
VALUES ('l1', 'p1', 'd3', 1000, 1);

INSERT INTO F_VENDA 
(IdLoja, IdProduto, IdData, Valor, Quantidade)
VALUES ('l2', 'p2', 'd4', 700, 3);

INSERT INTO F_VENDA 
(IdLoja, IdProduto, IdData, Valor, Quantidade)
VALUES ('l2', 'p2', 'd4', 700, 1);

INSERT INTO F_VENDA 
(IdLoja, IdProduto, IdData, Valor, Quantidade)
VALUES ('l1', 'p3', 'd5', 150, 4);

INSERT INTO F_VENDA 
(IdLoja, IdProduto, IdData, Valor, Quantidade)
VALUES ('l1', 'p3', 'd6', 150, 4);

INSERT INTO F_VENDA 
(IdLoja, IdProduto, IdData, Valor, Quantidade)
VALUES ('l2', 'p3', 'd5', 150, 2);

INSERT INTO F_VENDA 
(IdLoja, IdProduto, IdData, Valor, Quantidade)
VALUES ('l2', 'p3', 'd7', 150, 1);

-- listando os elementos

select * from D_PRODUTO;

select * from D_DATA;

select * from D_LOJA;

select * from F_VENDA;

select * from F_VENDA, D_PRODUTO, D_DATA, D_LOJA where 
F_VENDA.IdProduto = D_PRODUTO.IdProduto and 
F_VENDA.IdData = D_DATA.IdData and
F_VENDA.IdLoja = D_LOJA.IdLoja;