/*
1- Consulte apenas os nomes dos artistas que possuem 'SILVA' em qualquer qualquer lugar do nome  e que tenha idade superior a 25 e organize em ordem crescente de sobrenome.

2- Consulte apenas o nome e idade dos artistas que possuem idade entre 18 e 35 anos ou que possuam o nome iniciado com a letra 'P' e terminado com a letra 'Y' e organize em ordem crescente de idade.

3- Consulte o titulo dos discos do artista 5 e no resultado mostre o titulo apenas daqueles que tiverem de 20 minutos para cima e organize em ordem decrescente de minutos.

4- Consulte o titulo e ano de lançamento de todos os discos exceto os que estão entre 1998 e 2006 e organize por ano

5- Consulte o nome  dos artistas que tenham o nome iniciado com 'C' e terminado com 'A',   organize por ordem alfabética de nome

6- Consulte o nome e minutos de cada disco exceto dos artistas 3 e 7 e mostre no resultado apenas aqueles que possuem o tempo entre 35 e 75 minutos

7- Consulte todas as idades de cada artista e mostre quantos artistas possuem cada idade.

8-Consulte o ano de lançamento dos discos cadastrados mostre quantos discos cada ano possui, porém mostre apenas dos anos 2010 a 2020

9-Busque a data de nascimento mais antiga.

10- Busque a media de duração dos discos

11- Busque a menor musica

12- Indique quantas musicas possuem a mesma duração ordenado pela maior

13- indique quantos discos foram lançados no mesmo ano ordenado pelo que tem mais

14- indique quantas vezes cada musica se repete ordenado em de forma alfabética e numérica de quantidade

15- indique quantos artistas nasceram no mesmo dia ordenado por data crescente e quantidade decrescente, porem somente das datas que tiverem pelo menos 2 artistas e faça isso para as datas de 1890 a 2023

busque o maior id de gravadoras

16- busque o maior id de musica

17 - busque o maior id de disco

18- deseja-se saber quantos discas cada gravadora possue

10- deseja-se saber quantos discos são de cada genero

11- deseja-se saber quantos discos cada gênero possui, porém somente dos que vieram do ano 2000 pra frente e dos que possuírem mais que um disco*/



#1- Consulte apenas os nomes dos artistas que possuem 'SILVA' em qualquer qualquer lugar do nome  e que tenha idade superior a 25 e organize em ordem crescente de sobrenome.
SELECT nome FROM tb_artista
WHERE nome LIKE '%silva%' AND dt_nascimento < '1998-12-30' ORDER BY SUBSTRING_INDEX(nome, ' ', -1) ASC;


#2- Consulte apenas o nome e idade dos artistas que possuem idade entre 18 e 35 anos ou que possuam o nome iniciado com a letra 'P' e terminado com a letra 'Y' e organize em ordem crescente de idade.
SELECT dt_nascimento, nome FROM tb_artista
WHERE ((dt_nascimento BETWEEN '1988-12-30' AND '2005-12-30') OR (nome LIKE 'p%y')) AND (dt_nascimento != '0000-00-00') ORDER BY dt_nascimento;


#3- Consulte o titulo dos discos do artista 5 e no resultado mostre o titulo apenas daqueles que tiverem de 20 minutos para cima e organize em ordem decrescente de minutos.
SELECT titulo FROM tb_disco
WHERE id_artista = 5 AND duracao >= '00:20:00' ORDER BY duracao DESC;

#4- Consulte o titulo e ano de lançamento de todos os discos exceto os que estão entre 1998 e 2006 e organize por ano
SELECT titulo, ano_lancamento FROM tb_disco
WHERE ano_lancamento NOT BETWEEN 1998 AND 2006 ORDER BY ano_lancamento;

#5- Consulte o nome  dos artistas que tenham o nome iniciado com 'C' e terminado com 'A',   organize por ordem alfabética de nome
SELECT nome FROM tb_artista 
WHERE nome LIKE 'c%a' ORDER BY nome;


#6- Consulte o nome e minutos de cada disco exceto dos artistas 3 e 7 e mostre no resultado apenas aqueles que possuem o tempo entre 35 e 75 minutos
SELECT titulo, duracao FROM tb_disco
WHERE (id_artista != 3 and 7) AND (duracao BETWEEN '00:35:00' AND '01:15:00');


#7- Consulte todas as idades de cada artista e mostre quantos artistas possuem cada idade.
SELECT dt_nascimento, COUNT(dt_nascimento) AS qtd FROM tb_artista 
GROUP BY dt_nascimento;

#8-Consulte o ano de lançamento dos discos cadastrados mostre quantos discos cada ano possui, porém mostre apenas dos anos 2010 a 2020
SELECT ano_lancamento, COUNT(ano_lancamento) AS qtd_disco FROM tb_disco
WHERE ano_lancamento BETWEEN 2010 AND 2020
GROUP BY ano_lancamento;

#9-Busque a data de nascimento mais antiga
SELECT MIN(dt_nascimento) FROM tb_artista
WHERE dt_nascimento != '000-00-00';

#10-Busque a media de duração dos discos
SELECT AVG(duracao) FROM tb_disco;

#11- Busque a menor musica
SELECT nome, MIN(duracao) FROM tb_musica;

#12- Indique quantas musicas possuem a mesma duração ordenado pela maior
SELECT nome , COUNT(DURACAO) FROM tb_musica
GROUP BY duracao ORDER BY duracao;

#13- indique quantos discos foram lançados no mesmo ano ordenado pelo que tem mais
SELECT ano_lancamento, COUNT(ano_lancamento) AS ano FROM tb_disco
GROUP BY ano_lancamento ORDER BY ano desc;


#14- indique quantas vezes cada musica se repete ordenado em de forma alfabética e numérica de quantidade
SELECT nome, COUNT(nome) AS qtd FROM tb_musica
GROUP BY nome ORDER BY nome ASC, qtd ASC;


#15- indique quantos artistas nasceram no mesmo dia ordenado por data crescente e quantidade decrescente, porem somente das datas que tiverem pelo menos 2 artistas e faça isso para as datas de 1890 a 2023
SELECT nome, COUNT(dt_nascimento) AS qtd FROM tb_artista
WHERE dt_nascimento BETWEEN '1890-01-01' AND '2023-04-26'
GROUP BY dt_nascimento
having dt_nascimento >= 2 ORDER BY dt_nascimento asc, qtd desc;

#16- busque o maior id de musica
select max(id) from tb_musica;

#17 - busque o maior id de disco
select max(id) from tb_disco;

#8- deseja-se saber quantos discas cada gravadora possue
select id_gravadora, count(id_gravadora) AS discos_por_gravadora
from tb_disco
group by id_gravadora;
