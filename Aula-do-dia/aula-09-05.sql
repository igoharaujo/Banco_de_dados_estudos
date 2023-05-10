select fn_soma(2,3);
#1 --------------------
create function fn_mutplicacao(n1 int,  n2 int)
returns int
	READS SQL DATA
    RETURN n1 * n2;
#1 --------------------

#2--------------------

CREATE FUNCTION fn_divisao(n1 FLOAT, n2 FLOAT )
	RETURNS FLOAT
READS SQL DATA
	RETURN n1 / n2;
    
#2--------------------
select fn_mutplicacao(5,5);

select fn_divisao(10,2);

#3--------------------

DELIMITER $$
CREATE FUNCTION fn_mult2(n1 INT, n2 INT)
RETURNS INT
DETERMINISTIC

BEGIN
	DECLARE mult INT;
    SET mult = n1 * n2;
RETURN mult;
END $$
DELIMITER ;

#3--------------------

select fn_mult2(2, 2);

#4--------------------
DELIMITER $$
CREATE FUNCTION fn_divi2(n1 FLOAT, n2 FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE divi FLOAT;
    SET divi = n1 / n2;
    RETURN divi;

END $$
DELIMITER ; 

#4--------------------

select fn_divi2(10, 2);

#5--------------------

DELIMITER $$ 
CREATE FUNCTION IF NOT EXISTS fn_info_artista(id_artista INT)
RETURNS VARCHAR(255) -- esse varchar indica que o a saida sera uma Strig por que a saida sera uma string
READS SQL DATA
BEGIN
	DECLARE registro VARCHAR(255); #Esse varchar demostra que a vaviavel é uma string por que a função concat é um string
		SET registro = (SELECT concat('codigo artista: ', id ,' - nome ', nome ,' - Nascimento ', date_format(dt_nascimento, '%d/%m/%Y')) FROM tb_artista
        where id = id_artista and dt_nascimento != '0000-00-00');

RETURN registro;
END $$
DELIMITER ;

#5--------------------

select fn_info_artista(1);

show create function fn_info_artista;

select 'coração';

select replace(replace('coração', 'ç', 'c'), 'ã', 'a'); #cololamos o nome no caso: coração, em seguida o que quremos altera no caso o: ç e em seguida a alteração, no caso: c


#6--------------------

DELIMITER $$
CREATE FUNCTION fn_maiuscula(texto varchar(255))
RETURNS VARCHAR(255)
DETERMINISTIC
	BEGIN
		DECLARE resultado VARCHAR(255);
        
        SET resultado = REPLACE(texto, 'a', 'A');
        SET resultado = REPLACE(texto, 'b', 'B');
         SET resultado = REPLACE(texto, 'c', 'C');
          SET resultado = REPLACE(texto, 'd', 'D');
           SET resultado = REPLACE(texto, 'e', 'E');
    
    RETURN resultado;
    END $$
DELIMITER ;

#6--------------------
select fn_maiuscula('abcd');














