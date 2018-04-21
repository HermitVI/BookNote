create database bd_book_note;
use bd_book_note;
-- drop database bd_book_note;


create table usuario(
    id int auto_increment,
    nickname varchar(50),
    pass varchar(50),
    primary key(id)
); -- select * from perfil;

INSERT INTO usuario VALUES (null,'aaa','111');
INSERT INTO usuario VALUES (null,'bbb','222');
INSERT INTO usuario VALUES (null,'ccc','333');

create table apoderado (
    id int auto_increment,
    nombre varchar (50),
    apellido varchar (50),
    id_usuario INT,
    primary key (id),
    foreign key (id_usuario) references usuario(id)    
); -- select * from curso;
INSERT INTO apoderado VALUES (null,'mama','luchona','3');

create table docente (
    id int auto_increment,
    nombre varchar (100),
    id_usuario INT,
    primary key (id),
    foreign key (id_usuario) references usuario(id)  
); -- select * from curso;
INSERT INTO docente VALUES (null,'tio','2');

create table alumno (
    id int auto_increment,
    nombre varchar (100),
    id_usuario INT,
    primary key (id),
    foreign key (id_usuario) references usuario(id)  
); -- select * from curso;
INSERT INTO alumno VALUES (null,'franco','1');

-- INSERT INTO nota VALUES ();
create table asignatura (
    id int auto_increment,
    nombre varchar (100),
    id_docente INT,
    primary key (id),
    foreign key (id_docente) references usuario(id)  
); -- select * from curso;

INSERT INTO asignatura VALUES (null,'matematica','1');

create table asignatura_alumno (
	id int auto_increment,
    id_asignatura int,
    id_alumno int,
    primary key (id),
    foreign key (id_asignatura) references asignatura(id),
    foreign key (id_alumno) references alumno(id)     
);
INSERT INTO asignatura_alumno VALUES (null,'1','1');

-- Cada nota posee un valor y un porcentaje.
create table nota(
    id int auto_increment,
	valor float,	-- resultado int,
    procentaje float,
    id_asignatura_alumno int,
	primary key (id),
    foreign key (id_asignatura_alumno) references asignatura_alumno(id)  
); -- select * from nota;


INSERT INTO nota VALUES (null,'6.5','0.3','1');

create table asistencia (
    id int auto_increment,
    fecha datetime,
    atrasado boolean,
    id_asignatura_alumno int,
    primary key (id),
    foreign key (id_asignatura_alumno) references asignatura_alumno(id)  
); -- select * from asistencia;

INSERT INTO asistencia VALUES (null,CURDATE(),false,'1');

create table mensaje (
    id int auto_increment,
    texto varchar (100),
    fecha datetime,
    id_asignatura int,
    primary key (id),
    foreign key (id_asignatura) references asignatura(id)    
); -- select * from mensaje;

INSERT INTO mensaje VALUES (null,'me da un completo',NOW(),'1');



/*
create table alumnoCurso (
    id int auto_increment,
    alumno varchar (100),
    curso int,
    nota int,
    primary key (id),
    foreign key (alumno) references alumno (rut),
    foreign key (curso) references curso (id),
    foreign key (nota) references nota (id)
); -- select * from alumnoCurso;
*/