USE WSBrasil;

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

-- Inserção de novos endereços únicos

-- São Paulo - Bairro A - Rua 2
IF NOT EXISTS (SELECT 1 FROM Endereco WHERE Logradouro = 'Rua 2' AND Numero = 15 AND fk_Bairro_ID = 1)
    EXEC InserirEndereco @Logradouro = 'Rua 2', @Numero = 15, @Complemento = 'Casa', @fkBairro = 1;

-- São Paulo - Bairro B - Avenida 3
IF NOT EXISTS (SELECT 1 FROM Endereco WHERE Logradouro = 'Avenida 3' AND Numero = 30 AND fk_Bairro_ID = 2)
    EXEC InserirEndereco @Logradouro = 'Avenida 3', @Numero = 30, @Complemento = 'Apartamento', @fkBairro = 2;

-- São Paulo - Bairro C - Praça 4
IF NOT EXISTS (SELECT 1 FROM Endereco WHERE Logradouro = 'Praça 4' AND Numero = 45 AND fk_Bairro_ID = 3)
    EXEC InserirEndereco @Logradouro = 'Praça 4', @Numero = 45, @Complemento = 'Casa', @fkBairro = 3;

-- Rio de Janeiro - Bairro X - Rua Y
IF NOT EXISTS (SELECT 1 FROM Endereco WHERE Logradouro = 'Rua Y' AND Numero = 20 AND fk_Bairro_ID = 4)
    EXEC InserirEndereco @Logradouro = 'Rua Y', @Numero = 20, @Complemento = 'Casa', @fkBairro = 4;

-- Rio de Janeiro - Bairro Y - Avenida Z
IF NOT EXISTS (SELECT 1 FROM Endereco WHERE Logradouro = 'Avenida Z' AND Numero = 35 AND fk_Bairro_ID = 5)
    EXEC InserirEndereco @Logradouro = 'Avenida Z', @Numero = 35, @Complemento = 'Apartamento', @fkBairro = 5;

-- Rio de Janeiro - Bairro Z - Praça W
IF NOT EXISTS (SELECT 1 FROM Endereco WHERE Logradouro = 'Praça W' AND Numero = 50 AND fk_Bairro_ID = 6)
    EXEC InserirEndereco @Logradouro = 'Praça W', @Numero = 50, @Complemento = 'Casa', @fkBairro = 6;

-- Minas Gerais - Bairro 1 - Rua C
IF NOT EXISTS (SELECT 1 FROM Endereco WHERE Logradouro = 'Rua C' AND Numero = 25 AND fk_Bairro_ID = 7)
    EXEC InserirEndereco @Logradouro = 'Rua C', @Numero = 25, @Complemento = 'Casa', @fkBairro = 7;

-- Minas Gerais - Bairro 2 - Avenida V
IF NOT EXISTS (SELECT 1 FROM Endereco WHERE Logradouro = 'Avenida V' AND Numero = 40 AND fk_Bairro_ID = 8)
    EXEC InserirEndereco @Logradouro = 'Avenida V', @Numero = 40, @Complemento = 'Apartamento', @fkBairro = 8;

-- Minas Gerais - Bairro 3 - Praça L
IF NOT EXISTS (SELECT 1 FROM Endereco WHERE Logradouro = 'Praça L' AND Numero = 55 AND fk_Bairro_ID = 9)
    EXEC InserirEndereco @Logradouro = 'Praça L', @Numero = 55, @Complemento = 'Casa', @fkBairro = 9;

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

-- Inserção de novos imóveis

-- São Paulo - Bairro A - Rua 2
EXEC InserirImovel @q_vaga = 3, @q_quarto = 4, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 300000, @observacoes = 'Ótima área de lazer', @fkTipoImovel = 1, @fkEndereco = 10, @fkTipoAnuncio = 1;

-- São Paulo - Bairro B - Avenida 3
EXEC InserirImovel @q_vaga = 2, @q_quarto = 3, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 250000, @observacoes = 'Vista incível', @fkTipoImovel = 2, @fkEndereco = 11, @fkTipoAnuncio = 2;

-- São Paulo - Bairro C - Praça 4
EXEC InserirImovel @q_vaga = 4, @q_quarto = 5, @q_suite = 2, @q_banheiro = 4, @areaUtil = 300, @valorImovel = 400000, @observacoes = 'Garagem espaçosa', @fkTipoImovel = 1, @fkEndereco = 12, @fkTipoAnuncio = 1;

-- Rio de Janeiro - Bairro X - Rua Y
EXEC InserirImovel @q_vaga = 3, @q_quarto = 4, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 350000, @observacoes = 'Suítes com banheira', @fkTipoImovel = 2, @fkEndereco = 13, @fkTipoAnuncio = 2;

-- Rio de Janeiro - Bairro Y - Avenida Z
EXEC InserirImovel @q_vaga = 2, @q_quarto = 3, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 290000, @observacoes = 'Ótiama localização', @fkTipoImovel = 1, @fkEndereco = 14, @fkTipoAnuncio = 1;

-- Rio de Janeiro - Bairro Z - Praça W
EXEC InserirImovel @q_vaga = 4, @q_quarto = 5, @q_suite = 2, @q_banheiro = 4, @areaUtil = 300, @valorImovel = 450000, @observacoes = 'Altíssimo padrão', @fkTipoImovel = 2, @fkEndereco = 15, @fkTipoAnuncio = 2;

-- Minas Gerais - Bairro 1 - Rua C
EXEC InserirImovel @q_vaga = 3, @q_quarto = 4, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 300000, @observacoes = 'Próximo à praia', @fkTipoImovel = 1, @fkEndereco = 16, @fkTipoAnuncio = 1;

-- Minas Gerais - Bairro 2 - Avenida V
EXEC InserirImovel @q_vaga = 2, @q_quarto = 3, @q_suite = 1, @q_banheiro = 3, @areaUtil = 250, @valorImovel = 250000, @observacoes = 'Localização nobre', @fkTipoImovel = 2, @fkEndereco = 17, @fkTipoAnuncio = 2;

-- Minas Gerais - Bairro 3 - Praça L
EXEC InserirImovel @q_vaga = 4, @q_quarto = 5, @q_suite = 2, @q_banheiro = 4, @areaUtil = 300, @valorImovel = 400000, @observacoes = 'Lareira aconchegante ', @fkTipoImovel = 1, @fkEndereco = 18, @fkTipoAnuncio = 1;

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