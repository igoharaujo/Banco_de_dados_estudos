DELIMITER $$
CREATE PROCEDURE sp_insert_pais(nome_pais VARCHAR(100), cod_pais VARCHAR(20))
	BEGIN
		
       
		IF nome_pais IS NULL OR cod_pais IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo null ';
        ELSEIF nome_pais = '' OR cod_pais = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] campo vazio';
        ELSEIF nome_pais NOT LIKE '%___%' OR cod_pais NOT LIKE '%__%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] menos de 2 caracteres letras';
        ELSEIF cod_pais REGEXP '[a-zA-Z]' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] codigo do país invalido'; -- não aceitará nenhuma letra do alfabeto
		ELSEIF cod_pais not REGEXP '[+]' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] acrescente o caractere [+]';
		ELSEIF cod_pais NOT LIKE '+%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] inserção incorreta: + ';
    
    
		ELSE
		INSERT INTO pais
			(nome, codigo)
		VALUES
			(LOWER(nome_pais), cod_pais);
		END IF;
    END $$
DELIMITER ;



