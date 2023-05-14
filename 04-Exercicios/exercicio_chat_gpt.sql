CREATE DATABASE IF NOT EXISTS db_vendas
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

use db_vendas;

CREATE TABLE IF NOT EXISTS tb_cliente(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(55) NOT NULL,
	sobrenome VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    telefone varchar(14));
    
    
    CREATE TABLE IF NOT EXISTS tb_produto(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255),
    preco float NOT NULL);
    
    

    #--------------------------------------------------------------
    #Inserindo dados
    #--------------------------------------------------------------
    
    
    INSERT INTO tb_cliente
		(nome, sobrenome, email, telefone)
    VALUES
		( 'João',	'Silva',	'joao.silva@example.com','(11) 1111-1111'),
		( 'Maria'	, 'Santos',	'maria.santos@example.com','(21) 2222-2222'),
		('Ana'	, 'Souza',	'ana.souza@example.com','(31) 3333-3333'),
		('Pedro'	, 'Lima',	'pedro.lima@example.com','(41) 4444-4444'),
		('Fernanda'	, 'Costa',	'fernanda.costa@example.com','(51) 5555-5555');
        
        
	
    INSERT INTO tb_produto
		(nome, descricao, preco)
	VALUES
		('Notebook Dell', 'Notebook com processador Intel Core i5, 8GB de RAM, SSD',	4.500),
		('Samsung Galaxy' ,	'Smartphone com tela AMOLED, câmera tripla, 128GB de RAM',	 2.000),
		('TV LG',	'Smart TV LED 4K com tela de 50 polegadas',	 3.500),
		('Console PS5',	'Console de última geração com 825GB de armazenamento',	 5.000),
		('Caixa de som'	,'Caixa de som portátil com Bluetooth e bateria de longa duração', 500);
        
	
        
/*
1- Inserir um novo cliente na tabela "Clientes".
2- Alterar o telefone do cliente com ID = 3.
3- Excluir o cliente com ID = 5 da tabela "Clientes".
4- Inserir um novo produto na tabela "Produtos".
5- Alterar o preço do produto com ID = 1.
6- Excluir o produto com ID = 5 da tabela "Produtos".
7- Listar todos os clientes da tabela "Clientes".
8- Listar todos os produtos da tabela "Produtos".
9- Listar todos os clientes ordenados por ordem alfabética.
10- Listar todos os produtos ordenados por ordem crescente de preço.
11- Listar o nome e sobrenome dos clientes que têm telefone com código de área "11".
12- Listar o nome e preço dos produtos cujo preço é maior que R$ 3.000.
13- Listar o nome do cliente e nome do produto que ele comprou.
14- Listar o número total de clientes na tabela "Clientes".
15- Listar o número total de produtos na tabela "Produtos".
16- Listar o preço médio dos produtos na tabela "Produtos".
17- Listar o nome do produto mais caro da tabela "Produtos".
18- Listar o nome do cliente com o maior ID na tabela "Clientes".
19- Listar o ID do produto com o menor preço na tabela "Produtos".
20- Listar o nome do produto mais caro e o nome do cliente que o comprou.
*/
        
        
        
	
	
        
-- 1- Inserir um novo cliente na tabela "Clientes".
        
        INSERT INTO tb_cliente
			(nome, sobrenome, email, telefone)
		VALUES
			('igor', 'ferreira araujo', 'igoraraujo@gmail.com', '(61) 9989-6211');
        select concat(nome,' ', sobrenome) as nome_compreto from tb_cliente;
        
-- 2- Alterar o telefone do cliente com ID = 3.
UPDATE tb_cliente SET telefone = '(61)99929-1111'
where id = 3;
        
        SELECT telefone FROM tb_cliente
        where id = 3;
        
-- 3- Excluir o cliente com ID = 5 da tabela "Clientes".

	DELETE FROM tb_cliente
    where id = 5;
    
SELECT * FROM tb_cliente;
        
        
-- 4- Inserir um novo produto na tabela "Produtos".
DELIMITER $$
CREATE PROCEDURE sp_inserir(nomes VARCHAR(255), descricaos VARCHAR(255), precos FLOAT)
BEGIN
     INSERT INTO tb_produto
     (nome , descricao, preco)
		VALUES
	(nomes , descricaos, precos);
    
END $$
DELIMITER ;
        CALL sp_inserir('igor','lindo de mais', 950);
	
        select * from tb_produto;
        
-- 5- Alterar o preço do produto com ID = 1.
DELIMITER $$
CREATE PROCEDURE sp_alter(cod_produto INT, preco FLOAT)
BEGIN
	UPDATE tb_produto SET preco = preco
    WHERE id = cod_produto;


END $$
DELIMITER ;
        
    CALL sp_alter(4, 4500);
    
      select * from tb_produto;
      
      
-- 6- Excluir o produto com ID = 5 da tabela "Produtos".

CREATE PROCEDURE sp_delete_pro(cod_produto int)

	DELETE from tb_produto 
    where id = cod_produto;

CALL sp_delete_pro(5);

      select * from tb_produto;

-- 7- Listar todos os clientes da tabela "Clientes".

SELECT nome FROM tb_cliente;


-- 8- Listar todos os produtos da tabela "Produtos".

SELECT * FROM tb_produto;

-- 9- Listar todos os clientes ordenados por ordem alfabética.

SELECT nome FROM tb_cliente ORDER BY nome;


-- 10- Listar todos os produtos ordenados por ordem crescente de preço.

SELECT * FROM tb_produto ORDER BY preco;



-- 11- Listar o nome e sobrenome dos clientes que têm telefone com código de área "11".

SELECT nome, sobrenome FROM tb_cliente
where telefone LIKE '(11)%';
select * from tb_cliente;


-- 12- Listar o nome e preço dos produtos cujo preço é maior que R$ 3.000.

SELECT nome, preco FROM tb_produto
where preco > 3000;


-- 14- Listar o número total de clientes na tabela "Clientes".

SELECT  count(id) FROM tb_cliente;

select * FROM tb_cliente;


-- 15- Listar o número total de produtos na tabela "Produtos".

SELECT count(id) FROM tb_cliente;



-- 16- Listar o preço médio dos produtos na tabela "Produtos".

SELECT avg(preco) FROM tb_produto;


-- 17- Listar o nome do produto mais caro da tabela "Produtos".

SELECT MAX(preco) FROM tb_produto;


-- 18- Listar o nome do cliente com o maior ID na tabela "Clientes".

select nome from tb_cliente
where id = (select max(id) from tb_cliente );


-- 19- Listar o ID do produto com o menor preço na tabela "Produtos".
SELECT nome, id, preco FROM tb_produto
WHERE preco = (SELECT MIN(preco) FROM tb_produto);















