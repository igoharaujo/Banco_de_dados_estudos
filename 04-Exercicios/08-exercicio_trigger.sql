/*Modifique os procedimentos de insert e update, todos os dados devem ser validados, antes das inserções e atualizações, por exemplo:

Crie um procedimento / function para validações de strings.
Altere todos os procedimentos de insert,, e update do discoteca para que usem essa nova procedure/functionpara validar seus campos strings.

Todas as triggers a seguir devem utilizar do procedimento anterior para validar strings.

Crie uma trigger no db_discoteca2 que a cada musica inserida para um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.

Crie uma trigger no db_discoteca2 que a cada atualização do tempo de musica de um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.

Crie uma trigger no db_discoteca2 que a cada musica deletada de um disco, o mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas restantes desse disco.*/


use db_discoteca2;

#-------------------------------------------- FUNÇOES QUE valida as strings
DELIMITER $$
CREATE FUNCTION sp_valida_string(valor VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
			IF ISNULL(valor) = 1 then SET valor = false;
        ELSE
            IF trim(valor) NOT LIKE '%___%' THEN set valor = false;
            ELSEIF valor = '' THEN  set valor = false;
            
	END IF;
    END IF;

RETURN fn_acento(trim(LOWER(valor)));
    
END $$
DELIMITER ;

SELECT sp_valida_string(null);
drop function sp_valida_string;
SELECT SP_VALIDA_STRING('');

drop function sp_valida_string;
#------------- correção
DELIMITER $$
CREATE FUNCTION sp_valida_string(texto VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
	BEGIN
		DECLARE validado BOOLEAN;
        IF length(trim(fn_acento(texto))) <= 2 THEN 
			SET validado = false;
		ELSEIF texto IS NULL OR texto = '' THEN SET valido = FALSE;
        ELSE SET validado = TRUE;
	RETURN validado;
    end if;
    END $$
    DELIMITER ;
#------------------------------------------------------------------insert---------------------------------------------------------------------------------------

#-------------------- tb_artista
DELIMITER $$
CREATE PROCEDURE sp_insert_art(nome_art VARCHAR(255), nascimento_art DATE, fk_id_tipo_art INT)
	BEGIN
    DECLARE id_existe INT;
    SELECT COUNT(*) INTO id_existe FROM tb_tipo_artista WHERE id = fk_id_tipo_art;
    
    IF id_existe = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id não existe na tabela tipo artista';
    ELSE
		INSERT INTO tb_artista
			(nome, dt_nascimento, id_tipo_artista)
		VALUES
			(sp_valida_string(nome_art), nascimento_art, fk_id_tipo_art);
            END IF;
	END $$
DELIMITER ;
DROP PROCEDURE SP_INSERT_ART;
call sp_insert_art('i', '2000-05-05', 5);

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
        else
			INSERT INTO tb_disco
				(titulo, duracao, ano_lancamento, id_artista, id_gravadora, id_genero)
			VALUES
				(sp_valida_string(titulo_dis), duracao_dis, lancamento, cod_art, cod_gra, cod_gen);
		END IF;
	
    END $$
DELIMITER ;
drop procedure sp_insert_dis;
CALL sp_insert_dis('m', '01:00:00', 2023, 12, 14, 60);

#
#
#-------------------- tb_genero
DELIMITER $$
CREATE PROCEDURE sp_insert_gen(nome_gen VARCHAR(255))
	BEGIN
            INSERT INTO tb_genero
				(nome)
			VALUES 
				(sp_valida_string(nome_gen));    
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
            INSERT INTO tb_gravadora
				(nome)
			VALUES
				(sp_valida_string(nome_gra));
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
            WHEN duracao_mus < '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitidos tempo negativo';
            WHEN verifica = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id não existe na tabela disco';
            ELSE
				INSERT INTO tb_musica
					(nome, duracao, id_disco)
				VALUES
					(sp_valida_string(nome_mus), duracao_mus, cod_disco);
			END CASE;
	END $$
DELIMITER ;

CALL sp_insert_mus('mamamia', '01:00:00', 12);

#
#
#----------------------tb_tipo_artista
DELIMITER $$
CREATE PROCEDURE sp_insert_tipo(nome_t VARCHAR(255))
	BEGIN
            INSERT INTO tb_tipo_artista
				(nome)
			VALUES
				(sp_valida_string(nome));
    END $$
DELIMITER ;
    

#--------------------------------------------------------------------- UPDATE --------------------------------------------------------------------------

#---------------tb_artista
DELIMITER $$
CREATE PROCEDURE sp_update_art(cod_art INT, nome_art VARCHAR(255), nascimento DATE, id_t_art INT)
	BEGIN
		DECLARE verifica INT;
		SELECT COUNT(*) INTO verifica FROM tb_tipo_artista where id = id_t_art;
        
        IF nascimento > curdate() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data invalida';
        ELSEIF verifica = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'id tipo_artista não encontrado';
        elseif sp_valida_string(nome_art) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nome informado é invalidado';
        ELSE 
			UPDATE tb_artista SET nome = (nome_art), dt_nascimento = nascimento, id_tipo_artista = id_t_art
            WHERE id = cod_art;
		END IF;
    END $$
DELIMITER ;

SELECT * FROM TB_ARTISTA where id = 1;
drop procedure sp_update_art;
CALL sp_update_art(1,'igor', '2023-05-05', 1);
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
            WHEN verifica_art = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID artista não econtrado';
			WHEN verifica_gra = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID gravadora não econtrado';
			WHEN verifica_gen = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ID genero não econtrado';
            WHEN duracao_dis < '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'duracao negativa';
            WHEN lancamento > curdate() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ANO invalido';
            ELSE
				UPDATE tb_disco SET 
                titulo = sp_valida_string(titulo_dis)
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
				UPDATE tb_genero SET nome = sp_valida_string(nome_gen)
				where id = cod_gen;
		
    END $$
DELIMITER ;
CALL sp_up_gen(1, 'OI');

#---------------tb_gravadora
DELIMITER $$
CREATE PROCEDURE sp_up_gra(cod_gra INT, nome_gra VARCHAR(255))
	BEGIN
				UPDATE tb_gravadora SET nome = sp_valida_string(nome_gra)
				where id = cod_gra;
		
    END $$
DELIMITER ;

#---------------tb_musica
DELIMITER $$
CREATE PROCEDURE sp_up_gra(cod_mus INT, nome_mus VARCHAR(255), duracao_mus TIME, cod_disco INT)
	BEGIN
		DECLARE verifica INT;
        SELECT COUNT(*) INTO verifica FROM tb_disco WHERE id = cod_disco;
        
        CASE
            WHEN duracao_mus < '00:00:00' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é permitidos tempo negativo';
            WHEN verifica = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id não existe na tabela disco';
            ELSE
				UPDATE tb_musica SET nome = sp_valida_string(nome_mus), duracao = duracao_mus, id_disco = cod_disco
                WHERE id = cod_mus;
			END CASE;
	END $$
DELIMITER ;

#---------------tb_tipo_artista
DELIMITER $$
CREATE PROCEDURE sp_up_tipo_art(cod_t INT, nome_t VARCHAR(255))
	BEGIN
				UPDATE tb_tipo_artista SET nome = sp_valida_string(nome_t)
				where id = cod_t;
    END $$
DELIMITER ;


#  Crie uma trigger no db_discoteca2 que a cada musica inserida para um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.


DELIMITER $$
CREATE TRIGGER tr_inserindo_musica
AFTER INSERT
ON tb_musica
FOR EACH ROW
BEGIN
    DECLARE verifica TIME;
    SELECT duracao INTO verifica FROM tb_disco WHERE new.id = id_disco;
    UPDATE tb_disco SET duracao = verifica + NEW.duracao WHERE new.id = id_disco;
END $$
DELIMITER ;


call sp_insert_mus('igolindos','00:03:00',1);

select id, duracao from tb_disco;

#Crie uma trigger no db_discoteca2 que a cada atualização do tempo de musica de um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.

DELIMITER $$
CREATE TRIGGER tr_atualiza_duracao_disco
BEFORE UPDATE
ON tb_musica
FOR EACH ROW
BEGIN
	DECLARE verifica INT;
    SELECT duracao INTO verifica FROM tb_disco


END $$
DELIMITER ;












