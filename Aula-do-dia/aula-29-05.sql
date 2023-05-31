 # mysqlserver8.0
     
     
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
     
      #BACKUP FULL de tudo da database -------------------------------------------------------------------------------
     # caminho C:\xampp\mysql\bin>mysqldump -u root -p db_familia > c:\backup\DumpFullDb_familia29052023.sql
     #o caminho ate o bin, mysqdump: e o comando para o backup -u root -p db_famili: a database que eu quero fazer o backup e > onde eu vou salvar o backup;
     #DumpFullDb_familia29052023.sql - esse final é o nome do arquivo, o mais detalhado possivel
     
	# para fazer o backup das trigges, routines (procedure, function...) fazemos dessa forma:
	# mysqldump -u root -p --routines --triggers db_discoteca2 > c:\backup\DumpFulldb_discoteca229052023.sql
    
    
    #BACKUP DOS DADOS--------------------------------------------------------------------------------------
		#C:\xampp\mysql\bin>mysqldump -u root -p --no-create-info db_discoteca2 > c:\backup\DumpOnlydb_discoteca229052023.sql
     
	#BACKUP DA ESTRUTURA-----------------------------------------------------------------------------------
		#C:\xampp\mysql\bin>mysqldump -u root -p --routines --triggers --no-data db_discoteca2 > c:\backup\DumpNo_datadb_discoteca229052023.sql
     
	# -- BACKUP CONSCISTENTE(caso falhe no meio o backup é cancelado)-------------------------------------------
		#mysqldump -u root -p --single-transaction --routines --triggers db_discoteca2 > c:\backup\Dumpfull_transactiondb_discoteca229052023.sql # -- routines são as procedures e functions
        --  ESSE É O IDEAL PARA FAZER BACKUP, 
        -- O parametro: --complete-insert salva os insert tambem
        
	#para recuperar o backup:-----------------------------------------------------------------------------
    -- primeiro eu vou criar a database e em seguida vou colocar esse comando:
    #C:\xampp\mysql\bin>mysql -u root -p db_discoteca2 < c:\backup\Dumpfull_transactiondb_discoteca229052023.sql
    #o que mudou foi que coloquei o < e o caminho de onde esta o buckup
    
    
    
    #-----------------------------------------------------------------AULA-30-05 -----------------------------------------------------------
#Como identificar um erro no backup, usamos o seguinte parametro:
	
	#mysqldump -u root -p --all databases verbose > c:\backup\servidor\servidor.sql
        
	#comando para o apagar todas as datasbases 
     
     
    
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#-----------------------------------------------------------------------USUÁRIOS e PRIVILÉGIOS------------------------------------------------------------------------#
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------#

-- Usuarios, são todos os indivíduos que possam se concetat no servidor
-- Privilégios: são as permissões
-- O privilégios para trabalhar com os dados são:
	-- -insert
    -- -update
    -- -delete
    -- -select
    -- -execute - (procedimentos e funções) a pessoa tem o privilegio de executa as procedures
    
 #-------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
-- privilegios para modificar a estruturas:
	-- -create
    -- -alter
    -- -drop
    -- -views
    -- -trigger
    -- -index (select) esta pesquisando pelo o banco o select, quando coloco o index ele ajudar a achar oq que quero mais rapidos, os filtros
    -- -routine 
    
-- Privilégio administrativos
	-- -create user
    -- -show database
    -- -shotdown (ligar)
    -- -reload
    
-- privilégio adicional
	-- -all            ---------------- TODOS OS PREVILEGIOS
    -- -grant option   ---------------- ATRIBUIR PRIVILEGIOS A OUTRO
    -- -usage		   ---------------- NÃO ALTERA PRIVILEGIOS, ESTE É O PADRÃO PRA NOVOS USUARIOS
    
   
    #NIVEIS DE PRIVILEGIOS
		#Global - acesso a todas as tabelas de todos os bancos
        #Database - acesso a tabelas de bancode de dados especificos
        #table - acesso a todas as colunas de tabelas especificas
        #Column - acesso apenas a colunas especificas de uma tabela
   
   
   #DCL - DATA CONTROL LENGUAGE
		#GRANT - Atribuir privilegios
        #REVOKE - Remover privilegios
    
#criando ususarios e dando privilegios: -------------------------------------------------------------------------

	#para criar o usuario: 	CREATE USER nome@local IDENTIFIED BY senha;
		-- CREATE USER 'igor'@'localhost' IDENTIFIED BY '1234';
        
	#Para dar previlegios de administrador:
		-- GRANT ALL PRIVILEGES ON *.* TO 'igor'@'localhost' WITH GRANT OPTION;
        
    #Para dar o privilegio: GRANT privilegios ON banco.tabela TO usuario@local;
		-- GRANT ALL PRIVILEGES ON *.* TO 'igor'@localhost;
		-- GRANT SELECT, INSERT, UPDATE, DELETE ON db_discoteca2.* TO 'igor'@localhost; Aqui estou concedendo, o privilegio de fazer select insert... na database db_discoteca em todas as tabelas
        
	#Dando o privilegio de quais select vai aparecer para o usuario
		-- tb_historico grant select (id, nome, id_mae) on db_familia.tb_filho to 'luciano'@'localhost'; nesse caso o usuario so poderá ver o id, nome, e o id_mae
        
	#Para dar o previlegio de procedure:
		-- GRANT EXECUTE ON PROCEDURE sp_insert_pai TO 'igor'@'localhost';
        
    #Para remover: REVOKE privilegios ON banco.tabela FROM usuario@local;
		-- REVOKE update, delete ON db_familia.* FROM 'igor'@localhost;
	
    
#vendo os usuarios e os previlegios----------------------------------------------------------------------------
    
	#para ver os usuario:
		-- SELECT User, Host FROM mysql.user;
        
    #Para ver os previlegios do usuario:
		/* SHOW GRANTS FOR 'igor'@localhost;.
+-------------------------------------------------------------------------------------------------------------+
| Grants for igor@localhost                                                                                   |
+-------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `igor`@`localhost` IDENTIFIED BY PASSWORD '*A4B6157319038724E3560894F7F932C8886EBFCF' |
+-------------------------------------------------------------------------------------------------------------+
1 row in set (0.000 sec)*/ 
		# *.* Significa que o usuario tem acesso a todas as databases e todas as tabelas, a primeira * representa as databases e a segunda * a todas as tabelas

    
    #-----------------------------------------------------------------------------Aula 31-05-23---------------------------------------------------------------
    
    
    oi
    oi
    
    show grants for 'igor'@localhost;
    
    REVOKE SELECT, INSERT, UPDATE, DELETE ON db_familia.tb_filho FROM 'igor'@localhost;
    
   tb_historico grant select (id, nome, id_mae) on db_familia.tb_filho to 'luciano'@'localhost';