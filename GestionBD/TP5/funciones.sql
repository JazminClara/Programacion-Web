-- Trabajo Práctico sobre Funciones de Usuario
use pubs;

-- Ejercicio 1: Crear una función para calcular la regalía total de cada autor.

delimiter //
create function regalia_au(qty smallint(6), price float, royalty int, royaltyper int)
returns decimal(6,2)
begin 
	declare regalia decimal(6,2);
    set regalia=0;
    set regalia=(( qty*price*royalty)/100)*(royaltyper/100);
    return round(regalia,2);
end;
// delimiter ;

select  ta.au_id, a.au_lname, t.title_id, t.title, t.royalty, ta.royaltyper,
regalia_au(sum(s.qty), t.price, t.royalty, ta.royaltyper)
from authors a 
join titleauthor ta on a.au_id = ta.au_id
right join titles t on t.title_id = ta.title_id
join sales s on s.title_id = t.title_id
group by t.title_id, a.au_id
order by au_id desc;


-- Ejercicio 2: Crear una función para obtener el precio máximo de cada tipo de libro.

select type, max(price) from titles group by type;

delimiter //
create function precio_max_type(title_type char(12))
returns decimal(6,2)
begin 
	declare precio_max decimal(6,2);
    select max(price) into precio_max from titles
    where type = title_type;
    return precio_max;
end;
// delimiter ;

select type from titles;
select 'Popular Comp', precio_max_type('popular_comp') 'Precio Máximo';

-- Ejercicio 3: Crear una función para calcular el ingreso (cantidad vendida multiplicada por el precio) de cada título.
 
select t.title titulo, t.price precio, round(sum(s.qty)*t.price) total_vendido
from  sales s
join titles t on s.title_id = t.title_id
group by t.title;
 
delimiter //
create function ingreso_titulo(title_id int(11))
returns decimal(6,2)
begin 
	declare ingreso decimal(6,2);
    select sum(s.qty)*t.price into ingreso from titles t 
    join sales s on t.title_id = s.title_id
	where t.title_id = title_id;
    return round(ingreso,2);
end;
// delimiter ;

select t.title titulo, t.price precio, ingreso_titulo(t.title_id) total_vendido
from  sales s
join titles t on s.title_id = t.title_id
group by t.title_id;
 
 
-- Ejercicio 4: Crear una función para obtener el nombre completo de un empleado a partir de su código.

select emp_id codigo, concat(fname, ' ', lname) from employee;

delimiter //
create function nombre_completo(id int(11))
returns varchar(50)
begin 
	declare nombre varchar(50);
    select concat(fname, ' ', lname) into nombre from employee
    where emp_id = id;
    return nombre;
end;
// delimiter ;

select emp_id codigo, nombre_completo(emp_id) nombre_completo from employee;


-- Ejercicio 5: Crear una función para calcular el precio promedio de libros publicados de cada editorial.

select t.title, t.title_id, avg(t.price) 
from titles t left join publishers p on t.pub_id = p.pub_id
group by p.pub_id;

delimiter //
create function promedio_pub(pub char(4))
returns decimal(6,2)
begin 
	declare promedio decimal(6,2);
    select avg(t.price) into promedio 
    from titles t left join publishers p on t.pub_id = p.pub_id
	where p.pub_id = pub;
    return round(promedio,2);
end;
// delimiter ;

select pub_id, pub_name publisher, promedio_pub(pub_id) from publishers;