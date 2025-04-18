-- Banco de dados exe: III
CREATE DATABASE dbcomercio;
USE dbcomercio;

CREATE TABLE tbCliente (
  Id TINYINT PRIMARY KEY,
  NomeCli CHAR(200) NOT NULL,
  NumEnd BIT(6) NOT NULL,
  CompEnd CHAR(50)
);

CREATE TABLE tbClientePF (
  CPF BIT(11) PRIMARY KEY,
  RG BIT(9),
  Rgdig CHAR(1),
  Nascimento DATE NOT NULL
);

-- Banco de dados exe: IV
CREATE DATABASE dbRosalina;
USE dbRosalina;

CREATE TABLE tbproduto (
  IdProp INT PRIMARY KEY,
  NomeProd VARCHAR(50) NOT NULL,
  Qtd INT,
  DataValida DATE NOT NULL,
  Preço DECIMAL (8,2) NOT NULL
);

ALTER TABLE tbproduto ADD COLUMN Peso DECIMAL (5,2) NULL, ADD COLUMN Cor VARCHAR (50) NULL, ADD COLUMN Marca VARCHAR (50) NOT NULL;

ALTER TABLE tbproduto DROP COLUMN Cor;

ALTER TABLE tbproduto MODIFY COLUMN Peso DECIMAL (5,2) NOT NULL;

ALTER TABLE tbproduto DROP COLUMN DataValida;

SHOW TABLES;

