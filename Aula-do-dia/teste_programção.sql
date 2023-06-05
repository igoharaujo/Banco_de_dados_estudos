#Divisor de conta de restaurante


CREATE DATABASE IF NOT EXISTS restaurante -- Criando uma database chamada restaurante
COLLATE utf8mb4_general_ci -- Tipo de texto usando
CHARSET utf8mb4;


CREATE TABLE IF NOT EXISTS produto( -- Criando a tabela produto
	cod_produto INT PRIMARY KEY,
    nome VARCHAR(45),
    valor FLOAT);