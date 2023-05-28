/*Modifique os procedimentos de insert e update, todos os dados devem ser validados, antes das inserções e atualizações, por exemplo:

Crie um procedimento / function para validações de strings.
Altere todos os procedimentos de insert,, e update do discoteca para que usem essa nova procedure/functionpara validar seus campos strings.

Todas as triggers a seguir devem utilizar do procedimento anterior para validar strings.

Crie uma trigger no db_discoteca2 que a cada musica inserida para um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.

Crie uma trigger no db_discoteca2 que a cada atualização do tempo de musica de um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.

Crie uma trigger no db_discoteca2 que a cada musica deletada de um disco, o mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas restantes desse disco.*/


use db_discoteca;

#-------------------------------------------- FUNÇOES QUE valida as strings
/*DELIMITER $$
CREATE FUNCTION fn_valida_string(valor VARCHAR(255))
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
DELIMITER ;*/

DELIMITER //
CREATE FUNCTION fn_valida2_string(valor VARCHAR(255))
RETURNS BOOLEAN
READS SQL DATA
BEGIN 
	DECLARE parametro BOOLEAN;
	IF
		(LENGTH(TRIM(fn_acento(valor)))) <= 2 THEN 
		SET parametro = FALSE;
	ELSEIF
		valor IS NULL OR valor = ' ' THEN 
        SET parametro = FALSE;
	ELSE
		SET parametro = TRUE;
    END IF;
    RETURN parametro;
END//
DELIMITER ;

#teste----------------------
SELECT fn_valida2_string(null);
drop function fn_valida2_string;
SELECT fn_valida2_string('');
#---------------------------


#------------------------------------------------------------------insert---------------------------------------------------------------------------------------

#-------------------- tb_artista - validada
DELIMITER $$
CREATE PROCEDURE sp_insert_art(nome_art VARCHAR(255), nascimento_art DATE, fk_id_tipo_art INT)
	BEGIN
		DECLARE id_existe INT;
		SELECT COUNT(*) INTO id_existe FROM tb_tipo_artista WHERE id = fk_id_tipo_art;
		IF fn_valida2_string(nome_art) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome informado é invalido';
		ELSEIF id_existe = FALSE THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O id não existe na tabela tipo artista';
		ELSE
			INSERT INTO tb_artista
				(nome, dt_nascimento, id_tipo_artista)
			VALUES
				(fn_acento(trim(nome_art)), nascimento_art, fk_id_tipo_art);
		END IF;
	END $$
DELIMITER ;
#teste-------------------
call sp_insert_art('MATUEç', '2000-05-05', 5);
select * from tb_artista where nome = 'matuec';
#-----------------------
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
		ELSEIF fn_valida2_string(titulo_dis) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Titulo invalido';
        ELSE
			INSERT INTO tb_disco
				(titulo, duracao, ano_lancamento, id_artista, id_gravadora, id_genero)
			VALUES
				(fn_acento(trim(titulo_dis)), duracao_dis, lancamento, cod_art, cod_gra, cod_gen);
		END IF;
    END $$
DELIMITER ;

#Teste------------------
CALL sp_insert_dis('camila', '01:00:00', 2023, 12, 14, 60);
#----------------------

#
#
#-------------------- tb_genero
DELIMITER $$
CREATE PROCEDURE sp_insert_gen(nome_gen VARCHAR(255))
	BEGIN
        CASE 
			WHEN fn_valida2_string(nome_gen) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
            ELSE
            INSERT INTO tb_genero
				(nome)
			VALUES 
				(fn_acento(trim(nome_gen)));
		END CASE;
    
    END $$
DELIMITER ;

#Teste--------------------
call sp_insert_gen('ação');
select * from tb_genero;
#-------------------------

#
#
#-------------------- tb_gravadora
DELIMITER $$
CREATE FUNCTION fn_insert_gra(nome_gra VARCHAR(255)) 
RETURNS VARCHAR(255)
DETERMINISTIC
	BEGIN
		CASE
			WHEN fn_valida2_string(nome_gra) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
            ELSE
            INSERT INTO tb_gravadora
				(nome)
			VALUES
				(fn_acento(trim(nome_gra)));
        END CASE;
    
    RETURN nome_gra;
    END $$
DELIMITER ;

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
            WHEN fn_valida2_string(nome_mus) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
            ELSE
				INSERT INTO tb_musica
					(nome, duracao, id_disco)
				VALUES
					(fn_acento(trim(nome_mus)), duracao_mus, cod_disco);
			END CASE;
	END $$
DELIMITER ;
#Teste---------------------
CALL sp_insert_mus('musica', '01:00:00', 12);
#---------------------------

#
#
#
DELIMITER $$
CREATE PROCEDURE sp_insert_tipo(nome_t VARCHAR(255))
	BEGIN
		CASE
			WHEN fn_valida2_string(nome_t) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
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
        IF fn_valida2_string(nome_mus) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
        ELSEIF nascimento > curdate() THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data invalida';
        ELSEIF verifica = false THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'id tipo_artista não encontrado';
        ELSE 
			UPDATE tb_artista SET nome = fn_acento(trim(nome_art)), dt_nascimento = nascimento, id_tipo_artista = id_t_art
            WHERE id = cod_art;
		END IF;
    END $$
DELIMITER ;

#Teste--------------------------
SELECT * FROM TB_ARTISTA;
CALL sp_update_art(1,'igo', '2023-05-05', 10);
#-------------------------------
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
			WHEN fn_valida2_string(titulo_dis) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
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

#Teste-----------------------
CALL sp_update_dis(1, 'oi', '01:00:00', 2023, 10, 6, 61 );
#----------------------------
#
#
#---------------tb_genero
DELIMITER $$
CREATE PROCEDURE sp_up_gen(cod_gen INT, nome_gen VARCHAR(255))
	BEGIN
		CASE
			WHEN fn_valida2_string(nome_gen) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
            ELSE
				UPDATE tb_genero SET nome = fn_acento(nome_gen)
				where id = cod_gen;
		END CASE;
    END $$
DELIMITER ;
#
#
#---------------tb_gravadora
DELIMITER $$
CREATE PROCEDURE sp_up_gra(cod_gra INT, nome_gra VARCHAR(255))
	BEGIN
		CASE
			WHEN fn_valida2_string(nome_gra) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
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
			WHEN fn_valida2_string(nome_mus) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
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
			WHEN fn_valida2_string(nome_t) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome invalido';
            ELSE
				UPDATE tb_tipo_artista SET nome = fn_acento(trim(nome_t))
				where id = cod_t;
		END CASE;
    END $$
DELIMITER ;


/*Crie uma trigger no db_discoteca2 que a cada musica inserida para um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.

Crie uma trigger no db_discoteca2 que a cada atualização do tempo de musica de um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.

Crie uma trigger no db_discoteca2 que a cada musica deletada de um disco, o mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas restantes desse disco.*/

#----------------------------

#Crie uma trigger no db_discoteca2 que a cada musica inserida para um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.
DELIMITER $$
CREATE TRIGGER tr_insert_disco
AFTER INSERT
ON tb_musica
FOR EACH ROW
	BEGIN
        UPDATE tb_disco SET duracao = (duracao + new.duracao) WHERE id = new.id_disco;
    END $$
DELIMITER ;

#Teste-----------------------
call sp_insert_mus('igolino', '00:10:00', 1);
select * from tb_disco;
#--------------------------
#
#
#Crie uma trigger no db_discoteca2 que a cada atualização do tempo de musica de um disco, esse mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas desse disco.

DELIMITER $$
CREATE TRIGGER tr_update_disco
AFTER UPDATE
ON tb_musica
FOR EACH ROW
	BEGIN
			UPDATE tb_disco SET duracao = (OLD.duracao + NEW.duracao)
            WHERE id = new.id_disco;
		
    END $$
DELIMITER ;

drop trigger tr_update_disco;

select * from tb_musica;

update tb_musica set duracao = '00:01:00' where id = 22;

select distinct nome, id, duracao from tb_musica where id_disco = 32 ;


#Crie uma trigger no db_discoteca2 que a cada musica deletada de um disco, o mesmo disco tenha em sua respectiva tabela uma atualização do tempo total, sendo a soma total do tempo das musicas restantes desse disco.
DELIMITER $$
CREATE TRIGGER tr_delete_disco
AFTER DELETE
ON tb_musica
FOR EACH ROW
	BEGIN
		UPDATE tb_disco SET duracao = (duracao - old.duracao) where id = old.id_disco;
    END $$
DELIMITER ;

select * from tb_musica;

select * from tb_disco where id = 88;
delete from tb_musica where id = 269; 