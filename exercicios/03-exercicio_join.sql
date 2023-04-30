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

-19 Mostre quantos discos cada gravadora possui, mostre apenas as que possuem mais que 500 discos e que o ano de lançamento seja de 2000 pra frente ordenado de forma crescente de ano, 

-20 deseja-se saber o nome da gravadora

-21 Mostre quantos discos cada artista possui filtrando apenas os que tem mais que 700 e tenha e não estejam presentes os anos 1985, 1998 e 2002.
*/
use db_discoteca;

#01 Mostre o nome do disco e da gravadora porem mostre somente aqueles que estão relacionados
SELECT disco.titulo AS disco, gravadora.nome AS gravadora
FROM tb_disco AS disco INNER JOIN tb_gravadora AS gravadora
ON disco.id = gravadora.id;


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



use db_discoteca;



