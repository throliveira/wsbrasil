CREATE DATABASE WSBrasil;

USE WSBrasil;

--Sess�o dedicada � cria��o das tabelas
-- Tabelas de usu�rio e login
CREATE TABLE TipoUsuario (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Tipo VARCHAR(80)
);

CREATE TABLE Usuario (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(120),
    Senha NCHAR(32),
    DataHoraCrianao DATETIME,
    DataHoraUltimoAcesso DATETIME,
    Email VARCHAR(120),
    fk_TipoUsuario_ID INT
);

CREATE TABLE Login (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Email VARCHAR(120),
    Senha NCHAR(32),
    Fk_Usuario_Id INT
);
-------------------------------------------------------------------------------------------

--Tabelas de endere�o
CREATE TABLE UF (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nome_UF VARCHAR(120),
    Sigla_UF CHAR(2)
);

CREATE TABLE Cidade (
	ID INT PRIMARY KEY IDENTITY(1,1),
    Nome_cidade VARCHAR(120),
    fk_UF_ID INT
);

CREATE TABLE Bairro (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nome_bairro VARCHAR(120),
    fk_Cidade_ID INT
);

CREATE TABLE Endereco (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Logradouro VARCHAR(120),
    Numero INT,
    Complemento VARCHAR(120),
    fk_Bairro_ID INT
);
----------------------------------------------------------------------------------------------

--Tabelas referente a im�vel
CREATE TABLE TipoImovel (
    ID INT PRIMARY KEY IDENTITY(1,1),
    NomeTipoImovel VARCHAR(120)
);

CREATE TABLE TipoAnuncio (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nome_Tipo_Anuncio VARCHAR(120)
);

CREATE TABLE Imovel (
	ID INT PRIMARY KEY IDENTITY(1,1),
    Qtd_vaga INT,
    Qtd_quarto INT,
    Qtd_suite INT,
    Qtd_banheiro INT,
    Area_util INT,
    Valor_imovel DECIMAL,
    Observacoes TEXT,
    fk_TipoImovel_ID INT,
    fk_Endereco_ID INT,
    fk_TipoAnuncio_ID INT
);

CREATE TABLE Imagem (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nome_Imagem VARCHAR(120),
    url VARCHAR(120),
    fk_Imovel_ID INT
);
-------------------------------------------------------------------------------------------
--Sess�o dedicada aos Alter Tables para relacionamentos de entidades
-- Usu�rio e login
ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_2
    FOREIGN KEY (fk_TipoUsuario_ID)
    REFERENCES TipoUsuario (ID)
    ON DELETE CASCADE;

ALTER TABLE Login ADD CONSTRAINT FK_Login_2
    FOREIGN KEY (Fk_Usuario_Id)
    REFERENCES Usuario (ID);
-------------------------------------------------------------------------------------------
--Endere�o
ALTER TABLE Cidade ADD CONSTRAINT FK_Cidade_2
    FOREIGN KEY (fk_UF_ID)
    REFERENCES UF (ID);

ALTER TABLE Bairro ADD CONSTRAINT FK_Bairro_2
    FOREIGN KEY (fk_Cidade_ID)
    REFERENCES Cidade (ID);

ALTER TABLE Endereco ADD CONSTRAINT FK_Endereco_2
    FOREIGN KEY (fk_Bairro_ID)
    REFERENCES Bairro (ID);
-------------------------------------------------------------------------------------------
--Im�vel
ALTER TABLE Imovel ADD CONSTRAINT FK_Imovel_3
    FOREIGN KEY (fk_Endereco_ID)
    REFERENCES Endereco (ID);

ALTER TABLE Imovel ADD CONSTRAINT FK_Imovel_2
    FOREIGN KEY (fk_TipoImovel_ID)
    REFERENCES TipoImovel (ID)
    ON DELETE CASCADE;

ALTER TABLE Imovel ADD CONSTRAINT FK_Imovel_4
    FOREIGN KEY (fk_TipoAnuncio_ID)
    REFERENCES TipoAnuncio (ID)
    ON DELETE CASCADE;

/*
ALTER TABLE Imovel ADD CONSTRAINT FK_Imovel_5
    FOREIGN KEY (Imagem???)
    REFERENCES ??? (???);
*/

ALTER TABLE Imagem ADD CONSTRAINT FK_Imagem_2
    FOREIGN KEY (fk_Imovel_ID)
    REFERENCES Imovel (ID);
----------------------------------------------------------------------------------------------