-- Coloque em um arquivo do bloco de notas apenas os códigos para realizar as seguintes consultas.
/*
1 mostre o nome das gravadores em ordem alfabética

2  Mostre os disco que possuem mais que uma hora de musicas em ordem do maior para o menor

3 Mostre as musicas todas as musicas com tamanho iguais ou menor que 3.0 minutos

4  mostre os discos que são do ano 1996, 1999, 2015 em ordem crescente

5 mostre o nome e ano dos disco do ano 2000 ate 2022

6  mostre nome e data de nascimento dos artistas de 2003 pra frente

7 mostre todas as gravadoras que o ID seja diferente de 6 em ordem decrescente.

8 Mostre quais são as datas de nascimento dos artistas cadastradas no banco sem repetilas.

9 Mostre o nome e tempo das musicas que possuem o tempo menor ou igual 2, ou maior ou igual 4 
 
10 Mostre o titulo e ano dos discos entre 1997 e 2008
 
11 Mostre o nome das gravadoras com a letra 'd' em qualquer parte do nome. 
 
12 Mostre o nome das musicas do disco 23

13 Mostre os discos que tenham a letra 'S' no final

14 Mostre em ordem decrescente o nome dos artistas que tem a segunda letra 'E' e terminem com a letra 'O'

15 Indique o nome crescente , mas apenas das musicas que possuam menos de 3.0 minutos de duração

16 Indique os discos que iniciam com a letra A ou terminem com letra a sendo a penultima letra

17 Mostre o nome dos artistas que comecem com a letra C e que tenham idade superior a 23.

18 Mostre o nome das musicas, exceto as são são dos discos 6, 12 e 34.

Mostre o nome dos artistas que comecem com a letra C e que tenham idade superior a 23.



*/


-- 1 mostre o nome das gravadores em ordem alfabética

SELECT nome FROM tb_gravadora ORDER BY nome LIMIT 1000;

# 2  Mostre os disco que possuem mais que uma hora de musicas em ordem do maior para o menor

SELECT titulo FROM tb_disco 
where duracao > '01:00:00' ORDER BY duracao DESC LIMIT 1000;

-- 3 Mostre as musicas todas as musicas com tamanho iguais ou menor que 3.0 minutos

SELECT  nome, duracao FROM tb_musica
where duracao <= '00:03:00' ORDER BY duracao, nome LIMIT 1000;

# 4  mostre os discos que são do ano 1996, 1999, 2015 em ordem crescente

SELECT titulo, ano_lancamento FROM tb_disco
WHERE ano_lancamento = '1996' and '1999' and '2015' ORDER BY ano_lancamento LIMIT 1000;


-- 5 mostre o nome e ano dos disco do ano 2000 ate 2022
SELECT titulo, ano_lancamento FROM tb_disco
WHERE ano_lancamento BETWEEN '2000' AND 2022 order by ano_lancamento LIMIT 1000;


-- 6  mostre nome e data de nascimento dos artistas de 2003 pra frente

SELECT nome, dt_nascimento FROM tb_artista
WHERE dt_nascimento >= '2003-00-00' LIMIT 1000;

-- 7 mostre todas as gravadoras que o ID seja diferente de 6 em ordem decrescente.

SELECT id, nome FROM tb_gravadora
WHERE  id != 6 ORDER BY id desc LIMIT 1000;


-- 8 Mostre quais são as datas de nascimento dos artistas cadastradas no banco sem repetilas.

SELECT DISTINCT dt_nascimento FROM tb_artista LIMIT 1000;

-- 9 Mostre o nome e tempo das musicas que possuem o tempo menor ou igual 2, ou maior ou igual 4

SELECT nome, duracao FROM tb_musica 
WHERE duracao <= '00:02:00' OR duracao >= '00:04:00' LIMIT 1000;


# 10 Mostre o titulo e ano dos discos entre 1997 e 2008

SELECT titulo, ano_lancamento FROM tb_disco
WHERE ano_lancamento BETWEEN 1997 AND 2008 LIMIT 1000;


# 11 Mostre o nome das gravadoras com a letra 'd' em qualquer parte do nome.

SELECT nome FROM tb_gravadora 
WHERE nome LIKE '%d%' LIMIT 1000;

# 12 Mostre o nome das musicas do disco 23

SELECT nome, id_disco FROM tb_musica
WHERE id_disco = 23;

#13 Mostre os discos que tenham a letra 'S' no final

SELECT titulo FROM tb_disco
WHERE titulo LIKE '%s' LIMIT 1000;

#14 Mostre em ordem decrescente o nome dos artistas que tem a segunda letra 'E' e terminem com a letra 'O'

SELECT distinct nome FROM tb_artista 
WHERE nome LIKE '_e%' AND nome LIKE '%o' ORDER BY nome DESC LIMIT 1000;

# 15 Indique o nome crescente , mas apenas das musicas que possuam menos de 3.0 minutos de duração

SELECT DISTINCT nome FROM tb_musica 
WHERE duracao < '00:03:00' ORDER BY nome LIMIT 1000;


# 16 Indique os discos que iniciam com a letra A ou terminem com letra a sendo a penultima letra

SELECT titulo FROM tb_disco
WHERE titulo LIKE 'a%' or titulo LIKE '%a_' LIMIT 1000;

# 17 Mostre o nome dos artistas que comecem com a letra C e que tenham idade superior a 23.

SELECT nome FROM tb_artista 
WHERE nome LIKE 'c%' and dt_nascimento > '2000-01-01' LIMIT 1000;

# 18 Mostre o nome das musicas, exceto as são são dos discos 6, 12 e 34.

SELECT nome, id_disco FROM tb_musica 
WHERE id_disco NOT IN  (6,12,34) ORDER BY id_disco LIMIT 1000;




select id from tb_disco;










