CREATE DATABASE Libreria
GO

USE Libreria
GO

CREATE SCHEMA Catalogo
GO
CREATE SCHEMA Ventas
GO

--TABLA1 (T1)
CREATE TABLE Catalogo.Autores
(
	AutorID INT IDENTITY (1,3) PRIMARY KEY,
	Nombre VARCHAR (100),
	Apellido VARCHAR (100)
)

--Modificación Nombre Columna (T1)
EXEC sp_rename 'Catalogo.Autores.Nombre','Nombre_Autor','COLUMN';
EXEC sp_rename 'Catalogo.Autores.Apellido','Apellido_Autor','COLUMN';

-- Columa Adicional (T1)
ALTER TABLE Catalogo.Autores
ADD Nacionalidad VARCHAR(100)

ALTER TABLE Catalogo.Autores
ADD Telefono INT

SELECT * FROM Catalogo.Autores

--TABLA2 (T2)
CREATE TABLE Catalogo.Categorias
(
	CategoriaID INT IDENTITY (2,3) PRIMARY KEY,
	Nombre VARCHAR (100) UNIQUE
)

--Modificación Nombre Columna (T2)
EXEC sp_rename 'Catalogo.Categorias.Nombre','Nombre_Categoria','COLUMN';
SELECT * FROM Catalogo.Categorias

--TABLA 3 (T3)
CREATE TABLE Catalogo.Libros
(
	LibroID INT IDENTITY (5,10) UNIQUE,
	Titulo NVARCHAR(200),
	AutorID INT PRIMARY KEY,
	CategoriaID INT,
	Precio NUMERIC
	CONSTRAINT FK_AutorID_CON_AUTORID_AUTORES FOREIGN KEY(AutorID)
	REFERENCES Catalogo.Autores(AutorID)
)

--Relación Modelo (T3)
ALTER TABLE Catalogo.Libros
ADD CONSTRAINT FK_CATEGORIAID_CON_CATEGORIAID_CATEGORIAS FOREIGN KEY (CategoriaID)
REFERENCES Catalogo.Categorias (CategoriaID)

-- Columa Adicional (T3)
ALTER TABLE Catalogo.Libros
ADD Editorial NVARCHAR (300)

ALTER TABLE Catalogo.Libros
ADD Fecha_Publicacion DATE

SELECT * FROM Catalogo.Libros

--TABLA4 (T4)

CREATE TABLE Ventas.Clientes
(
	ClienteID INT IDENTITY (4,5) PRIMARY KEY,
	Nombre VARCHAR (100),
	Apellido VARCHAR (100),
	Correo NVARCHAR (200)
)

SELECT * FROM Ventas.Clientes

--TABLA5 (T5)

CREATE TABLE Ventas.Ventas
(
	VentaID INT IDENTITY (4,5) PRIMARY KEY,
	ClienteID INT,
	FechaVenta DATE
	CONSTRAINT FK_CLIENTEID_CON_CLIENTEID_AUTORES FOREIGN KEY(ClienteID)
	REFERENCES Ventas.Clientes (ClienteID)
)

SELECT * FROM Ventas.Ventas

--TABLA6 (T6)

CREATE TABLE Ventas.DetalleVentas
(
	DetalleID INT IDENTITY (4,5) UNIQUE,
	VentaID INT,
	LibroID INT,
	Cantidad INT NOT NULL,
	PrecioVenta NUMERIC
	CONSTRAINT FK_VENTAID_CON_VENTAID_VENTAS FOREIGN KEY(VentaID)
	REFERENCES Ventas.Ventas (VentaID)
)

--Relación Modelo (T6)
ALTER TABLE Ventas.DetalleVentas
ADD CONSTRAINT FK_LIBROID_CON_LIBROID_LIBRO FOREIGN KEY(LibroID)
REFERENCES Catalogo.Libros(LibroID)
	

	---INSERTAR DATOS---

SELECT * FROM Catalogo.Autores
INSERT INTO Catalogo.Autores(Nombre_Autor,Apellido_Autor,Nacionalidad,Telefono)
VALUES
('Gabriel', 'Garcia', 'Colombiano', 123-456-7890)
,('Maria', 'Martinez', 'Mexicana', 987-654-3210)
,('Juan', 'Lopez', 'Español', 456-789-0123)
,('Emily', 'Smith', 'Estadounidense', 789-012-3456)
,('Rajesh', 'Patel', 'Indio', 234-567-8901)
,('Sophie', 'Dupont', 'Francesa', 567-890-1234)
,('Luis', 'Fernandez', 'Argentino', 890-123-4567)
,('Hiroshi', 'Tanaka', 'Japonés', 678-901-2345)
,('Anna', 'Kowalski', 'Polaca', 901-234-5678)
,('Ali', 'Khan', 'Pakistani', 345-678-9012)

SELECT * FROM Catalogo.Categorias
INSERT INTO Catalogo.Categorias(Nombre_Categoria)
VALUES
('Ficción contemporánea			'		 )
,('Literatura clásica				'	 )
,('Ciencia ficción				'		 )
,('Fantasía						'		 )
,('Misterio y suspense			'		 )
,('Romance						'		 )
,('No ficción						'	 )
,('Historia						'		 )
,('Ciencia y tecnología			'		 )
,('Autoayuda y desarrollo personal'		 )

SELECT * FROM Catalogo.Libros
INSERT INTO Catalogo.Libros(Titulo,AutorID,CategoriaID,Precio,Editorial,Fecha_Publicacion)
VALUES
('Cien años de soledad', 4, 29, 20.99, 'Editorial Sudamericana', '1967-05-30'				)
,('Harry Potter y la piedra filosofal', 7, 8, 15.50, 'Bloomsbury Publishing', '1997-06-26'	)
,('El código Da Vinci', 10, 26, 18.95, 'Doubleday', '2003-03-18'								)
,('1984', 13, 11, 12.75, 'Secker & Warburg', '1949-06-08'										)
,('El principito', 16, 2, 8.99, 'Gallimard', '1943-04-06'									)
,('El señor de los anillos', 19, 23, 25.00, 'George Allen & Unwin', '1954-07-29'				)
,('Breve historia del tiempo', 22, 5, 16.99, 'Bantam Books', '1988-04-01'					)
,('Orgullo y prejuicio', 25, 14, 10.25, 'Thomas Egerton', '1813-01-28'						)
,('El alquimista', 28, 20, 14.00, 'HarperCollins', '1988-01-01'								)
,('Percy Jackson y el ladrón del rayo', 31, 17, 13.50, 'Miramax Books', '2005-06-28'			)

SELECT * FROM Ventas.Clientes
INSERT INTO Ventas.Clientes(Nombre,Apellido,Correo)
VALUES
('Juan', 'López', 'juan.lopez@example.com')
,('María', 'González', 'maria.gonzalez@example.com')
,('Pedro', 'Martínez', 'pedro.martinez@example.com')
,('Ana', 'Pérez', 'ana.perez@example.com')
,('Laura', 'Díaz', 'laura.diaz@example.com')
,('Carlos', 'Rodríguez', 'carlos.rodriguez@example.com')
,('Sofía', 'Hernández', 'sofia.hernandez@example.com')
,('David', 'Sánchez', 'david.sanchez@example.com')
,('Lucía', 'López', 'lucia.lopez@example.com')
,('José', 'Gómez', 'jose.gomez@example.com')

SELECT * FROM Ventas.Ventas
INSERT INTO Ventas.Ventas(ClienteID,FechaVenta)
VALUES
 (4, '2024-05-01')
,(9, '2024-05-02')
,(14, '2024-05-03')
,(19, '2024-05-04')
,(24, '2024-05-05')
,(29, '2024-05-06')
,(34, '2024-05-07')
,(39, '2024-05-08')
,(44, '2024-05-09')
,(49, '2024-05-10')

SELECT * FROM Ventas.DetalleVentas
INSERT INTO Ventas.DetalleVentas(VentaID,LibroID,Cantidad,PrecioVenta)
VALUES
(4, 35, 2, 35.99)
,(9, 45, 1, 18.50)
,(14, 55, 3, 49.95)
,(19, 65, 1, 12.75)
,(24, 75, 2, 22.99)
,(29, 85, 1, 16.00)
,(34, 95, 4, 65.00)
,(39, 105, 1, 10.25)
,(44, 115, 2, 28.00)
,(49, 125, 3, 39.50)