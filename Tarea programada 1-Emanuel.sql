--Tarea programada 1
--Emanuel Jiménez Cubero
--B84036

--Este es el codigo para crear la base de datos segun mi modelo relacional.

create database DISTRIBUIDORA
-- Ahora voy a crear las tablas de acuaerdo al modelo relacional
--Primero PROVEEDOR
create table proveedor(
cedula int primary key,
tipodecedula varchar(80) not null,
nombre varchar(80) not null,
correoelectronico varchar(80) not null
)
--Ahora voy a crear la tabla de la entidad Direccion
Create table direccion(
id int identity (1,1) primary key,
disticto varchar(80) not null,
canton varchar(80) not null,
prvincia varchar(80) not null,
proveedor_cedula INT,  -- Columna para la clave foránea
    foreign key (proveedor_cedula) references proveedor(cedula)
)
--Ahora la tabla producto
create table producto(
id_producto int identity(1,1) primary key,
id_universal varchar(80) not null,
nombre varchar(80) not null,
tamano_fisico varchar(80) not null,
color varchar(80) not null,
precio decimal(10,2) not null
)
--Ahora creo la relacion de muchos a muchos, la tabla intermedia
create table suministra (
    proveedor_cedula int,
    id_producto int,
	cantidad int not null,
    primary key (proveedor_cedula, id_producto),
    foreign key (proveedor_cedula) references proveedor(cedula),
    foreign key (id_producto) references producto(id_producto)
) 
--Ahora la tabla categoria
create table categoria(
codigo_contador int identity(1,1) primary key,
nombre varchar(80),
id_producto int,  -- Columna para la clave foránea
    foreign key (id_producto) references producto(id_producto)
)
--Ahora la tabla sub-categoria
create table sub_categoria(
codigo_subcontador int identity(1,1) primary key,
nombre varchar(80),
codigo_contador INT,  -- Columna para la clave foránea
   foreign key (codigo_contador) references categoria(codigo_contador)
)
--Ahora la tabla factura
create table factura(
numero_factura int identity(1,1) primary key,
cantidad_unidades int not null,
descuento int not null,
impuestos varchar (80) not null,
porcentaje_impuestos decimal(5,2),
porcentaje_descuento decimal(5,2),
fecha date not null,
)
--Ahora creo la relacion de muchos a muchos, la tabla intermedia
create table refleja (
    id_producto int,                     
    numero_factura int,
	precio_producto int not null,
    primary key (id_producto, numero_factura),
    foreign key (id_producto) references producto(id_producto),
    foreign key (numero_factura) references factura(numero_factura)
)
--Ahora la tabla cliente
create table cliente(
cedula_cliente int not null,
direccion varchar(300) not null,
correo varchar(80),
telefono varchar (15) not null,
nombre varchar(80) not null,
numero_factura INT,  -- Columna para la clave foránea
    foreign key (numero_factura) references factura(numero_factura)
) 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                       ---Ahora voy a insertar los datos---
									   -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO proveedor (cedula, tipodecedula, nombre, correoelectronico)
VALUES
    (208000368, 'Persona Física', 'María Rodríguez Pérez', 'Rodríguez@gmail.com'),
    (308800543, 'Persona Jurídica', 'Juan García López', 'García@gmail.com'),
	(207540363, 'Persona Física', 'Laura Torres Sánchez', 'Torres@gmail.com'),
    (508800743, 'Persona Jurídica', 'Pedro López González', 'López@gmail.com'),
    (708800543, 'Persona Física', 'Emanuel Jiménez Cubero', 'Jiménez@gmail.com')

-- Insertar datos en la tabla direccion
INSERT INTO direccion (disticto, canton, prvincia, proveedor_cedula)
VALUES
    ('San Sebastián', 'Escazú', 'San José', 208000368),
	('Desamparados', 'Alajuela', 'Alajuela', 308800543),
	('Guarco', 'Tejar', 'Cartago', 207540363),
	('Parcelas', 'Tilarán', 'Gunacaste', 508800743),
    ('Los Angeles', 'Siquirres', 'Limon', 708800543)

-- Insertar datos en la tabla producto
INSERT INTO producto (id_universal, nombre, tamano_fisico, color, precio)
VALUES
    ('P12345', 'Producto 1', 'Pequeño', 'Rojo', 1250),
    ('P12345', 'Producto 2', 'mediano', 'Azul', 2050),
	('P12345', 'Producto 3', 'grande', 'Verde', 3400),
	('P12345', 'Producto 4', 'Pequeño', 'Amarillo', 1250),
	('P12345', 'Producto 5', 'grande', 'Rojo', 3400)

-- Insertar datos en la tabla suministra (relación muchos a muchos)
INSERT INTO suministra (proveedor_cedula, id_producto, cantidad)
VALUES
    (208000368, 1,3),
	(308800543, 2,5),
	(207540363, 3,2),
	(508800743, 4,1),
    (708800543, 5,2)
-- Insertar datos en la tabla categoria
INSERT INTO categoria (nombre, id_producto)
VALUES
    ('Categoría 1', 1),
	('Categoría 2', 2),
	('Categoría 1', 3),
	('Categoría 2', 4),
    ('Categoría 1', 5)

-- Insertar datos en la tabla sub_categoria
INSERT INTO sub_categoria (nombre, codigo_contador)
VALUES
    ('Subcategoría 1', 1),
	('Subcategoría 2', 2),
	('Subcategoría 3', 3),
	('Subcategoría 1', 4),
    ('Subcategoría 2', 5)

-- Insertar datos en la tabla factura

-- Insertar datos en la tabla "factura"
INSERT INTO factura (cantidad_unidades, descuento, impuestos, porcentaje_impuestos, porcentaje_descuento, fecha)
VALUES 
    (5, 50, 'IVA', 15.00, 10.00, '2023-09-13'),
    (3, 20, 'Impuesto de ventas', 7.50, 5.00, '2023-09-14'),
    (7, 75, 'Impuesto al consumo', 20.00, 15.00, '2023-09-15'),
    (4, 30, 'IVA', 12.00, 8.00, '2023-09-16'),
    (6, 40, 'Impuesto de ventas', 10.00, 7.50, '2023-09-17')

INSERT INTO refleja (id_producto, numero_factura,precio_producto)
VALUES
	(1,1,3795),
	(2,2,10467.83),
	(3,3,6937),
	(4,4,1288),
	(5,5,6919)

-- Insertar datos en la tabla cliente
INSERT INTO cliente (cedula_cliente, direccion, correo, telefono, nombre, numero_factura)
VALUES
    (12222122, '	Guadalupe', 'Perez@gmail.com', '82604057', 'Juana Perez', 1),
    (223222, 'Mozotal ', 'Arce@gmail.com', '87603957', 'Luisa Arce', 2),
    (33333, 'Purral ', 'Ruiz@gmail.com', '87604009', 'Antonio Ruiz', 3),
    (434444, 'Carrillos ', 'Campbell@gmail.com', '82104057', 'Joel Campbell', 4),
    (25555, '	Grecia ', '´Lopez@gmail.com', '87603257', 'Yaritza López', 5)

-------------Tercera parte
--¿Cuánto dinero se ha vendido en total por mes?
SELECT
    SUM(precio_producto) AS TotalVentas
FROM
    refleja
---¿Cuántos productos diferentes tiene la empresa?
SELECT COUNT(DISTINCT id_producto) AS CantidadProductos
FROM producto
---¿Cuáles son los proveedores a los que más unidades de productos se les compra?
SELECT
    P.nombre AS Proveedor,
    SUM(S.cantidad) AS TotalUnidadesCompradas
FROM
    suministra S
JOIN
    proveedor P ON S.proveedor_cedula = P.cedula
GROUP BY
    P.nombre
ORDER BY
    TotalUnidadesCompradas DESC;---¿Cuáles son los clientes a los que más unidades de productos se les vende?SELECT
    C.nombre AS Cliente,
    SUM(F.cantidad_unidades) AS TotalUnidadesVendidas
FROM
    cliente C
JOIN
    factura F ON C.numero_factura = F.numero_factura
GROUP BY
    C.nombre
ORDER BY
    TotalUnidadesVendidas DESC;


---¿Qué categoría de producto vende menos?
SELECT
    C.nombre AS Categoria,
    SUM(F.cantidad_unidades) AS TotalUnidadesVendidas
FROM
    categoria C
LEFT JOIN
    producto P ON C.id_producto = P.id_producto
LEFT JOIN
    refleja R ON P.id_producto = R.id_producto
LEFT JOIN
    factura F ON R.numero_factura = F.numero_factura
GROUP BY
    C.nombre
ORDER BY
    TotalUnidadesVendidas ASC;

