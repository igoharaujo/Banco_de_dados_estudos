



#1) Criar uma constraint que garanta que o valor do NUMERO da tabela PEDIDO esteja entre, inclusive, 1 e 99999.

	ALTER TABLE pedido
	ADD CONSTRAINT chk_numero_
	CHECK (numero_pedido BETWEEN 1 AND 99999);
    
    
#2) Criar os indexes das tabelas PF e PJ. Estes indexes serão únicos e utilizados como listas invertidas.

#Índexe para a tabela PF:
CREATE UNIQUE INDEX idx_pf_cnpf ON pf (CNPF);

#Índice para a tabela PJ
CREATE UNIQUE INDEX idx_pj_cnpj ON pj (CNPJ);

CREATE UNIQUE INDEX idx_pj_nome_fantasia ON pj (NOME_FANTASIA);


#3) Criar uma sequence de nome SEQ_ITEM_ID para o campo CODIGO de ITEM_PRODUTO, com incremento de 2.

-- Criação da sequência
  CREATE SEQUENCE seq_item_id
	  START WITH 1
	  INCREMENT BY 2
	  NOMAXVALUE
	  NOCYCLE;
