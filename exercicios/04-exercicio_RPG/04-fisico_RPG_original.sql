CREATE DATABASE IF NOT EXISTS db_dataq_jogo
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

use db_dataq_jogo;

CREATE TABLE IF NOT EXISTS tb_usuario(
id_usuario INT PRIMARY KEY,
nome VARCHAR(100),
dt_nascimento DATE
);

CREATE TABLE IF NOT EXISTS tb_personagem(
id_personagem INT PRIMARY KEY,
nome VARCHAR(100),
id_usuario int not null,
CONSTRAINT uq_nome UNIQUE(nome),
CONSTRAINT fk_id_usuario foreign key(id_usuario) REFERENCES tb_usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS tb_classe(
id_classe INT PRIMARY KEY,
nome VARCHAR(100),
id_personagem INT,
CONSTRAINT uq_nome UNIQUE(nome),
CONSTRAINT fk_personagem FOREIGN KEY(id_personagem) REFERENCES tb_personagem(id_personagem)
);

CREATE TABLE IF NOT EXISTS tb_habilidade(
id_habilidade INT PRIMARY KEY,
nome VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS tb_classe_habilidade(
id_classe INT not null,
id_habilidade INT not null,
CONSTRAINT fk_classe FOREIGN KEY(id_classe) REFERENCES tb_classe(id_classe),
CONSTRAINT fk_habilidade FOREIGN KEY(id_habilidade) REFERENCES tb_habilidade(id_habilidade),
PRIMARY KEY(id_classe, id_habilidade)
);


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






select personagem.nome as personagem,
		habilidade.nome as habilidade
from tb_personagem as personagem INNER JOIN tb_classe_habilidade as classe
ON classe.id_classe = personagem.id_personagem
inner join tb_habilidade as habilidade
on classe.id_habilidade = habilidade.id_habilidade;












