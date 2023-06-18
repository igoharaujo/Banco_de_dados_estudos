-- ------------------------- PROCEDURES ------------------------------

# ----------------- INSERTS -----------------

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
	IF cla_idade IS NULL OR cod_pais IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
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

CALL sp_insert_ator ('igor', 'Downey Jr.', '2023-05-04', null);

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

call sp_insert_idioma('test');


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

call sp_insert_categoria('test');



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

call sp_insert_catalogo('test','mafia do barroco',2024, '01:00:00', 5, 10, 2 );


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
    
    
    CALL sp_insert_pais_catalogo(5,18);
    

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
    SELECT count(*) INTO id_test2 FROM catalogo WHERE id_catalog = pc_fk_catalogo;
    
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
CREATE PROCEDURE sp_ator_catalogo(
	pc_fk_ator INT
    ,pc_fk_catalogo INT
    )
	BEGIN
    
    DECLARE id_test1 INT;
    DECLARE id_test2 INT;
    SELECT count(*) INTO id_test1 FROM ator where id_ator = pc_fk_ator;
    SELECT count(*) INTO id_test2 FROM catalogo WHERE id_catalog = pc_fk_catalogo;
    
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
CREATE PROCEDURE sp_categoria_catalogo(
	pc_fk_categoria INT
    ,pc_fk_catalogo INT
    )
	BEGIN
    
    DECLARE id_test1 INT;
    DECLARE id_test2 INT;
    SELECT count(*) INTO id_test1 FROM categoria where id_categoria = pc_fk_categoria;
    SELECT count(*) INTO id_test2 FROM catalogo WHERE id_catalog = pc_fk_catalogo;
    
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
   
    -- CATEGORIA_CATALOGO
DELIMITER $$
CREATE PROCEDURE sp_categoria_catalogo(
	pc_fk_categoria INT
    ,pc_fk_catalogo INT
    )
	BEGIN
    
    DECLARE id_test1 INT;
    DECLARE id_test2 INT;
    SELECT count(*) INTO id_test1 FROM categoria where id_categoria = pc_fk_categoria;
    SELECT count(*) INTO id_test2 FROM catalogo WHERE id_catalog = pc_fk_catalogo;
    
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

    

