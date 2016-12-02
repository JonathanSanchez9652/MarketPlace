--INSERCIONES EN LA TABLA usuarios 		(estados posibles a = aceptado , e = espera , i = inhabilitado)
-- tipos de usuarios c = cliente , p = proveedor, a = administrador    
insert into usuarios values (1,'Juan','Perez','juanperez','1234','juanperez@marketplace.com','a',55555,'c');
insert into usuarios values (2,'Angela','Gutierrez','angelagutierrez','1234','angelagutierrez@marketplace.com','e',55555,'c');
insert into usuarios values (3,'Pedro','Sosa','pedrososa','1234','pedrososa@marketplace.com','i',55555,'c');
insert into usuarios values (4,'Comidas','','comidas','1234','comidas@comidas.com','a',55555,'p');
insert into usuarios values (5,'alojamiento','','alojamiento','1234','alojamiento@alojamiento.com','a',55555,'p');
insert into usuarios values (6,'paseos','','paseos','1234','paseos@paseos.com','a',55555,'p');
insert into usuarios values (7,'administrador','','administrador','1234','administrador@administrador.com','a',55555,'a');

--INSERCIONES EN LA TABLA categorias	(categorias c = comida , p = paseos ecológicos, a = alojamiento )
insert into categorias values (1,'c');
insert into categorias values (2,'p');
insert into categorias values (3,'a');

--INSERCIONES EN LA TABLA catalogos
insert into catalogos values(1,'Almuerzo sencillo','jkkljkljkl','Arroz, lenteja, pollo',4,1);
insert into catalogos values(2,'Desayuno sencillo','jkkljkljkl','Chocolate, pan, huevos y fruta',4,1);
insert into catalogos values(3,'Cabañas Santa Marta','jkkljkljkl','3 habitaciones, 1 baño, cocina',5,3);
insert into catalogos values(4,'Hotel vista al mar Cancún','jkkljkljkl','4 habitaciones, 2 baños, cocina',5,3);
insert into catalogos values(5,'Manglares y sierra nevada','jkkljkljkl','Ida y vuelta transportes incluídos',6,2);
insert into catalogos values(6,'Río amazonas','jkkljkljkl','lancha incluída',6,2);

--INSERCIONES EN LA TABLA ofertas
insert into ofertas values(1,5000,'2016-08-13','2016-09-11','huevo opcional gratis',1);
insert into ofertas values(2,4000,'2016-07-13','2016-08-11','Doble pan gratis',2);
insert into ofertas values(3,450000,'2016-09-15','2016-11-12','Calefacción gratis',3);
insert into ofertas values(4,500000,'2016-09-13','2016-10-11','Te regalamos un día adicional',4);
insert into ofertas values(5,800000,'2016-10-13','2016-11-07','Snacks incluídos',5);
insert into ofertas values(6,750000,'2015-03-13','2016-12-11','Incluye vacunas',6);

--INSERCIONES EN LA TABLA calificaciones
insert into calificaciones values(1,3,1,1);
insert into calificaciones values(2,4,1,2);
insert into calificaciones values(3,5,2,3);
insert into calificaciones values(4,2,2,4);
insert into calificaciones values(5,1,3,5);
insert into calificaciones values(6,5,3,6);

--INSERCIONES EN LA TABLA compras
insert into compras values(1,1,1);
insert into compras values(2,1,2);
insert into compras values(3,2,3);
insert into compras values(4,2,4);
insert into compras values(5,3,5);
insert into compras values(6,3,6);

