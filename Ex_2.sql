-- Banco de dados exe: II
CREATE DATABASE dbMarcelo;
USE dbMarcelo;

CREATE TABLE tbproduto (
  IdProp INT PRIMARY KEY,
  NomeProd VARCHAR(50) NOT NULL,
  Qtd INT,
  DataValidade DATE NOT NULL,
  Preço DECIMAL (8,2)
);

CREATE TABLE tbcliente (
  Código INT PRIMARY KEY,
  NomeCli VARCHAR (50) NOT NULL,
  DataNascimento DATE
);

