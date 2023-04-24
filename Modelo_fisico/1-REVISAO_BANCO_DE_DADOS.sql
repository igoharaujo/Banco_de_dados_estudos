-- AULA 1 - CRIANDO BASE DE DADOS E TABELAS

CREATE DATABASE IF NOT EXISTS db_game # CREATE DATABASE: cria uma base de dados, 
									  # IF NOT EXISTS: esse comando impede a criação de outra base de dados com o mesmo nome.
COLLATE utf8mb4_general_ci # COLLATE: comando para puxar o padrão da linguagem
CHARSET utf8mb4; #CHARSER: é usado para especificar o conjunto de caracteres que será utilizado, que fui puxado pelo collate.

USE db_game; # USE: comando usado para usarmor a base de dados.

CREATE TABLE IF NOT EXISTS tb_jogo( # CREATE TABLE: usado para criar tabela
	id_jogo INT NOT NULL PRIMARY KEY,
    nome VARCHAR(35) NOT NULL,
    CONSTRAINT uq_nome_tb_jogo UNIQUE(nome) # CONSTRAINT: é uma restrição de integridade, UNIQUE(): para indicar que o atributo é unico 
);

CREATE TABLE IF NOT EXISTS tb_console(
	id_console INT NOT NULL PRIMARY KEY,
    nome VARCHAR(35) NOT NULL,
    CONSTRAINT uq_nome_tb_console UNIQUE(nome)
);

CREATE TABLE IF NOT EXISTS tb_jogo_console(
	id_jogo INT NOT NULL,
    id_console INT NOT NULL,
    CONSTRAINT fk_id_jogo FOREIGN KEY(id_jogo) REFERENCES tb_jogo(id_jogo), # Esse comando é usado para definir a chave estrangerira
    CONSTRAINT fk_id_console FOREIGN KEY(id_console) REFERENCES tb_console(id_console),
    PRIMARY KEY(id_jogo, id_console) # assim definimos uma chave composta.
);
DROP TABLE tb_jogo_console; # DROP: Apaga algo, seja em uma DATABASE ou uma TABLE
DROP TABLE tb_jogo;
DROP TABLE tb_console;

# ---------------------------------------------------------------------------------------------------------------------
-- AULA 2 INSERINDO VALORES

# Aqui vamos colocar os valores dos consoles que temos:
INSERT INTO tb_console # INSERT INTO: comando de inserir dados
    (id_console, nome) # aqui colocamos em quais linhas vamos inserir os dados
VALUES # VALUES: Usamos para colocar o valor de "id_console" e "nome" nessa ordem
    (1, 'Nitendo'),
    (2, 'Xbox'),
    (3, 'Xbox one'),
    (4, 'Playstation 3'),
    (5, 'Playstation 5');
    
# Aqui vamos inserir os valores dos jogos, id do jogo e nome do jogo
INSERT INTO tb_jogo
    # Aqui não colocamos as linha pois vamos usar todas as linha da table na ordem que criamos anteriomente
VALUES
    (1, 'Super Mario'), (2, 'The legend of'), (3,'Pokémon'), -- nitento
    (4,'Halo'), (5,'Gears of War'), (6, 'Forza Horizon'), -- xbox
    (7,'Sunset Overdrive'), (8,'Quantum Break'), (9, 'Ryse'), -- xbox one
    (10,'The Last of Us'), (11,'Uncharted 2'), (12, 'God of War III'), -- playstation 3
    (13,'Demons Souls'), (14,'Returnal'), (15, 'Ratchet & Clank'); -- playstation 5
    
INSERT INTO tb_jogo_console
    (id_console, id_jogo)
VALUES
    (1,1), (1,2),(1,3),
    (2,4), (2,5), (2,6),
    (3,7), (3,8), (3,9),
    (4,10), (4,11), (4,12),
    (5,13), (5,14), (5,15);
    
    SELECT * FROM tb_jogo_console; # SELECT * FROM: Quando usado, esse comando retorna todos os dados contidos em cada linha e coluna da tabela
    DESC tb_jogo_console; # DESCRIBE: usado para obter informações sobre a estrutura de uma tabela

SELECT * FROM tb_jogo_console;

# ---------------------------------------------------------------------------------------------------------------------

-- AULA 3 ALTERAÇÕES

/*O comando "ALTER" é utilizado em bancos de dados para realizar alterações na estrutura de uma tabela já existente.
 Existem várias possibilidades de alterações que podem ser feitas, como adicionar ou remover colunas, 
 alterar o tipo de dados de uma coluna, modificar índices, etc. */
 
 DESC tb_jogo;
 DESC tb_console;
 SELECT * FROM tb_console;
 SELECT * FROM tb_jogo;
 SELECT * FROM tb_jogo_console;
 
 #1-VAMOS ALTERAR A TABELA JOGO ACRESCETANDO A COLUNA ANO DE LANÇAMENTO
 ALTER TABLE tb_jogo #Ultilizamos o comando ALTER TABLE para alterar a tabela
 ADD COLUMN ano_lancamento YEAR NOT NULL DEFAULT '2000'; /*Em seguida ultilizamos o comando ADD COLUMN e 
 o nome da nova coluna com as caracteristicas dela*/
 
 #2-AGORA VAMOS MODIFICAR A COLUNA CRIADA. OBS: MIDIFICAR A COLUNA NÃO SIGNIFICA MODIFICAR OS VALORES DA COLUNA.
 ALTER TABLE tb_jogo
 MODIFY ano_lancamento  YEAR NOT NULL; /*Aqui usei o comando MODIFY para retirar o DEFAULT "2000"
 se eu quisesse modificar a data eu usaria o comando UPDATE*/
 
 #2.1-O CAMANDO MODIFY ALTERA AS CARACTERISTICAS DA COLUNA MAS NÃO O NOME, PARA ALTERA O NOME FAZEMOS DA SEGUINTE FORMA:
 ALTER TABLE tb_jogo
 CHANGE ano_lancamento lancamento YEAR NOT NULL ; /*O comando CHANGE faz a mesma coisa que o modify com o acremento
 de mudar o nome*/
 
 #3-AGORA VAMOS APAGAR UMA COLUNA
 ALTER TABLE tb_jogo
 DROP COLUMN lancamento; #usamos o comando DROP para apagar a coluna.
 # ---------------------------------------------------------------------------------------------------------------------

-- AULA 4 USANDO O SELECT E APRENDENDO  OS COMANDOS AS, WHERE OR AND, BETWEEN, LIKE

#SELECT 
#01- CAMINHO TODO DO COMANDO SELECT:
SELECT tb_musica.nome, tb_musica.duracao FROM db_discoteca2.tb_musica;

#02- O COMANDO AS da um apelido temporario para a tabela, obs: "LIMIT 5" faz com que sejam mostrados apenas 5 registros
SELECT nome AS musica, duracao AS tempo FROM tb_musica LIMIT 5; -- nesse exemplo trocamos o nome "nome" e "duracao" para "musica" e "tempo"

#03- Assim como fizemos a cima vamos usar o AS para da um apelido temporario para as tabelas musica e jogo.
SELECT nome AS musica, duracao AS tempo FROM tb_musica AS c, tb_jogo AS j;

#------------ # ----------
#WHERE 

#01- Explicação do comando: selecione todos os registros da tabela tb_artista onde id é igual a 100000		# < MENOR QUE | <= MENOR OU IGUA
SELECT * FROM tb_artista																					# > MAIOR QUE | >= MAIOR OU IGUAL
WHERE id = 100000; 																							# != ou <> DIFERENTE QUE
	# '*' essa estrela faz com que todos os registros sejam mostrados										
	# "WHERE" colocamos where e em seguida o comando para ele mostrar apenas o que foi especificado

#02- Queremos que todos os registros que tenham o id menor que 10 seja mostrado
SELECT * FROM tb_artista 
WHERE id < 10; #Assim como na programção usamos o simbolo '<' para menor que (10 < menor 11) e '>' para maior que (10 >maior 9)

#03- Vamos pedir para mostrar registros cuja a dt_nascimento sejam diferentes de '0000-00-00'
SELECT * FROM tb_artista 
WHERE dt_nascimento != '0000-00-00'; # nesse caso poderiamos usar o comando != ou <> os dois são a mesma coisa.alter

#04- comando IN 
SELECT * FROM tb_artista 
WHERE dt_nascimento IN ("1993-09-09", "1997-09-23");
	/* IN: (colamos as datas de nascimento dos registros que serão mostrados)
ele mostrara somente os registros das datas que estão dentro parentes*/

#------------ # ----------

#OR, AND, BETWEEN, NOT BETWEEN

#01- Aqui mostrará os registros com id_tipo_artista igual a 2 OU igual a 10 
SELECT * FROM tb_artista 
WHERE id_tipo_artista = 2 OR id_tipo_artista = 10; 

SELECT * FROM tb_artista 
WHERE id_tipo_artista = 2 OR dt_nascimento >= '2000-01-01';

#02- Aqui mostrará os registros com duracao >= '00:03:00' e <='00:05:00 
SELECT * FROM tb_musica
WHERE duracao >= '00:03:00' AND duracao <= '00:05:00' LIMIT 1000; 

#03- BETWEEN é usado para mostrar os valores entre '00:03:00' e '00:05:00, poderiamos dizer que aqui ele substitui o >= e <=
SELECT * FROM tb_musica
WHERE duracao BETWEEN '00:03:00' AND  '00:05:00' LIMIT 1000; 

#04- O 'not' vai inverter o resultado, ou seja, ele vai mostra todos que não seja entre '00:06:00' AND '00:09:00'
SELECT * FROM tb_musica 
WHERE duracao NOT BETWEEN '00:06:00' AND '00:09:00' 
limit 1000;

#05- uma outra forma de utilizamos os tres comandos:
SELECT * FROM tb_musica
WHERE (duracao BETWEEN '00:03:00' AND  '00:05:00') OR (duracao BETWEEN '00:09:00' AND  '00:012:00') LIMIT 1000;

#----------- # ----------

#LIKE: BUSQUE o que for parecido (apenas para string)

#01- Com as letras: 'jim' mais o simbulo '%' queremos dizer para ele procura um nome que comece com jin
SELECT * FROM tb_musica 
WHERE nome LIKE 'jin %' LIMIT 1000; # usamos o % quando e não sei os resto do nome
									# Se invertermos e colocarmos o '%' em primeiro '%jim', ai ele vai entender que as tres ultimas letras é 'jim'
                                    # %ss%' estarei pequisando a string 'ss' em qualquer lugar em minha tabela
                                    
#02- Para mostrar os nomes que têm a letra 'a' na segunda posição usamos:
SELECT * FROM tb_musica
WHERE nome LIKE '_a%' LIMIT 1000; # caso quisessemos que fosse mostrado o 'a' na terceira posição colocariamos mais um underline: '__a%'
								  #  para achar as ultimas finais eu faço ao contrario: 'a%__'


 




