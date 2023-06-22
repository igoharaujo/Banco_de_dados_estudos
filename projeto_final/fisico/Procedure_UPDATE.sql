# -------------- PROCEDURES ----------------

# --------------- INSERTS -----------------

-- PAÍS
DELIMITER $$
CREATE PROCEDURE sp_update_pais(
    p_id_pais INT,
	nome_pais VARCHAR(100),
	cod_pais VARCHAR(20)
)
BEGIN
	DECLARE verifica INT;
    SELECT count(*) INTO verifica FROM pais where id_pais = p_id_pais;
    
	IF verifica = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[PRIMARY KEY] ID não encontrad';
	ELSEIF nome_pais IS NULL OR cod_pais IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
    ELSEIF nome_pais = '' OR cod_pais = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF nome_pais NOT LIKE '%___%' OR cod_pais NOT LIKE '%__%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] quantidade de caracteres curta';
    ELSEIF cod_pais REGEXP '[a-zA-Z]' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] codigo do país invalido'; -- não aceitará nenhuma letra
	ELSEIF cod_pais not REGEXP '[+]' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] acrescente o caractere [+]'; -- Terá que inserir o caractere '+'
	ELSEIF cod_pais NOT LIKE '+%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] inserção incorreta: + '; -- o caractere '+' tera que ser inserido primeiro
	ELSE
		UPDATE pais
			SET nome = LOWER(nome_pais), codigo = cod_pais
		WHERE id_pais = p_id_pais;
	END IF;
END $$
DELIMITER ;

-- CLASSIFICAÇÃO
DELIMITER $$
CREATE PROCEDURE sp_update_classificacao(
	cla_id INT
	,cla_idade VARCHAR(20)
	,cla_descricao VARCHAR(100)
    )
    
	BEGIN
    DECLARE verifica INT;
    SELECT count(*) INTO verifica FROM classificacao where id_classificacao = cla_id;
    
	IF verifica = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[PRIMARY  KEY] id não encontrado';
	ELSEIF cla_idade IS NULL OR cla_descricao IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
	ELSEIF cla_idade = '' OR cla_descricao = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
	ELSEIF cla_descricao NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] menos de 3 caracteres';
    ELSE
		UPDATE classificacao
			SET idade = LOWER(cla_idade), descricao = LOWER(cla_descricao)
		WHERE id_classificacao = cla_id;
	END IF;
END $$
DELIMITER ;

-- ATOR
DELIMITER $$
CREATE PROCEDURE sp_update_ator(
	at_id_ator INT,
	at_nome VARCHAR(16),
	at_sobrenome VARCHAR(32),
	at_nascimento DATE,
	at_foto BLOB
)
BEGIN
	DECLARE verifica INT;
	SELECT COUNT(*) INTO verifica FROM ator WHERE id_ator = at_id_ator;
	IF verifica = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[PRIMARY KEY] ID não encontrado';
	ELSEIF at_nome IS NULL OR at_sobrenome IS NULL OR at_nascimento IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo nulo';
	ELSEIF at_nome = '' OR at_sobrenome = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo vazio';
	ELSEIF at_nome NOT LIKE '%___%' OR at_sobrenome NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Menos de 3 caracteres';
	ELSEIF at_nascimento >= CURDATE() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Data inválida';
	ELSE
		UPDATE ator
		SET
			nome = LOWER(at_nome),
			sobrenome = LOWER(at_sobrenome),
			nascimento = at_nascimento,
			foto = at_foto
		WHERE
			id_ator = at_id_ator;
	END IF;
END $$
DELIMITER ;

-- IDIOMA
DELIMITER $$
CREATE PROCEDURE sp_update_idioma(i_id_idioma INT, i_nome VARCHAR(45))
BEGIN
	DECLARE verifica INT;
	SELECT COUNT(*) INTO verifica FROM idioma WHERE id_idioma = i_id_idioma;
	IF verifica = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] ID não encontrado';
	ELSEIF i_nome IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo nulo';
	ELSEIF i_nome = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo vazio';
	ELSEIF i_nome NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Menos de 3 caracteres';
	ELSE
		UPDATE idioma
		SET nome = LOWER(i_nome)
		WHERE id_idioma = i_id_idioma;
	END IF;
END $$
DELIMITER ;

-- CATEGORIA
DELIMITER $$
CREATE PROCEDURE sp_update_categoria(c_id_categoria INT, c_nome VARCHAR(45))
BEGIN
	DECLARE verifica INT;
	SELECT COUNT(*) INTO verifica FROM categoria WHERE id_categoria = c_id_categoria;
	IF verifica = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[PRIMARY KEY] ID não encontrado';
	ELSEIF c_nome IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo nulo';
	ELSEIF c_nome = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo vazio';
	ELSEIF c_nome NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO]nome com menos de 3 caracteres';
	ELSE
		UPDATE categoria
		SET nome = LOWER(c_nome)
		WHERE id_categoria = c_id_categoria;
	END IF;
END $$
DELIMITER ;

-- CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_update_catalogo(
    c_id_catalogo INT,
    c_titulo VARCHAR(45),
    c_sinopse VARCHAR(255),
    c_lancamento YEAR,
    c_duracao TIME,
    c_avaliacao ENUM ('1', '2', '3', '4', '5'),
    c_fk_idioma INT,
    c_fk_cla INT
)
BEGIN
    DECLARE id_test1 INT;
    DECLARE id_test2 INT;
    DECLARE verifica INT;
    
    SELECT COUNT(*) INTO id_test1 FROM idioma WHERE id_idioma = c_fk_idioma;
    SELECT COUNT(*) INTO id_test2 FROM classificacao WHERE id_classificacao = c_fk_cla;
    SELECT COUNT(*) INTO verifica FROM catalogo WHERE id_catalogo = c_id_catalogo;
    
    IF verifica = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] ID INEXISTENTE';
    ELSEIF c_id_catalogo <= 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Valor inválido para ID';
    ELSEIF c_titulo IS NULL OR c_lancamento IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo nulo';
    ELSEIF c_titulo = '' OR c_sinopse = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo vazio';
    ELSEIF LENGTH(c_titulo) < 3 OR LENGTH(c_sinopse) < 3 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Menos de 3 caracteres';
    ELSEIF c_duracao <= '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Duração inválida';
    ELSEIF c_lancamento > YEAR(CURDATE()) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Ano de lançamento inválido';
    ELSEIF id_test1 = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] Valor de idioma_original não encontrado';
    ELSEIF id_test2 = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] Valor de id_classificacao não encontrado';
    ELSE
        UPDATE catalogo
        SET
            titulo = LOWER(c_titulo),
            sinopse = LOWER(c_sinopse),
            ano_lancamento = c_lancamento,
            duracao = c_duracao,
            avaliacao = c_avaliacao,
            idioma_original = c_fk_idioma,
            id_classificacao = c_fk_cla
        WHERE
            id_catalogo = c_id_catalogo;
    END IF;
END $$
DELIMITER ;
-- -------------------------------------------------
-- FILME
DELIMITER $$
CREATE PROCEDURE sp_update_filme(
    f_id_filme INT,
    f_osca INT,
    f_fk_catalogo INT
)
BEGIN
    DECLARE verifica_filme INT;
	DECLARE verifica_catalogo INT;
    SELECT COUNT(*) INTO verifica_filme FROM filme WHERE id_filme = f_id_filme;
    SELECT COUNT(*) INTO verifica_catalogo FROM catalogo WHERE id_catalogo = f_fk_catalogo;
    
    IF verifica_filme = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[PRIMARY KEY] Valor de ID não encontrado';
    ELSEIF verifica_catalogo = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] Valor de id_catalogo não encontrado';
    ELSE
        UPDATE filme
        SET osca = f_osca,
            id_catalogo = f_fk_catalogo
        WHERE id_filme = f_id_filme;
    END IF;
END $$
DELIMITER ;

-- SERIE
DELIMITER $$
CREATE PROCEDURE sp_update_serie(
    s_id_serie INT,
    s_fk_catalogo INT
)
BEGIN
    DECLARE verifica_serie INT;
	DECLARE verifica_catalogo INT;
    SELECT COUNT(*) INTO verifica_serie FROM serie WHERE id_serie = s_id_serie;
    SELECT COUNT(*) INTO verifica_catalogo FROM catalogo WHERE id_catalogo = s_fk_catalogo;
    
    IF verifica_serie = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[PRIMARY KEY] ID não encontrado';
    ELSEIF verifica_catalogo = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] Valor de id_catalogo não encontrado';
    ELSE
        UPDATE serie
        SET id_catalogo = s_fk_catalogo
        WHERE id_serie = s_id_serie;
    END IF;
END $$
DELIMITER ;

-- TEMPORADA
DELIMITER $$
CREATE PROCEDURE sp_update_temporada(
    t_id_temporada INT,
    t_titulo VARCHAR(45),
    t_descricao VARCHAR(100),
    t_fk_serie INT
)
BEGIN
    DECLARE verifica_temporada INT;
    DECLARE verifica_serie INT;
    SELECT COUNT(*) INTO verifica_temporada FROM temporada WHERE id_temporada = t_id_temporada;
    SELECT COUNT(*) INTO verifica_serie FROM serie WHERE id_serie = t_fk_serie;
    
    IF verifica_temporada = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] ID não encontrado';
    ELSEIF verifica_serie = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] Valor de id_serie não encontrado';
    ELSEIF t_titulo IS NULL OR t_descricao IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo nulo';
    ELSEIF t_titulo = '' OR t_descricao = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo vazio';
    ELSEIF LENGTH(t_titulo) < 3 OR LENGTH(t_descricao) < 3 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Quantidade de caracteres inválida';
    ELSE
        UPDATE temporada
        SET titulo = LOWER(t_titulo),
            descricao = LOWER(t_descricao),
            id_serie = t_fk_serie
        WHERE id_temporada = t_id_temporada;
    END IF;
END $$
DELIMITER ;

# EPISODIO
DELIMITER $$
CREATE PROCEDURE sp_update_episodio(
    p_id_episodio INT,
    p_nome VARCHAR(100),
    p_duracao TIME,
    p_id_temporada INT,
    p_id_serie INT
)
BEGIN
    DECLARE verifica_temporada INT;
    DECLARE verifica_serie INT;
    
    SELECT COUNT(*) INTO verifica_temporada FROM temporada WHERE id_temporada = p_id_temporada;
    SELECT COUNT(*) INTO verifica_serie FROM serie WHERE id_serie = p_id_serie;
    
    IF verifica_temporada = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] Valor de id_temporada não encontrado';
    ELSEIF verifica_serie = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] Valor de id_serie não encontrado';
    ELSEIF p_nome IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo "nome" nulo';
    ELSEIF p_nome = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo "nome" vazio';
    ELSEIF LENGTH(p_nome) < 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo "nome" com menos de 3 caracteres';
    ELSEIF p_duracao <= '00:00:00' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Duração inválida';
    ELSE
        UPDATE episodio
        SET nome = LOWER(p_nome),
            duracao = p_duracao,
            id_temporada = p_id_temporada,
            id_serie = p_id_serie
        WHERE id_episodio = p_id_episodio;
    END IF;
END $$
DELIMITER ;


#ENDEREÇO
DELIMITER $$
CREATE PROCEDURE sp_update_endereco(
	  e_id_endereco INT
	, e_numero SMALLINT
	, e_endereco VARCHAR(45)
	, e_cep CHAR(8)
	, e_cidade VARCHAR(58)
	, e_id_pais INT
)
BEGIN
    DECLARE id_test INT;
    SELECT COUNT(*) INTO id_test FROM pais WHERE id_pais = e_id_pais;
    
    IF e_endereco IS NULL OR e_cep IS NULL OR e_cidade IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF e_endereco = '' OR e_cidade = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF id_test = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor de "id_pais" não encontrado';
    ELSE
        UPDATE endereco
        SET
            numero = e_numero,
            endereco = e_endereco,
            cep = e_cep,
            cidade = e_cidade,
            id_pais = e_id_pais
        WHERE
            id_endereco = e_id_endereco;
    END IF;
END $$
DELIMITER ;
drop procedure sp_update_endereco;

-- PESSOA
DELIMITER $$
CREATE PROCEDURE sp_update_pessoa(
	  p_id_pessoa INT
	, p_nome VARCHAR(32)
	, p_sobrenome VARCHAR(45)
	, p_senha VARCHAR(32)
	, p_email VARCHAR(100)
	, p_status VARCHAR(45)
	, p_avaliacao ENUM('1','2','3','4','5')
	, p_dt_nascimento DATE
	, p_id_endereco INT
)
BEGIN
    DECLARE id_test INT;
    DECLARE id_test2 INT;
    SELECT id_pessoa INTO id_test FROM pessoa WHERE id_pessoa = p_id_pessoa;
    SELECT COUNT(*) INTO id_test2 FROM endereco WHERE id_endereco = p_id_endereco;
    
    IF p_nome IS NULL OR p_sobrenome IS NULL OR p_senha IS NULL OR p_email IS NULL OR p_dt_nascimento IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF p_dt_nascimento >= curdate() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] data invalida';
    ELSEIF p_nome = '' OR p_sobrenome = '' OR p_senha = '' OR p_email = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF LENGTH(p_senha) < 8 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] senha deve ter no mínimo 8 caracteres';
    ELSEIF id_test = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor de "id_pessoa" não encontrado';
    ELSEIF id_test2 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor de "id_endereco" não encontrado';
    ELSE
        UPDATE pessoa
        SET
            nome = LOWER(p_nome),
            sobrenome = LOWER(p_sobrenome),
            senha = p_senha,
            email = LOWER(p_email),
            status = LOWER(p_status),
            avaliacao = p_avaliacao,
            dt_nascimento = p_dt_nascimento,
            id_endereco = p_id_endereco
        WHERE
            id_pessoa = p_id_pessoa;
    END IF;
END $$
DELIMITER ;

-- FUNCIONARIO
DELIMITER $$
CREATE PROCEDURE sp_update_funcionario(
	  f_id_funcionario INT
	, f_foto TINYBLOB
	, f_id_pessoa INT
)
BEGIN
    DECLARE id_test INT;
    SELECT COUNT(*) INTO id_test FROM pessoa WHERE id_pessoa = f_id_pessoa;
    
    IF f_id_pessoa IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF id_test = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor de "id_pessoa" não encontrado';
    ELSE
        UPDATE funcionario
        SET
            foto = f_foto,
            id_pessoa = f_id_pessoa
        WHERE
            id_funcionario = f_id_funcionario;
    END IF;
END $$
DELIMITER ;

-- PAGAMENTO
DELIMITER $$
CREATE PROCEDURE sp_update_plano(
	  p_id_plano INT
	, p_valor FLOAT
	, p_descricao VARCHAR(100)
)
BEGIN
    IF p_valor IS NULL OR p_descricao IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF p_descricao = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSE
        UPDATE plano
        SET
            valor = p_valor,
            descricao = p_descricao
        WHERE
            id_plano = p_id_plano;
    END IF;
END $$
DELIMITER ;

-- TIPO_PAGAMENTO
DELIMITER $$
CREATE PROCEDURE sp_update_tipo_pagamento(
	  tp_id_tipo_pagamento INT
	, tp_nome VARCHAR(45)
)
BEGIN
    IF tp_nome IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF tp_nome = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSE
        UPDATE tipo_pagamento
        SET nome = tp_nome
        WHERE id_tipo_pagamento = tp_id_tipo_pagamento;
    END IF;
END $$
DELIMITER ;

-- CLIENTE
DELIMITER $$
CREATE PROCEDURE sp_update_cliente(
	  c_id_cliente INT
	, c_nickname VARCHAR(32)
	, c_dt_vencimento DATE
	, c_id_plano INT
	, c_id_pessoa INT
)
BEGIN
	
	DECLARE verifica INT;
	DECLARE verifica2 INT;
    SELECT count(*) INTO verifica FROM pessoa WHERE id_pessoa = c_id_pessoa;
    SELECT count(*) INTO verifica2 FROM plano WHERE id_plano = c_id_plano;

    IF c_nickname IS NULL OR c_dt_vencimento IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF c_nickname = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF verifica = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor de "id_pessoa" não encontrado';
     ELSEIF verifica2 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor de "id_plano" não encontrado';
    ELSEIF c_id_plano IS NOT NULL AND NOT EXISTS (SELECT id_plano FROM plano WHERE id_plano = c_id_plano) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_plano não encontrado';
    ELSE
        UPDATE cliente
        SET
            nickname = c_nickname,
            dt_vencimento = c_dt_vencimento,
            id_plano = c_id_plano,
            id_pessoa = c_id_pessoa
        WHERE
            id_cliente = c_id_cliente;
    END IF;
END $$
DELIMITER ;

-- PAGAMENTO

DELIMITER $$
CREATE PROCEDURE sp_update_pagamento(
	  p_id_pagamento INT
	, p_valor FLOAT
	, p_forma_pagamento VARCHAR(20)
	, p_id_cliente INT
	, p_id_cartao INT
	, p_id_tipo_pagamento INT
)
BEGIN
    IF p_valor IS NULL OR p_forma_pagamento IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF p_forma_pagamento = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF p_id_cliente IS NOT NULL AND NOT EXISTS (SELECT id_cliente FROM cliente WHERE id_cliente = p_id_cliente) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_cliente não encontrado';
    ELSEIF p_id_cartao IS NOT NULL AND NOT EXISTS (SELECT id_cartao FROM cartao_credito WHERE id_cartao = p_id_cartao) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_cartao não encontrado';
    ELSEIF p_id_tipo_pagamento IS NOT NULL AND NOT EXISTS (SELECT id_tipo_pagamento FROM tipo_pagamento WHERE id_tipo_pagamento = p_id_tipo_pagamento) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_tipo_pagamento não encontrado';
    ELSE
        UPDATE pagamento
        SET
            valor = p_valor,
            forma_pagamento = p_forma_pagamento,
            id_cliente = p_id_cliente,
            id_cartao = p_id_cartao,
            id_tipo_pagamento = p_id_tipo_pagamento
        WHERE
            id_pagamento = p_id_pagamento;
    END IF;
END $$
DELIMITER ;

-- PERFIL

DELIMITER $$
CREATE PROCEDURE sp_update_perfil(
    p_id_perfil INT,
    p_foto BLOB,
    p_nome VARCHAR(32),
    p_tipo ENUM('perfil infantil', 'perfil adulto'),
    p_id_cliente INT
)
BEGIN
    IF p_foto IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo foto não pode ser nulo';
    ELSEIF p_nome IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo nome não pode ser nulo';
    ELSEIF p_nome = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo nome não pode ser vazio';
    ELSEIF p_id_cliente IS NOT NULL AND NOT EXISTS (SELECT id_cliente FROM cliente WHERE id_cliente = p_id_cliente) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_cliente não encontrado';
    ELSE
        UPDATE perfil
        SET foto = p_foto,
            nome = LOWER(p_nome),
            tipo = p_tipo,
            id_cliente = p_id_cliente
        WHERE id_perfil = p_id_perfil;
    END IF;
END $$
DELIMITER ;








