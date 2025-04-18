-- Banco de dados exe: IX
CREATE DATABASE dbBANCO;
USE dbBANCO;

CREATE TABLE tbBanco (
  Codigo INT PRIMARY KEY,
  Nome VARCHAR(50) NOT NULL
  
);

CREATE TABLE tbAgencia (
  CodBanco INT ,
  NumeroAgencia INT PRIMARY KEY,
  Endereco VARCHAR(50) NOT NULL,
  FOREIGN KEY (CodBanco) REFERENCES tbBanco(Codigo)
);

CREATE TABLE tbConta (
  NumeroConta INT PRIMARY KEY auto_increment,
  Saldo DECIMAL(7, 2),
  TipoConta SMALLINT,
  NumAgencia INT not null,
  foreign key (NumAgencia) references tbAgencia(NumeroAgencia)
);

CREATE TABLE tbHistorico (
  Cpf int,
  NumeroConta INT,
  DataInicio DATE,
  PRIMARY KEY (Cpf, NumeroConta),
  foreign key (NumeroConta) references tbConta(NumeroConta)
  
);

CREATE TABLE tbCliente (
  Cpf int PRIMARY KEY,
  Nome VARCHAR(50) NOT NULL,
  Sexo CHAR(1) NOT NULL,
  Endereco VARCHAR(50) NOT NULL
);
 alter table tbHistorico 
 add foreign key (Cpf) references tbCliente(Cpf);
 

CREATE TABLE tbTelefone_cliente (
  Cpf int,
  Telefone INT PRIMARY KEY,
  FOREIGN KEY (Cpf) REFERENCES tbCliente (Cpf)
);

INSERT INTO tbBanco VALUES 
(1, 'Banco do Brasil'),
(104, 'Caixa Economica Federal'),
(801, 'Banco Escola');


INSERT INTO tbAgencia VALUES 
(1, 123, 'Av Paulista, 78'),
(104, 159, 'Rua Liberdade, 124'),
(801, 401, 'Rua das Artes, 75'),
(801, 485, 'Av Marechal, 68');

INSERT INTO tbCliente (Cpf, Nome, Sexo, Endereco) VALUES
(12345678910, 'Enildo', 'M', 'Rua Grande, 75');
INSERT INTO tbCliente (Cpf, Nome, Sexo, Endereco) VALUES
(12345678911, 'Astrogildo', 'M', 'Rua Pequena, 789');
INSERT INTO tbCliente (Cpf, Nome, Sexo, Endereco) VALUES
(12345678912, 'Monica', 'F', 'Av Larga, 148');
INSERT INTO tbCliente (Cpf, Nome, Sexo, Endereco) VALUES
(12345678913, 'Cascão', 'M', 'Av Principal, 369');

-- sdfgsfsdfsdfsd-
select * from tbCliente;
describe tbCliente;
select * from tbhistorico;
-- sdfgsfsdfsdfsd-



INSERT INTO tbConta VALUES 
(9876, 456.05, 1, 123),
(9877, 321.00, 1, 123),
(9878, 100.00, 2, 485),
(9879, 5589.48, 1, 401);

INSERT INTO tbHistorico VALUES 
(12345678910, 9876, '2001-04-15'),
(12345678911, 9877, '2011-03-10'),
(12345678912, 9878, '2021-01-05'),
(12345678913, 9879, '2000-07-15');

INSERT INTO tbTELEFONE_CLIENTE VALUES 
(12345678910, 912345678),
(12345678911, 912345679),
(12345678912, 912345680),
(12345678913, 912345681);

ALTER TABLE tbCliente 
ADD e_mail VARCHAR(100);



SELECT Cpf, Endereco 
FROM tbCliente 
WHERE Nome = 'Monica';

SELECT NumeroAgencia, Endereco 
FROM tbAgencia
WHERE CodBanco = (
    SELECT Codigo 
    FROM tbBanco
    WHERE Nome = 'Banco Escola'
);


-- Banco de dados exe: X 


DELETE FROM tbTELEFONE_CLIENTE  WHERE Cpf = '12345678911';


UPDATE tbConta SET TipoConta = 2 WHERE NumeroConta = 9879;

SET SQL_SAFE_UPDATES = 0;


UPDATE tbCliente SET e_mail = 'Astro@Escola.com' WHERE Nome = 'Monica';




UPDATE tbconta SET Saldo = Saldo * 1.10 WHERE NumeroConta = 9876;


SELECT Nome, E_mail, Endereco FROM tbcliente WHERE Nome = 'Monica';


UPDATE tbcliente 
SET Nome = 'Enildo Candido', E_mail = 'enildo@escola.com' 
WHERE Nome = 'Enildo';


UPDATE tbconta SET Saldo = Saldo - 30;


DELETE FROM tbConta WHERE NumeroConta = 9878;
SET SQL_SAFE_UPDATES = 1;

