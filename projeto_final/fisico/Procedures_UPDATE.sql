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
call sp_update_pais(3, 'arroz', '+4787');


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

CALL sp_update_classificacao(1, '21', 'para lindos');


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

call sp_update_ator(300,'igor', 'lindão', '2020-05-05', null);

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

call sp_update_idioma(5, 'i');
select * from idioma;


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
call sp_update_categoria(1, 'm');


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

call sp_update_catalogo(1, 'IGOR', 'MACACADA LOKA', 2023, '01:00:00',5,3,2);
select * from catalogo;

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
call sp_update_filme(1,5,100);


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

CALL sp_update_serie(11,10);

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


call sp_update_temporada(101, 'igor do mal', 'o grande poderoso', 2);

-- ------------------------

# EPISODIO
DELIMITER $$
CREATE PROCEDURE sp_insert_episodio(
    e_nome VARCHAR(100),
    e_duracao TIME,
    e_fk_temporada INT,
    e_fk_serie INT
)
BEGIN
    DECLARE verifica_temporada INT;
    DECLARE verifica_serie INT;
    SELECT COUNT(*) INTO verifica_temporada FROM temporada WHERE id_temporada = e_fk_temporada;
    SELECT COUNT(*) INTO verifica_serie FROM serie WHERE id_serie = e_fk_serie;
    
    IF verifica_temporada = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] Valor de id_temporada não encontrado';
    ELSEIF verifica_serie = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[FOREIGN KEY] Valor de id_serie não encontrado';
    ELSEIF e_nome IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo nulo';
    ELSEIF e_nome = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Campo vazio';
    ELSEIF LENGTH(e_nome) < 3 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Menos de 3 caracteres';
    ELSEIF e_duracao <= '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] Duração inválida';
    ELSE
        INSERT INTO episodio
            (nome, duracao, id_temporada, id_serie)
        VALUES
            (LOWER(e_nome), e_duracao, e_fk_temporada, e_fk_serie);
    END IF;
END $$
DELIMITER ;







