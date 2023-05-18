/*Modifique os procedimentos de insert e update, todos os dados devem ser validados, antes das inserções e atualizações, por exemplo:

- nomes devem ser inseridos/atualizados sem acentos e não podemos aceitar valores vazios ou nulos
- datas não podem ser futuras
- tempos não podem ser negativos
- e as fk's devem ser conferidas se existem antes de inseridas

Para cada erro deve ser gerado uma mensagem personalizada o identificando.*/



#------------------------------------------------------------------insert---------------------------------------------------------------------------------------

#-------------------- tb_artista
DELIMITER $$
CREATE PROCEDURE sp_insert_art(nome_art VARCHAR(255), nascimento_art DATE, fk_id_tipo_art INT)
	BEGIN
		INSERT INTO tb_artista
			(nome, dt_nascimento, id_tipo_artista)
		VALUES
			if (nome_art == null)(fn_acento(nome_art), nascimento_art, fk_id_tipo_art);
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

call sp_insert_dis('Lúcícãno fítnês', '03:00:00', 1993, 1, 10, 14);

select * from tb_disco 
where id = (select max(id) from tb_disco);

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
DELIMITER $$
CREATE PROCEDURE sp_up_gen(nome_gen VARCHAR(255), cod_gen INT)
	BEGIN
		UPDATE tb_genero SET nome = fn_acento(nome_gen)
        where id = cod_gen;
    
    END $$
DELIMITER ;
CALL sp_up_gen();

#---------------tb_gravadora
DELIMITER $$
CREATE PROCEDURE sp_up_gra(nome_gra varchar(255), cod_gra INT)
	BEGIN
		UPDATE tb_gravadora SET nome = fn_acento(nome_gra)
        where id = cod_gra;
    END $$
DELIMITER ;

#---------------tb_musica
DELIMITER $$
CREATE PROCEDURE sp_up_gra(nome_mus VARCHAR(255), duracao TIME, cod_mus INT)
	BEGIN
		UPDATE tb_musica SET nome = fn_acento(nome_mus), duracao = duracao_mus
        where id = cod_mus;
    END $$
DELIMITER ;

#---------------tb_tipo_artista
DELIMITER $$
CREATE PROCEDURE sp_up_tipo_art(nome_tipo_art varchar(255), cod_tipo_art INT)
	BEGIN
		UPDATE tb_gravadora SET nome = fn_acento(nome_tipo_art)
        where id = cod_tipo_art;
    END $$
DELIMITER ;


#--------------------------------------------------------------------- DELETE --------------------------------------------------------------------------

#---------------tb_artista
DELIMITER $$
CREATE PROCEDURE sp_del_art(cod_art INT)
BEGIN
	DELETE FROM tb_artista
    where id = cod_art;
    
END $$
DELIMITER ;

call sp_del_art(40);
SELECT MAX(ID) FROM tb_artista;

#---------------tb_disco
DELIMITER $$
CREATE PROCEDURE sp_del_dis(cod_dis INT)
BEGIN
	DELETE FROM tb_disco
    where id = cod_dis;
    
END $$
DELIMITER ;

#---------------tb_genero
DELIMITER $$
CREATE PROCEDURE sp_del_gen(cod_gen INT)
BEGIN
	IF EXISTS (SELECT id FROM tb_genero WHERE id = cod_gen) THEN -- THEN: comparacao, usamos o than para fazer essa ligacao, ex: se existe faça: delete...
		DELETE FROM tb_genero where id = cod_gen;
    else 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Codigo de genero invalido' ; -- eu uso esse codigo para personar, eu preciso usar o cod: '45000' para funcionar
    end if;

END $$
DELIMITER ;
