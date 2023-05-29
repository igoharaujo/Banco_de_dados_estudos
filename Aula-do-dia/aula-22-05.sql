#trigge: procedimento que desencadeia uma ação, como o procedimento pode fazer qualquer coisa
# new: estado novo depois, como ficara, que vai aconter, O INSERT é new pois serao dados que vimrao exister
#old: a forma antiga, exemplo DELETE: o dado ja existia, o UPDATE são as duas situações, ja que tem os dados antigos antes de atualizar e o depois de atualizar
#

USE db_familia;

#CRIANDO UMA TRIGGER, usado para rotina e procedimento


#primeiro vamos criar uma tabela: para indentificar o historico desenvovedores que fizeram o insert na tabela pai
CREATE TABLE tb_historico(
	id int PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(255) NOT NULL,
    acao CHAR(6) NOT NULL,
    data DATETIME NOT NULL,
    `table` VARCHAR(255) NOT NULL
)AUTO_INCREMENT = 1;


#A qui criamos o tigger, para toda vez que for inserido um novo pai na tabela seja identificado a hora, a data, e o nome do usuario que inserio
DELIMITER $$
CREATE TRIGGER tr_insert_pai
AFTER INSERT     #AFTER: depois da acao, BEFOR: depois da acao
ON tb_pai
FOR EACH ROW     #para cada linha, ou: para cada registro da tabela varificamos se houve um insert la

	BEGIN
    INSERT INTO tb_historico
		(usuario, acao, `table`, data)
	VALUES
		(current_user(), 'INSERT', 'tb_pai', now());
    
    END $$
DELIMITER ;



insert into tb_pai
	(nome)
values
	('triggernilson');


select * from tb_historico;

#--------------------------------------------------------------


drop trigger if exists tr_update_pai;
DELIMITER $$
CREATE TRIGGER tr_update_pai
before update   #AFTER: depois da acao, BEFOR: depois da acao
ON tb_pai
FOR EACH ROW     #para cada linha, ou: para cada registro da tabela varificamos se houve um insert la

	BEGIN
    INSERT INTO tb_historico
		(usuario, acao, `table`, data, nome_antigo, novo_nome)
	VALUES
		(current_user(), 'UPDATE', 'tb_pai', now(), OLD.nome, NEW.nome);
    
    END $$
DELIMITER ;



UPDATE tb_pai set nome = 'ig'
where id = 3006;

select * from tb_historico;

ALTER TABLE TB_HISTORICO 
ADD NOME_ANTIGO VARCHAR(255),
ADD NOVO_NOME VARCHAR(255);




#-------------------------------------



drop trigger tr_delete_pai;

DELIMITER $$
CREATE TRIGGER tr_delete_pai
before DELETE    #AFTER: depois da acao, BEFOR: depois da acao
ON tb_pai
FOR EACH ROW     #para cada linha, ou: para cada registro da tabela varificamos se houve um insert la

	BEGIN
    INSERT INTO tb_historico
		(usuario, acao, `table`, data)
	VALUES
		(current_user(), 'DELETE', 'tb_pai', now());
    
    END $$
DELIMITER ;


delete from tb_pai where id = 1;


#-------------------------------------------------------------------------------23-05-20223
create database if not exists db_loja
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

use db_loja;


CREATE TABLE IF NOT EXISTS tb_produto(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    preco FLOAT,
    quantidade INT
);

CREATE TABLE IF NOT EXISTS tb_venda(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    qtd_comprada INT NOT NULL,
    CONSTRAINT fk_id_produto FOREIGN KEY (id_produto) REFERENCES tb_produto(id));

CREATE TABLE IF NOT EXISTS tb_extorno(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT NOT NULL,
    qtd_extornada INT NOT NULL,
    CONSTRAINT fk_id_venda FOREIGN KEY (id_venda) REFERENCES tb_venda(id));


INSERT INTO tb_produto
	(nome, preco, quantidade)
VALUES
	('iphone', '14.999', 55),
    ('Playstation 5', '4999.99',100),
    ('Xbox x', '4680.99', 10);
    
    update tb_produto set quantidade = 50 where id = 1;
    

    
    #----------------- EXTORNO DA COMPRA
    drop trigger tr_delete_atualiza_estoque;
    DELIMITER $$
    CREATE TRIGGER tr_delete_atualiza_estoque
	BEFORE DELETE
    ON tb_venda
    fOR each row 
    BEGIN 
		CASE 
			WHEN EXISTS (SELECT id FROM tb_produto WHERE id = OLD.id_produto) THEN
				update TB_PRODUTO set quantidade = (quantidade + OLD.qtd_comprada)
				where ID = Old.ID_PRODUTO;
			ELSE
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não foi possivel realizar o extorno';
		END CASE;
    END $$
    DELIMITER ;
    
    
    delete from tb_venda WHERE id = 100;
    #-----------------  Venda 
    
    
    
    
    #----------------- correção de da venda
    DELIMITER $$
    CREATE TRIGGER tr_atualizar_estoque
    AFTER UPDATE
    ON tb_venda 
    FOR EACH ROW
    BEGIN
		DECLARE valida_estoque INT;
        DECLARE estoque_atual INT;
        SELECT quantidade + (OLD.qtd_comprada - NEW.qtd_comprada) INTO valida_estoque FROM tb_produto WHERE id = new.id_produto;
        SELECT quantidade INTO estoque_atual FROM tb_produto WHERE id = new.id_produto;
        
		IF valida_estoque < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantidade em estoque insuficiente';
        ELSEIF valida_estoque = estoque_atual THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A quantidade nova, é igual a anterior';
        ELSE 
			UPDATE tb_produto SET quantidade = (quantidade +(OLD.qtd_comprada - NEW.qtd_comprada))
            WHERE id = new.id_produto;
		END IF;
        
	END $$
    DELIMITER ;
    
    
    
    
    
    
    
    
    
    DELETE FROM tb_venda WHERE id = 1;
    
   
     
     
	#-----------------------------------------------------aula 29-05-----------------------------------------
    
     #para entrar no servidor do mysql usamos esse caminho:
     # mysql -u root -p
     # -u: user de usuario
     # -p: senha de senha en ingles
     
     -- agora vamos entrar nos comando do mysql
     # show status; mostra tudo que esta ativo
     # show databases;
     
     #-------------------------------------------------------backup ou Damp--------------------------------------------
     
     
     -- tipos de backup:-----------
     # full - completo
     #diferencial - a diferença de um backup para outro
     #dados - somentes os dados
     #ddl - o de estrutura
     -- ----------------------------
     
      #BACKUP FULL de tudo -------------------------------------------------------------------------------
     # caminho C:\xampp\mysql\bin>mysqldump -u root -p db_familia > c:\backup\DumpFullDb_familia29052023.sql
     #o caminho ate o bin, mysqdump: e o comando para o backup -u root -p db_famili: a database que eu quero fazer o backup e > onde eu vou salvar o backup;
     #DumpFullDb_familia29052023.sql - esse final é o nome do arquivo, o mais detalhado possivel
     
	# para fazer o backup das trigges, routines (procedure, function...) fazemos dessa forma:
	# mysqldump -u root -p --routines --triggers db_discoteca2 > c:\backup\DumpFulldb_discoteca229052023.sql
    
    
    #BACKUP DOS DADOS--------------------------------------------------------------------------------------
		#C:\xampp\mysql\bin>mysqldump -u root -p --no-create-info db_discoteca2 > c:\backup\DumpOnlydb_discoteca229052023.sql
     
	#BACKUP DA ESTRUTURA-----------------------------------------------------------------------------------
		#C:\xampp\mysql\bin>mysqldump -u root -p --routines --triggers --no-data db_discoteca2 > c:\backup\DumpNo_datadb_discoteca229052023.sql
     
	#BACKUP CONSCISTENTE(caso falhe no meio o backup é cancelado)-------------------------------------------
		#mysqldump -u root -p --single-transaction --routines --triggers db_discoteca2 > c:\backup\Dumpfull_transactiondb_discoteca229052023.sql
        
	#para recuperar o backup:-----------------------------------------------------------------------------
    -- primeiro eu vou criar a database e em seguida vou colocar esse comando:
    #C:\xampp\mysql\bin>mysql -u root -p db_discoteca2 < c:\backup\Dumpfull_transactiondb_discoteca229052023.sql
    #o que mudou foi que coloquei o < e o caminho de onde esta o buckup

        
     
     
     
     
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

























