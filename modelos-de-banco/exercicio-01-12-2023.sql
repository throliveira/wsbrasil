USE WSBrasil;
GO
----------------------------------------------------------------------------------
--Exerc�cios 01/12/2023-----------------------------------------------------------
--Fa�a uma busca que mostra todos os im�veis que tenha �reas entre 110 e 330 metros quadrados e de um desconto no valor de 30%.
CREATE VIEW vw_Imovel_trinta_desconto
AS
	SELECT ID, Area_util, FORMAT(Valor_imovel, 'C','pt_BR') AS Valor_Imovel, FORMAT(Valor_imovel*0.7, 'C', 'pt-BR') AS Valor_Desconto
	FROM Imovel;

SELECT * FROM vw_Imovel_trinta_desconto WHERE Area_util BETWEEN 110 AND 330;
--Fa�a uma consulta que busque as 5 cidades com a maior m�dia de valor do metro quadrado.
SELECT TOP 5
    C.Nome_cidade AS Cidade,
    FORMAT(AVG(I.Valor_imovel / NULLIF(I.Area_util, 0)), 'C', 'pt-BR') AS Media_Valor_Metro_Quadrado
FROM
    Imovel I
JOIN
    Endereco E ON I.fk_Endereco_ID = E.ID
JOIN
    Cidade C ON E.fk_Bairro_ID = C.ID
GROUP BY
    C.Nome_cidade
ORDER BY
    Media_Valor_Metro_Quadrado DESC;
--Para executar a tarefa abaixo, � preciso ter mais de um im�vel por estado e/ou por cidade.
--Calcular a m�dia de valor por metro quadrado de cada estado ordenado de forma crescente e na mesma consulta trazer outra coluna com os estados com menor e maior m�dia por metro quadrado.
CREATE PROCEDURE CalcularMediaValorPorMetroQuadrado
AS
BEGIN
    -- M�dia de valor por metro quadrado de cada estado ordenado de forma crescente
    SELECT 
        U.Sigla_UF AS Estado,
        AVG(I.Valor_imovel / NULLIF(I.Area_util, 0)) AS Media_Valor_Metro_Quadrado
    FROM
        Imovel I
    JOIN
        Endereco E ON I.fk_Endereco_ID = E.ID
    JOIN
        Cidade C ON E.fk_Bairro_ID = C.ID
    JOIN
        UF U ON C.fk_UF_ID = U.ID
    GROUP BY
        U.Sigla_UF
    ORDER BY
        Media_Valor_Metro_Quadrado ASC;

    -- Estado com a menor m�dia de valor por metro quadrado
    SELECT TOP 1 WITH TIES
        U.Sigla_UF AS Estado_Menor_Media,
        AVG(I.Valor_imovel / NULLIF(I.Area_util, 0)) AS Media_Valor_Metro_Quadrado
    FROM
        Imovel I
    JOIN
        Endereco E ON I.fk_Endereco_ID = E.ID
    JOIN
        Cidade C ON E.fk_Bairro_ID = C.ID
    JOIN
        UF U ON C.fk_UF_ID = U.ID
    GROUP BY
        U.Sigla_UF
    ORDER BY
        Media_Valor_Metro_Quadrado ASC;

    -- Estado com a maior m�dia de valor por metro quadrado
    SELECT TOP 1 WITH TIES
        U.Sigla_UF AS Estado_Maior_Media,
        AVG(I.Valor_imovel / NULLIF(I.Area_util, 0)) AS Media_Valor_Metro_Quadrado
    FROM
        Imovel I
    JOIN
        Endereco E ON I.fk_Endereco_ID = E.ID
    JOIN
        Cidade C ON E.fk_Bairro_ID = C.ID
    JOIN
        UF U ON C.fk_UF_ID = U.ID
    GROUP BY
        U.Sigla_UF
    ORDER BY
        Media_Valor_Metro_Quadrado DESC;
END;

exec CalcularMediaValorPorMetroQuadrado;