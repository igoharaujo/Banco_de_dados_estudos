create table if not exists tb_funcionario(
id int primary key auto_increment auto_increment,
nome varchar(255) NOT NULL
)auto_increment = 1; 


CREATE TABLE IF NOT EXISTS tb_horaio(
id INT PRIMARY KEY AUTO_increment,
horario DATETIME not null default now(),
id_funcionario INT NOT NULL,
CONSTRAINT fk_id_funcionario FOREIGN KEY(id_funcionario) REFERENCES tb_funcionario(id)
)AUTO_INCREMENT = 1;




INSERT INTO tb_funcionario
(nome)
VALUES
('Marcelo'),
('Luciano'),
('Fabricio');

INSERT INTO tb_horario
(horario, id_funcionario)
values
(default, 1),
(now(), 3);

update tb_horario set horario = '2023-05-08 08:14:54'
where id = 2;

select * from tb_horario;


CREATE VIEW vw_ponto_eletronico as
SELECT funcionario.id as id, funcionario.nome as funcionario, horario as horario
from tb_funcionario as funcionario INNER JOIN tb_horario as horario
ON funcionario.id = horario.id_funcionario;







