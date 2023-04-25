-- NOME-1: Igor Ferreira Araújo
-- NOME-2: Kaio Lucas Ferreira Barbosa

CREATE DATABASE IF NOT EXISTS db_discoteca
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

use db_discoteca;

CREATE TABLE IF NOT EXISTS tb_gravadora(
id_gravadora INT PRIMARY KEY,
nome VARCHAR(255),
cnpj CHAR (15),
CONSTRAINT uq_nome_tb_gravadora UNIQUE(nome)
);

CREATE TABLE IF NOT EXISTS tb_artista(
id_artista INT PRIMARY KEY,
nome_banda varchar(255),
nome_artista varchar(255),
conserto VARCHAR(255),
dupla VARCHAR (255),
data_nascimento DATE
);

CREATE TABLE IF NOT EXISTS tb_disco(
id_disco INT PRIMARY KEY,
titulo VARCHAR(255) ,
duracao FLOAT(4,2),
ano_lancamento YEAR,
id_gravadora INT NOT NULL,
id_artista INT NOT NULL,
CONSTRAINT fk_id_gravadora FOREIGN KEY(id_gravadora) REFERENCES tb_gravadora(id_gravadora),
CONSTRAINT fk_id_artista FOREIGN KEY(id_artista) REFERENCES tb_artista(id_artista)
);

CREATE TABLE IF NOT EXISTS tb_musica(
id_musica INT PRIMARY KEY,
nome VARCHAR(255),
tempo_duracao FLOAT(4,2),
id_disco INT NOT NULL,
CONSTRAINT fk_id_disco FOREIGN KEY(id_disco) REFERENCES tb_disco(id_disco)
);


CREATE TABLE IF NOT EXISTS tb_genero(
id_genero INT PRIMARY KEY,
id_genero INT PRIMARY KEY,
nome VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS tb_musica_genero(
id_musica INT NOT NULL,
id_genero INT NOT NULL,
CONSTRAINT fk_id_musica FOREIGN KEY(id_musica) REFERENCES tb_musica(id_musica),
CONSTRAINT fk_id_genero FOREIGN KEY(id_genero) REFERENCES tb_genero(id_genero),
PRIMARY KEY (id_musica, id_genero)
);





















