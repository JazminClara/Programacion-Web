-- Ejercicios de creación de vistas con MySQL

-- 1 Crea una vista que muestre el título, el autor y el precio de todos los libros de la tabla titles.

create view eje1 as
select t.title titulo , a.au_lname autor, t.price precio 
from titles t 
join titleauthor ta on t.title_id = ta.title_id 
join authors a on ta.au_id = a.au_id;

select * from eje1;


-- 2 Crea una vista que muestre el título, el autor, el precio y el tipo de todos los libros de la tabla titles.

create view eje2 as 
select t.title titulo , a.au_lname autor, t.price precio, t.type tipo_libro 
from titles t 
join titleauthor ta on t.title_id = ta.title_id 
join authors a on ta.au_id = a.au_id;

select * from eje2;


-- 3 Crea una vista que muestre el título, el autor, el precio y la fecha de publicación de todos
-- los libros de la tabla titles.

create view eje3 as
select t.title titulo , a.au_lname autor, t.price precio, t.pubdate fecha_publicacion 
from titles t 
join titleauthor ta on t.title_id = ta.title_id 
join authors a on ta.au_id = a.au_id;

select * from eje3;


-- 4 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales.

create view eje4 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_libro 
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id 
-- Uso el left join porque hay libros vendidos que no tienen la relación con tabla autores
group by t.title_id order by cantidad_vendida_libro desc;

select * from eje4;


-- 5 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda.

create view eje5 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_tienda, s.stor_id tienda
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, t.title
order by s.stor_id;

select * from eje5;


-- 6 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tipo de libro.

-- Al agrupar por tipo de libros, los campos title y au_lname o price generará un resgitro aleatorio en cada grupo
-- Entiendo que se puede concatenar con group_concat() 
-- Igualmente agrego como haría esa parte de la query en tal caso, para que en ese campo aparezcan todos los títulos, autores y precios:
-- select group_concat(distinct concat(t.title,a.au_lname, t.price), sum(s.qty)(...)
-- Esta solución funciona con pocos registros, al tener muchos se vuelve algo ilegible

create view eje6 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_tipo_libro, t.type tipo_libro
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by t.type;

select * from eje6;


-- 7 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda y tipo de libro.

create view eje7 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_tipo_libro, s.stor_id tienda, t.type tipo_libro
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, t.type
order by t.title;

select * from eje7;


-- 8 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda y año de publicación.

create view eje8 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_publicacion, s.stor_id, year(t.pubdate) anio_pub
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, year(t.pubdate);

select * from eje8;


-- 9 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda, tipo de libro y año de publicación.

create view eje9 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_tipo_anio, s.stor_id, t.type tipo_libro, year(t.pubdate) anio_pub
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, t.type, year(t.pubdate);

select * from eje9;


-- 10 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda, tipo de libro, año de publicación y mes de publicación.

create view eje10 as
select t.title titulo, a.au_lname autor, t.price precio, sum(s.qty) cantidad_vendida_tipo_anio_mes, s.stor_id, t.type tipo_libro,
year(t.pubdate) anio_pub, month(t.pubdate) mes_pub
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, t.type, year(t.pubdate), month(t.pubdate);

select * from eje10;



-- Vistas que tienen condiciones con la cláusula WHERE:

-- 11 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las
-- ventas que superaron los 10 libros.

create view eje11 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_tipo_anio, s.stor_id, t.type tipo_libro, year(t.pubdate) anio_pub
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, t.type, year(t.pubdate)
having cantidad_vendida_tipo_anio > 10;

select * from eje11;


-- 12 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las
-- ventas que se realizaron en el año 1990.

create view eje12 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_tipo_anio, s.stor_id, 
t.type tipo_libro, year(t.pubdate) anio_pub,
year(s.ord_date) anio_venta
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, t.type, year(t.pubdate)
having anio_venta = 1990;

select * from eje12;


-- 13 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las
-- ventas que se realizaron entre 1990 y 1994.

create view eje13 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_tipo_anio, s.stor_id, 
t.type tipo_libro, year(t.pubdate) anio_pub,
year(s.ord_date) anio_venta
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, t.type, year(t.pubdate)
having anio_venta between 1990 and 1994;

select * from eje12;


-- 14 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las
-- ventas que se realizaron en la tienda con el ID 7066. 

create view eje14 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_tipo_anio, s.stor_id, 
t.type tipo_libro, year(t.pubdate) anio_pub
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, t.type, year(t.pubdate)
having s.stor_id = 7066;

select * from eje14;


-- 15 Crea una vista que muestre el título, el autor, el precio y la cantidad vendida de todos
-- los libros de la tabla sales por cada tienda, tipo de libro y año de publicación, pero solo para las
-- ventas que se realizaron por el autor con el ID 172.

create view eje15 as
select t.title titulo, a.au_lname autor, t.price, sum(s.qty) cantidad_vendida_tipo_anio, s.stor_id, 
t.type tipo_libro, year(t.pubdate) anio_pub, a.au_id
from  sales s
join titles t on s.title_id = t.title_id 
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id
group by s.stor_id, t.type, year(t.pubdate)
having a.au_id = 172;

select * from eje15;



-- Actualización de datos en tablas mediante la actualización de vistas:

-- 16 Crea una vista que permita actualizar el precio de un libro en la tabla titles.

create view eje16 as
select title_id id, title titulo, price precio from titles;

update eje16 set precio = 99.99 where id = 10;
select * from eje16;
select * from titles where title_id = 10;


-- 17 Crea una vista que permita actualizar el nombre de un autor en la tabla authors.

create view eje17 as
select au_id id, au_lname apellido, au_fname nombre from authors;

set sql_safe_updates = 0;

UPDATE eje17
SET nombre = 'Ada', apellido = 'Lovelace'
WHERE id = 267;

select * from eje17;
select * from eje17 where id = 267;
select au_fname, au_lname from authors where au_id = 267;


-- 18 Crea una vista que permita actualizar la cantidad vendida de un libro en la tabla sales.

create view eje18 as
select s.stor_id tienda, s.ord_num orden, s.title_id id_libro, t.title nombre_libro, s.qty cantidad_vendida 
from sales s 
join titles t on s.title_id = t.title_id;

select * from eje18;

update eje18 set cantidad_vendida = 100 where tienda = '8042' and orden = '423LL922' and id_libro = 7;

select * from eje18 where tienda = '8042' and orden = '423LL922' and id_libro = 7;
select * from sales where stor_id = '8042' and ord_num = '423LL922' and title_id = 7;


-- 19 Crea una vista que permita actualizar la fecha de publicación de un libro en la tabla titles.

create view eje19 as
select title_id id, title titulo, pubdate fecha_publicacion from titles;

update eje19 set fecha_publicacion = '2021-01-05 00:00:00' where id = 1;
select * from eje19 where id = 1;
select * from titles where title_id = 1;


-- 20 Crea una vista que permita actualizar el tipo de un libro en la tabla titles.

create view eje20 as
select title_id id, title titulo, type tipo_libro from titles;

update eje20 set tipo_libro = 'trad_cook' where id = 15;
select * from eje20 where id = 15;
select * from titles where title_id = 15;