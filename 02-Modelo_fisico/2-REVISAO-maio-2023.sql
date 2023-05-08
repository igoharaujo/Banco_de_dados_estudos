#--------------FUNÇÕES----------------#
#-------------------------------------------------------------------------
-- OBS: FUNÇÃO QUE CAPTURA O USUARIO E O HOST DE QUEM ESTA LOGADO NO MOMENTO
SELECT current_user();
#-------------------------------------------------------------------------

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
SELECT TIMEDIFF('12:00:00', '08:15:00'); #timediff mostra a diferença entre uma hora e outra
SELECT TIMEDIFF('08:14:53', curtime()); #curtime retorna a hora atual

-- 10- 
SELECT DATEDIFF( CURDATE(),'2001-08-21')/365;

-- 11- Vai calcular a diferença e entre duas datas diferentes
SELECT TIMESTAMPDIFF(month, '1993-09-09',CURDATE()); #YEAR: colocamos year pq queremos ver o resultado em anos, '1993-09-09': colocamos as data, CURDATE(): Vai pegar a data atual
-- aqui o a menor data precisar ser primeiro, ou a data mais antiga
#Mostre o nome, a data de nascimento e a idade dos artista
SELECT nome, dt_nascimento, TIMESTAMPDIFF(YEAR, dt_nascimento, curdate()) as idade from tb_artista 
where dt_nascimento != '0000-00-00' order by idade;
# ou
SELECT nome, dt_nascimento, datediff(curdate(), dt_nascimento)/365 as idade from tb_artista
where dt_nascimento <> '0000-00-00' order by idade;

-- 12- vamos aprender a mostrar a data pela padrão brasileiro
SELECT DATE_FORMAT('1993-09-10', '%d-%m-%Y'); # %d: day, %month, %Year


-- ---------- VIEW -----------------
#É uma tabela virtual, servi para visualizar os dados da tabela origina, para protege a tabela original

CREATE VIEW vw_ponto_eletronico as # eu crio o comando view dou um nome para ele e uso o comando AS para ligar com o select
SELECT funcionario.id as id, funcionario.nome as funcionario, horario as horario
from tb_funcionario as funcionario INNER JOIN tb_horario as horario
ON funcionario.id = horario.id_funcionario;


select * from vw_ponto_eletronico;







-- ---------- EXERCICIO -----------------













