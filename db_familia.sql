CREATE DATABASE IF NOT EXISTS db_familia
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

USE db_familia;

CREATE TABLE IF NOT EXISTS tb_mae (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_pai (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_filho (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    id_mae INTEGER NOT NULL, 
    id_pai INTEGER NOT NULL,
CONSTRAINT fk_id_mae FOREIGN KEY (id_mae) REFERENCES tb_mae (id),
CONSTRAINT fk_id_pai FOREIGN KEY (id_pai) REFERENCES tb_pai (id)
);

/*ALTER TABLE tb_filho
MODIFY id_mae INT;

ALTER TABLE tb_filho
modify nome varchar(255) not null;


DESCRIBE tb_filho;*/

