-- Write your own SQL object definition here, and it'll be included in your package.
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

CREATE TABLE Menu (
    id_menu INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL
)

-- La relacion entre Niño-Menu o lo que consumió
CREATE TABLE Consumo (
    id_nino INT,
    id_menu INT,
    PRIMARY KEY (id_nino, id_menu),
    FOREIGN KEY (id_nino) REFERENCES Nino(id_nino) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Alimento (
    id_alimento INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    datos_nutricionales NVARCHAR(MAX) NOT NULL,
    tipo NVARCHAR(10) NOT NULL CHECK (tipo IN ('COMIDA', 'POSTRE', 'BEBIDA'))
)

-- La relacion entre menu-alimento
CREATE TABLE Menu_Alimento (
    id_menu INT,
    id_alimento INT,
    PRIMARY KEY (id_menu, id_alimento),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Receta (
    id_receta INT IDENTITY(1,1) PRIMARY KEY,
    porciones INT CHECK (porciones > 0)
)

--Relacion entre menu-receta
CREATE TABLE Menu_Receta (
    id_menu INT,
    id_receta INT,
    PRIMARY KEY (id_menu, id_receta),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_receta) REFERENCES Receta(id_receta) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Ingrediente (
    id_ingrediente INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    unidad NVARCHAR(50) NOT NULL
)

CREATE TABLE Receta_Ingrediente (
    id_receta INT,
    id_ingrediente INT,
    cantidad DECIMAL(10,2) CHECK (cantidad > 0),
    PRIMARY KEY (id_receta, id_ingrediente),
    FOREIGN KEY (id_receta) REFERENCES Receta(id_receta) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente) ON DELETE CASCADE ON UPDATE CASCADE
)

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
    ('Gabriela', 'Reyes', 'Núñez', '6623344559', '6621122335', 'Oficina G'),
    ('Roberto', 'Gómez', 'Luna', '6621112233', '6629998887', 'Empresa H'),
    ('Elena', 'Hernández', 'Pérez', '6622223344', '6628887776', 'Escuela I'),
    ('Miguel', 'Vargas', 'Gómez', '6623334455', '6627776665', 'Universidad J'),
    ('Sofía', 'Jiménez', 'Flores', '6624445566', '6626665554', 'Hospital K'),
    ('Fernando', 'Díaz', 'Hernández', '6625556677', '6625554443', 'Banco L'),
    ('Carmen', 'Torres', 'Ramírez', '6626667788', '6624443332', 'Oficina M'),
    ('Raúl', 'Castillo', 'Santos', '6627778899', '6623332221', 'Consultorio N'),
    ('Patricia', 'Morales', 'Ortega', '6628889900', '6622221110', 'Escuela O'),
    ('Alejandro', 'López', 'Fernández', '6629990011', '6621110009', 'Hospital P'),
    ('Daniela', 'Reyes', 'García', '6621234321', '6629090807', 'Empresa Q');

INSERT INTO Nino (nombre, apellido_paterno, apellido_materno, edad, grado, nivel, alergias_alimenticias, id_tutor) 
VALUES
    ('Pedro', 'Perez', 'Gomez', 7, 'Primero', 'Primaria', 'Ninguna', 1),
    ('Lucia', 'Lopez', 'Fernandez', 8, 'Segundo', 'Primaria', 'Gluten', 2),
    ('Miguel', 'Sanchez', 'Hernandez', 9, 'Tercero', 'Primaria', 'Lactosa', 3),
    ('Elena', 'Martinez', 'Diaz', 10, 'Cuarto', 'Primaria', 'Nueces', 4),
    ('Javier', 'Gonzalez', 'Ruiz', 11, 'Quinto', 'Primaria', 'Ninguna', 5),
    ('Andrés', 'García', 'Luna', 6, 'Primero', 'Primaria', 'Ninguna', 6),
    ('Valeria', 'Hernández', 'Torres', 7, 'Segundo', 'Primaria', 'Mariscos', 7),
    ('Emiliano', 'Vargas', 'Ortega', 8, 'Tercero', 'Primaria', 'Frutos secos', 8),
    ('Camila', 'Jiménez', 'Santos', 9, 'Cuarto', 'Primaria', 'Chocolate', 9),
    ('Mateo', 'Díaz', 'Ramírez', 10, 'Quinto', 'Primaria', 'Lácteos', 10),
    ('Samantha', 'Torres', 'Gómez', 11, 'Sexto', 'Primaria', 'Ninguna', 11),
    ('Diego', 'Castillo', 'Fernández', 7, 'Primero', 'Primaria', 'Pescado', 12),
    ('Renata', 'Morales', 'Mendoza', 8, 'Segundo', 'Primaria', 'Ninguna', 13),
    ('Sebastián', 'López', 'Cruz', 9, 'Tercero', 'Primaria', 'Huevos', 14),
    ('Isabella', 'Reyes', 'Flores', 10, 'Cuarto', 'Primaria', 'Ninguna', 15),
       ('Luciano', 'Fernández', 'Ruiz', 6, 'Primero', 'Primaria', 'Ninguna', 16),
    ('Mariana', 'Santos', 'López', 7, 'Segundo', 'Primaria', 'Maní', 17),
    ('Tomás', 'Gómez', 'Díaz', 8, 'Tercero', 'Primaria', 'Ninguna', 18),
    ('Regina', 'Ortega', 'Vargas', 9, 'Cuarto', 'Primaria', 'Fresas', 19),
    ('Joaquín', 'Cruz', 'Jiménez', 10, 'Quinto', 'Primaria', 'Ninguna', 20);

    INSERT INTO Alimento (nombre, datos_nutricionales, tipo) 
    VALUES
    ('Arroz', 'Carbohidratos, fibra', 'COMIDA'),
    ('Pollo', 'Proteínas, baja grasa', 'COMIDA'),
    ('Pescado', 'Omega-3, proteínas', 'COMIDA'),
    ('Frijoles', 'Fibra, proteínas', 'COMIDA'),
    ('Manzana', 'Vitaminas, antioxidantes', 'POSTRE'),
    ('Plátano', 'Potasio, carbohidratos', 'POSTRE'),
    ('Leche', 'Calcio, proteínas', 'BEBIDA'),
    ('Jugo de Naranja', 'Vitamina C, antioxidantes', 'BEBIDA'),
    ('Tortilla', 'Carbohidratos, calcio', 'COMIDA'),
    ('Queso', 'Proteínas, calcio', 'COMIDA'),
    ('Zanahoria', 'Betacaroteno, fibra', 'COMIDA'),
    ('Brócoli', 'Fibra, vitaminas', 'COMIDA'),
    ('Ensalada', 'Fibra, vitaminas', 'COMIDA'),
    ('Pan Integral', 'Fibra, carbohidratos', 'COMIDA'),
    ('Yogur', 'Probióticos, calcio', 'POSTRE'),
    ('Gelatina', 'Colágeno, sin grasa', 'POSTRE'),
    ('Refresco Natural', 'Vitaminas, sin azúcar', 'BEBIDA'),
    ('Cereal Integral', 'Fibra, proteínas', 'COMIDA'),
    ('Huevo', 'Proteínas, grasas saludables', 'COMIDA'),
    ('Pasta', 'Carbohidratos, fibra', 'COMIDA');


    INSERT INTO Ingrediente (nombre, unidad) VALUES
    ('Harina', 'Kilogramos'),
    ('Azúcar', 'Gramos'),
    ('Sal', 'Gramos'),
    ('Aceite', 'Litros'),
    ('Leche', 'Litros'),
    ('Huevo', 'Piezas'),
    ('Queso', 'Gramos'),
    ('Carne de Res', 'Kilogramos'),
    ('Carne de Pollo', 'Kilogramos'),
    ('Pescado', 'Kilogramos'),
    ('Tomate', 'Piezas'),
    ('Cebolla', 'Piezas'),
    ('Zanahoria', 'Piezas'),
    ('Papa', 'Kilogramos'),
    ('Chícharos', 'Gramos'),
    ('Arroz', 'Gramos'), 
    ('Frijoles', 'Gramos'), 
    ('Pasta', 'Gramos'),
    ('Chocolate', 'Gramos'),
    ('Fresas', 'Gramos');


    INSERT INTO Menu (nombre) VALUES
    ('Desayuno Escolar'), 
    ('Almuerzo Saludable'),
    ('Cena Ligera'),
     ('Merienda Nutritiva'),
    ('Menú Infantil'), 
    ('Menú Vegetariano'), 
    ('Menú Sin Gluten'), 
    ('Menú Bajo en Calorías'),
    ('Menú Deportivo'), ('Menú Especial Navidad'), ('Menú Otoñal'), ('Menú Primaveral'),
    ('Menú Veraniego'), ('Menú Invierno'), ('Menú de Pascua'), ('Menú Fiesta Infantil'),
    ('Menú Internacional'), ('Menú Mexicano'), ('Menú Italiano'), ('Menú Asiático');

    INSERT INTO Menu_Alimento (id_menu, id_alimento) VALUES
    (1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10),
    (11,11), (12,12), (13,13), (14,14), (15,15), (16,16), (17,17), (18,18), (19,19), (20,20),
    (1,2), (2,3), (3,4), (4,5), (5,6), (6,7), (7,8), (8,9), (9,10), (10,11),
    (11,12), (12,13), (13,14), (14,15), (15,16), (16,17), (17,18), (18,19), (19,20), (20,1),
    (1,3), (2,4), (3,5), (4,6), (5,7), (6,8), (7,9), (8,10), (9,11), (10,12),
    (11,13), (12,14), (13,15), (14,16), (15,17), (16,18), (17,19), (18,20), (19,1), (20,2);


    INSERT INTO Consumo (id_nino, id_menu) VALUES
    (1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10),
    (11,11), (12,12), (13,13), (14,14), (15,15), (16,16), (17,17), (18,18), (19,19), (20,20),
    (1,2), (2,3), (3,4), (4,5), (5,6), (6,7), (7,8), (8,9), (9,10), (10,11),
    (11,12), (12,13), (13,14), (14,15), (15,16), (16,17), (17,18), (18,19), (19,20), (20,1),
    (1,3), (2,4), (3,5), (4,6), (5,7), (6,8), (7,9), (8,10), (9,11), (10,12),
    (11,13), (12,14), (13,15), (14,16), (15,17), (16,18), (17,19), (18,20), (19,1), (20,2),
    (1,4), (2,5), (3,6), (4,7), (5,8), (6,9), (7,10), (8,11), (9,12), (10,13),
    (11,14), (12,15), (13,16), (14,17), (15,18), (16,19), (17,20), (18,1), (19,2), (20,3),
    (1,5), (2,6), (3,7), (4,8), (5,9), (6,10), (7,11), (8,12), (9,13), (10,14),
    (11,15), (12,16), (13,17), (14,18), (15,19), (16,20), (17,1), (18,2), (19,3), (20,4);


    INSERT INTO Menu_Receta (id_menu, id_receta) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6), (4, 7), (4, 8), (5, 9), (5, 10),
(6, 11), (6, 12), (7, 13), (7, 14), (8, 15), (8, 16), (9, 17), (9, 18), (10, 19), (10, 20),
(11, 1), (11, 2), (12, 3), (12, 4), (13, 5), (13, 6), (14, 7), (14, 8), (15, 9), (15, 10),
(16, 11), (16, 12), (17, 13), (17, 14), (18, 15), (18, 16), (19, 17), (19, 18), (20, 19), (20, 20),
(1, 3), (2, 5), (3, 7), (4, 9), (5, 11), (6, 13), (7, 15), (8, 17), (9, 19), (10, 1),
(11, 4), (12, 6), (13, 8), (14, 10), (15, 12), (16, 14), (17, 16), (18, 18), (19, 20), (20, 2),
(1, 6), (2, 8), (3, 10), (4, 12), (5, 14), (6, 16), (7, 18), (8, 20), (9, 2), (10, 4),
(11, 7), (12, 9), (13, 11), (14, 13), (15, 15), (16, 17), (17, 19), (18, 1), (19, 3), (20, 5),
(1, 9), (2, 11), (3, 13), (4, 15), (5, 17), (6, 19), (7, 1), (8, 3), (9, 5), (10, 7),
(11, 10), (12, 12), (13, 14), (14, 16), (15, 18), (16, 20), (17, 2), (18, 4), (19, 6), (20, 8);


INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad) VALUES
(1, 1, 2.5), (1, 2, 1.0), (2, 3, 0.5), (2, 4, 3.0), (3, 5, 1.2), (3, 6, 2.3), (4, 7, 1.1), (4, 8, 2.7), (5, 9, 3.5), (5, 10, 1.4),
(6, 11, 0.8), (6, 12, 1.9), (7, 13, 2.1), (7, 14, 1.3), (8, 15, 2.6), (8, 16, 3.2), (9, 17, 0.9), (9, 18, 1.7), (10, 19, 2.4), (10, 20, 1.5),
(11, 1, 1.8), (11, 3, 2.2), (12, 5, 3.0), (12, 7, 1.6), (13, 9, 2.0), (13, 11, 3.3), (14, 13, 1.9), (14, 15, 2.8), (15, 17, 1.7), (15, 19, 3.1),
(16, 2, 1.5), (16, 4, 2.9), (17, 6, 3.4), (17, 8, 1.2), (18, 10, 2.3), (18, 12, 3.5), (19, 14, 1.1), (19, 16, 2.7), (20, 18, 1.4), (20, 20, 3.6),
(1, 5, 2.0), (2, 10, 1.8), (3, 15, 2.5), (4, 20, 3.1), (5, 1, 1.2), (6, 6, 2.9), (7, 11, 1.3), (8, 16, 3.4), (9, 2, 2.7), (10, 7, 1.1),
(11, 12, 2.6), (12, 17, 3.0), (13, 3, 1.9), (14, 8, 2.8), (15, 13, 1.5), (16, 18, 3.2), (17, 4, 1.6), (18, 9, 2.3), (19, 14, 1.4), (20, 19, 3.5),
(1, 6, 2.2), (2, 11, 1.7), (3, 16, 3.0), (4, 1, 2.1), (5, 7, 1.9), (6, 12, 3.3), (7, 17, 1.5), (8, 2, 2.8), (9, 8, 3.6), (10, 13, 1.2),
(11, 18, 2.5), (12, 3, 3.1), (13, 9, 1.4), (14, 14, 2.7), (15, 19, 3.2), (16, 4, 1.8), (17, 10, 2.9), (18, 15, 1.3), (19, 20, 3.0), (20, 5, 1.6);


Select * from Tutor
SELECT * FROM Nino 
SELECT * FROM Alimento
SELECT * FROM Ingrediente

SELECT * FROM Nino
WHERE edad = 10;

SELECT * FROM Alimento
WHERE tipo = 'COMIDA'

SELECT Menu.nombre
FROM Menu_Alimento
JOIN Menu ON Menu_Alimento.id_menu = Menu.id_menu
WHERE id_alimento = 2;

SELECT * FROM Nino
WHERE alergias_alimenticias IS NOT NULL AND alergias_alimenticias != '';

SELECT Nino.nombre, Nino.apellido_paterno, Nino.apellido_materno, Tutor.nombre AS tutor_nombre, Tutor.apellido_paterno AS tutor_apellido_paterno
FROM Nino
JOIN Tutor ON Nino.id_tutor = Tutor.id_tutor;

SELECT Menu.nombre AS menu_nombre, Alimento.nombre AS alimento_nombre
FROM Menu_Alimento
JOIN Menu ON Menu_Alimento.id_menu = Menu.id_menu
JOIN Alimento ON Menu_Alimento.id_alimento = Alimento.id_alimento;

SELECT Menu.nombre AS menu_nombre, Receta.id_receta, Receta.porciones
FROM Menu_Receta
JOIN Menu ON Menu_Receta.id_menu = Menu.id_menu
JOIN Receta ON Menu_Receta.id_receta = Receta.id_receta;

SELECT Receta.id_receta, Ingrediente.nombre AS ingrediente_nombre, Receta_Ingrediente.cantidad, Ingrediente.unidad
FROM Receta_Ingrediente
JOIN Receta ON Receta_Ingrediente.id_receta = Receta.id_receta
JOIN Ingrediente ON Receta_Ingrediente.id_ingrediente = Ingrediente.id_ingrediente;

SELECT Nino.nombre, Nino.apellido_paterno, Menu.nombre AS menu_nombre
FROM Consumo
JOIN Nino ON Consumo.id_nino = Nino.id_nino
JOIN Menu ON Consumo.id_menu = Menu.id_menu;
