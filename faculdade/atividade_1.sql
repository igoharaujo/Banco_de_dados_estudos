CREATE TABLE projects(
	id INTEGER,
	name CHARACTER VARYING(45),
	description CHARACTER VARYING(45),
	data TIMESTAMP CHECK (data > '2020-05-12'),
	PRIMARY KEY(id));

CREATE TABLE users(
	id INTEGER,
	nome CHARACTER VARYING(45),
	username CHARACTER VARYING(45),
	senha CHARACTER VARYING(45) default '123mudar',
	email CHARACTER VARYING(45),
	UNIQUE(username),
	primary key(id));
	
CREATE TABLE users_projects(
	users_id INTEGER,
	projects_id INTEGER,
	FOREIGN KEY(users_id) REFERENCES users(id),
	FOREIGN KEY(projects_id) REFERENCES projects(id),
	PRIMARY KEY(users_id, projects_id));

ALTER TABLE users ALTER COLUMN username TYPE CHARACTER VARYING(10);

ALTER TABLE users ALTER COLUMN senha TYPE CHARACTER VARYING(8);