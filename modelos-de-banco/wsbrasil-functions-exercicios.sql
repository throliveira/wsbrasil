USE WSBrasil;
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