CREATE DATABASE IF NOT EXISTS streamer
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

use streamer;






CREATE TABLE IF NOT EXISTS pais(
	id_pais INT PRIMARY KEY,
    nome VARCHAR(42),
    codigo TINYINT
);

CREATE TABLE IF NOT EXISTS classificacao(
	id_classificacao INT PRIMARY KEY,
    idade year,
    descricao VARCHAR(45)
    );
    
CREATE TABLE IF NOT EXISTS ator(
	id_ator INT PRIMARY KEY,
    nome VARCHAR(16),
    sobrenome VARCHAR(32),
    nascimento DATE,
    foto BLOB
    );

CREATE TABLE IF NOT EXISTS idioma(
	nome VARCHAR(45) PRIMARY KEY
 );
 
CREATE TABLE IF NOT EXISTS categoria(
	id_categoria INT PRIMARY KEY,
    nome VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS catalogo(
	id_catalogo INT PRIMARY KEY,
    titulo VARCHAR(45),
    sinopse VARCHAR(255),
    ano_lancamento YEAR,
    duracao TIME,
    avaliacao ENUM('1','2','3','4','5'),
    idioma_original VARCHAR(45),
    id_classificacao INT,
    CONSTRAINT fk_idioma FOREIGN KEY (idioma_original) REFERENCES idioma(nome),
    CONSTRAINT fk_classificacao FOREIGN KEY (id_classificacao) REFERENCES classificacao(id_classificacao)
);

CREATE TABLE IF NOT EXISTS pais_catalogo(
	id_pais INT,
    id_catalogo INT,
    PRIMARY KEY(id_pais, id_catalogo),
    CONSTRAINT fk_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais),
    CONSTRAINT fk_catalogo_pais FOREIGN KEY(id_catalogo) REFERENCES catalogo(id_catalogo)
);

CREATE TABLE IF NOT EXISTS idioma_catalogo(
	cod_idioma VARCHAR(45),
    id_catalogo INT,
    PRIMARY KEY(cod_idioma, id_catalogo),
    CONSTRAINT fk_idioma_catalogo FOREIGN KEY (cod_idioma) REFERENCES idioma(nome),
    CONSTRAINT fk_catalogo_idioma FOREIGN KEY(id_catalogo) REFERENCES catalogo(id_catalogo)
);

CREATE TABLE IF NOT EXISTS ator_catalogo(
	id_ator INT,
    id_catalogo INT,
    PRIMARY KEY(id_ator, id_catalogo),
    CONSTRAINT fk_id_ator FOREIGN KEY (id_ator) REFERENCES ator(id_ator),
    CONSTRAINT fk_id_catalogo_ator FOREIGN KEY (id_catalogo) REFERENCES catalogo(id_catalogo)
);
CREATE TABLE IF NOT EXISTS categoria_catalogo(
	id_categoria INT,
    id_catalogo INT,
    PRIMARY KEY(id_categoria, id_catalogo),
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    CONSTRAINT fk_catalogo_categoria FOREIGN KEY(id_catalogo) REFERENCES catalogo(id_catalogo)
);
CREATE TABLE IF NOT EXISTS filme(
	id_filme INT PRIMARY KEY,
    osca INT,
    id_catalogo INT,
    CONSTRAINT fk_catalogo_filme FOREIGN KEY(id_catalogo) REFERENCES catalogo(id_catalogo)
);
CREATE TABLE IF NOT EXISTS serie(
	id_serie INT PRIMARY KEY,
    qtd_epsodio INT,
    nome VARCHAR(32),
    id_catalogo INT,
    CONSTRAINT fk_catalogo_serie FOREIGN KEY(id_catalogo) REFERENCES catalogo(id_catalogo)
);
CREATE TABLE IF NOT EXISTS temporada(
	id_temporada INT PRIMARY KEY,
    titulo VARCHAR(45),
    descricao VARCHAR(100),
    id_serie INT,
    CONSTRAINT fk_serie FOREIGN KEY(id_serie) REFERENCES serie(id_serie)
);
CREATE TABLE IF NOT EXISTS epsodio(
	id_epsodio INT PRIMARY KEY,
    numero INT,
    id_catalogo INT,
    id_temporada INT,
    CONSTRAINT fk_catalogo_epsodio FOREIGN KEY(id_catalogo) REFERENCES catalogo(id_catalogo),
    CONSTRAINT fk_temporada FOREIGN KEY(id_temporada) REFERENCES temporada(id_temporada)
);
CREATE TABLE IF NOT EXISTS endereco(
	id_endreco INT PRIMARY KEY,
    numero SMALLINT,
    endereco VARCHAR(45), 
    cep CHAR(8),
    cidade VARCHAR(58),
    id_pais INT,
    CONSTRAINT fk_id_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);
    
CREATE TABLE IF NOT EXISTS funcionario(
	id_funcionario INT PRIMARY KEY,
    foto TINYBLOB
);

CREATE TABLE IF NOT EXISTS plano(
	id_plano INT PRIMARY KEY,
    valor FLOAT,
    descricao VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS cartao_credito(
	id_cartao INT PRIMARY KEY,
    numero VARCHAR(16),
    dt_nascimento DATE,
    cod_seguranca TINYINT,
    titulo VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS tipo_pagamento(
	id_tipo_pagamento INT PRIMARY KEY,
    nome VARCHAR(45)
);
CREATE TABLE IF NOT EXISTS cliente(
	id_cliente INT PRIMARY KEY,
    nickname VARCHAR(32),
    dt_vencimento DATE,
    id_plano INT,
    CONSTRAINT fk_id_plano FOREIGN KEY (id_plano) REFERENCES plano(id_plano)
);

CREATE TABLE IF NOT EXISTS pagamento(
	id_pagamento INT PRIMARY KEY,
    valor FLOAT,
    forma_pagamento VARCHAR(20),
    id_cliente INT,
    id_cartao INT,
    id_tipo_pagamento INT,
    CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	CONSTRAINT fk_id_cartao FOREIGN KEY (id_cartao) REFERENCES  cartao_credito(id_cartao),
    CONSTRAINT fk_id_tipo_pagamento FOREIGN KEY (id_tipo_pagamento) REFERENCES tipo_pagamento(id_tipo_pagamento)
);

CREATE TABLE IF NOT EXISTS perfil(
	id_perfil INT PRIMARY KEY,
    foto BLOB,
	nome VARCHAR(32),
    tipo ENUM('perfil infantil', 'perfil adulto'),
    id_cliente INT,
    CONSTRAINT fk_id_cliente_perfil FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE IF NOT EXISTS usuario(
	id_usuario INT PRIMARY KEY,
    nome VARCHAR(32),
    sobrenome VARCHAR(45),
    senha VARCHAR(32),
    data DATE,
    email VARCHAR(100),
    status VARCHAR(45),
    avaliacao ENUM('1','2','3','4','5'),
    dt_nascimento DATE,
    dt_cadastro DATE DEFAULT(CURDATE()),
    id_cliente INT,
    id_funcionario INT,
    id_endereco INT,
	CONSTRAINT fk_id_cliente_usuario FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_id_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario), 
    CONSTRAINT fk_id_endereco FOREIGN KEY (id_endereco) REFERENCES endereco(id_endreco)
);

