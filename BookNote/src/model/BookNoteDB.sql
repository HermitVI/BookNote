create database bdBlockNote;
use bdBlockNote;
-- drop database bdBlockNote

create table perfil(
    id int auto_increment,
    nivel int,
    primary key(id)
); -- select * from perfil;

create table alumno(
    rut varchar (100),
    nombre varchar (100),
    primary key (rut)
); -- select * from alumno;

create table docente (
    rut varchar (100),
    nombre varchar (100),
    primary key (rut)
); --select * from docente

create table nota (
    id int auto_increment,
    resultado int,
    primary key (id)
); -- select * from nota;

create table asistencia (
    id int auto_increment,
    fecha datetime,
    atrasado boolean,
    primary key (id)
); -- select * from asistencia;

create table curso (
    id int auto_increment,
    nombre varchar (100),
    docente varchar (100),
    alumno varchar (100),
    primary key (id),
    foreign key (docente) references docente (rut),
    foreign key (alumno) references alumno (rut)
); -- select * from curso;

create table usuario(
    id int auto_increment,
    nickame varchar (100),
    pass varchar (100),
    perfil int,
    primary key (id),
    foreign key (perfil) references perfil(id)
); -- select * from usuario;

create table mensaje (
    id int auto_increment,
    texto varchar (100),
    fecha datetime,
    docente varchar (100),
    curso int,
    primary key (id),
    foreign key (docente) references docente (rut), 
    foreign key (curso) references curso (id)
); -- select * from mensaje;

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
