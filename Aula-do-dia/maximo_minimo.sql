USE db_discoteca2;

SELECT * FROM tb_disco;

SELECT MAX(duracao) FROM tb_disco; -- o MAX() mostrara o maximo de duração

SELECT AVG(duracao) FROM tb_disco; -- AVG() mostrara a media

SELECT MIN(duracao) FROM tb_disco; -- MIN() mostrara o minimo

SELECT SUM(duracao) FROM tb_disco; -- SUM() mostrara a soma

SELECT COUNT(4) FROM tb_disco; -- é uma função que vai contar todos os atributos da tabela, ou substituindo * posso contar apenas as linhas da tabelas