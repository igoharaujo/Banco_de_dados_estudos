use db_familia;


desc tb_mae;

select * from tb_pai;

DELIMITER $$
CREATE PROCEDURE sp_insert_mae(nome_mae VARCHAR(255))
BEGIN
	INSERT INTO tb_mae
		(nome)
	VALUES
		(nome_mae);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_delete_mae(cod_mae INT)
BEGIN
	delete from tb_mae
    where id = cod_mae;
END $$
DELIMITER ;

call sp_delete_mae(2504);


select * from tb_mae
where nome = 'monica';



DELIMITER $$
CREATE FUNCTION  fn_acento(texto VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	SET texto = 	
     texto = REPLACE(texto, 'á', 'a'),
 	 texto = REPLACE(texto, 'à', 'a'),
     texto = REPLACE(texto, 'â', 'a'),
     texto = REPLACE(texto, 'ã', 'a'),
     texto = REPLACE(texto, 'ä', 'a'),
     texto = REPLACE(texto, 'Á', 'A'),
	 texto = REPLACE(texto, 'À', 'A'),
     texto = REPLACE(texto, 'Â', 'A'),
     texto = REPLACE(texto, 'Ã', 'A'),
     texto = REPLACE(texto, 'Ä', 'A'),
     texto = REPLACE(texto, 'é', 'e'),
     texto = REPLACE(texto, 'è', 'e'),
     texto = REPLACE(texto, 'ê', 'e'),
     texto = REPLACE(texto, 'ë', 'e'),
     texto = REPLACE(texto, 'É', 'E'),
     texto = REPLACE(texto, 'È', 'E'),
     texto = REPLACE(texto, 'Ê', 'E'),
     texto = REPLACE(texto, 'Ë', 'E'),
     texto = REPLACE(texto, 'í', 'i'),
     texto = REPLACE(texto, 'ì', 'i'),
     texto = REPLACE(texto, 'î', 'i'),
     texto = REPLACE(texto, 'ï', 'i'),
     texto = REPLACE(texto, 'Í', 'I'),
     texto = REPLACE(texto, 'Ì', 'I'),
     texto = REPLACE(texto, 'Î', 'I'),
     texto = REPLACE(texto, 'Ï', 'I'),
     texto = REPLACE(texto, 'ó', 'o'),
     texto = REPLACE(texto, 'ò', 'o'),
     texto = REPLACE(texto, 'ô', 'o'),
     texto = REPLACE(texto, 'õ', 'o'),
     texto = REPLACE(texto, 'ö', 'o'),
     texto = REPLACE(texto, 'Ó', 'O'),
     texto = REPLACE(texto, 'Ò', 'O'),
     texto = REPLACE(texto, 'Ô', 'O'),
     texto = REPLACE(texto, 'Õ', 'O'),
     texto = REPLACE(texto, 'Ö', 'O'),
     texto = REPLACE(texto, 'ú', 'u'),
     texto = REPLACE(texto, 'ù', 'u'),
     texto = REPLACE(texto, 'û', 'u'),
     texto = REPLACE(texto, 'ü', 'u'),
     texto = REPLACE(texto, 'Ú', 'U'),
     texto = REPLACE(texto, 'Ù', 'U'),
     texto = REPLACE(texto, 'Û', 'U'),
     texto = REPLACE(texto, 'Ü', 'U'),
     texto = REPLACE(texto, 'ç', 'c'),
     texto = REPLACE(texto, 'Ç', 'C');
    
RETURN texto;
END $$
DELIMITER ;


drop function fn_acento;



#------------------------------------------------------------------------- CONDICIONAIS ----------------------------------------------------------------------
-- A função if() me permite receber tres parametros
SELECT IF(5 > 10, 'Verdadeiro', 'Falso' ); -- 5 > 10 se o resutado for verdaderiro entao ele mostrara 'verdadeiro' se for falso ele mostrará: 'Falso'

set @idade = 18; -- para criar variavel fora de funcão eu coloco o SET e o @ antes
SELECT IF(@idade >= 18, 'maior de idade', 'menor de idade' ) as idade;

#utilizando a função IF()
SELECT
	nome,
    dt_nascimento,
    if(dt_nascimento != '0000-00-00', 'artista solo', 'outras categorias') as categoria
    FROM tb_artista;

#utilizanod em uma procedure
-- usamos o if exists pra caso exista o parametro ele execute o delete, caso não existea o parametro ele executara o 'id invalido'
DELIMITER $$
CREATE PROCEDURE sp_del_gen(cod_gen INT)
BEGIN
	IF EXISTS (SELECT id FROM tb_genero WHERE id = cod_gen) THEN -- THEN: comparacao, usamos o than para fazer essa ligacao, ex: se existe faça: delete...
		DELETE FROM tb_genero where id = cod_gen;
    else 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Codigo de genero invalido' ; -- eu uso esse codigo para personar, eu preciso usar o cod: '45000' para funcionar
    end if;

END $$
DELIMITER ;


#------------------------------------------------------------------------- CASE ----------------------------------------------------------------------
#aula - 18-05
use db_familia;


select 
	id
	,nome
	, case # estrutara condicional parecido com os if, mas usado quando eu sei a quatidade
		when id_mae IS NULL THEN 'mãe não informada'
        else id_mae 
	  end as id_mae
	,case
    when id_pai IS NULL THEN 'pai não informado'
    else id_pai
    end as id_pai
 from tb_filho ;



SELECT f.nome as filho
		,f.id
        ,case
        WHEN f.id_mae IS NULL THEN 'sem mae'
        else m.nome
       end as mae
       , case
       when f.id_pai IS NULL THEN 'sem pai, o jovem é orfão'
       else p.nome
       end as pai
from tb_filho as f left JOIN tb_pai as p
ON f.id_pai = p.id left join tb_mae as m
ON m.id = f.id_mae;


desc tb_filho;

#como apagar o constraint
alter table tb_filho drop constraint fk_id_pai;
alter table tb_filho modify id_pai int null;


update tb_filho set id_pai = null
where id = 11;

alter table tb_filho drop constraint fk_id_mae;
alter table tb_filho MODIFY id_mae int null;

SELECT
	id
	,nome
    ,dt_nascimento
    , 
    CASE WHEN dt_nascimento = '0000-00-00' THEN 'OUTRO TIPO'
    ELSE TIMESTAMPDIFF(YEAR, dt_nascimento, CURDATE())
    end as idades
    ,CASE
    WHEN (TIMESTAMPDIFF(YEAR, dt_nascimento, CURDATE()))  < 18 THEN 'menor de idade'
    WHEN (TIMESTAMPDIFF(YEAR, dt_nascimento, CURDATE()))  >= 65 THEN 'idoso'
    WHEN (TIMESTAMPDIFF(YEAR, dt_nascimento, CURDATE())) >= 18 THEN 'maior de idade'
    ELSE 'INEXISTENTE'
    END AS 'FAIXA ETARIA'
    
    
    
    
FROM tb_artista;
	











# funções para trabalhar com string
#essa função mostra a qtd de caracteres que existem em uma string, ele contra inclusive o acento. 

select length(fn_acento('LUCÍANÓ'));
#remove os espaços
SELECT trim();
#Remove os espalos da direita
SELECT ltrim();
#remove os espeaços da direita
SELECT rtrim();





#
#













#