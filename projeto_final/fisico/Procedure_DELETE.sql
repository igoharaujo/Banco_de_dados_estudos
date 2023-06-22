
-- PAIS
DELIMITER $$
CREATE PROCEDURE sp_delete_pais(
    p_id_pais INT
)
BEGIN
    DELETE FROM pais
    WHERE id_pais = p_id_pais;
END $$
DELIMITER ;

-- CLASSIFICACAO
DELIMITER $$
CREATE PROCEDURE sp_delete_classificacao(
    p_id_classificacao INT
)
BEGIN
    DELETE FROM classificacao
    WHERE id_classificacao = p_id_classificacao;
END $$
DELIMITER ;

-- ATOR
DELIMITER $$
CREATE PROCEDURE sp_delete_ator(
    p_id_ator INT
)
BEGIN
    DELETE FROM ator
    WHERE id_ator = p_id_ator;
END $$
DELIMITER ;

-- IDIOMA
DELIMITER $$
CREATE PROCEDURE sp_delete_idioma(
    p_id_idioma INT
)
BEGIN
    DELETE FROM idioma
    WHERE id_idioma = p_id_idioma;
END $$
DELIMITER ;

-- CATEGORIA
DELIMITER $$
CREATE PROCEDURE sp_delete_categoria(
    p_id_categoria INT
)
BEGIN
    DELETE FROM categoria
    WHERE id_categoria = p_id_categoria;
END $$
DELIMITER ;

-- CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_delete_catalogo(
    p_id_catalogo INT
)
BEGIN
    DELETE FROM catalogo
    WHERE id_catalogo = p_id_catalogo;
END $$
DELIMITER ;

-- PAIS_CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_delete_pais_catalogo(
    p_id_pais INT,
    p_id_catalogo INT
)
BEGIN
    DELETE FROM pais_catalogo
    WHERE id_pais = p_id_pais
    AND id_catalogo = p_id_catalogo;
END $$
DELIMITER ;

-- IDIOMA_CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_delete_idioma_catalogo(
    p_id_idioma INT,
    p_id_catalogo INT
)
BEGIN
    DELETE FROM idioma_catalogo
    WHERE id_idioma = p_id_idioma
    AND id_catalogo = p_id_catalogo;
END $$
DELIMITER ;

-- ATOR_CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_delete_ator_catalogo(
    p_id_ator INT,
    p_id_catalogo INT
)
BEGIN
    DELETE FROM ator_catalogo
    WHERE id_ator = p_id_ator
    AND id_catalogo = p_id_catalogo;
END $$
DELIMITER ;

-- CATEGORIA_CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_delete_categoria_catalogo(
    p_id_categoria INT,
    p_id_catalogo INT
)
BEGIN
    DELETE FROM categoria_catalogo
    WHERE id_categoria = p_id_categoria
    AND id_catalogo = p_id_catalogo;
END $$
DELIMITER ;


-- FILME
DELIMITER $$
CREATE PROCEDURE sp_delete_filme(
    p_id_filme INT
)
BEGIN
    DELETE FROM filme
    WHERE id_filme = p_id_filme;
END $$
DELIMITER ;

-- SERIE
DELIMITER $$
CREATE PROCEDURE sp_delete_serie(
    p_id_serie INT
)
BEGIN
    DELETE FROM serie
    WHERE id_serie = p_id_serie;
END $$
DELIMITER ;

-- TEMPORADA
DELIMITER $$
CREATE PROCEDURE sp_delete_temporada(
    p_id_temporada INT
)
BEGIN
    DELETE FROM temporada
    WHERE id_temporada = p_id_temporada;
END $$
DELIMITER ;

-- EPISODIO
DELIMITER $$
CREATE PROCEDURE sp_delete_episodio(
    p_id_episodio INT
)
BEGIN
    DELETE FROM episodio
    WHERE id_episodio = p_id_episodio;
END $$
DELIMITER ;


-- ENDERECO
DELIMITER $$
CREATE PROCEDURE sp_delete_endereco(
    p_id_endereco INT
)
BEGIN
    DELETE FROM endereco
    WHERE id_endereco = p_id_endereco;
END $$
DELIMITER ;


-- PESSOA
DELIMITER $$
CREATE PROCEDURE sp_delete_pessoa(
    p_id_pessoa INT
)
BEGIN
    DELETE FROM pessoa
    WHERE id_pessoa = p_id_pessoa;
END $$
DELIMITER ;


-- FUNCIONARIO
DELIMITER $$
CREATE PROCEDURE sp_delete_funcionario(
    p_id_funcionario INT
)
BEGIN
    DELETE FROM funcionario
    WHERE id_funcionario = p_id_funcionario;
END $$
DELIMITER ;


-- PLANO
DELIMITER $$
CREATE PROCEDURE sp_delete_plano(
    p_id_plano INT
)
BEGIN
    DELETE FROM plano
    WHERE id_plano = p_id_plano;
END $$
DELIMITER ;

-- CARTAO_CREDITO
DELIMITER $$
CREATE PROCEDURE sp_delete_cartao_credito(
    p_id_cartao INT
)
BEGIN
    DELETE FROM cartao_credito
    WHERE id_cartao = p_id_cartao;
END $$
DELIMITER ;

-- TIPO_PAGAMENTO
DELIMITER $$
CREATE PROCEDURE sp_delete_tipo_pagamento(
    p_id_tipo_pagamento INT
)
BEGIN
    DELETE FROM tipo_pagamento
    WHERE id_tipo_pagamento = p_id_tipo_pagamento;
END $$
DELIMITER ;


-- CLIENTE
DELIMITER $$
CREATE PROCEDURE sp_delete_cliente(
    p_id_cliente INT
)
BEGIN
    DELETE FROM cliente
    WHERE id_cliente = p_id_cliente;
END $$
DELIMITER ;


-- PAGAMENTO
DELIMITER $$
CREATE PROCEDURE sp_delete_pagamento(
    p_id_pagamento INT
)
BEGIN
    DELETE FROM pagamento
    WHERE id_pagamento = p_id_pagamento;
END $$
DELIMITER ;


-- PERFIL
DELIMITER $$
CREATE PROCEDURE sp_delete_perfil(
    p_id_perfil INT
)
BEGIN
    DELETE FROM perfil
    WHERE id_perfil = p_id_perfil;
END $$
DELIMITER ;
