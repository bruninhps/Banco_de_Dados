-- BANCO DE DADOS XI:

CREATE DATABASE dbDistribuidora;
USE dbDistribuidora;
 
 create table tbCliente(
	Id int primary key auto_increment,
	NomeCli varchar(200) not null,
	NumEnd  char(6) not null,
	CompEnd varchar(50) null,
	CepCli char(8) null /*FK (tbEndereco)*/
    
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
	CEP char(9) primary key /*FK*/ not null,
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
	CNPJ char(18) unique,
	Nome varchar(200) not null,
	Telefone char(14) not null
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
	NF int /*FK*/ null
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
(1, 'Revenda Chico Loco', '12.456.789/371-23', '(11)9345-67897'),
(2, 'José Faz Tudo S/A', '13.456.789/371-23', '(11)93456-7898'),
(3, 'Vadalto Entregas', '14.456.789/371-23', '(11)93456-7899'),
(4, 'Astrogildo das Estrelas', '15.456.789/371-23', '(11)93456-7800'),
(5, 'Amoroso e Doce', '16.456.789/371-23', '(11)93456-7801'),
(6, 'Marcelo Dedal', '17.456.789/371-23', '(11)93456-7802'),
(7, 'Franciscano Cachaça', '18.456.789/371-23', '(11)93456-7803'),
(8, 'Joãozinho Chupeta', '19.456.789/371-23', '(11)93456-7804');
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
alter table tbProduto
modify column Valor decimal(8,2);

DELIMITER $$
CREATE PROCEDURE spInsertProduto (
    IN CodigoBarras char(14),
    IN Nome VARCHAR(200),
    IN Valor decimal(8,2),
    IN Qtd INT
)
BEGIN
    INSERT INTO tbProduto (CodigoBarras, Nome, Valor, Qtd)
    VALUES (CodigoBarras, Nome, Valor, Qtd);
END $$
DELIMITER ; 

CALL spInsertProduto(12345678910111, 'Rei de Papel Mache', 54.61, 120);
CALL spInsertProduto(12345678910112, 'Bolinha de Sabão', 100.45, 120);
CALL spInsertProduto(12345678910113, 'Carro Bate', 44.00, 120);
CALL spInsertProduto(12345678910114, 'Bola Furada', 10.00, 120);
CALL spInsertProduto(12345678910115, 'Maçã Laranja', 99.44, 120);
CALL spInsertProduto(12345678910116, 'Boneco do Hitler', 124.00, 200);
CALL spInsertProduto(12345678910117, 'Farinha de Suruí', 50.00, 200);
CALL spInsertProduto(12345678910118, 'Zelador de Cemitério', 24.50, 100);
use dbDistribuidora;
describe tbProduto;


-- Procedure para tbENDERECO
DELIMITER $$
CREATE PROCEDURE spInsertEndereco (
    IN Logradouro VARCHAR(200),
	in CEP char(9)
)
BEGIN
    INSERT INTO tbEndereco (Logradouro, CEP)
    VALUES (Logradouro, CEP);
END $$
DELIMITER ;


call spInsertEndereco (12345051, 'Av Brasil');
call spInsertEndereco (12345052, 'Rua Liberdade');
call spInsertEndereco (12345053, 'Av Paulista');
call spInsertEndereco (12345054, 'Rua Ximbú');
call spInsertEndereco (12345055,'Rua Piu XI');
call spInsertEndereco (12345056,'Rua Chocolate');
call spInsertEndereco (12345057, 'Rua Pão na Chapa');

-- Procedure para tbClientePF
delimiter $$
create procedure spInsertClientePF(
	in CPF char(11), 
    in RG char(9), 
    in RG_Dig char(1), 
    in Nasc date)
begin

	insert into tbClientePF(CPF, RG, RG_Dig, Nasc)
	values(CPF, RG, RG_Dig, Nasc);
end $$
delimiter ;
describe tbClientePF;

call spInsertClientePF (12345678911,12345678,0,'2000-10-12');
call spInsertClientePF (12345678912,12345679,0,'2001-11-21');
call spInsertClientePF (12345678913,12345680,0,'2001-06-01');
call spInsertClientePF (12345678914,12345681,'X',2004-04-05);
call spInsertClientePF (12345678915,12345682,0,'2002-07-15');

-- Procedure para tbClientesPJ
delimiter $$
create procedure spInsertClientePJ(
	in CNPJ char(14),
    In IE char(11) 
)
begin
	insert into tbClientePJ (CNPJ, IE)
    values (CNPJ, IE);
end$$
delimiter ;
describe tbClientePJ;

call callspInsertClientePJ (12345678912345,98765432198);
call callspInsertClientePJ (12345678912346,98765432199);
call callspInsertClientePJ (12345678912347,98765432100);
call callspInsertClientePJ (12345678912348,98765432101);
call callspInsertClientePJ (12345678912349,98765432102);

-- Procedure para 
describe tbCompra;

delimiter $$
create procedure spInsertCompra(  
	IN pNotaFiscal INT,
    IN pFornecedor VARCHAR(100),
    IN pDataCompra VARCHAR(10),
    IN pCodigoBarras VARCHAR(20),
    IN pValorItem DECIMAL(10,2),
    IN pQtd INT,
    IN pQtdTotal INT,
    IN pValorTotal DECIMAL(10,2)
)
begin 
	declare CodigoBarras int;
    declare Codigo int;

    SELECT Codigo INTO IdFornecedor
    FROM Fornecedores
    WHERE nome = Fornecedor;
    
	SELECT CodigoBarras INTO IdProduto
    FROM Produtos
    WHERE codigo_barras = CodigoBarras;
    
	IF IdFornecedor IS NOT NULL AND IdProduto IS NOT NULL THEN
    
	INSERT INTO Compras (nota_fiscal, 
    id_fornecedor, 
    data_compra, 
    id_produto, 
    valor_item, 
    qtd, qtd_total, 
    valor_total)
    
	VALUES (pNotaFiscal, 
    vIdFornecedor, 
    STR_TO_DATE(pDataCompra, '%d/%m/%Y'), 
    vIdProduto, 
    pValorItem, 
    pQtd, 
    pQtdTotal, 
    pValorTotal);

end$$