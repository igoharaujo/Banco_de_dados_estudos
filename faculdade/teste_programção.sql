#Divisor de conta de restaurante


CREATE DATABASE IF NOT EXISTS restaurante -- Criando uma database chamada restaurante
COLLATE utf8mb4_general_ci 
CHARSET utf8mb4;


CREATE TABLE IF NOT EXISTS produto( -- Criando a tabela produto
	cod_produto INT PRIMARY KEY,
    nome VARCHAR(45),
    valor FLOAT);
    
    
CREATE TABLE IF NOT EXISTS cliente(
	cod_cliente INT PRIMARY KEY,
    nome VARCHAR(45));
    
    CREATE table IFRT54      