/*
1 - Usando seus conhecimentos e o que foi ensinado em aula, efetive os seguintes itens.

Usando o discoteca:

1 - vw_gravadora - deve conter id, nome e total de discos
2 - vw_disco - deve conter todos os dados do disco, porem as fks devem ser substituidas pelo nome do item que a mesma representa.
3 - vw_artista - deve conter id, nome completo, idade, total de discos
4 - vw_musicas - deve conter nome da musica, duração, o disco e o artista.
5 - Crie uma function que ao receber o codigo de um disco nos diga qual o tempo total desse disco Usando a tabela musica.
6 - Crie uma function que ao receber o codigo de um disco nos diga todas as informações desse disco.
 

Usando o db_familia:

1 -  crie uma view que mostre o id e nome do filho, nome do pai e nome da mae, porém somente dos que estão relacionados. Apos criada a view utiliezea em uma function que me premiter visualizar esses dados de um filho expecifico.


2 - Ainda usando o db_familia, crie uma view que mostre o id e nome dos pais, o nome do filho, desejasse visualisar todos os pais, mesmo os que não possuem filhos. crie uma functions que me permita visualizar esses dados pelo nome do pai.

3 - Usando o db_discoteca, crie uma view que me permita visualisar todos os dados do disco, junto ao nome da gravadora e nome do artista.

4 - Ainda usando o discoteca, crie uma function que remova os acentos de qualquer letra, seja ela maiuscula ou minuscula.

5 - Mostre todos o nome de todos os artistas e discos, mesmo os que não possuem relacionamento.

6 - Crie uma função que deixe todos os caracteres de uma string maiusculas.

7 - Crie uma função que deixe todos os caracteres de uma string minusculas.

8 - Crie uma função que ao ser chamada receba o codigo de um pai e me motra seus dados e quais são seus filhos.

*/

-- ---------------------------------------------------------------------------------------------------------------------
#Usando o db_discoteca2:
use db_discoteca2;
-- ---------------------------------------------------------------------------------------------------------------------

-- 1- vw_gravadora - deve conter id, nome e total de discos

CREATE VIEW vw_gravadora as
select gravadora.id as id, gravadora.nome as gravadora, count(disco.id) as 'total disco' 
FROM tb_gravadora as gravadora left join tb_disco as disco
on gravadora.id = disco.id_gravadora
group by disco.id;

#CORRIGIDO: 
CREATE VIEW vw_gravadora2 as
select gravadora.id as id, gravadora.nome as gravadora, count(disco.id_gravadora) as 'qtd de discos por gravadora' 
FROM tb_gravadora as gravadora inner join tb_disco as disco
on gravadora.id = disco.id_gravadora
group by disco.id_gravadora;

select * from vw_gravadora2;

-- 2 - vw_disco - deve conter todos os dados do disco, porem as fks devem ser substituidas pelo nome do item que a mesma representa.
CREATE view vw_disco as
SELECT disco.id,
		disco.titulo,
		disco.duracao,
		disco.ano_lancamento,
        artista.nome as 'nome artista',
        gravadora.nome as 'nome gravadora',
        genero.nome as 'nome genero'
	from tb_disco as disco 
inner join tb_artista as artista
	on artista.id = disco.id_artista
inner join tb_gravadora as gravadora
	on gravadora.id = disco.id_gravadora
inner join tb_genero as genero
	on genero.id = disco.id_genero;

SELECT * FROM vw_disco;

-- 3 - vw_artista - deve conter id, nome completo, idade, total de discos

SELECT artista.id, artista.nome as artista, timestampdiff(year, artista.dt_nascimento, curdate()) as idade, count(disco.id) as 'total disco'
FROM tb_artista as artista inner join tb_disco as disco on artista.id = disco.id_artista
group by disco.id;

#CORRIGIDO
create view vw_artista1 as
SELECT artista.id, artista.nome as artista, timestampdiff(year, artista.dt_nascimento, curdate()) as idade, count(disco.id_artista) as 'total disco'
FROM tb_artista as artista inner join tb_disco as disco on artista.id = disco.id_artista
group by disco.id_artista;


-- 4 - vw_musicas - deve conter nome da musica, duração, o disco e o artista.
CREATE view vw_musica as
SELECT musica.nome as musica, musica.duracao as 'duração musica', disco.titulo as disco, artista.nome as artista
FROM tb_musica as musica INNER JOIN tb_disco as disco
ON disco.id = musica.id_disco
inner join tb_artista as artista
ON artista.id = disco.id_artista;

-- 5 - Crie uma function que ao receber o codigo de um disco nos diga qual o tempo total desse disco Usando a tabela musica.

DELIMITER $$
 CREATE FUNCTION IF NOT EXISTS fn_tempo(cod_disco int)
 RETURNS time
 DETERMINISTIC
		BEGIN
		DECLARE tempo TIME;
		SET tempo = (select sec_to_time(sum(time_to_sec(duracao)))
			from tb_musica
			where id_disco = cod_disco);
            
 RETURN tempo;
		END $$
 DELIMITER ;

select fn_tempo(7);

-- 6 - Crie uma function que ao receber o codigo de um disco nos diga todas as informações desse disco.

DELIMITER $$
CREATE FUNCTION IF NOT EXISTS fn_info_disco(cod_disco INT)
RETURNS VARCHAR(255)
DETERMINISTIC
	BEGIN
		DECLARE info VARCHAR(255);
		SET info = (select concat('id = ', id, ' - titulo = ', titulo, ' - duracao = ', duracao, ' - lançamento = ', ano_lancamento)  #'id do artista = ', id_artista, 'id da gravadora = ', id_gravadora, 'id do genero'
		from tb_disco 
        where id = cod_disco);
    
RETURN info;
	END $$
DELIMITER ;

SELECT fn_info_disco(7);


-- ---------------------------------------------------------------------------------------------------------------------
#Usando o db_familia:
use db_familia;
-- ---------------------------------------------------------------------------------------------------------------------


/*7.1 -  crie uma view que mostre o id e nome do filho, nome do pai e nome da mae, porém somente dos que estão relacionados. 
Apos criada a view utiliezea em uma function que me premiter visualizar esses dados de um filho expecifico.*/

CREATE VIEW vw_filhos as 
select filho.id as id_filho, filho.nome as nome_filho, pai.nome as nome_pai , mae.nome as nome_mae
from tb_filho as filho INNER join tb_mae as mae
ON mae.id = filho.id_mae
INNER JOIN tb_pai AS pai
ON pai.id = filho.id_pai;

select * from vw_filhos;

#---------Agora fazendo a função

#OBS: para mostrar o view em uma function precisammos colocar o que queremos que seja exbido usando os apelidos que criamos no view
DELIMITER $$
CREATE FUNCTION IF NOT EXISTS fn_info_filhos(cod_filho INT)
RETURNS varchar(255)
deterministic 
	begin
		declare info varchar(255);
        SET info = (select concat('id filho: ', id_filho,' - nome filho: ',nome_filho, ' - nome pai: ', nome_pai,' - nome mae: ', nome_mae) from vw_filhos
        where id_filho = cod_filho); -- id_ filho é o apelido que criamos em vw_filho
        
    return info;
    
    end $$
DELIMITER ;

SELECT fn_info_filhos(19);


/*8.2 - Ainda usando o db_familia, crie uma view que mostre o id e nome dos pais, o nome do filho, desejasse visualisar todos os pais, mesmo os que não possuem filhos. 
crie uma functions que me permita visualizar esses dados pelo nome do pai.*/
CREATE VIEW vw_pais as
select pai.id as id_pai, pai.nome as nome_pai, mae.id as id_mae, mae.nome as nome_mae, filho.nome as nome_filho 
from tb_pai as pai left join tb_filho as filho
ON pai.id = filho.id_pai
right join tb_mae as mae
on mae.id = filho.id_mae;

DELIMITER $$
CREATE FUNCTION IF NOT EXISTS fn_pais(cod_pai int)
RETURNS VARCHAR(255)
DETERMINISTIC 
	BEGIN
		DECLARE info VARCHAR(255);
        SET info = (select concat('id_pai: ', id_pai , ' | pai: ', nome_pai,' | id_mae: ', id_mae, ' | mae: ', nome_mae,' | filho: ', nome_filho) as 'informações familia'
        from vw_pais 
        where id_pai = cod_pai);
    
	RETURN info;
	END $$
DELIMITER ;

select fn_pais(2);

drop function fn_pais;


USE db_discoteca;


-- 9.3 - Usando o db_discoteca, crie uma view que me permita visualisar todos os dados do disco, junto ao nome da gravadora e nome do artista.
CREATE VIEW vw_info_disco as
SELECT 
  di.id as id_disco
, di.titulo as titulo_disco
, di.duracao as duracao_disco
, di.ano_lancamento as ano_disco
, gra.nome as nome_gravadora
, art.nome as nome_artista
FROM tb_disco AS di INNER JOIN tb_gravadora AS gra
ON gra.id = di.id_gravadora
INNER JOIN tb_artista as art
ON art.id = di.id_artista;

select * from vw_info_disco;



-- 10.4 - Ainda usando o discoteca, crie uma function que remova os acentos de qualquer letra, seja ela maiuscula ou minuscula.




















