CREATE DATABASE IF NOT EXISTS db_rpg
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

USE db_rpg;


CREATE TABLE IF NOT EXISTS tb_habilidade(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(20) NOT NULL,
descricao VARCHAR(100) NOT NULL,
CONSTRAINT uq_nome_habilidade UNIQUE(nome)
)AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS tb_classe(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(20) NOT NULL,
descricao VARCHAR(100) NOT NULL,
CONSTRAINT uq_nome_classe UNIQUE(nome)
)AUTO_INCREMENT = 1;




CREATE TABLE IF NOT EXISTS tb_usuario(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
dt_nascimento DATE NOT NULL,
email VARCHAR(255) NOT NULL,
senha VARCHAR(255) NOT NULL,
nickname VARCHAR(40) NOT NULL,
CONSTRAINT uq_nickname UNIQUE(nickname),
CONSTRAINT uq_email UNIQUE(email),
CONSTRAINT ck_dt_nasciemtno CHECK(dt_nascimento != '0000-00-00')
)AUTO_INCREMENT = 1;



CREATE TABLE IF NOT EXISTS tb_classe_habilidade(
id_classe INT NOT NULL,
id_habilidade INT NOT NULL,
CONSTRAINT fk_id_classe FOREIGN KEY (id_classe) REFERENCES tb_classe(id),
CONSTRAINT fk_id_habilidade FOREIGN KEY (id_habilidade) REFERENCES tb_habilidade(id),
PRIMARY KEY(id_classe, id_habilidade)


);

CREATE TABLE IF NOT EXISTS tb_personagem(
id_personagem INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(12) NOT NULL,
genero ENUM('f','m') NOT NULL,
nivel TINYINT UNSIGNED NOT NULL DEFAULT 1,
experiencia INT UNSIGNED NOT NULL DEFAULT 0,
id_usuario INT,
id_classe INT,
CONSTRAINT uq_nome_personagem UNIQUE(nome),
CONSTRAINT fk_id_usuario FOREIGN KEY(id_usuario) REFERENCES tb_usuario(id),
CONSTRAINT fk_id_classe_personagem FOREIGN KEY(id_classe) REFERENCES tb_classe(id)

)AUTO_INCREMENT = 1;

show tables; #para ver o nome de todos as tabelas do banco

#--------------------------------------------------------------------------------------------------
#Inserindo Dados
#--------------------------------------------------------------------------------------------------

INSERT INTO tb_usuario
(id_usuario, nome, dt_nascimento)
VALUES
(1,'igor','2001-12-13'),
(2, 'Samuel', '2001-05-13'),
(3, 'david', '2000-02-13'),
(4, 'gabi', '2011-02-13'),
(5, 'giovana', '2003-7-13');



INSERT INTO tb_personagem
(id_personagem, nome, id_usuario)
VALUES
(1, 'DeuBug', 1),
(2, 'BitBug', 2);

INSERT INTO tb_classe
(id_classe, nome, id_personagem)
VALUES
(1, 'Barbaro',1 ),
(2, 'Monge', 2);


INSERT INTO tb_habilidade
(id_habilidade, nome)
VALUES
(1, 'Lança Mortal'),
(2, 'Escudo Supremo'),
(3, 'Recupera Vida');


INSERT INTO tb_classe_habilidade
(id_classe, id_habilidade)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2,2);










