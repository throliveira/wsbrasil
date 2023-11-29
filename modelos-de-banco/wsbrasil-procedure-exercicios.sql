USE WSBrasil;
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