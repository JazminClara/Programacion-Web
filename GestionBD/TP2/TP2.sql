drop database editoriales;
create database editoriales;
use editoriales;

SET FOREIGN_KEY_CHECKS = 1;

-- CREACIÓN DE TABLAS, PK Y FK

create table editoriales (
    id_editorial int,
    nombre_editorial varchar(50)
) engine = InnoDB;

alter table editoriales
add primary key (id_editorial);


create table empleados (
    id_empleado int,
    nombre_empleado varchar(50),
    id_editorial int
) engine = InnoDB;

alter table empleados
add primary key (id_empleado);
alter table empleados
add constraint editoriales_empleados foreign key(id_editorial) references editoriales (id_editorial) on delete cascade on update cascade;


create table libros (
    id_libro int,
    titulo_libro varchar(50),
    id_editorial int
) engine = InnoDB;

alter table libros
add primary key (id_libro);
alter table libros
add constraint editoriales_libros foreign key(id_editorial) references editoriales (id_editorial) on delete cascade on update cascade;


-- CARGA DE REGISTROS DE DATOS

INSERT INTO editoriales (id_editorial, nombre_editorial)
VALUES (1, 'Editorial Planeta'),
    (2, 'Editorial Santillana'),
    (3, 'Editorial Anaya'),
    (4, 'Editorial Alfaguara'),
    (5, 'Editorial SM'),
    (6, 'Editorial Fondo de Cultura Económica'),
    (7, 'Editorial Siglo XXI'),
    (8, 'Editorial Cátedra'),
    (9, 'Editorial Tecnos'),
    (10, 'Editorial Ariel');

INSERT INTO empleados (id_empleado, nombre_empleado, id_editorial)
VALUES (1, 'Juan Pérez', 1),
    (2, 'María Rodríguez', 1),
    (3, 'Pedro López', 2),
    (4, 'Ana Martínez', 2),
    (5, 'Carlos García', 3),
    (6, 'Laura González', 3),
    (7, 'Luis Fernández', 4),
    (8, 'Elena Sánchez', 4),
    (9, 'Javier Ruiz', 5),
    (10, 'Sofía Torres', 5);

INSERT INTO libros (id_libro, titulo_libro, id_editorial)
VALUES (1, 'Cien años de soledad', 1),
    (2, 'Don Quijote de la Mancha', 1),
    (3, 'La sombra del viento', 2),
    (4, 'Rayuela', 2),
    (5, 'Crónica de una muerte anunciada', 3),
    (6, 'Los detectives salvajes', 3),
    (7, 'Ficciones', 4),
    (8, 'La casa de los espíritus', 4),
    (9, 'La ciudad y los perros', 5),
    (10, 'Cien años de soledad', 5);


-- Ejercicios sobre integridad referencial --

-- 1. Eliminar una editorial: Si se elimina una editorial de la tabla editoriales, ¿qué sucede con los libros asociados? Escriba una consulta SQL que elimine una editorial y sus libros relacionados.

-- Si el SET FOREIGN_KEY está en 1, al borrar la editorial con id 1 se borrarán registros de las tablas hijas (como libros y empleados)

select * from libros where id_editorial = 1;
select * from empleados where id_editorial = 1;
set foreign_key_checks = 1;
delete from editoriales where id_editorial = 1;

-- 2. Actualizar el nombre de una editorial: Si se actualiza el nombre de una editorial en la tabla editoriales, ¿qué sucede con los libros relacionados?

--  Al actualizar el nombre de la editorial en la tabla padre no sucederán modificaciones en las tablas hijas puesto que nombre_editorial no es una FK en dichas tablas. Sí sucedería el cambio en caso de que se modificara el 'id_editorial'

select * from libros where id_editorial = 5;
select * from empleados where id_editorial = 5;
update editoriales set nombre_editorial = 'Editorial Salamandra' where id_editorial = 5;

-- 3. Eliminar un empleado: Si se elimina un empleado de la tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?

-- En este caso no habría ningún cambio ya que ambas tablas no están relacionadas

select * from empleados where id_empleado = 4; -- Este empleado pertenece a la editorial con id 2
select * from editoriales where id_editorial = 2;
select * from libros where id_editorial = 2;
delete from empleados where id_empleado = 4;

-- 4. Actualizar el nombre de un empleado: Si se actualiza el nombre de un empleado en la tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?

-- No habrá cambios en la tabla libros dado que no existe relación entre ellas (libros y empleados)

select * from empleados where id_empleado = 9; -- Este empleado pertenece a la editorial con id 5
select * from libros where id_editorial = 5;
update empleados set nombre_empleado = 'Carolina Herrera' where id_empleado = 9;

-- 5. Eliminar un libro: Si se elimina un libro de la tabla libros, ¿qué sucede con la relación con la editorial?

-- Se eliminará el registro de la tabla libros sin que la tabla editoriales sufra cambios, no así con la relación entre la editorial y el libro, que quedará eliminada


select * from libros where id_libro = 10;  -- Libro publicado por editorial con id 5
select * from editoriales where id_editorial = 5;
delete from libros where id_libro = 10;

-- 6. Cambiar la editorial de un libro: Si se cambia la editorial a la que está asociado un libro en la tabla libros, ¿qué sucede con la relación con la editorial anterior?

-- Al cambiar el id_editorial en un registro de un libro, la relación con la editorial sufrirá un cambio y la relación con la anterior editorial se eliminará

select * from editoriales;
select * from libros where id_libro = 3;
update libros set id_editorial = 10 where id_libro = 3;

-- 7.	Eliminar una editorial con empleados: Si se intenta eliminar una editorial que tiene empleados asociados, ¿qué sucede?

-- Seteando el foreign_key_checks en 1 así como también configurar ON DELETE CASCADE al establecer la relación entre las tablas, cuando se elimina la editorial se eliminarán los empleados que estén asociados con ese id_editorial. Pero también se eliminarán los libros que estén asociados a esa misma editorial

set foreign_key_checks =1;
select * from editoriales;
select * from empleados where id_editorial = 5;
select * from libros where id_editorial = 5;
delete from editoriales where id_editorial = 5;

-- 8.	Eliminar un empleado con libros: Si se intenta eliminar un empleado que tiene libros asociados, ¿qué sucede?

-- Los empleados no tienen libros asociados. Tienen editoriales asociadas, las cuales tienen libros asociados. En esta estructura de asociación al eliminar un empleado no se afectarán los libros, ni la editorial

select * from empleados where id_empleado = 7; -- El empleado id 7 tiene asociada la editorial id 4
select * from editoriales where id_editorial = 4;
select * from libros where id_editorial = 4;
delete from empleados where id_empleado = 7;

-- 9.	Eliminar una editorial y sus empleados: ¿Cómo se eliminaría una editorial y todos sus empleados?

-- Para eliminar una editorial y sus empleados suponiendo que está bien establecida la relación (ON DELETE CASCADE) y el foreign_key_checks en 1, basta con eliminar el registro de la editorial. Pero al realizar esa eliminación se borrarán los libros también

set foreign_key_checks = 1;
select * from editoriales where id_editorial = 4;
select * from empleados where id_editorial = 4;
select * from libros where id_editorial = 4;
delete from editoriales where id_editorial = 4;

-- 10.	Eliminar una editorial y transferir sus empleados a otra editorial: ¿Cómo se eliminaría una editorial y reasignaría a sus empleados a otra editorial?

-- Para realizar esta operación primero se debería reasignar a los empleados a otra editorial, para luego eliminar la editorial ya sin empleados asociados. Pero esto teniendo en cuenta que los libros de esa misma editorial a eliminar serán eliminados

select * from editoriales where id_editorial = 3;
select * from empleados where id_editorial = 3;
select * from libros where id_editorial = 3;
set foreign_key_checks = 1;
update empleados set id_editorial = 2 where id_editorial = 3;
select * from empleados where id_editorial = 2;
delete from editoriales where id_editorial = 3;
