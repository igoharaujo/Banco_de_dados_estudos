/*Modifique os procedimentos de insert e update, todos os dados devem ser validados, antes das inserções e atualizações, por exemplo:

- nomes devem ser inseridos/atualizados sem acentos e não podemos aceitar valores vazios ou nulos
- datas não podem ser futuras
- tempos não podem ser negativos
- e as fk's devem ser conferidas se existem antes de inseridas

Para cada erro deve ser gerado uma mensagem personalizada o identificando.*/



#------------------------------------------------------------------insert---------------------------------------------------------------------------------------

#-------------------- tb_artista
DELIMITER $$ b
CREATE PROCEDURE sp_insert_art(nome_art VARCHAR(255), nascimento_art DATE, fk_id_tipo_art INT)
	BEGIN
    DECLARE id_existe INT;
    SELECT COUNT(*) INTO id_existe FROM tb_tipo_artista WHERE id = fk_id_tipo_art;
    
    IF nome_art IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] nome NULL';
    ELSEIF nome_art = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[INVALIDO] nome vazio';
    ELSEIF nome_art NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'não é permitido nome com menos de três letras';
    ELSEIF id_existe = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id não existe na tabela tipo artista';
    ELSE
		INSERT INTO tb_artista
			(nome, dt_nascimento, id_tipo_artista)
		VALUES
			(fn_acento(trim(nome_art)), nascimento_art, fk_id_tipo_art);
            END IF;
	END $$
DELIMITER ;

call sp_insert_art('IGORLINO', '2000-05-05', 7);

#
#
#-------------------- tb_disco
DELIMITER $$
CREATE PROCEDURE sp_insert_dis(titulo_dis VARCHAR(255), duracao_dis TIME, lancamento YEAR, cod_art INT, cod_gra INT, cod_gen INT)
	BEGIN
		DECLARE id_existe_art INT;
        DECLARE id_existe_gra INT;
        DECLARE id_existe_gen INT;
        SELECT COUNT(*) INTO id_existe_art FROM tb_artista WHERE id = cod_art;
        SELECT COUNT(*) INTO id_existe_gra FROM tb_gravadora WHERE id = cod_gra;
        SELECT COUNT(*) INTO id_existe_gen FROM tb_genero WHERE id = cod_gen;
        
		IF duracao_dis < '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido horarios negativos';
        ELSEIF lancamento > curdate() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido um ano maior que o atual';
        ELSEIF id_existe_art = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'o cod artista não existe na tabela artista';
        ELSEIF id_existe_gra = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O  cod gravadora não existe na tabela gravadora';
        ELSEIF id_existe_gen = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O cod genero não existe na tabela genero';
        ELSEIF titulo_dis IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido nome null';
        ELSEIF titulo_dis = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido nome vazio';
        ELSEIF titulo_dis NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido nome com menos de duas letras';
        else
			INSERT INTO tb_disco
				(titulo, duracao, ano_lancamento, id_artista, id_gravadora, id_genero)
			VALUES
				(fn_acento(trim(titulo_dis)), duracao_dis, lancamento, cod_art, cod_gra, cod_gen);
		END IF;
	
    END $$
DELIMITER ;

CALL sp_insert_dis('m', '01:00:00', 2023, 12, 14, 60);

#
#
#-------------------- tb_genero
DELIMITER $$
CREATE PROCEDURE sp_insert_gen(nome_gen VARCHAR(255))
	BEGIN
        CASE 
			WHEN nome_gen = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido inserir um nome vazio vazio';
            WHEN nome_gen IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido inserir um nome null';
            WHEN nome_gen NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido inserir nomes com menos de tres letras';
            ELSE
            INSERT INTO tb_genero
				(nome)
			VALUES 
				(fn_acento(trim(nome_gen)));
		END CASE;
    
    END $$
DELIMITER ;

call sp_insert_gen('terror');

#
#
#-------------------- tb_gravadora
DELIMITER $$
CREATE FUNCTION fn_insert_gra(nome_gra VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
	BEGIN
		CASE
			WHEN nome_gra IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido valores NULL';
            WHEN nome_gra = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido valor vazio';
            WHEN nome_gra NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido nomes com menos de tres letras';
            ELSE
            INSERT INTO tb_gravadora
				(nome)
			VALUES
				(fn_acento(trim(nome_gra)));
        END CASE;
    
    RETURN nome_gra;
    END $$
DELIMITER ;

select fn_insert_gra('aninha revoluções');

#
#
#-------------------- tb_musica
DELIMITER $$
CREATE PROCEDURE sp_insert_mus(nome_mus VARCHAR(255), duracao_mus TIME, cod_disco INT)
	BEGIN
		DECLARE verifica INT;
        SELECT COUNT(*) INTO verifica FROM tb_disco WHERE id = cod_disco;
        
        CASE
			WHEN nome_mus IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido inserir nome null';
            when nome_mus = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido nome com valor vazio';
            when nome_mus NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido inserir nome com menos de três letras';
            WHEN duracao_mus < '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitidos tempo negativo';
            WHEN verifica = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id não existe na tabela disco';
            ELSE
				INSERT INTO tb_musica
					(nome, duracao, id_disco)
				VALUES
					(fn_acento(trim(nome_mus)), duracao_mus, cod_disco);
			END CASE;
	END $$
DELIMITER ;

CALL sp_insert_mus('mamamia', '01:00:00', 12);

#
#

DELIMITER $$
CREATE PROCEDURE sp_insert_tipo(nome_t VARCHAR(255))
	BEGIN
		CASE
			WHEN nome_t IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido valores null';
            WHEN nome_t = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido valor vazio';
            WHEN nome_t NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido nome com menos de três letras';
            ELSE
            INSERT INTO tb_tipo_artista
				(nome)
			VALUES
				(fn_acento(trim(nome)));
		END CASE;
    END $$
DELIMITER ;

#
#
#--------------------------------------------------------------------- UPDATE --------------------------------------------------------------------------

#---------------tb_artista
DELIMITER $$
CREATE PROCEDURE sp_update_art(cod_art INT, nome_art VARCHAR(255), nascimento DATE, id_t_art INT)
	BEGIN
		DECLARE verifica INT;
		SELECT COUNT(*) INTO verifica FROM tb_tipo_artista where id = id_t_art;
        IF nome_art IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nome null';
        ELSEIF nome_art NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nome com menos de três letras';
        ELSEIF nome_art = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nome vazio';
        ELSEIF nascimento > curdate() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data invalida';
        ELSEIF verifica = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'id tipo_artista não encontrado';
        ELSE 
			UPDATE tb_artista SET nome = fn_acento(trim(nome_art)), dt_nascimento = nascimento, id_tipo_artista = id_t_art
            WHERE id = cod_art;
		END IF;
    END $$
DELIMITER ;

SELECT * FROM TB_ARTISTA;

CALL sp_update_art(1,'igo', '2023-05-05', 10);
#	 
#
#---------------tb_disco
DELIMITER $$
CREATE PROCEDURE sp_update_dis (cod_disco INT, titulo_dis VARCHAR(255), duracao_dis TIME, lancamento YEAR, cod_art INT, cod_gra INT, cod_gen INT)
	BEGIN
			DECLARE verifica_art INT;
			DECLARE verifica_gra INT;
			DECLARE verifica_gen INT;
			SELECT COUNT(*) INTO verifica_art FROM tb_artista WHERE id = cod_art;
			SELECT COUNT(*) INTO verifica_gra FROM tb_gravadora WHERE id = cod_gra;
			SELECT COUNT(*) INTO verifica_gen FROM tb_genero WHERE id = cod_gen;
		CASE
			WHEN titulo_dis IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome NULL';
            WHEN titulo_dis = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nome vazio';
			WHEN titulo_dis NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome com menos de três letras';
            WHEN verifica_art = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID artista não econtrado';
			WHEN verifica_gra = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID gravadora não econtrado';
			WHEN verifica_gen = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID genero não econtrado';
            WHEN duracao_dis < '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'duracao negativa';
            WHEN lancamento > curdate() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ANO invalido';
            ELSE
				UPDATE tb_disco SET 
                titulo = titulo_dis
                , duracao = duracao_dis
                , ano_lancamento = lancamento
                , id_artista = cod_art
                , id_gravadora = cod_gra
                , id_genero = cod_gen
                WHERE id = cod_disco;
		END CASE;
	END $$
DELIMITER ;

CALL sp_update_dis(1, 'oi', '01:00:00', 2023, 10, 6, 61 );
#
#
#---------------tb_genero
DELIMITER $$
CREATE PROCEDURE sp_up_gen(cod_gen INT, nome_gen VARCHAR(255))
	BEGIN
		CASE
			WHEN nome_gen IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome NULL';
            WHEN nome_gen = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nome vazio';
			WHEN nome_gen NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome com menos de três letras';
            ELSE
				UPDATE tb_genero SET nome = fn_acento(nome_gen)
				where id = cod_gen;
		END CASE;
    END $$
DELIMITER ;
CALL sp_up_gen(1, 'OI');

#---------------tb_gravadora
DELIMITER $$
CREATE PROCEDURE sp_up_gra(cod_gra INT, nome_gra VARCHAR(255))
	BEGIN
		CASE
			WHEN nome_gra IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome NULL';
            WHEN nome_gra = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nome vazio';
			WHEN nome_gra NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome com menos de três letras';
            ELSE
				UPDATE tb_gravadora SET nome = fn_acento(trim(nome_gra))
				where id = cod_gra;
		END CASE;
    END $$
DELIMITER ;

#---------------tb_musica
DELIMITER $$
CREATE PROCEDURE sp_up_gra(cod_mus INT, nome_mus VARCHAR(255), duracao_mus TIME, cod_disco INT)
	BEGIN
		DECLARE verifica INT;
        SELECT COUNT(*) INTO verifica FROM tb_disco WHERE id = cod_disco;
        
        CASE
			WHEN nome_mus IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido inserir nome null';
            when nome_mus = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido nome com valor vazio';
            when nome_mus NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitido inserir nome com menos de três letras';
            WHEN duracao_mus < '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitidos tempo negativo';
            WHEN verifica = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id não existe na tabela disco';
            ELSE
				UPDATE tb_musica SET nome = nome_mus, duracao = duracao_mus, id_disco = cod_disco
                WHERE id = cod_mus;
			END CASE;
	END $$
DELIMITER ;

#---------------tb_tipo_artista
DELIMITER $$
CREATE PROCEDURE sp_up_tipo_art(cod_t INT, nome_t VARCHAR(255))
	BEGIN
		CASE
			WHEN nome_t IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome NULL';
            WHEN nome_t = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nome vazio';
			WHEN nome_t NOT LIKE '%___%' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome com menos de três letras';
            ELSE
				UPDATE tb_tipo_artista SET nome = fn_acento(trim(nome_t))
				where id = cod_t;
		END CASE;
    END $$
DELIMITER ;



