-- Banco de dados exe: VII

-- Bruno e Amanda

CREATE DATABASE dbEscola;
USE dbEscola;

CREATE TABLE tbCliente (
  IdCli INT PRIMARY KEY,
  NomeCli CHAR(50) NOT NULL,
  NumEnd SMALLINT,
  DataCadastro DATETIME
);

ALTER TABLE tbCliente ADD CPF char(11) unique not null;

ALTER TABLE tbCliente ADD Cep char(5);

CREATE DATABASE dbEmpresa;

use dbEscola;

CREATE TABLE tbEndereco (
  Cep char(5) PRIMARY KEY,
  Logradouro CHAR(250) NOT NULL,
  IdUf TINYINT NOT NULL
);

ALTER TABLE tbCliente ADD CONSTRAINT fk_Cep_tbCliente FOREIGN KEY (Cep) REFERENCES tbEndereco (Cep);

SHOW COLUMNS FROM tbCliente;
/* Por enquanto, não tive nem uma dificuldade.
Mas não sei como vai ser durante os exercicios */

show databases;

DROP DATABASE dbEmpresa;

