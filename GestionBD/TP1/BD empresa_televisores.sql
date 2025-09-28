create database empresa_televisores;
use empresa_televisores;
drop database empresa_televisores;


-- TABLAS

create table televisores (
cod_televisor int primary key,
modelo varchar(25) not null,
caracteristicas varchar(50)
) engine = InnoDB;

create table componentes (
cod_componente int primary key,
descripcion varchar(50)
) engine = InnoDB;

create table mapa_armado (
cod_componente int, 
cod_televisor int, 
cantidad int,
ubicacion varchar(50),
primary key (cod_componente, cod_televisor),
foreign key (cod_componente) references componentes (cod_componente),
foreign key (cod_televisor) references televisores (cod_televisor)
) engine = InnoDB;


create table importador (
nro_importador int primary key,
razon_social varchar(30) not null,
cuit varchar(11) not null
) engine = InnoDB;

create table facturas (
cod_factura int primary key, 
nro_importador int not null,
cod_componente int not null, 
cantidad int,
valor double,
foreign key (nro_importador) references importador (nro_importador),
foreign key (cod_componente) references componentes (cod_componente)
) engine = InnoDB;

create table operario (
nro_legajo int primary key,
apellido varchar(30) not null,
nombre varchar(30) not null,
domicilio varchar(25),
telefono varchar(15),
tipo_doc varchar(3),
numero_doc int not null
) engine = InnoDB;

create table hoja_confeccion (
cod_confeccion int primary key,
cod_componente int not null,
nro_legajo int not null,
fecha date,
cantidad_fabricada int,
foreign key (cod_componente) references componentes (cod_componente),
foreign key (nro_legajo) references operario (nro_legajo)
) engine = InnoDB;


-- REGISTROS

INSERT INTO televisores (cod_televisor, modelo, caracteristicas) VALUES
(1, 'XVision 55QLED', '55" QLED 4K Smart'),
(2, 'Nova 43LED',     '43" LED FHD Smart'),
(3, 'Orion 65OLED',   '65" OLED 4K HDR');

INSERT INTO componentes (cod_componente, descripcion) VALUES
(10, 'Panel 55" QLED'),
(11, 'Panel 43" LED'),
(12, 'Panel 65" OLED'),
(20, 'Mainboard v2'),
(21, 'Fuente 200W'),
(22, 'Módulo WiFi 802.11ac'),
(23, 'Control remoto RC-100'),
(24, 'Par de patas/soporte');

INSERT INTO importador (nro_importador, razon_social, cuit) VALUES
(100, 'TecnoImport SA',     2001234567),
(101, 'ElectroParts SRL',   2012345678),
(102, 'GlobalComp SA',       209876543);

INSERT INTO operario (nro_legajo, apellido, nombre, domicilio, telefono, tipo_doc, numero_doc) VALUES
(1, 'Gomez', 'Ana',  'Av Siempre Viva 742', '1144440000', 'DNI', 12345678),
(2, 'Perez', 'Luis', 'Calle 10 1234',       '1144441111', 'DNI', 23456789),
(3, 'Lopez', 'Maria','San Martin 55',       '1144442222', 'DNI', 34567890);

INSERT INTO mapa_armado (cod_componente, cod_televisor, cantidad, ubicacion) VALUES
-- TV 1
(10, 1, 1, 'Panel frontal'),
(20, 1, 1, 'Mainboard'),
(21, 1, 1, 'Fuente'),
(22, 1, 1, 'Bandeja WiFi'),
(23, 1, 1, 'Accesorio'),
(24, 1, 1, 'Base/soportes'),
-- TV 2
(11, 2, 1, 'Panel frontal'),
(20, 2, 1, 'Mainboard'),
(21, 2, 1, 'Fuente'),
(22, 2, 1, 'Bandeja WiFi'),
(23, 2, 1, 'Accesorio'),
(24, 2, 1, 'Base/soportes'),
-- TV 3
(12, 3, 1, 'Panel frontal'),
(20, 3, 1, 'Mainboard'),
(21, 3, 1, 'Fuente'),
(22, 3, 1, 'Bandeja WiFi'),
(23, 3, 1, 'Accesorio'),
(24, 3, 1, 'Base/soportes');

INSERT INTO facturas (cod_factura, nro_importador, cod_componente, cantidad, valor) VALUES
(5000, 100, 10, 100, 120.50),  -- Panel 55"
(5006, 100, 11, 100,  80.00),  -- Panel 43"
(5007, 100, 12, 100, 200.00),  -- Panel 65"
(5001, 100, 20, 100,  55.00),  -- Mainboard
(5002, 101, 21, 100,  25.00),  -- Fuente
(5003, 101, 22, 100,   8.75),  -- WiFi
(5004, 102, 23, 100,   3.50),  -- Control remoto
(5005, 102, 24, 100,   9.90);  -- Soporte/patas

INSERT INTO hoja_confeccion (cod_confeccion, cod_componente, nro_legajo, fecha, cantidad_fabricada) VALUES
(900, 10, 1, '2025-09-10',  50),
(901, 20, 2, '2025-09-11',  80),
(902, 21, 2, '2025-09-11',  80),
(903, 22, 3, '2025-09-12', 120),
(904, 23, 1, '2025-09-12', 150),
(905, 24, 3, '2025-09-13',  90),
(906, 11, 1, '2025-09-10',  40),
(907, 12, 2, '2025-09-10',  30);


-- QUERIES

select t.cod_televisor, t.modelo, c.cod_componente, c.descripcion, m.cantidad, m.ubicacion
from televisores t join mapa_armado m on t.cod_televisor = m.cod_televisor
join componentes c on m.cod_componente = c.cod_componente
order by t.cod_televisor, c.cod_componente;


select f.cod_factura, f.cod_componente, c.descripcion, i.razon_social, i.cuit, f.cantidad, f.valor, (f.cantidad * f.valor) total_valor 
from facturas f join importador i on f.nro_importador = i.nro_importador
join componentes c on f.cod_componente = c.cod_componente
order by f.cod_componente, f.cod_factura;
