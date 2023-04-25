USE db_discoteca2;

SELECT * FROM tb_disco;

SELECT MAX(duracao) FROM tb_disco; -- o MAX() mostrara o maximo de duração

SELECT AVG(duracao) FROM tb_disco; -- AVG() mostrara a media

SELECT MIN(duracao) FROM tb_disco; -- MIN() mostrara o minimo

SELECT COUNT(*) FROM tb_disco; -- é uma função que vai contar todos os atributos da tabela, ou substituindo * posso contar apenas as linhas da tabelas

SELECT SUM(duracao) FROM tb_disco; -- SUM() mostrara a soma

-- dados estatistico

use db_game;
SELECT * FROM tb_console
where id_console = 1; -- xbox

SELECT * FROM tb_jogo
where id_jogo = 3; -- gta v


SELECT DISTINCT id_jogo FROM tb_jogo_console;

SELECT id_jogo FROM tb_jogo_console GROUP BY id_jogo; -- Com o mando "GROUP BY" vai separa os grupos, caso o id_jogo = 1 repita ele vai colocar todos os id 1 dentro da coluna 1, id 2 repetido na coluna 2...

SELECT id_jogo, COUNT(id_jogo) FROM tb_jogo_console GROUP BY id_jogo; -- Aqui especificamos o que o COUNT vai contar, ele vai pegar o jogo e enquantos consoles aquele jogo aparece

SELECT ano_lancamento, count(ano_lancamento) FROM tb_disco GROUP BY ano_lancamento; -- Aqui vamos mostrar a linha ano_lancamento e a quantidade de ano_lancamento da tb_disco separado por ano lancamento


#Aqui vamos filtra os dados e depois vamos filtrar as colunas
SELECT ano_lancamento, count(ano_lancamento) AS quantidade FROM tb_disco
WHERE ano_lancamento BETWEEN 2000 AND 2020    -- aqui vamos usar o where para filtrar o ano entre 2000 e 2020, WHERE PRECISAR SER ANTES DO WHERE
GROUP BY ano_lancamento
HAVING quantidade > 5000 order by ano_lancamento; -- HAVING: filtro de grupos, so funciona dentro do GROUP BY


# quantas musicas cada disco tem, mas so  acima de 100 musicas e abaixo de 500, ordernados de forma descrescente, so disco que são de 1000 a 1999

SELECT id_disco, COUNT(id_disco) AS disco  FROM tb_musica
where id_disco between 1000 and 100000
group by id_disco
HAVING disco between 100 AND 1000 ORDER BY disco desc;






