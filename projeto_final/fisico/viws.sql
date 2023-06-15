/* Para as views deseja-se as seguintes visualizações:

vw_pagamento - Deve conter todos os dados de pagamento, seu tipo, o nome do cliente, seu plano e data de vencimento.
vw_perfil - deve conter todos os dados do perfil e seu cliente.*/

-- vw_usuario -----------------------------------------
CREATE VIEW vw_usuario AS
SELECT 
    p.id_pessoa,
	IF(f.id_funcionario IS NOT NULL, 'Funcionário', 'Cliente') AS tipo_usuario, 
    -- Se o ID do funcionário (f.id_funcionario) não for nulo, significa que a pessoa é um funcionário. Caso contrário, a pessoa é considerada um cliente.
    p.nome,
    p.sobrenome,
    p.email,
    p.dt_nascimento,
    p.dt_cadastro,
    e.numero AS numero_endereco,
    e.endereco,
    e.cep,
    e.cidade,
    pais.nome AS pais_origem,
    COUNT(pf.id_perfil) AS quantidade_perfis, --  contar os registros de perfis correspondentes ao ID do perfil.
    pl.valor AS valor_plano,
    pl.descricao AS descricao_plano
FROM pessoa p
LEFT JOIN funcionario f ON f.id_pessoa = p.id_pessoa
LEFT JOIN cliente c ON c.id_pessoa = p.id_pessoa
LEFT JOIN endereco e ON e.id_endereco = p.id_endereco
LEFT JOIN pais ON pais.id_pais = e.id_pais
LEFT JOIN perfil pf ON pf.id_cliente = c.id_cliente
LEFT JOIN plano pl ON pl.id_plano = c.id_plano
GROUP BY p.id_pessoa, tipo_usuario, numero_endereco, endereco, cep, cidade, pais_origem, valor_plano, descricao_plano;

 select * from vw_usuario;

 
 -- vw_catalogo -------------------------------------------
 CREATE VIEW vw_catalogo AS
 SELECT c.id_catalogo
 ,if (f.id_filme IS NOT NULL, 'filme', 'serie') AS identificação
 , c.titulo
 , c.sinopse
 , c.ano_lancamento
 , c.duracao
 , c.avaliacao
 FROM catalogo c 
 left join filme f ON c.id_catalogo = f.id_catalogo
 left join serie s ON s.id_catalogo = f.id_catalogo;
 
 select * from vw_catalogo;
 
 
 -- vw_episodio -----------------------------------------------------------
 
CREATE VIEW vw_episodio AS
SELECT  e.id_episodio
    , e.nome episodio
    , e.duracao
    , t.titulo temporada
    , c.titulo serie
FROM serie s
LEFT JOIN episodio e ON s.id_serie = e.id_serie
LEFT JOIN temporada t ON e.id_temporada = t.id_temporada
LEFT JOIN catalogo c ON c.id_catalogo = s.id_catalogo;

select * from vw_episodio;

-- vw_temporada --------------------------------------------------------------

CREATE VIEW vw_temporada AS
SELECT  t.id_temporada
, t.titulo AS nome_temporada
, t.descricao
, COUNT(e.id_episodio) AS quantidade_episodios
, c.titulo as serie
FROM temporada t
INNER JOIN episodio e ON t.id_temporada = e.id_temporada
INNER JOIN serie s ON s.id_serie = t.id_serie
INNER JOIN catalogo c ON s.id_catalogo = c.id_catalogo
GROUP BY t.id_temporada, t.titulo, t.descricao;

SELECT * FROM vw_temporada;

-- vw_ator ---------------------------------------------------

CREATE VIEW vw_ator AS
SELECT a.nome AS atores
, COUNT(DISTINCT CASE WHEN f.id_filme IS NOT NULL THEN c.id_catalogo END) AS quantidade_filmes
, COUNT(DISTINCT CASE WHEN s.id_serie IS NOT NULL THEN c.id_catalogo END) AS quantidade_series
FROM ator a
INNER JOIN ator_catalogo ac ON a.id_ator = ac.id_ator
INNER JOIN catalogo c ON ac.id_catalogo = c.id_catalogo
LEFT JOIN filme f ON c.id_catalogo = f.id_catalogo
LEFT JOIN serie s ON c.id_catalogo = s.id_catalogo
GROUP BY a.nome;

SELECT * FROM vw_ator;

-- vw_pagamento - Deve conter todos os dados de pagamento, seu tipo, o nome do cliente, seu plano e data de vencimento.

select * from pagamento;


