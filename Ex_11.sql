-- BANCO DE DADOS XI:

CREATE DATABASE dbDistribuidora;
USE dbDistribuidora;
 
 create table tbCliente(
	Id int primary key auto_increment,
	NomeCli varchar(200) not null,
	NumEnd  char(6) not null,
	CompEnd varchar(50) null,
	CepCli char(8) not null /*FK (tbEndereco)*/
    
 );
 
 create table tbClientePF(
	CPF char(11) primary key,
	RG char(9) not null,
	RG_Dig char(1) not null,
	Nasc date not null
);
 
 create table tbClientePJ(
	CNPJ char(14) primary key,
	IE char(11) unique 
);
 
 create table tbEndereco(
	Logradouro varchar(200) not null,
	CEP char(8) primary key /*FK*/ not null,
	BairroId int /*FK*/ not null,
	CidadeId int /*fk*/ not null,
	UFId int /*FK*/ not null
);
 
 create table tbBairro(
	BairroId int primary key auto_increment  not null,
	Bairro varchar(200) not null
);
 
 create table tbCidade(
	CidadeId int primary key auto_increment,
	Cidade varchar(200) not null
);
 
 create table tbEstado(
	UFId int primary key auto_increment,
	UF char(2) not null 
);
 
 create table tbFornecedor(
	Codigo int primary key auto_increment ,
	CNPJ char(14) unique,
	Nome varchar(200) not null,
	Telefone char(11) not null
);
 
 create table tbProduto(
	CodigoBarras char(14) primary key unique,
	Nome varchar(200) not null,
	Valor char(9) not null,
	Qtd int not null 
);
 
 create table tbCompra(
	NotaFiscal int primary key not null, 
	DataCompra date not null,
	ValorTotal char(9) not null,
	QtdTotal int not null,
	Codigo int  /*FK*/
);
 
 create table tbItemCompra(
	NotaFiscal int  primary key auto_increment ,
	CodigoBarras char(14) ,
	ValorItem char(8) not null,
	Qtd int not null
    
);
 create table tbVenda(
	NumeroVenda  int primary key,
	DataVenda date not null,
	TotalVenda char(8) not null,
	Id_Cli int /*FK*/ not null,
	NF int /*FK*/ not null
);
 
 create table tbItemVenda(
	NumeroVenda int primary key,
	CodigoBarras char(14) /*PK/FK*/ ,
	ValorItem char(9) not null ,
	Qtd int not null
);
 
 create table tbNota_fiscal(
	NF int primary key,
	TotalNota char (9) not null,
	DataEmissao date not null 
);

alter table tbClientePF
add column Id int;

alter table tbClientePJ
add column Id int;

alter table tbClientePF
add constraint FK_Id_tbClientePF
foreign key (Id) references tbCliente(Id);

alter table tbClientePJ
add constraint FK_Id_tbClientePJ
foreign key (Id) references tbCliente(Id);

alter table tbCliente
add constraint FK_CepCli_tbCliente
foreign key (CepCli) references tbEndereco(Cep);

alter table tbEndereco
add constraint FK_BairroId_tbEndereco
foreign key (BairroId) references tbBairro(BairroId);

alter table tbEndereco
add constraint FK_CidadeId_tbEndereco
foreign key (CidadeId) references tbCidade(CidadeId);

alter table tbEndereco
add constraint FK_UFId_tbEndereco
foreign key (UFId) references tbEstado(UfId);

alter table tbVenda
add constraint FK_Id_Cli_Id_tbVenda
foreign key (Id_Cli) references tbCliente(Id);

alter table tbVenda
add constraint FK_NF_tbVenda
foreign key (NF) references tbNota_Fiscal (NF);

alter table tbItemVenda
add constraint FK_NumeroVenda_tbItemVenda 
foreign key (NumeroVenda) references tbVenda (NumeroVenda);

alter table tbItemVenda
add constraint FK_CodigoBarras_tbItemVenda
foreign key (CodigoBarras) references tbProduto(CodigoBarras);

alter table tbItemCompra
add constraint FK_NotaFiscal_tbItemCompra
foreign key (NotaFiscal) references tbCompra(NotaFiscal);


alter table tbItemCompra
add constraint FK_CodigoBarras_tbItemCompra
foreign key (CodigoBarras) references tbProduto(CodigoBarras);


alter table tbCompra
add constraint FK_Codigo_tbCompra
foreign key (Codigo) references tbFornecedor(Codigo);


-- Inserção direta em tbFORNECEDOR
INSERT INTO tbFORNECEDOR (Codigo, Nome, CNPJ, Telefone) VALUES
(1, 'Revenda Chico Loco', '12.456.789/371-23', '(11) 9 3456 7897'),
(2, 'José Faz Tudo S/A', '13.456.789/371-23', '(11) 9 3456 7898'),
(3, 'Vadalto Entregas', '14.456.789/371-23', '(11) 9 3456 7899'),
(4, 'Astrogildo das Estrelas', '15.456.789/371-23', '(11) 9 3456 7800'),
(5, 'Amoroso e Doce', '16.456.789/371-23', '(11) 9 3456 7801'),
(6, 'Marcelo Dedal', '17.456.789/371-23', '(11) 9 3456 7802'),
(7, 'Franciscano Cachaça', '18.456.789/371-23', '(11) 9 3456 7803'),
(8, 'Joãozinho Chupeta', '19.456.789/371-23', '(11) 9 3456 7804');
describe tbFornecedor;

-- Procedure para tbCIDADE
DELIMITER $$
CREATE PROCEDURE spInsertCidade (
	IN CidadeId INT, 
    IN Cidade VARCHAR(100))
BEGIN
    INSERT INTO tbCidade (CidadeId, Cidade) 
    VALUES (CidadeId, Cidade);
END $$
DELIMITER ;

CALL spInsertCidade(1, 'Rio de Janeiro');
CALL spInsertCidade(2, 'São Carlos');
CALL spInsertCidade(3, 'Campinas');
CALL spInsertCidade(4, 'Franco da Rocha');
CALL spInsertCidade(5, 'Osasco');
CALL spInsertCidade(6, 'Pirituba');
CALL spInsertCidade(7, 'Lapa');
CALL spInsertCidade(8, 'Ponta Grossa');
describe tbCidade;



-- Procedure para tbESTADO
DELIMITER $$
CREATE PROCEDURE spInsertEstado (
	IN UFId INT,
    IN UF CHAR(2))
BEGIN
    INSERT INTO tbEstado (UFId, UF) 
    VALUES (UFId, UF);
END $$
DELIMITER ;
CALL spInsertEstado(1, 'SP');
CALL spInsertEstado(2, 'RJ');
CALL spInsertEstado(3, 'RS');



-- Procedure para tbBAIRRO
DELIMITER $$
CREATE PROCEDURE spInsertBairro (
	IN BairroId INT,
    IN Bairro VARCHAR(100))
BEGIN
    INSERT INTO tbBairro (BairroId, Bairro) 
    VALUES (BairroId, Bairro);
END $$
DELIMITER ;
CALL spInsertBairro(1, 'Aclimação');
CALL spInsertBairro(2, 'Capão Redondo');
CALL spInsertBairro(3, 'Pirituba');
CALL spInsertBairro(4, 'Liberdade');

-- Procedure para tbPRODUTO
DELIMITER $$
CREATE PROCEDURE spInsertProduto (
    IN CodigoBaras char(14),
    IN Nome VARCHAR(200),
    IN Valor char(9),
    IN Qtd INT
)
BEGIN
    INSERT INTO tbProduto (CodigoDeBarras, Nome, Valor, Qtd)
    VALUES (CodigoBarras, Nome, Valor, Qtd);
END $
DELIMITER ; 

CALL spInsertProduto(12345678910111, 'Rei de Papel Mache', 54.61, 120);
CALL spInsertProduto(12345678910112, 'Bolinha de Sabão', 100.45, 120);
CALL spInsertProduto(12345678910113, 'Carro Bate', 44.00, 120);
CALL spInsertProduto(12345678910114, 'Bola Furada', 10.00, 120);
CALL spInsertProduto(12345678910115, 'Maçã Laranja', 99.44, 120);
CALL spInsertProduto(12345678910116, 'Boneco do Hitler', 124.00, 200);
CALL spInsertProduto(12345678910117, 'Farinha de Suruí', 50.00, 200);
CALL spInsertProduto(12345678910118, 'Zelador de Cemitério', 24.50, 100);

-- Procedure para tbENDERECO
DELIMITER $$
CREATE PROCEDURE spInsertEndereco (
    IN Logradouro VARCHAR(200),
	in CEP char(8),
    in BairroId int,
    in CidadeId int,
    in UFId int
)
BEGIN
    INSERT INTO tbEndereco (Logradouro, Bairro, Cidade, UF, CEP)
    VALUES (Logradouro, Bairro, Cidade, UF, CEP);
END $$
DELIMITER ;
describe tbEndereco;
CALL spInsertEndereco('Rua da Federal', 'Lapa', 'São Paulo', 'SP', '12345-050');
CALL spInsertEndereco('Av Brasil', 'Lapa', 'Campinas', 'SP', '12345-051');
CALL spInsertEndereco('Rua Liberdade', 'Consolação', 'São Paulo', 'SP', '12345-052');
CALL spInsertEndereco('Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ', '12345-053');
CALL spInsertEndereco('Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ', '12345-054');
CALL spInsertEndereco('Rua Piu XI', 'Penha', 'Campinas', 'SP', '12345-055');
CALL spInsertEndereco('Rua Chocolate', 'Aclimação', 'Barra Mansa', 'RJ', '12345-056');
CALL spInsertEndereco('Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa', 'RS', '12345-057');


