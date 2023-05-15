use db_discoteca;
DELIMITER $$
CREATE FUNCTION fn_acento(texto VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	
    SET texto = REPLACE(texto, 'á', 'a');
    SET texto = REPLACE(texto, 'à', 'a');
    SET texto = REPLACE(texto, 'â', 'a');
    SET texto = REPLACE(texto, 'ã', 'a');
    SET texto = REPLACE(texto, 'ä', 'a');
    SET texto = REPLACE(texto, 'Á', 'A');
    SET texto = REPLACE(texto, 'À', 'A');
    SET texto = REPLACE(texto, 'Â', 'A');
    SET texto = REPLACE(texto, 'Ã', 'A');
    SET texto = REPLACE(texto, 'Ä', 'A');
    SET texto = REPLACE(texto, 'é', 'e');
    SET texto = REPLACE(texto, 'è', 'e');
    SET texto = REPLACE(texto, 'ê', 'e');
    SET texto = REPLACE(texto, 'ë', 'e');
    SET texto = REPLACE(texto, 'É', 'E');
    SET texto = REPLACE(texto, 'È', 'E');
    SET texto = REPLACE(texto, 'Ê', 'E');
    SET texto = REPLACE(texto, 'Ë', 'E');
    SET texto = REPLACE(texto, 'í', 'i');
    SET texto = REPLACE(texto, 'ì', 'i');
    SET texto = REPLACE(texto, 'î', 'i');
    SET texto = REPLACE(texto, 'ï', 'i');
    SET texto = REPLACE(texto, 'Í', 'I');
    SET texto = REPLACE(texto, 'Ì', 'I');
    SET texto = REPLACE(texto, 'Î', 'I');
    SET texto = REPLACE(texto, 'Ï', 'I');
    SET texto = REPLACE(texto, 'ó', 'o');
    SET texto = REPLACE(texto, 'ò', 'o');
    SET texto = REPLACE(texto, 'ô', 'o');
    SET texto = REPLACE(texto, 'õ', 'o');
    SET texto = REPLACE(texto, 'ö', 'o');
    SET texto = REPLACE(texto, 'Ó', 'O');
    SET texto = REPLACE(texto, 'Ò', 'O');
    SET texto = REPLACE(texto, 'Ô', 'O');
    SET texto = REPLACE(texto, 'Õ', 'O');
    SET texto = REPLACE(texto, 'Ö', 'O');
    SET texto = REPLACE(texto, 'ú', 'u');
    SET texto = REPLACE(texto, 'ù', 'u');
    SET texto = REPLACE(texto, 'û', 'u');
    SET texto = REPLACE(texto, 'ü', 'u');
    SET texto = REPLACE(texto, 'Ú', 'U');
    SET texto = REPLACE(texto, 'Ù', 'U');
    SET texto = REPLACE(texto, 'Û', 'U');
    SET texto = REPLACE(texto, 'Ü', 'U');
    SET texto = REPLACE(texto, 'ç', 'c');
    SET texto = REPLACE(texto, 'Ç', 'C');
    
RETURN texto;


END $$
DELIMITER ;

select fn_acento('ã');

#--------------------------------------------------------insert--------------------------------------------------------------

#-------------------- tb_artista
DELIMITER $$
CREATE PROCEDURE sp_insert_art(nome_art VARCHAR(255), nascimento_art DATE, fk_id_tipo_art INT)
	BEGIN
		INSERT INTO tb_artista
			(nome, dt_nascimento, id_tipo_artista)
		VALUES
			(fn_acento(nome_art), nascimento_art, fk_id_tipo_art);
	END $$
DELIMITER ;

call sp_insert_art('ãç', '2000-05-05', 1);

SELECT * FROM tb_artista
WHERE nome = 'ac';
#
#
#-------------------- tb_disco
DELIMITER $$
CREATE PROCEDURE sp_insert_dis(titulo_dis VARCHAR(255), duracao_dis time, lancamento_dis year(4), fk_artista int, fk_gravadora int, fk_genero int)
	BEGIN
		INSERT INTO tb_disco
			(titulo, duracao, ano_lancamento, id_artista, id_gravadora, id_genero)
		VALUES
			(fn_acento(titulo_dis), duracao_dis, lancamento_dis, fk_artista, fk_gravadora, fk_genero);

    END $$
DELIMITER ;
#
#
#-------------------- tb_genero
DELiMITER $$
CREATE PROCEDURE sp_insert_gen(nome_gen VARCHAR(255))
	BEGIN
		INSERT INTO tb_genero
			(nome)
		VALUES
			(fn_acento(nome_gen));

	END $$
DELIMITER ;
#
#
#-------------------- tb_gravadora
DELiMITER $$
CREATE PROCEDURE sp_insert_gra(nome_gra VARCHAR(255))
	BEGIN
		INSERT INTO tb_gravadora
			(nome)
		VALUES
			(fn_acento(nome_gra));

	END $$
DELIMITER ;
#
#
#-------------------- tb_musica
DELiMITER $$
CREATE PROCEDURE sp_insert_mus(nome_mus VARCHAR(255), duracao_mus TIME, fk_disco INT)
	BEGIN
		INSERT INTO tb_musica
			(nome, duracao, id_disco)
		VALUES
			(fn_acento(nome_mus), duracao_mus, fk_disco);
	END $$
DELIMITER ;
call sp_insert_mus();

#
#
#-------------------- tb_tipo_artista
DELiMITER $$
CREATE PROCEDURE sp_insert_tipo_art(nome_tipo_art VARCHAR(255))
	BEGIN
		INSERT INTO tb_tipo_artista
			(nome)
		VALUES
			(fn_acento(nome_tipo_art));

	END $$
DELIMITER ;

call sp_insert_art('marãoç','2000-05-05');

#
#
#--------------------------------------------------------------------- UPDATE --------------------------------------------------------------------------

#---------------tb_artista
DELIMITER $$
CREATE PROCEDURE sp_up_art(nome_art VARCHAR(255), nascimento_art date, cod_art INT)
BEGIN
	UPDATE tb_artista SET nome = fn_acento(nome_art), dt_nascimento = nascimento_art
    WHERE id = cod_art;

END $$
DELIMITER ;
#drop procedure sp_up_art;

call sp_up_art('iguinho','2000-10-21', 10);
SELECT * FROM tb_artista
where id = 10;

#---------------tb_disco
DELIMITER $$
CREATE PROCEDURE sp_up_dis(titulo_dis varchar(255), duracao_dis TIME, lancamento_dis YEAR, cod_disco INT)
BEGIN
	UPDATE tb_disco SET titulo = fn_acento(titulo_dis), duracao = duracao_dis, ano_lancamento = lancamento_dis
    where id = cod_disco;
    
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_up_dis2(fk_art int, fk_gra int, fk_gen int, cod_disco int)
BEGIN
	UPDATE tb_disco SET titulo = id_artista = fk_art, id_gravadora = fk_gra, id_genero = fk_gen
    where id = cod_disco;
    
END $$
DELIMITER ;

call sp_up_dis2(41112, 6, 5, 1);

SELECT * FROM tb_disco;

drop procedure sp_up_dis;

#
#
#---------------tb_genero
DELIMILER $$
CREATE PROCEDURE sp_up_gen()
	BEGIN
		
    
    
    
    
    END $$
DELIMITER ;








