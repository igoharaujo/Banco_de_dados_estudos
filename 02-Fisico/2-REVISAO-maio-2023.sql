#-------------------------------------------------FUNÇÕES---------------------------------------------------#
#-------------------------------------------------------------------------
-- OBS: FUNÇÃO QUE CAPTURA O USUARIO E O HOST DE QUEM ESTA LOGADO NO MOMENTO
SELECT current_user();
#-------------------------------------------------------------------------
use db_ponto;
#FUÇÕES DE DATA

-- 1- NOW(): Rertona exatamnete a hora e a data atual
SELECT NOW();

-- 2- Select curdate(): retorna apenas a data, a data atual
SELECT CURDATE();

-- 3- curtime() Retorna apenas a hora
SELECT curtime();

-- 4- current_timestamp(): faz a mesma coisa que o now, porem ele considera o fuso horaio
SELECT CURRENT_TIMESTAMP();

-- 5- year: colocamos uma data e ele vai extrair apenas o ano
SELECT year('1993-09-09');

-- 6- month: diferente do year vai puxar o mes
SELECT month('1993-09-09');      -- vai mostra em numero
SELECT monthname('1993-09-09');  -- vai mostrar o nome

-- 7- WEEK: Mostra as semanas
SELECT WEEK('1993-09-09'); #
SELECT WEEKDAY('1993-09-09'); #mostra o numero do dia da semana
SELECT WEEKOFYEAR('2023-05-08'); #mostra o numero da semana no ano

-- 8- comando day
SELECT DAY('1993-09-09'); #mostra o dia do mes
SELECT DAYNAME('1993-09-09'); #mostra o mes

-- 9- Diferença de horas
SELECT TIMEDIFF('18:17:00', '08:15:00'); #timediff mostra a diferença entre uma hora e outra
SELECT TIMEDIFF('08:14:53', curtime()); #curtime retorna a hora atual

-- 10- 
SELECT DATEDIFF( CURDATE(),'2001-08-21')/365;

-- 11- Vai calcular a diferença e entre duas datas diferentes
SELECT TIMESTAMPDIFF(month, '1993-09-09',CURDATE()); #YEAR: colocamos year pq queremos ver o resultado em anos, '1993-09-09': colocamos as data, CURDATE(): Vai pegar a data atual
-- aqui o a menor data precisar ser primeiro, ou a data mais antiga

use db_discoteca;
#Mostre o nome, a data de nascimento e a idade dos artista
SELECT nome, date_format(dt_nascimento, '%d-%m-%Y'), TIMESTAMPDIFF(YEAR, dt_nascimento, curdate()) as idade from tb_artista;
#where dt_nascimento != '0000-00-00' order by idade;
# ou
SELECT nome, dt_nascimento, datediff(curdate(), dt_nascimento)/365 as idade from tb_artista
where dt_nascimento <> '0000-00-00' order by idade;

-- 12- vamos aprender a mostrar a data pela padrão brasileiro
SELECT DATE_FORMAT('1993-09-10', '%d-%m-%Y'); # %d: day, %m: month, %Y: year




-- --------------------------------------------- VIEW --------------------------------------------------------------

#É uma tabela virtual, servi para visualizar os dados da tabela origina, para protege a tabela original
use db_ponto;
CREATE VIEW vw_ponto_eletronico as # eu crio o comando view dou um nome para ele e uso o comando AS para ligar com o select
SELECT funcionario.id as id, funcionario.nome as funcionario, horario as horario
from tb_funcionario as funcionario INNER JOIN tb_horario as horario
ON funcionario.id = horario.id_funcionario;

select * from vw_ponto_eletronico;

-- ---------------------------------------- CRIANDO FUNÇÕES ------------------------------------------------------

#CRIANDO FUNÇÃO, a função sempre retorna algo, e sempre em uma celula ---------------------------------------
use db_discoteca2;
CREATE FUNCTION fn_soma(numero1 INT, numero2 INT) # Para criar um função colocamos o nome da função e colocamos os parametros
												  #nesse caso a gente coloca o nome do parametro e de que tipo ela é, nesse caso é INT
                                                  
RETURNS INT  # Aqui falamos o que a função ira retornar, nesse caso ele vai retornar um numero INT, OBS: returns com S serve para mostrar o tipo que vai ser mostrado
			# return sem S mostra o dado que sera mostrado na saida
            
-- READS SQL DATA # quando o resultado muda de acordo com os paremetros, exemplo hora
-- DETERMINISTIC  # quando o resultado nao muda de acordo com os parametros, ou seja eu coloco (4,5) o resultado 4*5 sempre sera o mesmo, pi

READS SQL DATA
	RETURN numero1 + numero2;
#----------------------------------------------------- DELIMITER, BEGIN, DECLARE  ----------------------------------------------------------

#----------------------------------------------------------------------------------
#Troca o ponto e virgula (;) parao cifrão ($$)									-- |
DELIMITER $$ 																	-- |
CREATE FUNCTION fn_soma2 (n1 INT, n2 INT)										-- |
RETURNS INT																		-- |
DETERMINISTIC 																	-- |
	BEGIN -- (COMEÇO) # usado para começar um sequicia de codigo				-- |
		DECLARE soma INT;  -- DECLARE É COMO SE DECLARA VARIAVEIS NO SQL		-- |
        SET soma = n1 + n2;														-- |
																				-- |
RETURN soma;																	-- |
																				-- |
    END $$ -- (FIM)																-- |
    DELIMITER ;																	-- |
																				-- |
select fn_soma2(2, 7);															-- |
#-----------------------------------------------------------------------------------

#criando uma função para fazer a multiplicação
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


#----------------------------------------------------- CONCAT ----------------------------------------------------------

#CONCAT é a junçõa de varios valores
use db_discoteca;

SELECT nome,
	   dt_nascimento,
       CONCAT(nome,' - ', date_format(dt_nascimento, '%d/%m/%Y')) as 'nome e data' # Com o comando concat eu mostro todos os dados em uma unica tabela
FROM tb_artista;																	# ' - ' eu fuz isso para ficar mais legivel, ele vai colar isso entre os dados
#where dt_nascimento != '0000-00-00';

#---------------------------

# para criar uma fução que mostrar dados de varia tabelas eu preciso usar o CONCAT ja que a função sempre retornara apenas uma celula
DELIMITER $$ 
CREATE FUNCTION fn_info_artista(id_artista INT)
RETURNS VARCHAR(255)
	READS SQL DATA
		BEGIN
			DECLARE registro VARCHAR(255);
			SET registro = (SELECT concat('codigo artista: ', id ,' - nome ', nome ,' - Nascimento ', date_format(dt_nascimento, '%d/%m/%Y')) FROM tb_artista 
            where id = id_artista);

		RETURN registro;
	END $$
DELIMITER ;

#-------------------------------

select fn_info_artista(10);

#----------------------------------------------------- REPLACE ---------------------------------------------------------

select replace(replace('coração', 'ç', 'c'), 'ã', 'a'); #cololamos o nome no caso: coração, em seguida o que quremos altera no caso o: ç e em seguida a alteração, no caso: c

#------------------------------
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

#-------------------------------

select fn_maiuscula('abcd');


















