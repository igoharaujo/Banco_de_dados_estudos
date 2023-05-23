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
    
    
    #correção atualizadno a quantidade do produto de acordo com as vendas feitas
DELIMITER $$
CREATE TRIGGER tr_venda
after insert
ON tb_venda
FOR EACH ROW

	BEGIN
		UPDATE tb_produto SET quantidade = (quantidade - new.qtd_comprada) WHERE id = new.id_produto;

    END $$
     
DELIMITER ;



     SELECT * FROM TB_PRODUTO;
     
INSERT INTO tb_venda
	(id_produto, qtd_comprada)
VALUES
	(1,4);
    
    #----------------- EXTORNO DA COMPRA
    
    DELIMITER $$
    CREATE TRIGGER tr_delete_atualiza_estoque
    after delete
    ON tb_venda
    fOR each row 
    BEGIN 
		update TB_PRODUTO set quantidade = (quantidade + OLD.qtd_comprada)
        where ID = ld.ID_PRODUTO;
    

    END $$
    DELIMITER ;
    DELETE FROM tb_venda WHERE id = 1;
    
    #----------------- UPDATE
    
    DELIMITER $$
    CREATE TRIGGER tr_atualiza_estoque
    after UPDATE
    ON tb_venda
    fOR each row 
    BEGIN 
		update TB_PRODUTO set quantidade = (quantidade + (OLD.qtd_comprada - NEW.qtd_comprada))
        where ID = new.ID_PRODUTO;
    

    END $$
    DELIMITER ;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    drop trigger tr_extorno;
select * from tb_produto;
     

     
     

     
     
     
     
     
     
     
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

























