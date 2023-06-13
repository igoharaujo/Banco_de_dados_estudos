select * from tb_artista;
desc tb_tipo_artista;


INSERT INTO tb_gravadora
	(nome)
VALUES
	('Universal Music Group'),
	('Sony Music Entertainment'),
	('Warner Music Group'),
	('Atlantic Records'),
	('Capitol Records'),
	('Interscope Records'),
	('RCA Records'),
	('Def Jam Recordings'),
	('Island Records'),
	('Sub Pop Records');
    
INSERT INTO tb_genero
	(nome)
VALUES 
	('rap'),
	('Pop'),
	('Hip hop'),
	('Eletrônica'),
	('Jazz'),
	('Blues'),
	('País'),
	('Reggae');
    
INSERT INTO tb_tipo_artista
	(nome)
VALUES
	('Banda'), -- 1
	('Solo'), -- 2 
	('Dupla'), -- 3
	('Grupo'), -- 4
	('Conjunto'); -- 5
    
INSERT INTO tb_artista
	(nome, dt_nascimento, id_tipo_artista)
VALUES
	('7 minutoz',null,1), --  Bandas
    ('Os Paralamas do Sucesso',null,1),
	('Legião Urbana', null,1),
	('Titãs', null,1),
    
	('matue','1989/12/15',2), -- solo
	('Michael Jackson','1958/08/29',2),
	('Taylor Swift','1989/12/13',2),
	('marialia mendoza','1989/12/17',2),
    
    ('Simon & Garfunkel', null,3), -- duplas
	('The Everly Brothers', null,3),
	('Daft Punk', null,3),
	('The Carpenters', null,3),
    
    ('U2', null, 4), -- GRUPOS
	('Radiohead', null,4),
	('Guns N Roses', null,4),
	('AC/DC', null,4),
    
    ('Clube da Esquina', null,5), -- conjutos
	('Novos Baianos', null,5),
	('Tribalistas', null,5),
	('O Rappa', null,5);
    

INSERT INTO tb_disco
	(titulo, duracao, ano_lancamento, id_artista, id_gravadora, id_genero)	
VALUES
	('Forma de Você', '00:03:54', '2017',1,1,1),
	('Rapsódia Boêmia', '00:05:55', '1975',1,1,1),
	('Escadaria para o Céu', '00:08:02', '1971',2,10,2),
	('Cheiro de Espírito Adolescente', '00:05:01', '1991',2,2,2),
	('Imagine', '00:03:06', '1971',3,2,3),
	('Billie Jean', '00:04:54', '1983',3,2,4),
	('Ei Jude', '00:07:11', '1968',3,2,5),
	('Como uma Pedra que Rola', '00:06:13', '1965',4,3,6),
	('Eu Sempre Vou te Amar', '00:04:31', '1992',5,4,7),
	('Hotel Califórnia', '00:06:30', '1976',6,5,8),
	('Ontem', '00:02:05', '1965',7,6,5),
	('Thriller', '00:05:57', '1982',8,7,7),
	('Tudo Sobre o Baixo', '00:03:10', '2014',9,8,1),
	('Rolando no Profundo', '00:03:48', '2010',10,9,1);
	
    select * from tb_disco;

INSERT INTO tb_musica
	(titulo, duracao, id_disco)
VALUES
	
	('itachi a dor que causei','00:02:55',43),
    ('Cores do Arco-íris', '00:02:55', 43),
	('Sabor de Canela', '00:03:25', 43),
	('Brisa da Montanha', '00:03:15', 43),
	('Chuva de Prata', '00:03:50', 43),
	('Noites de Verão', '00:04:10', 43),
	('Tarde de Outono', '00:04:30', 43),
	('Lua Cheia no Sertão', '00:06:00', 43),
	('Samba na Praia', '00:05:20', 43), 	
    ('kio', '00:05:20', 43),
    
    ('Canções de Amor', '00:03:35', 44),
	('Ritmos Brasileiros', '00:04:45', 44),
	('O Sabor do Mar', '00:03:20', 44),
	('Flores da Primavera', '00:02:50', 44),
	('Serenata da Lua Cheia', '00:05:25', 44),
	('O Canto do Sabiá', '00:04:15', 44),
	('Sons da Cidade', '00:03:55', 44),
	('Dança do Vento', '00:06:10', 44),
	('Música da Montanha', '00:04:50', 44),
	('Carnaval de Verão', '00:05:35', 44),
    
    ('Café com Leite', '00:03:45', 45),
	('Amor de Verão', '00:04:10', 45),
	('Sabor da Paixão', '00:03:25', 45),
	('Noites de Festa', '00:04:20', 45),
	('Lua Cheia no Mar', '00:05:00', 45),
	('Brilho do Luar', '00:04:30', 45),
	('Festa na Praia', '00:03:55', 45),
	('Sonhos de Verão', '00:03:50', 45),
	('Saudade da Terra', '00:04:15', 45),
	('Terra da Fantasia', '00:05:20', 45),
    
    ('Cores da Primavera', '00:03:30', 46),
	('Dança das Estrelas', '00:04:15', 46),
	('Pôr do Sol na Praia', '00:05:00', 46),
	('Jardim Secreto', '00:03:45', 46),
	('Céu Azul', '00:03:20', 46),
	('Flores do Campo', '00:04:00', 46),
	('Caminhos do Amor', '00:05:30', 46),
	('Noite de Lua Cheia', '00:06:20', 46),
	('Vento no Rosto', '00:03:50', 46),
	('Cascata de Sonhos', '00:04:45', 46),

	('O Sol e a Lua', '00:03:20', 47),
	('Chuva de Verão', '00:04:15', 47),
	('Flores do Campo', '00:03:40', 47),
	('Pássaros Livres', '00:04:00', 47),
	('Céu Azul', '00:03:30', 47),
	('Praia do Amor', '00:05:00', 47),
	('Rios e Cachoeiras', '00:04:50', 47),
	('Horizonte Sem Fim', '00:06:30', 47),
	('Vida de Viajante', '00:05:15', 47),
	('Noites Enluaradas', '00:03:55', 47),
    
    ('Despertar do Sol', '00:03:30', 48),
	('Noite Estrelada', '00:04:20', 48),
	('Dançando na Chuva', '00:03:55', 48),
	('A Brisa da Tarde', '00:04:10', 48),
	('Caminhando na Areia', '00:03:40', 48),
	('Sonhos de Primavera', '00:04:15', 48),
	('No Pôr do Sol', '00:03:50', 48),
	('Tocando o Horizonte', '00:04:45', 48),
	('Voo Noturno', '00:03:25', 48),
	('Ritmo Latino', '00:05:00', 48),
        
    ('Florescer do Amor', '00:03:45', 49),
	('Doce Melodia', '00:04:12', 49),
	('Luzes da Cidade', '00:05:23', 49),
	('Voo Livre', '00:03:57', 49),
	('Onda Azul', '00:04:18', 49),
	('Valsa das Flores', '00:03:33', 49),
	('Passeio ao Luar', '00:04:50', 49),
	('Mar de Estrelas', '00:05:10', 49),
	('Amor sem Fronteiras', '00:04:25', 49),
	('Dança dos Ventos', '00:03:38', 49),
    
    ('Onda Azul', '00:03:45', 50),
	('Sol de Verão', '00:04:10', 50),
	('Amar é Preciso', '00:03:30', 50),
	('Noite de Luar', '00:05:20', 50),
	('Vida de Cigano', '00:04:05', 50),
	('Terra de Amor', '00:03:55', 50),
	('Lua Nova', '00:04:50', 50),
	('Caminhos da Vida', '00:05:15', 50),
	('Estrela da Noite', '00:03:25', 50),
	('Saudades de Você', '00:04:40', 50),
    
    ('Dançando na Chuva', '00:04:20', 51),
	('A Vida é um Carnaval', '00:03:55', 51),
	('Só o Amor', '00:03:30', 51),
	('Estrela Cadente', '00:03:45', 51),
	('Luzes da Cidade', '00:04:10', 51),
	('Noite de Paz', '00:03:15', 51),
	('O Sol Nascerá', '00:04:05', 51),
	('Olhos nos Olhos', '00:04:25', 51),
	('Cores e Sabores', '00:03:40', 51),
	('Despertar da Primavera', '00:05:00', 51);


	