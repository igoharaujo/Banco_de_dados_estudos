/*
4- Consulte o titulo e ano de lançamento de todos os discos exceto os que estão entre 1998 e 2006 e organize por ano

5- Consulte o nome  dos artistas que tenham o nome iniciado com 'C' e terminado com 'A',   organize por ordem alfabética de nome.

6- Consulte o nome e minutos de cada disco exceto dos artistas 3 e 7 e mostre no resultado apenas aqueles que possuem o tempo entre 35 e 75 minutos

7- Consulte todas as idades de cada artista e mostre quantos artistas possuem cada idade.

8-Consulte o ano de lançamento dos discos cadastrados mostre quantos discos cada ano possui, porém mostre apenas dos anos 2010 a 2020*/


#1- Consulte apenas os nomes dos artistas que possuem 'SILVA' em qualquer qualquer lugar do nome  e que tenha idade superior a 25 e organize em ordem crescente de sobrenome.
SELECT nome FROM tb_artista
WHERE nome LIKE '%silva%' AND dt_nascimento < '1998-12-30' ORDER BY SUBSTRING_INDEX(nome, ' ', -1) ASC;


#2- Consulte apenas o nome e idade dos artistas que possuem idade entre 18 e 35 anos ou que possuam o nome iniciado com a letra 'P' e terminado com a letra 'Y' e organize em ordem crescente de idade.
SELECT nome, dt_nascimento FROM tb_artista
WHERE (dt_nascimento BETWEEN 1988 AND 2005) OR (nome LIKE 'p%y') ORDER BY dt_nascimento;


#3- Consulte o titulo dos discos do artista 5 e no resultado mostre o titulo apenas daqueles que tiverem de 20 minutos para cima e organize em ordem decrescente de minutos.
SELECT titulo FROM tb_disco
WHERE id_artista = 5 AND duracao >= '00:20:00' ORDER BY duracao DESC;