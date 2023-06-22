# -------------- PROCEDURES ----------------

# --------------- INSERTS -----------------

-- PAÍS
DELIMITER $$
CREATE PROCEDURE sp_insert_pais(
	nome_pais VARCHAR(100)
	,cod_pais VARCHAR(20)
    )
    
	BEGIN
		
		IF nome_pais IS NULL OR cod_pais IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
        ELSEIF nome_pais = '' OR cod_pais = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
        ELSEIF nome_pais NOT LIKE '%___%' OR cod_pais NOT LIKE '%__%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] quantidade de caracteres curta';
        ELSEIF cod_pais REGEXP '[a-zA-Z]' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] codigo do país invalido'; -- não aceitará nenhuma letra
		ELSEIF cod_pais not REGEXP '[+]' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] acrescente o caractere [+]'; -- Terá que inserir o caractere '+'
		ELSEIF cod_pais NOT LIKE '+%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] inserção incorreta: + '; -- o caractere '+' tera que ser inserido primeiro
		ELSE
			INSERT INTO pais
				(nome, codigo)
			VALUES
				(LOWER(nome_pais), cod_pais);
		END IF;
    END $$
DELIMITER ;

-- CLASSIFICAÇÃO
DELIMITER $$
CREATE PROCEDURE sp_insert_classificacao(
	cla_idade VARCHAR(20)
	,cla_descricao VARCHAR(100)
    )
    
	BEGIN
	IF cla_idade IS NULL OR cla_descricao IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
	ELSEIF cla_idade = '' OR cla_descricao = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
	ELSEIF cla_descricao NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] menos de 3 caracteres';
    ELSE
    
		INSERT INTO classificacao
			(idade, descricao)
		VALUES
			(LOWER(cla_idade), LOWER(cla_descricao));
	END IF;
    
    END $$
    DELIMITER ;
    
-- ATOR
DELIMITER $$
CREATE PROCEDURE sp_insert_ator(
	at_nome VARCHAR(16)
    ,at_sobrenome VARCHAR(32)
    ,at_nascimento DATE
    ,at_foto BLOB
    )
    
	BEGIN
		IF at_nome IS NULL OR at_sobrenome IS NULL OR at_nascimento IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campu null';
		ELSEIF at_nome = '' OR at_sobrenome  = '' OR at_foto = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
		ELSEIF at_nome NOT LIKE '%___%' OR at_sobrenome NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] menos de 3 caracteres';
        ELSEIF at_nascimento >= curdate() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] data invalida';
		ELSE
			INSERT INTO ator 
				(nome, sobrenome, nascimento, foto)
			VALUES
				(LOWER(at_nome), LOWER(at_sobrenome), at_nascimento, at_foto);
		END IF;
    
    END $$
DELIMITER ;

-- IDIOMA
DELIMITER $$
CREATE PROCEDURE sp_insert_idioma(i_nome VARCHAR(45))
	BEGIN
	IF i_nome IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
	ELSEIF i_nome = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
	ELSEIF i_nome NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] menos de 3 caracteres';
    ELSE
    
		INSERT INTO idioma
			(nome)
		VALUES
			(LOWER(i_nome));
	END IF;
    
    END $$
    DELIMITER ;


-- CATEGORIA
DELIMITER $$
CREATE PROCEDURE sp_insert_categoria(c_nome VARCHAR(45))
	BEGIN
	IF c_nome IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
	ELSEIF c_nome = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
	ELSEIF c_nome NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] menos de 3 caracteres';
    ELSE
    
		INSERT INTO categoria
			(nome)
		VALUES
			(LOWER(c_nome));
	END IF;
    
    END $$
    DELIMITER ;

-- CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_insert_catalogo(
	  c_titulo VARCHAR(45)
	, c_sinopse VARCHAR(255)
	, c_lancamento YEAR
	, c_duracao TIME
	, c_avaliacao ENUM ('1','2','3','4','5')
	, c_fk_idioma INT
    , c_fk_cla INT
    )
    
	BEGIN
    
    DECLARE id_test1 INT;
    DECLARE id_test2 INT;
    SELECT count(*) INTO id_test1 FROM idioma where id_idioma = c_fk_idioma;
    SELECT count(*) INTO id_test2 FROM classificacao WHERE id_classificacao = c_fk_cla;
    
    
	IF c_titulo IS NULL OR c_lancamento IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
	ELSEIF c_titulo = '' OR c_sinopse = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
	ELSEIF c_titulo NOT LIKE '%___%' OR c_sinopse NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] menos de 3 caracteres';
    ELSEIF c_duracao <= '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] time invalido';
	ELSEIF c_lancamento >  year(curdate()) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] ano invalido';
    ELSEIF id_test1 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´idioma_original´ não encontrado';
    ELSEIF id_test2 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´id_classificacao´ não encontrado';
    ELSE
    
		INSERT INTO catalogo
			(titulo, sinopse, ano_lancamento, duracao, avaliacao, idioma_original, id_classificacao)
		VALUES
			(LOWER(c_titulo),LOWER(c_sinopse), c_lancamento, c_duracao, c_avaliacao, c_fk_idioma, c_fk_cla);
	END IF;
    
    END $$
    DELIMITER ;

-- PAÍS_CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_insert_pais_catalogo(
	pc_fk_pais INT
    ,pc_fk_catalogo INT
    )
	BEGIN
    
    DECLARE id_test1 INT;
    DECLARE id_test2 INT;
    SELECT count(*) INTO id_test1 FROM pais where id_pais = pc_fk_pais;
    SELECT count(*) INTO id_test2 FROM catalogo WHERE id_catalogo = pc_fk_catalogo;
    
    IF id_test1 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´ID_PAÍS´ não encontrado';
    ELSEIF id_test2 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´ID_CATALOGO´ não encontrado';
    ELSE
    
		INSERT INTO pais_catalogo
			(id_pais, id_catalogo)
		VALUES
			(pc_fk_pais, pc_fk_catalogo);
	END IF;
    
    END $$
    DELIMITER ;

-- IDIOMA_CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_insert_idioma_catalogo(
	pc_fk_idioma INT
    ,pc_fk_catalogo INT
    )
	BEGIN
    
    DECLARE id_test1 INT;
    DECLARE id_test2 INT;
    SELECT count(*) INTO id_test1 FROM idioma where id_idioma = pc_fk_idioma;
    SELECT count(*) INTO id_test2 FROM catalogo WHERE id_catalogo = pc_fk_catalogo;
    
    IF id_test1 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´id_idioma´ não encontrado';
    ELSEIF id_test2 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´ID_CATALOGO´ não encontrado';
    ELSE
    
		INSERT INTO idioma_catalogo
			(id_idioma, id_catalogo)
		VALUES
			(pc_fk_idioma, pc_fk_catalogo);
	END IF;
    
    END $$
    DELIMITER ;
    
-- ATOR_CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_insert_ator_catalogo(
	pc_fk_ator INT
    ,pc_fk_catalogo INT
    )
	BEGIN
    
    DECLARE id_test1 INT;
    DECLARE id_test2 INT;
    SELECT count(*) INTO id_test1 FROM ator where id_ator = pc_fk_ator;
    SELECT count(*) INTO id_test2 FROM catalogo WHERE id_catalogo = pc_fk_catalogo;
    
    IF id_test1 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´ID_ATOR´ não encontrado';
    ELSEIF id_test2 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´ID_CATALOGO´ não encontrado';
    ELSE
    
		INSERT INTO ator_catalogo
			(id_ator, id_catalogo)
		VALUES
			(pc_fk_ator, pc_fk_catalogo);
	END IF;
    
    END $$
    DELIMITER ;
   
-- CATEGORIA_CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_insert_categoria_catalogo(
	pc_fk_categoria INT
    ,pc_fk_catalogo INT
    )
	BEGIN
    
    DECLARE id_test1 INT;
    DECLARE id_test2 INT;
    SELECT count(*) INTO id_test1 FROM categoria where id_categoria = pc_fk_categoria;
    SELECT count(*) INTO id_test2 FROM catalogo WHERE id_catalogo = pc_fk_catalogo;
    
    IF id_test1 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´ID_CATEGORIA_´ não encontrado';
    ELSEIF id_test2 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´ID_CATALOGO´ não encontrado';
    ELSE
    
		INSERT INTO categoria_catalogo
			(id_categoria, id_catalogo)
		VALUES
			(pc_fk_categoria, pc_fk_catalogo);
	END IF;
    
    END $$
    DELIMITER ;
    
    -- FILME
DELIMITER $$
CREATE PROCEDURE sp_insert_filme(
	f_osca INT
    ,f_fk_catalogo INT
    )
	BEGIN
    
    DECLARE verifica INT;
    SELECT count(*) INTO verifica FROM catalogo where id_catalogo = f_fk_catalogo;

    IF verifica = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´id_catalogo´ não encontrado';
    ELSE
    
		INSERT INTO filme
			(osca, id_catalogo)
		VALUES
			(f_osca, f_fk_catalogo);
	END IF;
    
    END $$
    DELIMITER ;
    

 -- SERIE
DELIMITER $$
CREATE PROCEDURE sp_insert_serie(
    s_fk_catalogo INT
    )
	BEGIN
    
    DECLARE verifica INT;
    SELECT count(*) INTO verifica FROM catalogo where id_catalogo = s_fk_catalogo;

    IF verifica = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´id_catalogo´ não encontrado';
    ELSE
    
		INSERT INTO filme
			(id_catalogo)
		VALUES
			(s_fk_catalogo);
	END IF;
    
    END $$
    DELIMITER ;
    


-- TEMPORADA
DELIMITER $$
CREATE PROCEDURE sp_insert_temporada(
	t_titulo VARCHAR(45)
    ,t_descricao VARCHAR(100)
    ,t_fk_serie INT
    )
	BEGIN
    
    DECLARE verifica INT;
    SELECT count(*) INTO verifica FROM serie where id_serie = t_fk_serie;

    IF verifica = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´id_serie´ não encontrado';
    ELSEIF t_titulo IS NULL OR t_descricao IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
	ELSEIF t_titulo = '' OR t_descricao = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF t_titulo NOT LIKE '%__%' OR t_descricao NOT LIKE '%__%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] qtd de caracteres invalida';
    ELSE
    
		INSERT INTO temporada
			(titulo, descricao, id_serie)
		VALUES
			(LOWER(t_titulo), LOWER(t_descricao), t_fk_serie);
	END IF;
    
    END $$
    DELIMITER ;
    
    
-- EPISODIO
DELIMITER $$
CREATE PROCEDURE sp_insert_episodio(
	e_nome VARCHAR(100)
    ,e_duracao TIME
    ,e_fk_temporada INT
    ,e_fk_serie INT
    )
	BEGIN
    
    DECLARE verifica1 INT;
    DECLARE verifica2 INT;
    SELECT count(*) INTO verifica1 FROM temporada where id_temporada = e_fk_temporada;
    SELECT count(*) INTO verifica2 FROM serie where id_serie = e_fk_serie;

    IF verifica1 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´id_temporada´ não encontrado';
	ELSEIF verifica2 = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREING KEY] valor ´id_serie´ não encontrado';
    ELSEIF e_nome IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
	ELSEIF e_nome = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
	ELSEIF e_nome NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] menos de 3 caracteres';
    ELSEIF e_duracao <= '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] time invalido';
    ELSE
    
		INSERT INTO episodio
			(nome, duracao, id_temporada, id_serie)
		VALUES
			(LOWER(e_nome), e_duracao, e_fk_temporada, e_fk_serie);
	END IF;
    
    END $$
    DELIMITER ;
    
-- ENDERECO
    DELIMITER $$
CREATE PROCEDURE sp_insert_endereco(
	  e_numero SMALLINT
	, e_endereco VARCHAR(45)
	, e_cep CHAR(8)
	, e_cidade VARCHAR(58)
	, e_id_pais INT
)
BEGIN
    DECLARE id_test INT;
    SELECT COUNT(*) INTO id_test FROM pais WHERE id_pais = e_id_pais;
    
    IF e_endereco IS NULL OR e_cep IS NULL OR e_cidade IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF e_endereco = '' OR e_cep = '' OR e_cidade = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF LENGTH(e_cep) <> 8 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] CEP inválido';
    ELSEIF id_test = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor de "id_pais" não encontrado';
    ELSE
        INSERT INTO endereco (numero, endereco, cep, cidade, id_pais)
        VALUES (e_numero, e_endereco, e_cep, e_cidade, e_id_pais);
    END IF;
END $$
DELIMITER ;

-- PESSOA
DELIMITER $$
CREATE PROCEDURE sp_insert_pessoa(
	  p_nome VARCHAR(32)
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
    SELECT COUNT(*) INTO id_test FROM endereco WHERE id_endereco = p_id_endereco;
    
    IF p_nome IS NULL OR p_sobrenome IS NULL OR p_senha IS NULL OR p_email IS NULL OR p_dt_nascimento IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF p_nome = '' OR p_sobrenome = '' OR p_senha = '' OR p_email = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF LENGTH(p_senha) < 8 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] senha deve ter no mínimo 8 caracteres';
    ELSEIF p_id_endereco IS NOT NULL AND id_test = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor de "id_endereco" não encontrado';
    ELSE
        INSERT INTO pessoa (nome, sobrenome, senha, email, status, avaliacao, dt_nascimento, dt_cadastro, id_endereco)
        VALUES (LOWER(p_nome), LOWER(p_sobrenome), p_senha, LOWER(p_email), LOWER(p_status), p_avaliacao, p_dt_nascimento, CURDATE(), p_id_endereco);
    END IF;
END $$
DELIMITER ;

-- FUNCIONARIO
DELIMITER $$
CREATE PROCEDURE sp_insert_funcionario(
	  f_foto TINYBLOB
	, f_id_pessoa INT
)
BEGIN
    DECLARE id_test INT;
    SELECT COUNT(*) INTO id_test FROM pessoa WHERE id_pessoa = f_id_pessoa;
    
    IF f_id_pessoa IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF id_test = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor de "id_pessoa" não encontrado';
    ELSE
        INSERT INTO funcionario (foto, id_pessoa)
        VALUES (f_foto, f_id_pessoa);
    END IF;
END $$
DELIMITER ;


-- PLANO
DELIMITER $$
CREATE PROCEDURE sp_insert_plano(
	  p_valor FLOAT
	, p_descricao VARCHAR(100)
)
BEGIN
    IF p_valor IS NULL OR p_descricao IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF p_descricao = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSE
        INSERT INTO plano (valor, descricao)
        VALUES (p_valor, LOWER(p_descricao));
    END IF;
END $$
DELIMITER ;


-- CARTAO_CREDITO
DELIMITER $$
CREATE PROCEDURE sp_insert_cartao_credito(
	  c_numero VARCHAR(16)
	, c_dt_vencimento DATE
	, c_cod_seguranca INT
	, c_titular VARCHAR(100)
)
BEGIN
    IF c_numero IS NULL OR c_dt_vencimento IS NULL OR c_cod_seguranca IS NULL OR c_titular IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF c_numero = '' OR c_titular = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSE
        INSERT INTO cartao_credito (numero, dt_vencimento, cod_seguranca, titular)
        VALUES (c_numero, c_dt_vencimento, c_cod_seguranca, LOWER(c_titular));
    END IF;
END $$
DELIMITER ;


-- TIPO_PAGAMENTO

DELIMITER $$
CREATE PROCEDURE sp_insert_tipo_pagamento(
	  tp_nome VARCHAR(45)
)
BEGIN
    IF tp_nome IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF tp_nome = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSE
        INSERT INTO tipo_pagamento (nome)
        VALUES (LOWER(tp_nome));
    END IF;
END $$
DELIMITER ;


-- CLIENTE

DELIMITER $$
CREATE PROCEDURE sp_insert_cliente(
	  c_nickname VARCHAR(32)
	, c_dt_vencimento DATE
	, c_id_plano INT
	, c_id_pessoa INT
)
BEGIN
    IF c_nickname IS NULL OR c_dt_vencimento IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF c_nickname = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF c_id_pessoa IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] id_pessoa não pode ser null';
    ELSEIF c_id_plano IS NOT NULL AND NOT EXISTS (SELECT id_plano FROM plano WHERE id_plano = c_id_plano) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_plano não encontrado';
    ELSE
        INSERT INTO cliente (nickname, dt_vencimento, id_plano, id_pessoa)
        VALUES (LOWER(c_nickname), c_dt_vencimento, c_id_plano, c_id_pessoa);
    END IF;
END $$
DELIMITER ;


-- PAGAMENTO

DELIMITER $$
CREATE PROCEDURE sp_insert_pagamento(
	  p_valor FLOAT
	, p_forma_pagamento VARCHAR(20)
	, p_id_cliente INT
	, p_id_cartao INT
	, p_id_tipo_pagamento INT
)
BEGIN
    IF p_valor IS NULL OR p_forma_pagamento IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null';
    ELSEIF p_forma_pagamento = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
    ELSEIF p_id_cliente IS NOT NULL AND NOT EXISTS (SELECT id_cliente FROM cliente WHERE id_cliente = p_id_cliente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_cliente não encontrado';
    ELSEIF p_id_cartao IS NOT NULL AND NOT EXISTS (SELECT id_cartao FROM cartao_credito WHERE id_cartao = p_id_cartao) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_cartao não encontrado';
    ELSEIF p_id_tipo_pagamento IS NOT NULL AND NOT EXISTS (SELECT id_tipo_pagamento FROM tipo_pagamento WHERE id_tipo_pagamento = p_id_tipo_pagamento) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_tipo_pagamento não encontrado';
    ELSE
        INSERT INTO pagamento (valor, forma_pagamento, id_cliente, id_cartao, id_tipo_pagamento)
        VALUES (p_valor, p_forma_pagamento, p_id_cliente, p_id_cartao, p_id_tipo_pagamento);
    END IF;
END $$
DELIMITER ;


-- PERFIL

DELIMITER $$
CREATE PROCEDURE sp_insert_perfil(
    p_foto BLOB,
    p_nome VARCHAR(32),
    p_tipo ENUM('perfil infantil', 'perfil adulto'),
    p_id_cliente INT
)
BEGIN
    IF p_foto IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo foto não pode ser nulo';
    ELSEIF p_nome IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo nome não pode ser nulo';
    ELSEIF p_nome = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo nome não pode ser vazio';
    ELSEIF p_id_cliente IS NOT NULL AND NOT EXISTS (SELECT id_cliente FROM cliente WHERE id_cliente = p_id_cliente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] valor id_cliente não encontrado';
    ELSE
        INSERT INTO perfil (foto, nome, tipo, id_cliente)
        VALUES (p_foto, LOWER(p_nome), p_tipo, p_id_cliente);
    END IF;
END $$
DELIMITER ;

