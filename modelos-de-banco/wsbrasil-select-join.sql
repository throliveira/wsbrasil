USE WSBrasil;
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