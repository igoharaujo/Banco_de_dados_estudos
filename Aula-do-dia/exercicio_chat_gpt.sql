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
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    