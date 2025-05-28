CREATE DATABASE dbDistribuidora;
USE dbDistribuidora;

CREATE TABLE tbEstado (
    UFId INT PRIMARY KEY auto_increment,
    UF CHAR(2) NOT NULL 
);

CREATE TABLE tbCidade (
    CidadeId INT PRIMARY KEY auto_increment,
    Cidade VARCHAR(200) NOT NULL
);

CREATE TABLE tbBairro (
    BairroId INT PRIMARY KEY auto_increment,
    Bairro VARCHAR(200) NOT NULL
);

CREATE TABLE tbEndereco (
	Logradouro VARCHAR(200) NOT NULL,
    CEP DECIMAL(8,0) PRIMARY KEY,
    BairroId INT NOT NULL ,
    CidadeId INT NOT NULL,
    UFId INT NOT NULL,
    FOREIGN KEY (BairroId) REFERENCES tbBairro(BairroId),
    FOREIGN KEY (CidadeId) REFERENCES tbCidade(CidadeId),
    FOREIGN KEY (UFId) REFERENCES tbEstado(UFId)
);



CREATE TABLE tbCliente (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    NomeCli VARCHAR(200) NOT NULL,
    NumEnd DECIMAL(6,0) NOT NULL,
    CompEnd VARCHAR(50),
    CepCli DECIMAL(8,0),
    FOREIGN KEY (CepCli) REFERENCES tbEndereco(CEP)
);


CREATE TABLE tbCliente_pf (
	CPF DECIMAL(11,0) PRIMARY KEY,
    RG DECIMAL(9,0) not null,
    RG_Dig CHAR(1) not null,
    Nasc DATE NOT NULL,
	Id INT ,
    FOREIGN KEY (Id) REFERENCES tbCliente(Id)
);

CREATE TABLE tbCliente_pj (
	CNPJ decimal(14,0) primary key,
	IE decimal(11,0) unique,
	Id int,
	foreign key (Id) references tbCliente(Id)
);

CREATE TABLE tbfornecedor (
    Codigo INT PRIMARY KEY auto_increment,
    CNPJ decimal(14,0) unique,
    Nome VARCHAR(200) not null,
    Telefone decimal(11,0)
);

CREATE TABLE tbProduto (
    CodigoBarras DECIMAL(14,0) PRIMARY KEY unique,
    Nome VARCHAR(200) not null,
    Valor DECIMAL(8,2) not null,
    Qtd INT
);

CREATE TABLE tbnota_fiscal (
    NF INT PRIMARY KEY,
    TotalNota DECIMAL(8,2) not null,
    DataEmissao DATE not null
);

CREATE TABLE tbvenda (
    NumeroVenda INT PRIMARY KEY,
    DataVenda DATE not null,
    TotalVenda DECIMAL(8,2) not null,
    Id_Cl INT not null,
    NF INT,
    FOREIGN KEY (Id_Cl) REFERENCES tbCliente(Id),
    FOREIGN KEY (NF) REFERENCES tbnota_fiscal(NF)
);

CREATE TABLE tbitem_venda (
    NumeroVenda INT,
    CodigoBarras DECIMAL(14,0),
    ValorItem DECIMAL(8,2) NOT NULL,
    Qtd INT NOT NULL,
    PRIMARY KEY (NumeroVenda, CodigoBarras),
    FOREIGN KEY (NumeroVenda) REFERENCES tbvenda(NumeroVenda),
    FOREIGN KEY (CodigoBarras) REFERENCES tbProduto(CodigoBarras)
);

CREATE TABLE tbcompra (
    NotaFiscal INT PRIMARY KEY,
    DataCompra DATE not null,
    ValorTotal DECIMAL(8,2) not null,
    QtdTotal INT not null,
    Codigo INT,
    FOREIGN KEY (Codigo) REFERENCES tbfornecedor(Codigo)
);

CREATE TABLE tbitem_compra (
    NotaFiscal INT,
    CodigoBarras DECIMAL(14,0),
    ValorItem DECIMAL(8,2) NOT NULL,
    Qtd INT NOT NULL,
    PRIMARY KEY (NotaFiscal, CodigoBarras),
    FOREIGN KEY (NotaFiscal) REFERENCES tbcompra(NotaFiscal),
    FOREIGN KEY (CodigoBarras) REFERENCES tbProduto(CodigoBarras)
);


-- ex 1

insert into tbfornecedor (Codigo, Nome, CNPJ, Telefone) values 
(1, 'Revenda Chico Loco', '1245678937123', '11934567897'),
(2, 'José Faz Tudo S/A', '1345678937123', '11934567898'),
(3, 'Vadalto Entregas', '1445678937123', '11934567899'),
(4, 'Astrogildo das Estrela', '1545678937123', '11934567800'),
(5, 'Amoroso e Doce', '1645678937123', '11934567801'),
(6, 'Marcelo Dedal', '1745678937123', '11934567802'),
(7, 'Franciscano Cachaça', '1845678937123', '11934567803'),
(8, 'Joãozinho Chupeta', '1945678937123', '11934567804');


-- ex 2 -------
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

-- ex 3 ----
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

-- ex 4 -------

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

-- alter table tbproduto modify column Valor decimal(8,2);

-- ex 5 -----
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
describe tbproduto;


-- ex 6 ----
delimiter $$
CREATE PROCEDURE inserttbEndereco(vLogradouro VARCHAR(100),vCEP int,vBairro VARCHAR(200), vCidade VARCHAR(200), vEstado VARCHAR(200))
BEGIN
	DECLARE dBairro INT;
	DECLARE dCidade INT;
	DECLARE dEstado INT;

    -- BAIRRO
    IF NOT EXISTS (SELECT BairroId FROM tbBairro WHERE Bairro = vBairro) THEN 
		INSERT INTO tbBairro(Bairro)
        VALUES(vBairro);
    END IF;
        
    SET dBairro := (SELECT BairroId FROM tbBairro WHERE Bairro = vBairro);
        
    -- CIDADE
    IF NOT EXISTS (SELECT CidadeId FROM tbCidade WHERE Cidade = vCidade) THEN 
		INSERT INTO tbCidade(Cidade)
        VALUES(vCidade);
    END IF;
    
    SET dCidade := (SELECT CidadeId FROM tbCidade WHERE cidade = vCidade);
        
    -- UF
    IF NOT EXISTS (SELECT UFId FROM tbestado WHERE UF = vEstado) THEN 
		INSERT INTO tbestado(UF)
        VALUES(vEstado);
    END IF;
    
    SET dEstado := (SELECT UFId FROM tbestado WHERE UF = vEstado);
    
    insert into tbEndereco
    values(vLogradouro,vCep,dBairro, dCidade, dEstado);
    
	
    
END
$$

call inserttbEndereco( "Rua da Federal",12345050, "Lapa", "São Paulo", "SP");
call inserttbEndereco( "Av Brasil", 12345051,"Lapa", "Campinas", "SP");
call inserttbEndereco( "Rua Liberdade",12345052, "Consolação", "São Paulo", "SP");
call inserttbEndereco( "Ab Paulista", 12345053,"Penha", "Rio de Janeiro", "RJ");
call inserttbEndereco( "Rua Ximbú",12345054, "Penha", "Rio de Janeiro", "RJ");
call inserttbEndereco( "Rua Piu X1", 12345055,"Penha", "Campinas", "SP");
call inserttbEndereco( "Rua chocolate",12345056, "Aclimação", "Barra Mansa", "RJ");
call inserttbEndereco( "Rua Pão na Chapa",12345057, "Barra Funda", "Ponta Grossa", "RS");


select CEP,Logradouro,BairroId,CidadeId,UFid from tbendereco;
select * From tbCidade;
select * from tbEstado;
select * from tbBairro;

-- ex 7 -----

delimiter $$
Create Procedure insertCliente_PF (
vNomeCli varchar(200), 
vNumEnd mediumint,
vCompEnd varchar(50),
vCEP int,
vCPF bigint ,
vRG int,
vRG_Dig char(1),
vNasc date,
vLogradouro varchar(200),
vBairro varchar(200),
vCidade varchar(200),
vUF varchar(2)
)

Begin
	Declare dUFId int;
    Declare dCidadeId int;
    Declare dBairroId int;
    Declare dCepCli decimal ;
    Declare dId int;
    if not exists (select CPF from tbCliente_pf where CPF = vCPF) then

 if not exists (select CEP from tbEndereco where CEP = vCEP) then
		-- tbEstado
		if not exists (select UF from tbEstado where UF =  vUF) then
			insert into tbEstado(UF) values (vUF); 
		end if;
    

    -- TbBairro
    if not exists (select Bairro from tbBairro where Bairro =  vBairro) then      
		insert into tbBairro(Bairro) values (vBairro); 
	  end  if;
	 
	-- TbCidade
	if not exists (select Cidade from tbCidade where Cidade =  vCidade) then      
		insert into tbCidade(Cidade) values (vCidade); 
	  end if ;
      
    SET  dBairroId = (select BairroId from tbBairro where Bairro = vBairro);
	SET  dUFId = (select UFID from tbEstado where UF = vUF);     
	SET  dCidadeId = (select CidadeId from tbCidade where Cidade = vCidade);     
	-- tbEndereco    
     insert into tbEndereco (Logradouro,CEP,BairroId,CidadeId,UFId) values(vLogradouro,vCep,dBairroId,dCidadeId,dUFId);
     end if;     
     -- tbcliente     
	
		insert into tbCliente(Nomecli, CepCli, NumEnd, CompEnd) values (vNomeCli, vCEP, vNumEnd, vCompEnd);
        set dId = LAST_INSERT_ID();
		insert into tbCliente_pf( CPF, RG, Rg_Dig, Nasc, Id) values (vCPF, vRG, vRG_Dig, vNasc,dId);
	end if;
 end $$    
 
call InsertCliente_PF('Pimpão', 325, null, 12345051, 12345678911, 12345678, 0, '2000-12-10', 'Av. Brasil', 'Lapa', 'Campinas', 'SP');
call InsertCliente_PF('Disney Chaplin', 89, 'Ap. 12', 12345053, 12345678912, 12345679, 0, '2001-11-21', 'Av. Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call InsertCliente_PF('Marciano', 744, null, 12345054, 12345678913, 12345680, 0, '2001-06-01', 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
call InsertCliente_PF('Lança Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', '2004-04-05', 'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT');
call InsertCliente_PF('Remédio Amargo', 2485, null, 12345058, 12345678915, 12345682, 0, '2002-07-15', 'Av. Nova', 'Jardim Santa Isabel', 'Cuiabá', 'MT');


-- Ex.8

-- delimiter $$

-- create procedure InsertCliente_PJ

