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

--TABELA TipoUsuario--------------------------------------------------------------------------
IF OBJECT_ID('InserirTipoUsuario','P') IS NOT NULL
	DROP PROCEDURE InserirTipoUsuario;
GO

CREATE PROCEDURE InserirTipoUsuario
@tipo VARCHAR(80)
AS

BEGIN
	INSERT INTO TipoUsuario(Tipo) VALUES(@tipo);
END;

EXEC InserirTipoUsuario @tipo = 'Cliente';
EXEC InserirTipoUsuario @tipo = 'Corretor';

--TABELA Usuario-----------------------------------------------------------------------------
IF OBJECT_ID('InserirUsuario', 'P') IS NOT NULL
	DROP PROCEDURE InserirUsuario;
GO

CREATE PROCEDURE InserirUsuario
@nome_U VARCHAR(120),
@senha_U NCHAR(32),
@email_U VARCHAR(120),
@fkTipoUsuario INT
AS

BEGIN
	INSERT INTO Usuario(Nome, Senha, DataHoraCrianao, DataHoraUltimoAcesso, Email, fk_TipoUsuario_ID) VALUES(@nome_U, @senha_U, GETDATE(), GETDATE(), @email_U, @fkTipoUsuario);
END;

EXEC InserirUsuario @nome_U = 'João Miguel', @senha_U = 'senha123', @email_U = 'joao@email', @fkTipoUsuario = 1;
EXEC InserirUsuario @nome_U = 'Maria Eduarda', @senha_U = 'maria456', @email_U = 'maria@email', @fkTipoUsuario = 2;
EXEC InserirUsuario @nome_U = 'Pedro Sampaio', @senha_U = 'pedro789', @email_U = 'pedro@email', @fkTipoUsuario = 1;
EXEC InserirUsuario @nome_U = 'Ana Carolina', @senha_U = 'ana123', @email_U = 'ana@email', @fkTipoUsuario = 2;
EXEC InserirUsuario @nome_U = 'Carlos Cesar', @senha_U = 'carlos456', @email_U = 'carlos@email', @fkTipoUsuario = 1;
EXEC InserirUsuario @nome_U = 'Julia Matos', @senha_U = 'julia789', @email_U = 'julia@email', @fkTipoUsuario = 2;
EXEC InserirUsuario @nome_U = 'Mateus Carriere', @senha_U = 'mateus123', @email_U = 'mateus@email', @fkTipoUsuario = 1;
EXEC InserirUsuario @nome_U = 'Luiza Sonza', @senha_U = 'luiza456', @email_U = 'luiza@email', @fkTipoUsuario = 2;
EXEC InserirUsuario @nome_U = 'Rafael Muniz', @senha_U = 'rafael789', @email_U = 'rafael@email', @fkTipoUsuario = 1;
EXEC InserirUsuario @nome_U = 'Camila Pitanga', @senha_U = 'camila123', @email_U = 'camila@email', @fktipoUsuario = 2;

--TABELA Login--------------------------------------------------------------------------------
IF OBJECT_ID('InserirLogin', 'P') IS NOT NULL
	DROP PROCEDURE InserirLogin;
GO

CREATE PROCEDURE InserirLogin
@email_L VARCHAR(120),
@senha_L NCHAR(32),
@fkUsuario INT
AS

BEGIN
	INSERT INTO Login_Usuario(Email, Senha, Fk_Usuario_ID) VALUES(@email_L, @senha_L, @fkUsuario);
END;

EXEC InserirLogin @email_L = 'joao@email', @senha_L = 'senha123', @fkUsuario = 1;
EXEC InserirLogin @email_L = 'maria@email', @senha_L = 'maria456', @fkUsuario = 2;
EXEC InserirLogin @email_L = 'pedro@email', @senha_L = 'pedro789', @fkUsuario = 3;
EXEC InserirLogin @email_L = 'ana@email', @senha_L = 'ana123', @fkUsuario = 4;
EXEC InserirLogin @email_L = 'carlos@email', @senha_L = 'carlos456', @fkUsuario = 5;
EXEC InserirLogin @email_L = 'julia@email', @senha_L = 'julia789', @fkUsuario = 6;
EXEC InserirLogin @email_L = 'mateus@email', @senha_L = 'mateus123', @fkUsuario = 7;
EXEC InserirLogin @email_L = 'luiza@email', @senha_L = 'luiza456', @fkUsuario = 8;
EXEC InserirLogin @email_L = 'rafael@email', @senha_L = 'rafael789', @fkUsuario = 9;
EXEC InserirLogin @email_L = 'camila@email', @senha_L = 'camila123', @fkUsuario = 10;
----------------------------------------------------------------------------------------------

--TABELA UF-----------------------------------------------------------------------------------
IF OBJECT_ID('InserirUF', 'P') IS NOT NULL
	DROP PROCEDURE InserirUF;
GO

--criando procedure
CREATE PROCEDURE InserirUF
@nomeUF VARCHAR(120),
@siglaUF CHAR(2)
AS -- inicia a procedure

BEGIN -- início do bloco da procedure
	INSERT INTO UF(Nome_UF, Sigla_UF) VALUES (@nomeUF, @siglaUF);
END;

EXEC InserirUF @nomeUF = 'São Paulo', @siglaUF = 'SP';
EXEC InserirUF @nomeUF = 'Rio de Janeiro', @siglaUF = 'RJ';
EXEC InserirUF @nomeUF = 'Minas Gerais', @siglaUF = 'MG';

--TABELA CIDADE-------------------------------------------------------------------------------
IF OBJECT_ID('InserirCidade','P') IS NOT NULL
	DROP PROCEDURE InserirCidade;
GO

CREATE PROCEDURE InserirCidade
@nomeCidade VARCHAR(120),
@fkUf INT
AS

BEGIN
	INSERT INTO Cidade(Nome_cidade, fk_UF_ID) VALUES(@nomeCidade, @fkUf);
END;

EXEC InserirCidade @nomeCidade = 'São Paulo', @fkUf = 1;
EXEC InserirCidade @nomeCidade = 'Campinas', @fkUf = 1;
EXEC InserirCidade @nomeCidade = 'Guarulhos', @fkUf = 1;
EXEC InserirCidade @nomeCidade = 'Rio de Janeiro', @fkUf = 2;
EXEC InserirCidade @nomeCidade = 'Niterói', @fkUf = 2;
EXEC InserirCidade @nomeCidade = 'Duque de Caxias', @fkUf = 2;
EXEC InserirCidade @nomeCidade = 'Belo Horizonte', @fkUf = 3;
EXEC InserirCidade @nomeCidade = 'Uberlândia', @fkUf = 3;
EXEC InserirCidade @nomeCidade = 'Contagem', @fkUf = 3;

--TABELA BAIRRO------------------------------------------------------------------------------
IF OBJECT_ID ('InserirBairro', 'P') IS NOT NULL
	DROP PROCEDURE InserirBairro;
GO

CREATE PROCEDURE  InserirBairro
@nomeBairro VARCHAR(120),
@fkCidade INT
AS

BEGIN
	INSERT INTO Bairro(Nome_bairro, fk_Cidade_ID) VALUES(@nomeBairro, @fkCidade);
END;

EXEC InserirBairro @nomeBairro = 'Bairro A', @fkCidade = 1;
EXEC InserirBairro @nomeBairro = 'Bairro B', @fkCidade = 2;
EXEC InserirBairro @nomeBairro = 'Bairro C', @fkCidade = 3;
EXEC InserirBairro @nomeBairro = 'Bairro X', @fkCidade = 4;
EXEC InserirBairro @nomeBairro = 'Bairro Y', @fkCidade = 5;
EXEC InserirBairro @nomeBairro = 'Bairro Z', @fkCidade = 6;
EXEC InserirBairro @nomeBairro = 'Bairro 1', @fkCidade = 7;
EXEC InserirBairro @nomeBairro = 'Bairro 2', @fkCidade = 8;
EXEC InserirBairro @nomeBairro = 'Bairro 3', @fkCidade = 9;

--TABELA Endereco----------------------------------------------------------------------------
IF OBJECT_ID('InserirEndereco','P') IS NOT NULL
	DROP PROCEDURE InserirEndereco;
GO

CREATE PROCEDURE InserirEndereco
@Logradouro VARCHAR(120),
@Numero INT,
@Complemento VARCHAR(120),
@fkBairro INT
AS

BEGIN
	INSERT INTO Endereco(Logradouro, Numero, Complemento, fk_Bairro_ID) VALUES(@Logradouro, @Numero, @Complemento, @fkBairro);
END;

EXEC InserirEndereco @Logradouro = 'Rua 1', @Numero = 10, @Complemento = 'Casa', @fkBairro = 1;
EXEC InserirEndereco @Logradouro = 'Avenida 2', @Numero = 20, @Complemento = 'Apartamento', @fkBairro = 2;
EXEC InserirEndereco @Logradouro = 'Praça 3', @Numero = 30, @Complemento = 'Casa', @fkBairro = 3;
EXEC InserirEndereco @Logradouro = 'Rua X', @Numero = 5, @Complemento = 'Casa', @fkBairro = 4;
EXEC InserirEndereco @Logradouro = 'Avenida Y', @Numero = 15, @Complemento = 'Apartamento', @fkBairro = 5;
EXEC InserirEndereco @Logradouro = 'Praça Z', @Numero = 25, @Complemento = 'Casa', @fkBairro = 6;
EXEC InserirEndereco @Logradouro = 'Rua BH', @Numero = 8, @Complemento = 'Casa', @fkBairro = 7;
EXEC InserirEndereco @Logradouro = 'Avenida U', @Numero = 18, @Complemento = 'Apartamento', @fkBairro = 8;
EXEC InserirEndereco @Logradouro = 'Praça M', @Numero = 28, @Complemento = 'Casa', @fkBairro = 9;
----------------------------------------------------------------------------------------------
--TABELA TipoAnuncio--------------------------------------------------------------------------
IF OBJECT_ID('InserirTipoAnuncio','P') IS NOT NULL
	DROP PROCEDURE InserirTipoAnuncioo;
GO

CREATE PROCEDURE InserirTipoAnuncio
@nomeTipoAnuncio VARCHAR(120)
AS

BEGIN
	INSERT INTO TipoAnuncio(Nome_Tipo_Anuncio) VALUES(@nomeTipoAnuncio);
END;

EXEC InserirTipoAnuncio @nomeTipoAnuncio = 'Vender';
EXEC InserirTipoAnuncio @nomeTipoAnuncio = 'Alugar';
--TABELA TipoImovel---------------------------------------------------------------------------
IF OBJECT_ID('InserirTipoImovel','P') IS NOT NULL
	DROP PROCEDURE InserirTipoImovel;
GO

CREATE PROCEDURE InserirTipoImovel
@nomeTipoImovel VARCHAR(120)
AS

BEGIN
	INSERT INTO TipoImovel(NomeTipoImovel) VALUES(@nomeTipoImovel);
END;

EXEC InserirTipoImovel @nomeTipoImovel = 'Casa';
EXEC InserirTipoImovel @nomeTipoImovel = 'Apartamento';
--TABELA Imovel-------------------------------------------------------------------------------
IF OBJECT_ID('InserirImovel','P') IS NOT NULL
	DROP PROCEDURE InserirImovel;
GO

CREATE PROCEDURE InserirImovel
@q_vaga INT,
@q_quarto INT, 
@q_suite INT, 
@q_banheiro INT, 
@areaUtil INT, 
@valorImovel DECIMAL,
@observacoes TEXT, 
@fkTipoImovel INT, 
@fkEndereco INT, 
@fkTipoAnuncio INT
AS

BEGIN
	INSERT INTO Imovel(Qtd_vaga, Qtd_quarto, Qtd_suite, Qtd_banheiro, Area_util, Valor_imovel, Observacoes, fk_TipoImovel_ID, fk_Endereco_ID, fk_TipoAnuncio_ID) 
	VALUES(@q_vaga, @q_quarto, @q_suite, @q_banheiro, @areaUtil, @valorImovel, @observacoes, @fkTipoImovel, @fkEndereco, @fkTipoAnuncio);
END;

EXEC InserirImovel @q_vaga = 3, @q_quarto = 4, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 300000, @observacoes = 'Ótima área de lazer', @fkTipoImovel = 1, @fkEndereco = 1, @fkTipoAnuncio = 1;
EXEC InserirImovel @q_vaga = 2, @q_quarto = 3, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 250000, @observacoes = 'Vista incível', @fkTipoImovel = 2, @fkEndereco = 2, @fkTipoAnuncio = 2;
EXEC InserirImovel @q_vaga = 4, @q_quarto = 5, @q_suite = 2, @q_banheiro = 4, @areaUtil = 300, @valorImovel = 400000, @observacoes = 'Garagem espaçosa', @fkTipoImovel = 1, @fkEndereco = 3, @fkTipoAnuncio = 1;
EXEC InserirImovel @q_vaga = 3, @q_quarto = 4, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 350000, @observacoes = 'Suítes com banheira', @fkTipoImovel = 2, @fkEndereco = 4, @fkTipoAnuncio = 2;
EXEC InserirImovel @q_vaga = 2, @q_quarto = 3, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 290000, @observacoes = 'Ótiama localização', @fkTipoImovel = 1, @fkEndereco = 5, @fkTipoAnuncio = 1;
EXEC InserirImovel @q_vaga = 4, @q_quarto = 5, @q_suite = 2, @q_banheiro = 4, @areaUtil = 300, @valorImovel = 450000, @observacoes = 'Altíssimo padrão', @fkTipoImovel = 2, @fkEndereco = 6, @fkTipoAnuncio = 2;
EXEC InserirImovel @q_vaga = 3, @q_quarto = 4, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 300000, @observacoes = 'Próximo à praia', @fkTipoImovel = 1, @fkEndereco = 7, @fkTipoAnuncio = 1;
EXEC InserirImovel @q_vaga = 2, @q_quarto = 3, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 250000, @observacoes = 'Localização nobre', @fkTipoImovel = 2, @fkEndereco = 8, @fkTipoAnuncio = 2;
EXEC InserirImovel @q_vaga = 4, @q_quarto = 5, @q_suite = 2, @q_banheiro = 4, @areaUtil = 300, @valorImovel = 400000, @observacoes = 'Lareira aconchegante ', @fkTipoImovel = 1, @fkEndereco = 9, @fkTipoAnuncio = 1;


--TABELA Imagem-------------------------------------------------------------------------------
IF OBJECT_ID('InserirImagem','P') IS NOT NULL
	DROP PROCEDURE InserirImagem;
GO

CREATE PROCEDURE InserirImagem
@nomeImagem VARCHAR(120), 
@url VARCHAR(120), 
@fkImovel INT
AS

BEGIN
	INSERT INTO Imagem(Nome_Imagem, url, fk_Imovel_ID) VALUES(@nomeImagem, @url, @fkImovel);
END;

EXEC InserirImagem @nomeImagem = '1-1', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\1-1.jpg', @fkImovel = 1;
EXEC InserirImagem @nomeImagem = '1-2', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\1-2.jpg', @fkImovel = 1;
EXEC InserirImagem @nomeImagem = '2-1', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\2-1.jpg', @fkImovel = 2;
EXEC InserirImagem @nomeImagem = '2-2', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\2-2.jpg', @fkImovel = 2;
EXEC InserirImagem @nomeImagem = '3-1', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\3-1.jpg', @fkImovel = 3;
EXEC InserirImagem @nomeImagem = '3-2', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\3-2.jpg', @fkImovel = 3;
EXEC InserirImagem @nomeImagem = '4-1', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\4-1.jpg', @fkImovel = 4;
EXEC InserirImagem @nomeImagem = '4-2', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\4-2.jpg', @fkImovel = 4;
EXEC InserirImagem @nomeImagem = '5-1', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\5-1.jpg', @fkImovel = 5;
EXEC InserirImagem @nomeImagem = '5-2', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\5-2.jpg', @fkImovel = 5;
EXEC InserirImagem @nomeImagem = '6-1', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\6-1.jpg', @fkImovel = 6;
EXEC InserirImagem @nomeImagem = '6-2', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\6-2.jpg', @fkImovel = 6;
EXEC InserirImagem @nomeImagem = '7-1', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\7-1.jpg', @fkImovel = 7;
EXEC InserirImagem @nomeImagem = '7-2', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\7-2.jpg', @fkImovel = 7;
EXEC InserirImagem @nomeImagem = '8-1', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\8-1.jpg', @fkImovel = 8;
EXEC InserirImagem @nomeImagem = '8-2', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\8-2.jpg', @fkImovel = 8;
EXEC InserirImagem @nomeImagem = '9-1', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\9-1.jpg', @fkImovel = 9;
EXEC InserirImagem @nomeImagem = '9-2', @url = 'C:\Users\ead\Desktop\dba_senai\wsbrasil\ASSETS\9-2.jpg', @fkImovel = 9;
----------------------------------------------------------------------------------------------
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

--TABELA ContatoSite--------------------------------------------------------------------------
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
exec InserirDadoContato @nome = 'José', @email = 'josfilho@email.com', @mensagem = 'O imóvel que eu gostaria de comprar não está mais no site.', @fk = 1;
exec InserirDadoContato @nome = 'Maria Santos', @email = 'maria.santos@hotmail.com', @mensagem = 'Quero fazer uma reclamação sobre o atendimento', @fk = 2;
exec InserirDadoContato @nome = 'Pedro Costa', @email = 'pedro.costa@yahoo.com', @mensagem = 'Tenho um loft para vender. Entre em contato comigo.', @fk = 3;
exec InserirDadoContato @nome = 'Ana Lima', @email = 'ana.lima@outlook.com', @mensagem = 'Seus imóveis são horríveis.', @fk = 4;
exec InserirDadoContato @nome = 'Bruno Dias', @email = 'bruno.dias@uol.com.br', @mensagem = 'A forma de pagamento deveria ser mais claro.', @fk = 5;
exec InserirDadoContato @nome = 'Carla Souza', @email = 'carla.souza@bol.com.br', @mensagem = 'Não encontrei o endereço do imóvel.', @fk = 1;
exec InserirDadoContato @nome = 'Daniel Oliveira', @email = 'daniel.oliveira@terra.com.br', @mensagem = 'O vendedor que estava me atendendo sumiu.', @fk = 2;
exec InserirDadoContato @nome = 'Eduarda Rocha', @email = 'eduarda.rocha@icloud.com', @mensagem = 'Quero vender minha casa na sua imobiliária.', @fk = 3;
exec InserirDadoContato @nome = 'Fabio Martins', @email = 'fabio.martins@globo.com', @mensagem = 'Preciso de ajuda para resolver um problema.', @fk = 4;
exec InserirDadoContato @nome = 'Fabio Martins', @email = 'gabriela.alves@zoho.com', @mensagem = 'Gostaria de fazer uma sugestão de melhoria.', @fk = 5;

--ALTERAR SENHA ------------------------------------------------------------------------------
IF OBJECT_ID ('AlterarSenha','P') IS NOT NULL
	DROP PROCEDURE AlterarSenha;
GO

CREATE PROCEDURE AlterarSenha

@UsuarioID INT,
@NovaSenha VARCHAR(32)
AS

BEGIN
	UPDATE Usuario SET Senha = @NovaSenha
	WHERE Usuario.ID = @UsuarioID
END;

EXEC AlterarSenha @UsuarioID = 1, @NovaSenha = 'kroatoan';

--SELECIONAR IMÓVEL POR CIDADE----------------------------------------------------------------
IF OBJECT_ID ('SelectImovelCidade','P') IS NOT NULL
	DROP PROCEDURE SelectImovelCidade
GO

CREATE PROCEDURE SelectImovelCidade
@Id INT
AS
BEGIN
	SELECT Imovel.Valor_imovel, Endereco.Logradouro, Endereco.Complemento, Endereco.Numero, Cidade.Nome_cidade, UF.Nome_UF, UF.Sigla_UF, Bairro.Nome_bairro 
	FROM Imovel
	JOIN Endereco ON Imovel.fk_Endereco_ID = Endereco.ID
	JOIN Bairro ON Endereco.fk_Bairro_ID = Bairro.ID
	JOIN Cidade ON Bairro.fk_Cidade_ID = Cidade.ID
	JOIN UF ON Cidade.fk_UF_ID = UF.ID
	WHERE Cidade.ID = @Id;
END;

EXEC SelectImovelCidade @Id = 5;
GO
----------------------------------------------------------------------------------------------
IF OBJECT_ID ('ImoveisPorTipoAnuncio','P') IS NOT NULL
	DROP PROCEDURE ImoveisPorTipoAnuncio
GO

CREATE PROCEDURE ImoveisPorTipoAnuncio
@idTipo INT
AS
BEGIN
	SELECT *
	FROM Imovel
	JOIN TipoAnuncio ON Imovel.fk_TipoAnuncio_ID = TipoAnuncio.ID
	WHERE fk_TipoAnuncio_ID = @idTipo;
END;

EXEC ImoveisPorTipoAnuncio @idTipo = 2;
GO
----------------------------------------------------------------------------------------------
IF OBJECT_ID ('Aumento','P') IS NOT NULL
	DROP PROCEDURE Aumento
GO

CREATE PROCEDURE Aumento
@fatorAumento FLOAT
AS
BEGIN
	UPDATE Imovel
	SET Valor_Imovel = Valor_Imovel * @fatorAumento;
END;
GO

EXEC Aumento @fatorAumento = 1.5;
--FUNCTIONS-----------------------------------------------------------------------------------
--FUNCTION PARA RETORNAR O TOTAL DEOS IMÓVEIS SELECIONADOS POR TIPO---------------------------
IF OBJECT_ID('dbo.CalcularValorTotalTipo', 'FN') IS NOT NULL
    DROP FUNCTION dbo.CalcularValorTotalTipo;
GO

CREATE FUNCTION CalcularValorTotalTipo (@TipoImovel INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
	DECLARE @ValorTotal DECIMAL;
	SELECT @ValorTotal = SUM(Valor_Imovel)
	FROM Imovel
	WHERE fk_TipoImovel_ID = @TipoImovel;
	RETURN @ValorTotal;
END;

SELECT dbo.CalcularValorTotalTipo(1) as ValorTotalImoveis;
GO
--RETORNAR USUÁRIO E DATA DO ÚLTIMO LOGIN-----------------------------------------------------
IF OBJECT_ID('dbo.RetornarUltimoLoginUsuario', 'FN') IS NOT NULL
    DROP FUNCTION dbo.RetornarUltimoLoginUsuario;
GO

CREATE FUNCTION dbo.RetornarUltimoLoginUsuario (@UsuarioID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT Usuario.Nome AS NomeUsuario, Login_Usuario.Email, Usuario.DataHoraUltimoAcesso AS UltimoLogin
    FROM Usuario
    JOIN Login_Usuario ON Usuario.ID = Login_Usuario.Fk_Usuario_Id
    WHERE Usuario.ID = @UsuarioID
);

SELECT * FROM dbo.RetornarUltimoLoginUsuario(1);

--CONTAR O NÚMERO DE IMÓVEIS POR CIDADE-------------------------------------------------------
IF OBJECT_ID('dbo.CidadeQtdImovel','FN') IS NOT NULL
	DROP FUNCTION dbo.UsuarioDataLogin;
GO

CREATE FUNCTION dbo.CidadeQtdImovel (@CidadeID INT)
RETURNS TABLE
AS
RETURN
(
	SELECT Cidade.Nome_Cidade As NomeCidade, COUNT(Imovel.ID) AS QuantidadeImoveis
	FROM Cidade
	LEFT JOIN Bairro ON Bairro.fk_Cidade_ID = Cidade.ID
	LEFT JOIN Endereco ON Endereco.fk_Bairro_ID = Bairro.ID
	LEFT JOIN Imovel ON Imovel.fk_Endereco_ID = Endereco.ID
	WHERE Cidade.ID = @CidadeID
	GROUP BY Cidade.Nome_cidade
);

SELECT * FROM dbo.CidadeQtdImovel(3);

----------------------------------------------------------------------------------------------
--SESSÃO JOIN---------------------------------------------------------------------------------
--SELECT IMOVEL/ENDEREÇO/IMAGEM---------------------------------------------------------------
SELECT Imagem.Nome_Imagem, Imagem.url, Imovel.Qtd_vaga, Imovel.Qtd_quarto, Imovel.Qtd_suite, Imovel.Qtd_banheiro, Imovel.Area_util, Imovel.Valor_imovel, Imovel.Observacoes, TipoImovel.NomeTipoImovel, TipoAnuncio.Nome_Tipo_Anuncio, Endereco.Logradouro, Endereco.Numero, Endereco.Complemento, Bairro.Nome_bairro, Cidade.Nome_cidade, UF.Nome_UF, UF.Sigla_UF 
FROM Imovel
JOIN Imagem
ON Imagem.ID = Imagem.fk_Imovel_ID
JOIN TipoImovel 
ON TipoImovel.ID = Imovel.fk_TipoImovel_ID
JOIN TipoAnuncio
ON TipoAnuncio.ID = Imovel.fk_TipoAnuncio_ID
JOIN Endereco
ON Endereco.ID = Imovel.fk_Endereco_ID
JOIN Bairro
ON Bairro.ID = Endereco.fk_Bairro_ID
JOIN Cidade
ON Cidade.ID = Bairro.fk_Cidade_ID
JOIN UF
ON UF.ID = Cidade.fk_UF_ID
;

--SELECT LOGIN---------------------------------------------------------------------------------
SELECT Usuario.Nome, Login_Usuario.Email, Login_Usuario.Senha, Usuario.DataHoraUltimoAcesso 
FROM login_Usuario
JOIN Usuario
ON Login_Usuario.Fk_Usuario_Id = Usuario.ID
;
--SELECT CONTATO-------------------------------------------------------------------------------
SELECT ContatoSite.Nome, ContatoSite.Email, TipoContato.Nome, ContatoSite.Mensagem, ContatoSite.DataHora
FROM ContatoSite
JOIN TipoContato
ON ContatoSite.fk_TipoContato_id = TipoContato.Id
;
--VIEWS-----------------------------------------------------------------------------------------
--Crie uma View para mostrar todos os detalhes do imóvel.---------------------------------------
----Chame essa View mostrando os imóveis de acordo com a cidade que você informa.---------------
drop view vw_DetalhesImovel;
go
CREATE VIEW vw_DetalhesImovel 
AS
SELECT i.ID, i.Valor_imovel, e.Logradouro, e.Complemento, e.Numero, b.Nome_bairro , c.Nome_cidade, u.Nome_UF, u.Sigla_UF
FROM Imovel i
	JOIN Endereco e ON i.fk_Endereco_ID = e.ID
	JOIN Bairro b ON e.fk_Bairro_ID = b.ID
	JOIN Cidade c ON b.fk_Cidade_ID = c.ID
	JOIN UF u ON c.fk_UF_ID = u.ID;
GO

SELECT * FROM vw_DetalhesImovel WHERE Nome_cidade = 'Rio de Janeiro';
go
--EXERCÍCIOS-23/11/2023-------------------------------------------------------------------------
--Crie uma View para mostrar quantidade de imóveis por cidade.----------------------------------
drop view vw_QtdImovelPorCidade;
go
CREATE VIEW vw_QtdImovelPorCidade
AS
SELECT COUNT(i.ID) AS QtdImoveis, c.Nome_cidade
FROM Imovel i
	JOIN Endereco e ON i.fk_Endereco_ID = e.ID
	JOIN Bairro b ON e.fk_Bairro_ID = b.ID
	JOIN Cidade c ON b.fk_Cidade_ID = c.ID
GROUP BY c.Nome_cidade;
GO

SELECT * FROM vw_QtdImovelPorCidade;
go
--Crie uma View para mostrar a quantidade de imóveis por tipo de anúncio.-----------------------
drop view vw_QtdImovelPorTipoAnuncio;
go
CREATE VIEW vw_QtdImovelPorTipoAnuncio
AS
SELECT t.Nome_Tipo_Anuncio, COUNT(i.ID) AS QtdImoveis, e.Logradouro, e.Complemento, e.Numero, b.Nome_bairro, c.Nome_cidade, u.Nome_UF, u.Sigla_UF 
FROM Imovel i
	JOIN Endereco e ON i.fk_Endereco_ID = e.ID
	JOIN TipoAnuncio t on i.fk_TipoAnuncio_ID = t.ID
	JOIN Bairro b ON e.fk_Bairro_ID = b.ID
	JOIN Cidade c ON b.fk_Cidade_ID = c.ID
	JOIN UF u ON c.fk_UF_ID = u.ID
GROUP BY t.Nome_Tipo_Anuncio, e.Logradouro, e.Complemento, e.Numero, b.Nome_bairro, c.Nome_cidade, u.Nome_UF, u.Sigla_UF;
GO

SELECT * FROM vw_QtdImovelPorTipoAnuncio;
go
--Crie uma View para calcular a soma dos valores dos imóveis por tipo de imóvel.----------------
drop view vw_SomarValorImovelPorTipo;
go
CREATE VIEW vw_SomarValorImovelPorTipo
AS
SELECT SUM(i.Valor_imovel) AS SomaImovelValor, ti.NomeTipoImovel
FROM Imovel i
	JOIN TipoImovel ti ON i.fk_TipoImovel_ID = ti.ID
GROUP BY ti.NomeTipoImovel;
GO

SELECT * FROM vw_SomarValorImovelPorTipo;
--Crie uma procedure para deletar imóveis pela cidade.------------------------------------------
IF OBJECT_ID('DeletarImoveisPorCidade', 'P') IS NOT NULL
    DROP PROCEDURE DeletarImoveisPorCidade;
GO

CREATE PROCEDURE DeletarImoveisPorCidade
    @nomeCidade VARCHAR(120)
AS
BEGIN
    DECLARE @cidadeID INT;
    SELECT @cidadeID = ID FROM Cidade WHERE Nome_cidade = @nomeCidade;

    IF @cidadeID IS NULL
    BEGIN
        PRINT('Cidade não encontrada');
        RETURN;
    END

    DELETE FROM Imovel
    WHERE fk_Endereco_ID IN (
        SELECT e.ID
        FROM Endereco e
        INNER JOIN Bairro b ON e.fk_Bairro_ID = b.ID
        WHERE b.fk_Cidade_ID = @cidadeID
    );

    PRINT('Imóveis na cidade ' + @nomeCidade + ' foram deletados com sucesso.');
END;
go

EXEC DeletarImoveisPorCidade @nomeCidade = 'Campinas';
go
--calcular a média de valores por metro quadrado dos imóveis diretamente------------------------
SELECT ID, Area_util, FORMAT (Valor_imovel, 'C', 'pt-BR'), FORMAT( CAST( ROUND(
	CASE
		WHEN NULLIF(Area_util, 0) IS NULL THEN NULL
		ELSE Valor_Imovel / NULLIF(Area_util, 0)
	END, 2) AS DECIMAL (10, 2)), 'C', 'pt-BR') AS ValorPorMetroQuadrado
FROM Imovel;
------------------------------------------------------------------------------------------------
-- SESSÃO DE MANUTENÇÃO
--ALTERAR NOME DE TABELA
exec sp_rename login_usuario, Login_Usuario ;
--SELECIONAR TABELA
select * from TipoUsuario;
select * from Usuario;
select * from Login_Usuario;
select * from UF;
select * from Cidade;
select * from Bairro;
select * from Endereco;
select * from TipoAnuncio;
select * from TipoImovel;
select * from Imovel;
select * from Imagem;
select * from TipoContato;
select * from ContatoSite;

--EXCLUIR TABELA
DROP TABLE TipoContato;
DROP TABLE ContatoSite;
Drop Table Imagem;
DROP TABLE Imovel;
DROP TABLE Endereco;
DROP TABLE Bairro;
DROP TABLE Cidade;
DROP TABLE UF;
