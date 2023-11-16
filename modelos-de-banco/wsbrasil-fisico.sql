CREATE DATABASE WSBrasil;

USE WSBrasil;

--Sessão dedicada à criação das tabelas
-- Tabelas de usuário e login
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

CREATE TABLE Login_Usuario(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Email VARCHAR(120),
    Senha NCHAR(32),
    Fk_Usuario_Id INT
);

-------------------------------------------------------------------------------------------

--Tabelas de endereço
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

--Tabelas referente a imóvel
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
--Sessão de contato
CREATE TABLE TipoContato(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Nome VARCHAR(80) NOT NULL
);

CREATE TABLE ContatoSite(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Nome VARCHAR(80) NOT NULL,
	Email VARCHAR(80) NOT NULL,
	Mensagem TEXT NOT NULL,
	DataHora Datetime NOT NULL,
	fk_TipoContato_id INT
);
-------------------------------------------------------------------------------------------
--Sessão dedicada aos Alter Tables para relacionamentos de entidades
-- Usuário e login
ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_2
    FOREIGN KEY (fk_TipoUsuario_ID)
    REFERENCES TipoUsuario (ID)
    ON DELETE CASCADE;

ALTER TABLE Login_Usuario ADD CONSTRAINT FK_Login_Usuario_2
    FOREIGN KEY (Fk_Usuario_Id)
    REFERENCES Usuario (ID);
-------------------------------------------------------------------------------------------
--Endereço
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
--Imóvel
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

ALTER TABLE Imagem ADD CONSTRAINT FK_Imagem_2
    FOREIGN KEY (fk_Imovel_ID)
    REFERENCES Imovel (ID);
----------------------------------------------------------------------------------------------
--Contato
alter table ContatoSite add constraint FK_ContatoSite_2
	foreign key (fk_TipoContato_id)
	references TipoContato (id)
	on delete cascade;
----------------------------------------------------------------------------------------------
--PROCEDURES
--INSERIR DADOS NAS TABELAS

--TABELA TipoContato--------------------------------------------------------------------------
IF OBJECT_ID('InserirDado', 'P') IS NOT NULL
	DROP PROCEDURE InserirDado;
GO

--criando procedure
CREATE PROCEDURE InserirDado
@nome VARCHAR(80)
AS -- inicia a procedure

BEGIN -- início do bloco da procedure
	INSERT INTO TipoContato(nome) VALUES (@nome);
END; --fim do bloco dda procedure

--chamando a procedure
EXEC InserirDado @nome = 'Não encontrei o imóvel';
EXEC InserirDado @nome = 'Não encontrei o vendedor';
EXEC InserirDado @nome = 'Quero vender';
EXEC InserirDado @nome = 'Crítica';
EXEC InserirDado @nome = 'Sugestões';

--TABELA ContatoSite---------------------------------------------------------------------------
IF OBJECT_ID('InserirDadoContato', 'P') IS NOT NULL
	DROP PROCEDURE InserirDadoContato;
GO

--criando procedure
CREATE PROCEDURE InserirDadoContato
@nome VARCHAR(80),
@email  VARCHAR(80),
@mensagem TEXT,
@fk INT

AS -- inicia a procedure

BEGIN -- início do bloco da procedure
	DECLARE @tipoContatoID INT;
	SELECT @tipoContatoID = Id FROM TipoContato WHERE Id = @fk;

	IF @tipoContatoID IS NULL
	BEGIN
		PRINT('Tipo de Contato não encontrado');
		RETURN -1;
	END

	INSERT INTO ContatoSite(Nome, Email, Mensagem, DataHora, fk_TipoContato_id)
	VALUES (@nome, @email, @mensagem, GETDATE(), @tipoContatoID);
END;
 --fim do bloco dda procedure

--chamando a procedure
exec InserirDadoContato @nome = 'José', @email = 'josfilho@email.com', @mensagem = 'Quais as formas de pagamento', @fk = 1;
exec InserirDadoContato @nome = 'Maria Santos', @email = 'maria.santos@hotmail.com', @mensagem = 'Quero fazer uma reclamação sobre o atendimento', @fk = 2;
exec InserirDadoContato @nome = 'Pedro Costa', @email = 'pedro.costa@yahoo.com', @mensagem = 'Parabéns pelo excelente trabalho', @fk = 3;
exec InserirDadoContato @nome = 'Ana Lima', @email = 'ana.lima@outlook.com', @mensagem = 'Preciso de um orçamento para um projeto', @fk = 4;
exec InserirDadoContato @nome = 'Bruno Dias', @email = 'bruno.dias@uol.com.br', @mensagem = 'Tenho uma dúvida sobre a forma de pagamento', @fk = 5;
exec InserirDadoContato @nome = 'Carla Souza', @email = 'carla.souza@bol.com.br', @mensagem = 'Quero cancelar minha compra', @fk = 1;
exec InserirDadoContato @nome = 'Daniel Oliveira', @email = 'daniel.oliveira@terra.com.br', @mensagem = 'Gostaria de fazer uma sugestão de melhoria', @fk = 2;
exec InserirDadoContato @nome = 'Eduarda Rocha', @email = 'eduarda.rocha@icloud.com', @mensagem = 'Quero elogiar o atendimento do vendedor', @fk = 3;
exec InserirDadoContato @nome = 'Fabio Martins', @email = 'fabio.martins@globo.com', @mensagem = 'Preciso de ajuda para resolver um problema', @fk = 4;
exec InserirDadoContato @nome = 'Fabio Martins', @email = 'gabriela.alves@zoho.com', @mensagem = 'Quero fazer uma parceria com sua empresa', @fk = 5;

----------------------------------------------------------------------------------------------
-- SESSÃO DE MANUTENÇÃO
--ALTERAR NOME DE TABELA
exec sp_rename login_usuario, Login_Usuario ;
--SELECIONAR TABELA
select * from Login_Usuario;
select * from TipoContato;
select * from ContatoSite;

--EXCLUIR TABELA
DROP TABLE TipoContato;
DROP TABLE ContatoSite;