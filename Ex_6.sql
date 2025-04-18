-- Banco de dados exe: VI

CREATE DATABASE dbdesenvolvimento;
USE dbdesenvolvimento;

CREATE TABLE tbproduto (
  IdProp INT PRIMARY KEY,
  NomeProd VARCHAR (50) NOT NULL,
  Qtd INT,
  DataValidade DATE NOT NULL,
  Preço DECIMAL (8,2) NOT NULL
);

ALTER TABLE tbProduto ADD Peso DECIMAL (7,2),
ADD Cor VARCHAR (50),
ADD Marca VARCHAR (50) NOT NULL;

ALTER TABLE tbProduto DROP COLUMN Cor;
ALTER TABLE tbProduto MODIFY COLUMN Peso DECIMAL (10,2) NOT NULL;

/*Não foi possível excluir a coluna "Cor".
 Pois já foi feita a remoção da coluna "Cor" */

CREATE DATABASE dbLojaGrande;
ALTER TABLE tbproduto ADD COLUMN Cor VARCHAR(50);

CREATE DATABASE dbLojica;
USE dblojica;

CREATE TABLE tbcliente (
    NomeCli VARCHAR(50) NOT NULL,
    CodigoCli INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    DataCadastro DATE NOT NULL
);

USE dbLojaGrande;
CREATE TABLE tbfuncionario (
    NomeFunc VARCHAR(50) NOT NULL,
    CodigoFunc INT PRIMARY KEY AUTO_INCREMENT,
    DataCadastro DATE NOT NULL
);

DROP DATABASE dbLojaGrande;

USE dblojica;
ALTER TABLE tbcliente ADD COLUMN cpf CHAR(11) UNIQUE NOT NULL;

