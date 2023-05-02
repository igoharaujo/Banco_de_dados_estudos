-- --------------------------------------------------------------------------------------
# EXERCICIOS: JOIN e COUNT
/*
-01 Mostre o nome do disco e da gravadora porem mostre somente aqueles que estão relacionados

-02 Mostre o nome de todos os discos e quando disponível o nome das gravadoras de cada um

-03 Mostre o nome do disco 32 e todas as musicas desse disco.

-04 Consulte o nome do disco 80252 mostrando todas as suas musicas e mostre também o nome da gravadora

-05 Mostre o nome de todas os discos e todas as gravadoras e dos discos mostre também o ano de lançamento.

-06 Mostre quantas musicas cada disco possui. E deseja-se saber também o nome do disco.

-07 mostre o nome das musicas e o nome do disco dessas musicas

-08 mostre o nome dos discos e o nome dos artista ordenado por artista, deseja-se saber todos os artistas e todos os discos

-09 mostre o nome do disco, da gravadora e do artista ordenado por gravadora

-10 mostre nome do disco, ano de lancamento, tempo, nome da gravadora e nome  completo do artista, junto a sua idade, ordenado por artista
 
-11 mostre o nome do disco e todos os dados da musica, exceto fk, porem somente dos   discos 1, 10, 100, 1000, 10000, 100000  ordenado por disco.

-12 mostre nome da gravadora, todos os dados do artista, exceto fk, todos os dados do disco exceto fk, e todos os dados das musicas relacionados, ordenado por artista porem mostre apenas dos disco de 1000 a 15000.

-13 Mostre quantas musicas estão cadastradas.

-14 Mostre a maior musica.

-15 Mostre a menor disco.

-16 Mostre quantos discos cada gravadora possui em ordem decrescente deseja-se saber o nome da gravadora
Mostre quantos discos cada gênero possui em ordem decrescente 

-17 deseja-se saber o nome do gênero

-18 Mostre  o tempo total de cada disco, porém mostre apenas os que possuem tempo superior a 1 hora, ordenado de forma decrescente (faça usando a tabela musica).

-19 Mostre quantos discos cada gravadora possui, mostre apenas as que possuem mais que 500 discos e que o ano de lançamento seja de 2000 pra frente ordenado de forma crescente de ano, deseja-se saber o nome da gravadora

-21 Mostre quantos discos cada artista possui filtrando apenas os que tem mais que 700 e tenha e não estejam presentes os anos 1985, 1998 e 2002.
*/
use db_discoteca2;

#01 Mostre o nome do disco e da gravadora porem mostre somente aqueles que estão relacionados
SELECT disco.titulo AS disco, gravadora.nome AS gravadora
FROM tb_disco AS disco INNER JOIN tb_gravadora AS gravadora
ON disco.id_gravadora = gravadora.id;


#-02 Mostre o nome de todos os discos e quando disponível o nome das gravadoras de cada um
SELECT disco.titulo AS disco, tb_gravadora.nome AS gravadoras
FROM tb_disco AS disco LEFT JOIN tb_gravadora 
ON disco.id_gravadora = tb_gravadora.id;

#-03 Mostre o nome do disco 32 e todas as musicas desse disco.
SELECT distinct disco.id, disco.titulo AS disco, musica.nome AS musica 
FROM tb_disco AS disco JOIN tb_musica AS musica
ON disco.id = musica.id_disco 
where disco.id = 32;

#-04 Consulte o nome do disco 80252 mostrando todas as suas musicas e mostre também o nome da gravadora

/*select distinct disco.titulo AS disco, musica.nome AS musica, gravadora.nome AS gravadora
from 
tb_disco AS disco INNER JOIN tb_musica AS musica
ON disco.id = musica.id_disco
inner join tb_gravadora AS gravadora
where disco.id = 80252;*/


select distinct disco.titulo AS disco, 
				gravadora.nome AS gravadora, 
                musica.nome AS musica
from tb_disco AS disco 
INNER JOIN tb_gravadora AS gravadora 
	on gravadora.id = disco.id_gravadora
INNER JOIN tb_musica AS musica
	on disco.id = musica.id_disco
WHERE disco.id = 80252;


#-05 Mostre o nome de todas os discos e todas as gravadoras e dos discos mostre também o ano de lançamento.
SELECT  disco.ano_lancamento AS lancamento_disco,
		disco.titulo AS titulo,
		gravadora.nome AS gravadora
FROM tb_disco AS disco RIGHT JOIN tb_gravadora AS gravadora
ON gravadora.id = disco.id_gravadora;
        

#-06 Mostre quantas musicas cada disco possui. E deseja-se saber também o nome do disco.
SELECT disco.titulo, COUNT(musica.id) AS QTD
FROM tb_musica AS musica RIGHT JOIN tb_disco AS disco
ON musica.id_disco = disco.id
GROUP BY musica.id_disco;


#-07 mostre o nome das musicas e o nome do disco dessas musicas
SELECT distinct .nome as musica, disco.titulo as disco 
FROM tb_musica AS musica left JOIN tb_disco AS disco
ON musica.id_disco = disco.id;


#-08 mostre o nome dos discos e o nome dos artista ordenado por artista, deseja-se saber todos os artistas e todos os discos
SELECT artista.nome, disco.titulo 
FROM tb_disco AS disco RIGHT JOIN tb_artista AS artista
ON artista.id = disco.id_artista		
union
SELECT DISTINCT artista.nome, disco.titulo 
FROM tb_disco AS disco LEFT JOIN tb_artista AS artista
ON artista.id = disco.id_artista;		


#-09 mostre o nome do disco, da gravadora e do artista ordenado por gravadora

SELECT disco.titulo AS disco, 
		gravadora.nome AS gravadora,
        artista.nome AS artista
FROM tb_disco AS disco INNER JOIN tb_gravadora AS gravadora			#se eu colocasse o LEFT eu iriar mostrar os discos mesmo que ele não tivesse gravadora.
	ON gravadora.id = disco.id_gravadora							#se eu colocasse o RIGHT eu iria mostrar os gravadora mesmo que não tivessem disco
INNER JOIN															# o INNER JOIN vai mostrar so os que têm uma conexão
tb_artista AS artista 												
	ON artista.id = disco.id_artista ORDER BY gravadora.nome;


#-10 mostre nome do disco, ano de lancamento, tempo, nome da gravadora e nome  completo do artista, junto a sua idade, ordenado por artista
SELECT disco.titulo as disco, disco.ano_lancamento as ano_disco, disco.duracao as tempo_disco, gravadora.nome as gravadora, artista.nome as artista, artista.dt_nascimento
FROM tb_disco as disco INNER JOIN tb_artista as artista
on disco.id_artista = artista.id
inner join tb_gravadora as gravadora
on disco.id_gravadora = gravadora.id ORDER BY artista.nome
; 

#-11 mostre o nome do disco e todos os dados da musica, exceto fk, porem somente dos  discos 1, 10, 100, 1000, 10000, 100000  ordenado por disco.
SELECT disco.titulo as disco,
		musica.id as id_musica,
		musica.nome as musica, 
		musica.duracao as tempo_musica 
from tb_disco as disco inner join tb_musica as musica
	ON disco.id = musica.id_disco
where disco.id IN (1, 10, 100, 10000, 100000);

#-12 mostre nome da gravadora, todos os dados do artista, exceto fk, todos os dados do disco exceto fk, e todos os dados das musicas relacionados, ordenado por artista porem mostre apenas dos disco de 1000 a 15000.
SELECT gravadora.nome as gravadora,
 artista.id as artista, 
 artista.nome as nome_artista, 
 artista.dt_nascimento as nascimento_artista, 
 disco.id as id_disco, 
 disco.titulo as nome_disco, 
 disco.duracao as duracao_disco, 
disco.ano_lancamento as lancamento,  
musica.id as id_musica,													-- Erro
 musica.nome as musica, 
 musica.duracao as tempo_musica
 
FROM tb_disco as disco INNER JOIN tb_gravadora AS gravadora
ON gravadora.id = disco.id_gravadora
INNER JOIN tb_artista AS artista
ON artiata.id = disco.id_artista
WHERE disco.id BETWEEN 1000 and 15000
ORDER BY artista;


#-13 Mostre quantas musicas estão cadastradas.
select COUNT(1) FROM tb_musica; #posso fazer assim
select COUNT(id) FROM tb_musica; # ou assim
select COUNT(*) FROM tb_musica; # ou assim ...
select COUNT(nome) FROM tb_musica;


#-14 Mostre a maior musica.
SELECT MAX(duracao) FROM tb_musica;

#-15 Mostre a menor disco.
SELECT MIN(titulo) from tb_disco;


#-16 Mostre quantos discos cada gravadora possui em ordem decrescente deseja-se saber o nome da gravadora Mostre quantos discos cada gênero possui em ordem decrescente 
SELECT gravadora.nome,
		COUNT(disco.id_gravadora) as QTD
FROM tb_disco as disco
RIGHT JOIN tb_gravadora as gravadora
ON gravadora.id = disco.id_gravadora
GROUP BY id_gravadora order by QTD desc;


#-17 deseja-se saber o nome do gênero
SELECT genero.nome,
		COUNT(disco.id_gravadora) as QTD
FROM tb_disco as disco
RIGHT JOIN tb_genero as genero
ON genero.id = disco.id_genero
GROUP BY id_genero order by QTD desc;

#-18 Mostre  o tempo total de cada disco, porém mostre apenas os que possuem tempo superior a 1 hora, ordenado de forma decrescente (faça usando a tabela musica).
SELECT 
 		musica.id_disco,
		SUM(musica.duracao) AS duracao_total 
FROM tb_musica AS musica
INNER JOIN tb_musica AS musica
ON disco.id = musica.id_disco
GROUP BY musica.id_disco
HAVING duracao_total > 6000;


#-19 Mostre quantos discos cada gravadora possui, mostre apenas as que possuem mais que 500 discos e que o ano de lançamento seja de 2000 pra frente ordenado de forma crescente de ano, deseja-se saber o nome da gravadora

SELECT gravadora.nome,
		COUNT(disco.id_gravadora) as QTD
FROM tb_disco as disco
RIGHT JOIN tb_gravadora as gravadora
ON gravadora.id = disco.id_gravadora
WHERE disco.ano_lancamento >= 2000
GROUP BY id_gravadora 
HAVING QTD > 500;



#-21 Mostre quantos discos cada artista possui filtrando apenas os que tem mais que 700 e tenha e não estejam presentes os anos 1985, 1998 e 2002.
SELECT 
	artista.nome as artista,
    COUNT(disco.id_artista) AS quantidade
FROM tb_disco AS disco
LEFT JOIN tb_artista as artista
ON artista.id = disco.id_artista
WHERE disco.ano_lancamento NOT IN (1985, 1998, 2002)
GROUP BY disco.id_artista
HAVING quantidade > 100;



