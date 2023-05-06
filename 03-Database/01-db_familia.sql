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






#-------------------



INSERT INTO tb_pai
(id, nome)
VALUES 
(1,'VEGETA'),
    (2,'goku'),
    (3,'naruto'),
    (4,'Darth vader'),
    (5,'Ran Solo');
    
INSERT INTO tb_mae
(id, nome)
VALUES
(1,'chichi'),
    (2,'bulma'),
    (3,'chichin'),
    (4,'hinata'),
    (5, 'Matsunaga');
    

INSERT INTO tb_filho
(id, nome, id_mae, id_pai)
VALUES
(1,'Trunks', 2, 1),
    (2,'Gohan', 1, 2),
    (3,'Goten', 1, 2),
    (4,'Boruto', 4, 3),
    (5, 'Luke Skywalker', null, 4),
    (6, 'Afonso Padilha', null, null),
    (7, 'Orfão', null, null);

    select * from tb_filho;
    
   