drop database editoriales;
create database editoriales;
use editoriales;

CREATE TABLE editoriales (
    id_editorial INT PRIMARY KEY,
    nombre_editorial VARCHAR(255) NOT NULL
);

INSERT INTO editoriales (id_editorial, nombre_editorial)
VALUES
    (1, 'Editorial Santillana'),
    (2, 'Editorial Anagrama'),
    (3, 'Editorial Planeta'),
    (4, 'Editorial Alfaguara'),
    (5, 'Editorial SM'),
    (6, 'Editorial Penguin Random House'),
    (7, 'Editorial Norma'),
    (8, 'Editorial Ediciones B'),
    (9, 'Editorial Aguilar'),
    (10, 'Editorial Fondo de Cultura Económica');

CREATE TABLE libros (
    id_libro INT PRIMARY KEY,
    id_editorial INT,
    titulo VARCHAR(255) NOT NULL,
    fecha_publicacion DATE,
    FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial)
);

INSERT INTO libros (id_libro, id_editorial, titulo, fecha_publicacion)
VALUES
    (1, 1, 'Cien años de soledad', '1967-05-30'),
    (2, 2, 'Rayuela', '1963-07-23'),
    (3, 3, 'La sombra del viento', '2001-04-27'),
    (4, 4, 'Pedro Páramo', '1955-11-30'),
    (5, 5, 'Don Quijote de la Mancha', '1605-01-16'),
    (6, 6, 'Harry Potter y la piedra filosofal', '1997-06-26'),
    (7, 7, 'Crimen y castigo', '1866-01-29'),
    (8, 8, 'Los detectives salvajes', '1998-09-01'),
    (9, 9, 'La casa de los espíritus', '1982-01-01'),
    (10, 10, 'Ficciones', '1944-05-01');

select * from editoriales;
select * from libros;

show index from editoriales;
show index from libros;

-- Ejercicio 1: Crea un índice compuesto en las columnas id_editorial y titulo de la tabla libros.

create index idx_libros_id_editorial_titulo on libros (id_editorial, titulo);

-- Ejercicio 2: Crea un índice en la columna fecha_publicacion de la tabla libros.

alter table libros add index i_fechapublicacion (fecha_publicacion);

-- Ejercicio 3: Elimina el índice idx_libros_id_editorial_titulo de la tabla libros.

/*
Si vemos los índices de la tabla libros antes de realizar el ejercicio 1 (crear el indice idx_libros_id_editorial_titulo):
Table    Non_unique  Key_name  Seq_in_index   Column_name   Null  Index_type
__________________________________________________________
libros	    0	     PRIMARY	     1	      id_libro	            BTREE		
libros      1	   id_editorial	     1	    id_editorial    YES	    BTREE		

Esto nos muestra que la foreign key realizada en el script de la tabla libros ("FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial)")
 se construyó como un index 
*/
show index from libros;
/*
En cambio al hacer la misma consulta ya no vemos la Key_name id_editorial, pero si vemos la idx_libros_id_editorial_titulo,
debido a que el motor ahora utiliza el índice compuesto para el sustento de la FK.
Al querer borrar el compuesto me da un error: "needed in a foreign key constraint".
Entonces para borrarlo necesito agregar el índice (id_editorial) para que la relación de foreign key siga funcionando 
y poder borrar la compuesta
*/
alter table libros add index idx_id_editorial (id_editorial);
drop index idx_libros_id_editorial_titulo on libros;
show index from libros;

-- Ejercicio 4: Actualiza el índice idx_libros_id_editorial_titulo de la tabla libros para que sea un índice 
--              único en la columna id_editorial.

/* 
	No se puede modificar un index a un unique. Debería crear un unique con la columna id_editorial y luego borrar el índice
	idx_libros_id_editorial_titulo o más bien idx_id_editorial que es el índice que queda en mi BD luego de hacer el punto anterior
*/
alter table libros add unique idx_libros_id_editorial (id_editorial);
drop index idx_id_editorial on libros;
show index from libros;

-- Ejercicio 5: ¿Se puede usar alter para resolver el ejercicio anterior?

/*
Se puede usar el alter table para crear un nuevo índice, no así para convertir un index en un unique
*/

-- Ejercicio 6: Crea un índice único en la columna id_editorial de la tabla editoriales.

alter table editoriales add unique idx_editoriales_id_editorial (id_editorial);
show index from editoriales;

-- Ejercicio 7: Crea un índice primary en la columna id_libro de la tabla libros.

/*
El campo id_libro ya es una primary key, lo cual al intentar hacer una nueva dará un error, ya que no se permite múltiples PK
En caso de no tener una PK y tener que crearla, primero corroborar que no hay registros duplicados
y que a su vez no haya otra PK, ya que debe ser única.
*/

alter table libros add primary key(id_libro);