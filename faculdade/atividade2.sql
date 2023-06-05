
CREATE TABLE departamento(
	dnumero INTEGER PRIMARY KEY,
	dnome CHARACTER VARYING(45),
	cpf_gerente CHARACTER VARYING(11),
	data_inicio_gerente DATE);
	
CREATE TABLE funcionario (
    cpf CHARACTER VARYING(11),
    cpf_supervisor CHARACTER VARYING(11),
    pnome CHARACTER VARYING(45),
    minicial CHARACTER VARYING(45),
    datanasc DATE,
    endereco CHARACTER VARYING(50),
    sexo CHARACTER(1) CHECK (sexo IN ('f', 'm')),
    salario DOUBLE PRECISION,
    dnr INTEGER,
    CONSTRAINT uq_cpf_supervisor UNIQUE(cpf_supervisor),
    FOREIGN KEY (cpf_supervisor) REFERENCES funcionario(cpf_supervisor),
	FOREIGN KEY (dnr) REFERENCES departamento(dnumero),
    PRIMARY KEY (cpf));

CREATE TABLE dependente(
	Nome_dependente CHARACTER VARYING(45) PRIMARY KEY,
	sexo CHAR(1) CHECK (sexo IN ('f', 'm')),
	datanasc DATE,
	parentesco CHARACTER VARYING(10),
	fcpf CHARACTER VARYING(11),
	FOREIGN KEY(fcpf) REFERENCES funcionario(cpf));

CREATE TABLE localizacoes_dep(
	dnumero INTEGER,
	dlocal INTEGER PRIMARY KEY,
	FOREIGN KEY(dnumero) REFERENCES departamento(dnumero));

CREATE TABLE projeto(
	projnumero INTEGER PRIMARY KEY,
	projnome CHARACTER VARYING(45),
	projlocal CHAR(20),
	dnum INTEGER,
	FOREIGN KEY (dnum) REFERENCES departamento(dnumero));

CREATE TABLE trabalha_em(
	fcpf CHARACTER VARYING(11),
	pnr INTEGER,
	hora TIME,
	FOREIGN KEY(fcpf) REFERENCES funcionario(cpf),
	FOREIGN KEY(pnr) REFERENCES projeto(projnumero));
	
	
-- ------------------------------------------------------------------------------

-- Inserção de registros na tabela departamento
INSERT INTO departamento
VALUES
    (1, 'Departamento 1', '11111111111', '2022-01-01'),
    (2, 'Departamento 2', '22222222222', '2022-02-01'),
    (3, 'Departamento 3', '33333333333', '2022-03-01'),
    (4, 'Departamento 4', '44444444444', '2022-04-01'),
    (5, 'Departamento 5', '55555555555', '2022-05-01'),
    (6, 'Departamento 6', '66666666666', '2022-06-01'),
    (7, 'Departamento 7', '77777777777', '2022-07-01'),
    (8, 'Departamento 8', '88888888888', '2022-08-01'),
    (9, 'Departamento 9', '99999999999', '2022-09-01'),
    (10, 'Departamento 10', '10101010101', '2022-10-01');

-- Inserção de registros na tabela funcionario
INSERT INTO funcionario 
VALUES
    ('11111111111', '11111111111', 'Funcionario 1', 'F1', '2000-01-01', 'Endereco 1', 'm', 1000.00, 1),
    ('22222222222', '22222222222', 'Funcionario 2', 'F2', '2000-02-02', 'Endereco 2', 'f', 2000.00, 1),
    ('33333333333', '33333333333', 'Funcionario 3', 'F3', '2000-03-03', 'Endereco 3', 'm', 3000.00, 2),
    ('44444444444', '44444444444', 'Funcionario 4', 'F4', '2000-04-04', 'Endereco 4', 'f', 4000.00, 2),
    ('55555555555', '55555555555', 'Funcionario 5', 'F5', '2000-05-05', 'Endereco 5', 'm', 5000.00, 3),
    ('66666666666', '66666666666', 'Funcionario 6', 'F6', '2000-06-06', 'Endereco 6', 'f', 6000.00, 3),
    ('77777777777', '77777777777', 'Funcionario 7', 'F7', '2000-07-07', 'Endereco 7', 'm', 7000.00, 4),
    ('88888888888', '88888888888', 'Funcionario 8', 'F8', '2000-08-08', 'Endereco 8', 'f', 8000.00, 4),
    ('10101010101', '10101010101', 'Funcionario 10', 'F10', '2000-10-10', 'Endereco 10', 'f', 10000.00, 10);

-- Inserção de registros na tabela dependente
INSERT INTO dependente 
VALUES
    ('Dependente 1', 'm', '2005-01-01', 'Filho', '11111111111'),
    ('Dependente 2', 'f', '2007-02-02', 'Filha', '11111111111'),
    ('Dependente 3', 'm', '2009-03-03', 'Filho', '22222222222'),
    ('Dependente 4', 'f', '2011-04-04', 'Filha', '22222222222'),
    ('Dependente 5', 'm', '2013-05-05', 'Filho', '33333333333'),
    ('Dependente 6', 'f', '2015-06-06', 'Filha', '33333333333'),
    ('Dependente 7', 'm', '2017-07-07', 'Filho', '44444444444'),
    ('Dependente 8', 'f', '2019-08-08', 'Filha', '44444444444'),
    ('Dependente 9', 'm', '2021-09-09', 'Filho', '55555555555'),
    ('Dependente 10', 'f', '2023-10-10', 'Filha', '55555555555');
	
-- Inserção de registros na tabela localizacoes_dep
INSERT INTO localizacoes_dep 
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);

-- Inserção de registros na tabela projeto
INSERT INTO projeto 
VALUES
    (1, 'Projeto 1', 'Local 1', 1),
    (2, 'Projeto 2', 'Local 2', 2),
    (3, 'Projeto 3', 'Local 3', 3),
    (4, 'Projeto 4', 'Local 4', 4),
    (5, 'Projeto 5', 'Local 5', 5),
    (6, 'Projeto 6', 'Local 6', 6),
    (7, 'Projeto 7', 'Local 7', 7),
    (8, 'Projeto 8', 'Local 8', 8),
    (9, 'Projeto 9', 'Local 9', 9),
    (10, 'Projeto 10', 'Local 10', 10);

-- Inserção de registros na tabela trabalha_em
INSERT INTO trabalha_em
VALUES
    ('11111111111', 1, '08:00:00'),
    ('22222222222', 2, '09:00:00'),
    ('33333333333', 3, '10:00:00'),
    ('44444444444', 4, '11:00:00'),
    ('55555555555', 5, '12:00:00'),
    ('66666666666', 6, '13:00:00'),
    ('77777777777', 7, '14:00:00'),
    ('88888888888', 8, '15:00:00'),
    ('10101010101', 10, '17:00:00');
	
	
	
	
	
	
-- Confirme as inserções
SELECT * FROM departamento;
SELECT * FROM funcionario;
SELECT * FROM dependente;
SELECT * FROM localizacoes_dep;
SELECT * FROM projeto;
SELECT * FROM trabalha_em;


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	




