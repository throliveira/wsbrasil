USE WSBrasil;
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
