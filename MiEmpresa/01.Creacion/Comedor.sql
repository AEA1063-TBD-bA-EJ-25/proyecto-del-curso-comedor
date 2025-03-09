CREATE DATABASE Comedor

go

USE Comedor

-- Tablas

CREATE TABLE Tutor (
    id_tutor INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido_paterno NVARCHAR(100) NOT NULL,
    apellido_materno NVARCHAR(100) NOT NULL,
    telefono NVARCHAR(15) NOT NULL,
    telefono_celular NVARCHAR(15),
    lugar_trabajo NVARCHAR(255)
)

SELECT * FROM Tutor

CREATE TABLE Nino (
    id_nino INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido_paterno NVARCHAR(100) NOT NULL,
    apellido_materno NVARCHAR(100) NOT NULL,
    edad INT CHECK (edad > 0),
    grado NVARCHAR(50) NOT NULL,
    nivel NVARCHAR(50) NOT NULL,
    alergias_alimenticias NVARCHAR(MAX),
    id_tutor INT,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE ON UPDATE CASCADE
)

SELECT * FROM Nino

CREATE TABLE Menu (
    id_menu INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL
)

SELECT * FROM Menu

-- La relacion entre Niño-Menu o lo que consumió
CREATE TABLE Consumo (
    id_nino INT,
    id_menu INT,
    PRIMARY KEY (id_nino, id_menu),
    FOREIGN KEY (id_nino) REFERENCES Nino(id_nino) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE
)

SELECT * FROM Consumo

CREATE TABLE Alimento (
    id_alimento INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    datos_nutricionales NVARCHAR(MAX) NOT NULL,
    tipo NVARCHAR(10) NOT NULL CHECK (tipo IN ('COMIDA', 'POSTRE', 'BEBIDA'))
)

SELECT * FROM Alimento

-- La relacion entre menu-alimento
CREATE TABLE Menu_Alimento (
    id_menu INT,
    id_alimento INT,
    PRIMARY KEY (id_menu, id_alimento),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento) ON DELETE CASCADE ON UPDATE CASCADE
)

SELECT * FROM Menu_Alimento

CREATE TABLE Receta (
    id_receta INT IDENTITY(1,1) PRIMARY KEY,
    porciones INT CHECK (porciones > 0)
)

SELECT * FROM Receta

--Relacion entre menu-receta
CREATE TABLE Menu_Receta (
    id_menu INT,
    id_receta INT,
    PRIMARY KEY (id_menu, id_receta),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_receta) REFERENCES Receta(id_receta) ON DELETE CASCADE ON UPDATE CASCADE
)

SELECT * FROM Menu_Receta

CREATE TABLE Ingrediente (
    id_ingrediente INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    unidad NVARCHAR(50) NOT NULL
)

SELECT * FROM Ingrediente

CREATE TABLE Receta_Ingrediente (
    id_receta INT,
    id_ingrediente INT,
    cantidad DECIMAL(10,2) CHECK (cantidad > 0),
    PRIMARY KEY (id_receta, id_ingrediente),
    FOREIGN KEY (id_receta) REFERENCES Receta(id_receta) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente) ON DELETE CASCADE ON UPDATE CASCADE
)

SELECT * FROM Receta_Ingrediente


-- Datos catálogos
INSERT INTO Tutor (nombre, apellido_paterno, apellido_materno, telefono, telefono_celular, lugar_trabajo)
VALUES 
    ('Carlos', 'González', 'Pérez', '6621234567', '6629876543', 'Escuela Primaria X'),
    ('María', 'López', 'García', '6627654321', '6621122334', 'Hospital Y'),
    ('Juan', 'Martínez', 'Hernández', '6623344556', '6629988776', 'Universidad Z'),
    ('Ana', 'Ramírez', 'Torres', '6625566778', '6626677889', 'Oficina A'),
    ('Pedro', 'Sánchez', 'Vargas', '6629988776', '6623344556', 'Fábrica B'),
    ('Laura', 'Fernández', 'Díaz', '6627766554', '6622233445', 'Banco C'),
    ('Jorge', 'Ortega', 'Castillo', '6623344552', '6624433221', 'Consultorio D'),
    ('Andrea', 'Mendoza', 'Rojas', '6622233441', '6626655443', 'Escuela E'),
    ('Luis', 'Cruz', 'Moreno', '6629988771', '6625566778', 'Hospital F'),
    ('Gabriela', 'Reyes', 'Núñez', '6623344559', '6621122335', 'Oficina G');

SELECT * FROM Tutor

INSERT INTO Nino (nombre, apellido_paterno, apellido_materno, edad, grado, nivel, alergias_alimenticias, id_tutor) 
VALUES
    ('Pedro', 'Perez', 'Gomez', 7, 'Primero', 'Primaria', 'Ninguna', 1),
    ('Lucia', 'Lopez', 'Fernandez', 8, 'Segundo', 'Primaria', 'Gluten', 2),
    ('Miguel', 'Sanchez', 'Hernandez', 9, 'Tercero', 'Primaria', 'Lactosa', 3),
    ('Elena', 'Martinez', 'Diaz', 10, 'Cuarto', 'Primaria', 'Nueces', 4),
    ('Javier', 'Gonzalez', 'Ruiz', 11, 'Quinto', 'Primaria', 'Ninguna', 5);

DELETE FROM Tutor
    WHERE id_tutor = 4;

-- Datos operaciones
