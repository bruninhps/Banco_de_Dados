-- Banco de dados exe: VIII
USE dbescola;

CREATE TABLE tbest (
  IdUf TINYINT PRIMARY KEY,
  NomeUfs CHAR(2) NOT NULL,
  NomeEstado VARCHAR (40) NOT NULL
);

ALTER TABLE tbEndereco ADD COLUMN FK_IdUf_tbEndereco TINYINT, ADD CONSTRAINT fk_IdUf_tbEndereco FOREIGN KEY (FK_IdUf_tbEndereco) REFERENCES tbest (IdUf);

ALTER TABLE tbest DROP COLUMN NomeEstado;

RENAME TABLE tbest TO tbEstado;

ALTER TABLE tbEstado RENAME COLUMN NomeUfs TO NomeUf;

ALTER TABLE tbEndereco ADD COLUMN IdCid SMALLINT;

USE dbescola;

CREATE TABLE tbcidade (
  IdCid SMALLINT PRIMARY KEY,
  NomeCidade VARCHAR(50) NOT NULL
);

ALTER TABLE tbcidade MODIFY COLUMN NomeCidade VARCHAR(250);

ALTER TABLE tbEndereco ADD CONSTRAINT fk_IdCid_tbEndereco FOREIGN KEY (IdCid) REFERENCES tbcidade (IdCid);

