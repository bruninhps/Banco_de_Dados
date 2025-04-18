-- BANCO DE DADOS XI:

CREATE DATABASE dbDistribuidora;
USE dbDistribuidora;
 
 create table tbCliente(
	Id int primary key auto_increment,
	NomeCli varchar(200) not null,
	NumEnd  decimal(6,0) not null,
	CompEnd varchar(50) null,
	CepCli decimal(8,0) not null /*FK (tbEndereco)*/
    
 );
 
 create table tbClientePF(
	CPF decimal(11,0) primary key,
	RG decimal(9,0) not null,
	RG_Dig char(1) not null,
	Nasc date not null
);
 
 create table tbClientePJ(
	CNPJ decimal(14,0) primary key,
	IE decimal(11,0) unique 
);
 
 create table tbEndereco(
	Logradouro varchar(200) not null,
	CEP decimal(8,0) primary key /*FK*/ not null,
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
	CNPJ decimal(14,0) unique,
	Nome varchar(200) not null,
	Telefone decimal(11,0) not null
);
 
 create table tbProduto(
	CodigoBarras decimal(14,0) primary key unique,
	Nome varchar(200) not null,
	Valor decimal(9,2) not null,
	Qtd int not null 
);
 
 create table tbCompra(
	NotaFiscal int primary key not null, 
	DataCompra date not null,
	ValorTotal decimal(9,2) not null,
	QtdTotal int not null,
	Codigo int  /*FK*/
);
 
 create table tbItemCompra(
	NotaFiscal int  primary key auto_increment ,
	CodigoBarras decimal(14,0) ,
	ValorItem decimal(8,2) not null,
	Qtd int not null
    
);
 create table tbVenda(
	NumeroVenda  int primary key,
	DataVenda date not null,
	TotalVenda decimal (8,2) not null,
	Id_Cli int /*FK*/ not null,
	NF int /*FK*/ not null
);
 
 create table tbItemVenda(
	NumeroVenda int primary key,
	CodigoBarras decimal(14,0) /*PK/FK*/ ,
	ValorItem decimal(9,2) not null ,
	Qtd int not null
);
 
 create table tbNota_fiscal(
	NF int primary key,
	TotalNota decimal (9,2) not null,
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


insert into tbFornecedor values
( 'Revenda Chico Loco', '12.456.789/371-23', '(11)9 3456 7897'),
( 'José Faz Tudo S/A', '13.456.789/371-23', '(11) 9 3456 7898'),
( 'Vadalto Entregas', '14.456.789/371-23', '(11) 9 3456 7899'),
( 'Astrogildo das Estrelas', '15.456.789/371-23', '(11) 9 3456 7800'),
( 'Amoroso e Doce', '16.456.789/371-23', '(11) 9 3456 7801'),
( 'Marcelo Dedal', '17.456.789/371-23', '(11) 9 3456 7802'),
( 'Franciscano Cachaça', '18.456.789/371-23', '(11) 9 3456 7803'),
( 'Joãozinho Chupeta', '19.456.789/371-23', '(11) 9 3456 7804');

delimiter $$

create procedure spInsertCidade ()
begin 
	insert into tbCidade(CidadeId, Cidade)
	values (VCidadeId int, VCidade varchar(200))
	
end$$

delimiter;
	call spinsertCidade	(1 ,'Rio de Janeiro'),
	call spinsertCidade	(2, 'São Carlos'),
	call spinsertCidade	(3, 'Campinas'),
	call spinsertCidade	(4, 'Franco da Rocha'),
	call spinsertCidade	(5, 'Osasco'),
	call spinsertCidade	(6, 'Pirituba'),
	call spinsertCidade	(7, 'Lapa'),
	call spinsertCidade (8, 'Ponta Grossa');

describe tbCidade;

delimiter $$


create procedure spInsertEstado()
begin
	insert into tbEstado(UFId, UF)
    values 
		
        
end$$ 
delimiter;
call spInsertEstado (1, 'Aclimação');
call spInsertEstado(2, 'Capão Redondo');
call spInsertEstado(3, 'Pirituba');
call spInsertEstado(4, 'Liberdade');


delimiter $$

create procedure spInsertProduto()
begin
	insert into tbProduto( Nome, ValorUnitario, Quantidade)
    values
		( 'Rei de Papel Mache', 54,61 ,120  ),
		( 'Bolinha de Sabão', 100,45 ,120),
		( 'Carro Bate', 44,00 ,120),
		( 'Bola Furada', 10,00 ,120),
		( 'Maçã Laranja', 99,44 ,120),
		( 'Boneco do Hitler', 124,00 ,200),
		( 'Farinha de Suruí', 50,00 ,200),
		( 'Zelador de Cemitério', 24,50 ,100);
        
end$$
delimiter;
call spinsertProduto();





delimiter $$
 
create procedure spInsertEndereco()
begin
	insert into tbEndereco( Logradouro, Bairro, Cidade, UF, CEP)
    values 
		('Rua da Federal', 'Lapa', 'São Paulo', 'SP', 12345-050),
		('Av Brasil', 'Lapa', 'Campinas', 'SP', 12345-051),
		('Rua Liberdade', 'Consolação', 'São Paulo', 'SP', 12345-052),
		('Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ', 12345-053),
		('Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ', 12345-054),
		('Rua Piu XI', 'Penha', 'Campinas', 'SP', 12345-055),
		('Rua Chocolate', 'Aclimação', 'Barra Mansa', 'RJ', 12345-056),
		('Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa', 'RS', 12345-057);

end$$
delimiter;
call spInsertEndereco();


delimiter $$

create procedure InsertClientePF()
begin
	insert into tbClientePF(NomeCli, NumEnd, CompEnd, CEP, CPF, RG, RG_Dig, Nasc, Logradouro, Bairro, Cidade, UF)
    values
		(1, 'Pimpão', 325, Null, 12345-051, 12345678911, 12345678, 0, '12/10/2000', 'Av Brasil', 'Lapa', 'Campinas', 'SP'),
 		(2, 'Disney Chaplin', 89, 'Ap. 12', 12345-053, 12345678912, 12345679, 0, '21/11/2001', 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ'),
 		(3, 'Marciano', 744, Null, 12345-054, 12345678913, 12345680, 0, '01/06/2001', 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ'),
 		(4, 'Lança Perfume', 128, Null, 12345-059, 12345678914, 12345681, 'X', '05/04/2004', 'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT'),
 		(5, 'Remédio Amargo', 2585, Null, 12345-058, 12345678915, 12345682, 0, '15/07/2002', 'Av Nova', 'Jardim Santa Isabel', 'Cuiabá', 'MT');
    
    end$$
    delimiter;
    call spInsertClientePF();


delimiter $$

create procedure spInsertClientePJ()
begin
	insert into tbClientePJ(NomeCli, CNPJ, IE, CEP, Logradouro, NumEnd, CompEnd, Bairro, Cidade, UF)
    values 
		(6, 'Paganada', 12345678912345, 98765432198, 12345-051, 'Av Brasil', 159, Null, 'Lapa', 'Campinas', 'SP'),
		(7, 'Caloteando', 12345678912346, 98765432199, 12345-053, 'Av Paulista', 69, Null, 'Penha', 'Rio de Janeiro', 'RJ'),
		(8, 'Semgrana', 12345678912347, 98765432100, 12345-060, 'Rua dos Amores', 189, Null, 'Sei Lá', 'Recife', 'PE'),
		(9, 'Cemreais', 12345678912348, 98765432101, 12345-060, 'Rua dos Amores', 5024, 'Sala', 23, 'Sei Lá', 'Recife', 'PE'),
		(10, 'Durango', 12345678912349, 98765432102, 12345-060, 'Rua dos Amores', 1254, Null, 'Sei Lá', 'Recife', 'PE');

    end$$
    delimiter;
    call spInsertClientePJ();






