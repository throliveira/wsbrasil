USE WSBrasil;
GO
----------------------------------------------------------------------------------
--Exercícios 01/12/2023-----------------------------------------------------------
--Faça uma busca que mostra todos os imóveis que tenha áreas entre 110 e 330 metros quadrados e de um desconto no valor de 30%.
CREATE VIEW vw_Imovel_trinta_desconto
AS
	SELECT ID, Area_util, FORMAT(Valor_imovel, 'C','pt_BR') AS Valor_Imovel, FORMAT(Valor_imovel*0.7, 'C', 'pt-BR') AS Valor_Desconto
	FROM Imovel;

SELECT * FROM vw_Imovel_trinta_desconto WHERE Area_util BETWEEN 110 AND 330;
--Faça uma consulta que busque as 5 cidades com a maior média de valor do metro quadrado.
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
--Para executar a tarefa abaixo, é preciso ter mais de um imóvel por estado e/ou por cidade.
--Calcular a média de valor por metro quadrado de cada estado ordenado de forma crescente e na mesma consulta trazer outra coluna com os estados com menor e maior média por metro quadrado.

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
CREATE PROCEDURE CalcularMediaValorPorMetroQuadrado AS BEGIN: Isso define a criação de uma nova procedure chamada CalcularMediaValorPorMetroQuadrado.

SELECT I.ID AS ID_Imovel, U.Sigla_UF AS Estado, I.Valor_imovel, I.Area_util, FORMAT(I.Valor_imovel, 'C', 'pt-BR') AS Valor_Imovel_Real, FORMAT(I.Valor_imovel / NULLIF(I.Area_util, 0), 'C', 'pt-BR') AS Media_Valor_Metro_Quadrado_Imovel, FORMAT(MAX(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Maior_Media_Valor_Metro_Quadrado, FORMAT(MIN(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Menor_Media_Valor_Metro_Quadrado FROM Imovel I ...: Esta é a consulta principal que seleciona dados da tabela Imovel e junta informações das tabelas relacionadas (Endereco, Cidade, UF) usando JOIN. Aqui estão os detalhes:

I.ID AS ID_Imovel: Renomeia a coluna ID da tabela Imovel para ID_Imovel.
U.Sigla_UF AS Estado: Renomeia a coluna Sigla_UF da tabela UF para Estado.
I.Valor_imovel: Seleciona o valor do imóvel da tabela Imovel.
I.Area_util: Seleciona a área útil do imóvel da tabela Imovel.
FORMAT(I.Valor_imovel, 'C', 'pt-BR') AS Valor_Imovel_Real: Formata o valor do imóvel para exibição em formato de moeda brasileira.
FORMAT(I.Valor_imovel / NULLIF(I.Area_util, 0), 'C', 'pt-BR') AS Media_Valor_Metro_Quadrado_Imovel: Calcula e formata a média do valor por metro quadrado do imóvel, também formatando para moeda brasileira.
FORMAT(MAX(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Maior_Media_Valor_Metro_Quadrado: Utiliza a função de janela MAX para encontrar a maior média por metro quadrado por estado.
FORMAT(MIN(I.Valor_imovel / NULLIF(I.Area_util, 0)) OVER (PARTITION BY U.Sigla_UF), 'C', 'pt-BR') AS Menor_Media_Valor_Metro_Quadrado: Utiliza a função de janela MIN para encontrar a menor média por metro quadrado por estado.
FROM Imovel I JOIN Endereco E ON I.fk_Endereco_ID = E.ID ...: Aqui, as tabelas são unidas através de suas chaves estrangeiras (fk_Endereco_ID) para relacionar os imóveis aos seus respectivos endereços, cidades e estados.

ORDER BY Estado, ID_Imovel;: Ordena o resultado primeiro pelo estado (Estado) e depois pelo ID do imóvel (ID_Imovel).

Essencialmente, essa procedure busca informações dos imóveis, seus estados, valores e áreas, além de calcular as médias por metro quadrado e identificar as maiores e menores médias por estado, tudo isso formatado para apresentar os valores em formato de moeda brasileira.

As funções OVER e PARTITION BY são usadas em conjunto para realizar operações em conjuntos de dados específicos em consultas SQL. Aqui está a explicação:

PARTITION BY: É usado para dividir o conjunto de resultados em partições lógicas. Cada partição é tratada separadamente para a aplicação de funções analíticas. Quando você usa PARTITION BY em uma função analítica, ela cria grupos separados de dados com base nos valores da coluna especificada. No contexto de PARTITION BY U.Sigla_UF, por exemplo, isso significa que a análise é feita separadamente para cada estado (cada valor único de U.Sigla_UF).

OVER: É usado em conjunto com funções de agregação ou analíticas para especificar como os cálculos devem ser feitos em relação a cada linha do conjunto de resultados. Ao usar OVER, você define a janela ou o conjunto de linhas nas quais a função será aplicada. Ele pode ser usado em combinação com PARTITION BY para criar uma função analítica que considera grupos separados de dados (definidos pela partição).

No contexto da sua query, ao usar OVER (PARTITION BY U.Sigla_UF), as funções analíticas MAX e MIN estão sendo aplicadas a cada estado separadamente. Isso permite calcular a maior e a menor média por metro quadrado para cada estado individualmente, em vez de considerar todo o conjunto de dados ao calcular esses valores.
*/