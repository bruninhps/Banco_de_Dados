-- Banco de dados exe:I
CREATE DATABASE dbBruno;
USE dbBruno;

CREATE TABLE tbUsuario (
  IdUsuario INT PRIMARY KEY,
  NomeUsuario CHAR(45),
  DataNascimento DATE
);

CREATE TABLE tbEstado (
  id INT Primary key Not null,
  uf CHAR(2)
);

CREATE TABLE tbCliente (
  CodigoCli SMALLINT Primary Key NOT NULL,
  Nome CHAR(50),
  Endereco CHAR(60)
);

CREATE TABLE tbProduto (
  Barras CHAR(13) Primary Key NOT NULL,
  Valor FLOAT,
  Descricao CHAR(150)
);

DESCRIBE tbProduto;

SHOW TABLES;

SHOW DATABASES;

ALTER TABLE tbCliente MODIFY COLUMN Nome CHAR(58);

ALTER TABLE tbProduto ADD Qtd INT;

DROP TABLE tbEstado;

ALTER TABLE tbUsuario DROP COLUMN DataNascimento;