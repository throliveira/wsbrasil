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
go
--Para executar a tarefa abaixo, � preciso ter mais de um im�vel por estado e/ou por cidade.
--Calcular a m�dia de valor por metro quadrado de cada estado ordenado de forma crescente e na mesma consulta trazer outra coluna com os estados com menor e maior m�dia por metro quadrado.

CREATE PROCEDURE CalcularMediaValorPorMetroQuadrado
AS
BEGIN
    SELECT 
        I.ID AS ID_Imovel,
        U.Sigla_UF AS Estado,
        I.Area_util,
        FORMAT(I.Valor_imovel, 'C', 'pt-BR') AS Valor_Imovel_Real,
        FORMAT(I.Valor_imovel / NULLIF(I.Area_util, 0), 'C', 'pt-BR') AS Media_Valor_Metro_Quadrado_Imovel,
        FORMAT(MAX(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Maior_Media_Valor_Metro_Quadrado,
        FORMAT(MIN(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Menor_Media_Valor_Metro_Quadrado
    FROM
        Imovel I
    JOIN
        Endereco E ON I.fk_Endereco_ID = E.ID
    JOIN
        Cidade C ON E.fk_Bairro_ID = C.ID
    JOIN
        UF U ON C.fk_UF_ID = U.ID
    ORDER BY
        Estado, ID_Imovel;
END;


exec CalcularMediaValorPorMetroQuadrado;
drop procedure CalcularMediaValorPorMetroQuadrado;

select * from Imovel;

/*
CREATE PROCEDURE CalcularMediaValorPorMetroQuadrado AS BEGIN: Isso define a cria��o de uma nova procedure chamada CalcularMediaValorPorMetroQuadrado.

SELECT I.ID AS ID_Imovel, U.Sigla_UF AS Estado, I.Valor_imovel, I.Area_util, FORMAT(I.Valor_imovel, 'C', 'pt-BR') AS Valor_Imovel_Real, FORMAT(I.Valor_imovel / NULLIF(I.Area_util, 0), 'C', 'pt-BR') AS Media_Valor_Metro_Quadrado_Imovel, FORMAT(MAX(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Maior_Media_Valor_Metro_Quadrado, FORMAT(MIN(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Menor_Media_Valor_Metro_Quadrado FROM Imovel I ...: Esta � a consulta principal que seleciona dados da tabela Imovel e junta informa��es das tabelas relacionadas (Endereco, Cidade, UF) usando JOIN. Aqui est�o os detalhes:

I.ID AS ID_Imovel: Renomeia a coluna ID da tabela Imovel para ID_Imovel.
U.Sigla_UF AS Estado: Renomeia a coluna Sigla_UF da tabela UF para Estado.
I.Valor_imovel: Seleciona o valor do im�vel da tabela Imovel.
I.Area_util: Seleciona a �rea �til do im�vel da tabela Imovel.
FORMAT(I.Valor_imovel, 'C', 'pt-BR') AS Valor_Imovel_Real: Formata o valor do im�vel para exibi��o em formato de moeda brasileira.
FORMAT(I.Valor_imovel / NULLIF(I.Area_util, 0), 'C', 'pt-BR') AS Media_Valor_Metro_Quadrado_Imovel: Calcula e formata a m�dia do valor por metro quadrado do im�vel, tamb�m formatando para moeda brasileira.
FORMAT(MAX(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Maior_Media_Valor_Metro_Quadrado: Utiliza a fun��o de janela MAX para encontrar a maior m�dia por metro quadrado por estado.
FORMAT(MIN(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Menor_Media_Valor_Metro_Quadrado: Utiliza a fun��o de janela MIN para encontrar a menor m�dia por metro quadrado por estado.
FROM Imovel I JOIN Endereco E ON I.fk_Endereco_ID = E.ID ...: Aqui, as tabelas s�o unidas atrav�s de suas chaves estrangeiras (fk_Endereco_ID) para relacionar os im�veis aos seus respectivos endere�os, cidades e estados.

ORDER BY Estado, ID_Imovel;: Ordena o resultado primeiro pelo estado (Estado) e depois pelo ID do im�vel (ID_Imovel).

Essencialmente, essa procedure busca informa��es dos im�veis, seus estados, valores e �reas, al�m de calcular as m�dias por metro quadrado e identificar as maiores e menores m�dias por estado, tudo isso formatado para apresentar os valores em formato de moeda brasileira.

As fun��es OVER e PARTITION BY s�o usadas em conjunto para realizar opera��es em conjuntos de dados espec�ficos em consultas SQL. Aqui est� a explica��o:

PARTITION BY: � usado para dividir o conjunto de resultados em parti��es l�gicas. Cada parti��o � tratada separadamente para a aplica��o de fun��es anal�ticas. Quando voc� usa PARTITION BY em uma fun��o anal�tica, ela cria grupos separados de dados com base nos valores da coluna especificada. No contexto de PARTITION BY U.Sigla_UF, por exemplo, isso significa que a an�lise � feita separadamente para cada estado (cada valor �nico de U.Sigla_UF).

OVER: � usado em conjunto com fun��es de agrega��o ou anal�ticas para especificar como os c�lculos devem ser feitos em rela��o a cada linha do conjunto de resultados. Ao usar OVER, voc� define a janela ou o conjunto de linhas nas quais a fun��o ser� aplicada. Ele pode ser usado em combina��o com PARTITION BY para criar uma fun��o anal�tica que considera grupos separados de dados (definidos pela parti��o).

No contexto da sua query, ao usar OVER (PARTITION BY U.Sigla_UF), as fun��es anal�ticas MAX e MIN est�o sendo aplicadas a cada estado separadamente. Isso permite calcular a maior e a menor m�dia por metro quadrado para cada estado individualmente, em vez de considerar todo o conjunto de dados ao calcular esses valores.
*/