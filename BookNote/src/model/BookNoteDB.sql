create database bd_book_note;
use bd_book_note;
-- drop database bd_book_note;


create table usuario(
    id int auto_increment,
    nickname varchar(50),
    pass varchar(50),
    primary key(id)
); -- select * from usuario;

INSERT INTO usuario VALUES (null,'aaa','111');
INSERT INTO usuario VALUES (null,'bbb','222');
INSERT INTO usuario VALUES (null,'ccc','333');
INSERT INTO usuario VALUES (null,'ddd','444');
INSERT INTO usuario VALUES (null,'eee','555');
INSERT INTO usuario VALUES (null,'fff','666');

create table apoderado (
    id int auto_increment,
    nombre varchar (50),
    apellido varchar (50),
    id_usuario INT,
    primary key (id),
    foreign key (id_usuario) references usuario(id)    
); -- select * from apoderado;
INSERT INTO apoderado VALUES (null,'mama','luchona','3');

create table docente (
    id int auto_increment,
    nombre varchar (50),
    apellido varchar (50),
    id_usuario INT,
    primary key (id),
    foreign key (id_usuario) references usuario(id)  
); -- select * from docente;

INSERT INTO docente VALUES (null,'tio','bkn','2');

create table alumno (
    id int auto_increment,
    nombre varchar (50),
    apellido varchar (50),
    id_usuario INT,
    primary key (id),
    foreign key (id_usuario) references usuario(id)  
); -- select * from alumno;

INSERT INTO alumno VALUES (null,'franco','Barrera','1');
INSERT INTO alumno VALUES (null,'test1','prueba1','1');
INSERT INTO alumno VALUES (null,'test2','prueba2','1');
INSERT INTO alumno VALUES (null,'test3','prueba3','1');

-- INSERT INTO nota VALUES ();
create table asignatura (
    id int auto_increment,
    nombre varchar (100),
    id_docente INT,
    primary key (id),
    foreign key (id_docente) references docente(id)  
); -- select * from asignatura;

INSERT INTO asignatura VALUES (null,'matematica','1');
INSERT INTO asignatura VALUES (null,'lenguaje','1');

create table asignatura_alumno (
	id int auto_increment,
    id_asignatura int,
    id_alumno int,
    primary key (id),
    foreign key (id_asignatura) references asignatura(id),
    foreign key (id_alumno) references alumno(id)     
);
INSERT INTO asignatura_alumno VALUES (null,'1','1');
INSERT INTO asignatura_alumno VALUES (null,'2','1');
INSERT INTO asignatura_alumno VALUES (null,'1','2');
INSERT INTO asignatura_alumno VALUES (null,'1','3');
INSERT INTO asignatura_alumno VALUES (null,'2','4');

-- Cada nota posee un valor y un porcentaje.
create table nota(
    id int auto_increment,
	valor float,	-- resultado int,
    porcentaje float,
    id_asignatura_alumno int,
	primary key (id),
    foreign key (id_asignatura_alumno) references asignatura_alumno(id)  
); -- select * from nota;


INSERT INTO nota VALUES (null,'6.5','0.3','1');
INSERT INTO nota VALUES (null,'7','0.3','1');
INSERT INTO nota VALUES (null,'3.2','0.4','1');
INSERT INTO nota VALUES (null,'6.5','0.6','5');
INSERT INTO nota VALUES (null,'7','0.4','5');
INSERT INTO nota VALUES (null,'4','0.3','2');
INSERT INTO nota VALUES (null,'5','0.3','2');
INSERT INTO nota VALUES (null,'6','0.4','2');
INSERT INTO nota VALUES (null,'3','0.3','3');
INSERT INTO nota VALUES (null,'3','0.3','3');
INSERT INTO nota VALUES (null,'3','0.4','3');
INSERT INTO nota VALUES (null,'5.5','0.6','4');
INSERT INTO nota VALUES (null,'6.6','0.4','4');

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


/* Como hacer el procedimiento en MYSQL:
DELIMITER $$
CREATE PROCEDURE procedimiento (variable TIPO, variable2 TIPO)
BEGIN
	
END $$
DELIMITER ;
*/


--       ----------------------------------------------------------------------------------------------------------------
--       ---------------------------------------LEER COMENTARIOS PORFAAA!!!----------------------------------------------
--       ----------------------------------------------------------------------------------------------------------------

-- INSERTA NOTA pidiendo los ID del alumno, asignatura, la nota y su ponderacion, asumiendo que estamos en el USUARIO de un DOCENTE
DELIMITER $$
CREATE PROCEDURE insertar_nota(alumno_fk INT, asignatura_fk INT, nota_nueva FLOAT, ponderacion FLOAT)-- DROP PROCEDURE insertar_nota
BEGIN
	DECLARE destinatario INT;
    SET destinatario = (SELECT id FROM asignatura_alumno WHERE id_alumno = alumno_fk AND id_asignatura = asignatura_fk);
	INSERT INTO nota VALUES (NULL,nota_nueva,ponderacion,destinatario);
END $$
DELIMITER ;

CALL insertar_nota('1','2','5','0');


-- MODIFICA NOTA pudiendo cambiar el VALOR y su PORCENTAJE, pidiendo los ID del alumno, asignatura, la nota y su ponderacion, asumiendo que estamos en el USUARIO de un DOCENTE
DELIMITER $$
CREATE PROCEDURE modificar_nota(alumno_fk INT, asignatura_fk INT, nota_nueva FLOAT, ponderacion FLOAT)-- DROP PROCEDURE modificar_nota
BEGIN
	DECLARE destinatario INT;
    SET destinatario = (SELECT id FROM asignatura_alumno WHERE id_alumno = alumno_fk AND id_asignatura = asignatura_fk);
	UPDATE nota SET valor = nota_nueva, porcentaje = ponderacion where id = destinatario;
END $$
DELIMITER ;

CALL modificar_nota('1','2','7','0.5');


-- INSERTA ASISTENCIA pidiendo los ID del ALUMNO, ASIGNATURA y si llegó ALUMNO asumiendo que estamos en el USUARIO de un DOCENTE y que se queiere registrar la FECHA ACTUAL
DELIMITER $$
CREATE PROCEDURE registrar_asistencia(alumno_fk INT, asignatura_fk INT, atraso BOOLEAN)-- DROP PROCEDURE modificar_nota
BEGIN
	DECLARE destinatario INT;
    SET destinatario = (SELECT id FROM asignatura_alumno WHERE id_alumno = alumno_fk AND id_asignatura = asignatura_fk);
	INSERT INTO asistencia VALUES (null,CURDATE(),atraso,destinatario);
END $$
DELIMITER ;

CALL registrar_asistencia('1','1','0');


-- SELECT DE ASISTENCIA para los APODERADOS solicitando la ID del ALUMNO y ASIGNATURA asumiendo que estamos en el USUARIO de un APODERADO
DELIMITER $$
CREATE PROCEDURE ver_asistencia(alumno_actual INT, asignatura_actual INT)-- DROP PROCEDURE ver_asistencia
BEGIN
	SELECT 
		asist.fecha,
        asist.atrasado,
        al.nombre,
        al.apellido,
        asig.nombre
	
    FROM
		asistencia asist
        
	INNER JOIN asignatura_alumno asig_al ON asig_al.id = asist.id_asignatura_alumno
    INNER JOIN alumno al ON al.id = asig_al.id_alumno
    INNER JOIN asignatura asig ON asig_al.id_asignatura = asig.id
    
    WHERE 
		 al.id = alumno_actual AND
         asig.id = asignatura_actual;
END $$
DELIMITER ;

CALL ver_asistencia('1','1');


-- SELECT DE NOTAS para los APODERADOS solicitando la ID del ALUMNO y ASIGNATURA asumiendo que estamos en el USUARIO de un APODERADO
DELIMITER $$
CREATE PROCEDURE ver_notas(alumno_actual INT, asignatura_actual INT)-- DROP PROCEDURE ver_notas
BEGIN
	SELECT 
		n.valor,
        n.porcentaje,
        al.nombre,
        al.apellido,
        asig.nombre
	
    FROM
		nota n
        
	INNER JOIN asignatura_alumno asig_al ON asig_al.id = n.id_asignatura_alumno
    INNER JOIN alumno al ON al.id = asig_al.id_alumno
    INNER JOIN asignatura asig ON asig_al.id_asignatura = asig.id
    
    WHERE 
		al.id = alumno_actual AND
		asig.id = asignatura_actual;
END $$
DELIMITER ;

CALL ver_notas('1','1');


-- SELECT DE NOTAS para los ALUMNOS solicitando la ID del ALUMNO y ASIGNATURA asumiendo que estamos en el USUARIO de un ALUMNO
-- es igual que el de apoderados, pero con menos datos
DELIMITER $$
CREATE PROCEDURE revizar_notas(alumno_actual INT, asignatura_actual INT)-- DROP PROCEDURE revizar_notas
BEGIN
	SELECT 
		n.valor,
        n.porcentaje,
        asig.nombre
	
    FROM
		nota n
        
	INNER JOIN asignatura_alumno asig_al ON asig_al.id = n.id_asignatura_alumno
    INNER JOIN alumno al ON al.id = asig_al.id_alumno
    INNER JOIN asignatura asig ON asig_al.id_asignatura = asig.id
    
    WHERE 
		al.id = alumno_actual AND
		asig.id = asignatura_actual;
END $$
DELIMITER ;

CALL revizar_notas('4','2');


-- MUESTRA LOS MENSAJES por ASIGNATURA para los ALUMNOS asumiendo que estamos en el USUARIO de un ALUMNO
DELIMITER $$
CREATE PROCEDURE revizar_mensajes(asignatura_actual INT)-- DROP PROCEDURE revizar_notas
BEGIN
	SELECT 
		m.id,
        m.fecha,
        m.texto
	
    FROM
		mensaje m
        
    INNER JOIN asignatura asig ON m.id_asignatura = asig.id
    
    WHERE 
		asig.id = asignatura_actual;
END $$
DELIMITER ;

CALL revizar_mensajes ('2');
			
			

