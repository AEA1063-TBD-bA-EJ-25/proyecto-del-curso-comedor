CREATE DATABASE Comedor;
GO

USE Comedor;

--Tabla tutor
CREATE TABLE Tutor (
    id_tutor INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido_paterno NVARCHAR(100) NOT NULL,
    apellido_materno NVARCHAR(100) NOT NULL,
    telefono NVARCHAR(15) NOT NULL,
    telefono_celular NVARCHAR(15),
    lugar_trabajo NVARCHAR(255)
);

--Tabla niños
CREATE TABLE Nino (
    id_nino INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido_paterno NVARCHAR(100) NOT NULL,
    apellido_materno NVARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    grado NVARCHAR(50) NOT NULL,
    nivel NVARCHAR(50) NOT NULL,
    alergias_alimenticias NVARCHAR(MAX),
    id_tutor INT NOT NULL,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE ON UPDATE CASCADE
);

--Tabla Semana
CREATE TABLE Semana (
    id_semana INT IDENTITY(1,1) PRIMARY KEY,
    fecha_inicio DATE,
    id_menu INT,
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu)
);

--Tabla menu
CREATE TABLE Menu (
    id_menu INT IDENTITY(1,1) PRIMARY KEY,
    nombre_menu VARCHAR(100)
);

--Tabla comida
CREATE TABLE Comida (
    id_comida INT IDENTITY(1,1) PRIMARY KEY,
    nombre_comida VARCHAR(100)
);

CREATE TABLE Menu_Comida (
    id_menu INT,
    id_comida INT,
    PRIMARY KEY (id_menu, id_comida),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (id_comida) REFERENCES Comida(id_comida)
);

--Tabla bebida
CREATE TABLE Bebida (
    id_bebida INT IDENTITY(1,1) PRIMARY KEY,
    nombre_bebida VARCHAR(100)
);

CREATE TABLE Menu_Bebida (
    id_menu INT,
    id_bebida INT,
    PRIMARY KEY (id_menu, id_bebida),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (id_bebida) REFERENCES Bebida(id_bebida)
);

--Tabla Postre
CREATE TABLE Postre (
    id_postre INT IDENTITY(1,1) PRIMARY KEY,
    nombre_postre VARCHAR(100)
);

CREATE TABLE Menu_Postre (
    id_menu INT,
    id_postre INT,
    PRIMARY KEY (id_menu, id_postre),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (id_postre) REFERENCES Postre(id_postre)
);

--Tabla receta
CREATE TABLE Receta (
    id_receta INT IDENTITY(1,1) PRIMARY KEY,
    id_comida INT NULL,
    id_bebida INT NULL,
    id_postre INT NULL,
    procedimiento TEXT,
    porciones INT,
    FOREIGN KEY (id_comida) REFERENCES Comida(id_comida),
    FOREIGN KEY (id_bebida) REFERENCES Bebida(id_bebida),
    FOREIGN KEY (id_postre) REFERENCES Postre(id_postre)
);

--Tabla ingredientes
CREATE TABLE Ingrediente (
    id_ingrediente INT IDENTITY(1,1) PRIMARY KEY,
    nombre_ingrediente VARCHAR(100)
);

--Relacion receta - ingrediente
CREATE TABLE Receta_Ingrediente (
    id_receta INT,
    id_ingrediente INT,
    cantidad DECIMAL(10,2),
    unidad VARCHAR(50),
    PRIMARY KEY (id_receta, id_ingrediente),
    FOREIGN KEY (id_receta) REFERENCES Receta(id_receta),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente)
);

--Relación entre Niño y Menú (Consumo)
CREATE TABLE Consumo (
    id_consumo INT IDENTITY(1,1) PRIMARY KEY,
    id_nino INT,
    id_semana INT,
    id_menu INT,
    dia_semana VARCHAR(10),
    id_comida INT,
    id_bebida INT,
    id_postre INT,
    cantidad_porciones INT,
    FOREIGN KEY (id_nino) REFERENCES Nino(id_nino),
    FOREIGN KEY (id_semana) REFERENCES Semana(id_semana),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (id_comida) REFERENCES Comida(id_comida),
    FOREIGN KEY (id_bebida) REFERENCES Bebida(id_bebida),
    FOREIGN KEY (id_postre) REFERENCES Postre(id_postre)
);



--********************************************************
--Tabla de compras (registro de ingredientes y pedidos semanales)
CREATE TABLE Compra (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    id_semana INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad_necesaria DECIMAL(10,2) NOT NULL CHECK (cantidad_necesaria > 0),
    fecha_compra DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_semana) REFERENCES Semana(id_semana) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente) ON DELETE CASCADE ON UPDATE CASCADE
);

--Tabla de pagos
CREATE TABLE Pago (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_tutor INT NOT NULL,
    id_semana INT NOT NULL,
    total DECIMAL(10,2) NOT NULL CHECK (total > 0),
    fecha_pago DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_semana) REFERENCES Semana(id_semana) ON DELETE CASCADE ON UPDATE CASCADE
);


--************************************************************************************************************

-- Insertar datos catálogos

-- Inserciones en la tabla Tutor
INSERT INTO Tutor (nombre, apellido_paterno, apellido_materno, telefono, telefono_celular, lugar_trabajo)
VALUES 
    ('Carlos', 'González', 'Pérez', '6621234567', '6629876543', 'Escuela Primaria X'),
    ('María', 'López', 'García', '6627654321', '6621122334', 'Hospital Y'),
    ('Juan', 'Martínez', 'Hernández', '6623344556', '6629988776', 'Universidad Z'),
    ('Sofía', 'Ramírez', 'Jiménez', '6628765432', '6622233445', 'Oficina A'),
    ('Luis', 'Rodríguez', 'Mendoza', '6629988777', '6623344556', 'Colegio B');



-- Inserciones en la tabla Niño
INSERT INTO Nino (nombre, apellido_paterno, apellido_materno, fecha_nacimiento, grado, nivel, alergias_alimenticias, id_tutor) 
VALUES
    ('Pedro', 'Perez', 'Gomez', '2005-03-28', 'Primero', 'Primaria', 'Ninguna', 1),
    ('Juan', 'Ramírez', 'López', '2007-06-15', 'Cuarto', 'Primaria', 'Ninguna', 2),
    ('Ana', 'Martínez', 'López', '2005-06-18', 'Tercero', 'Primaria', 'Camarón', 3),
    ('Luis', 'Gómez', 'Vega', '2006-05-14', 'Segundo', 'Primaria', 'Ninguna', 4),
    ('María', 'Hernández', 'López', '2008-08-30', 'Primero', 'Primaria', 'Frutos secos', 5);


--Inserciones en la tabla Semana
INSERT INTO Menu (nombre_menu) VALUES 
    ('Menú 1'),
    ('Menú 2'),
    ('Menú 3'),
    ('Menú 4'),
    ('Menú 5');

INSERT INTO Comida (nombre_comida) VALUES 
    ('Pollo a la plancha'),
    ('Enchiladas verdes'),
    ('Tamales de verdura'),
    ('Mole poblano'),
    ('Ceviche de soya'),
    ('Tacos de carne asada');

INSERT INTO Bebida (nombre_bebida) VALUES 
    ('Agua de horchata'),
    ('Agua de pepino'),
    ('Agua de piña'),
    ('Agua de melón'),
    ('Agua de sandía'),
    ('Limonada');

INSERT INTO Postre (nombre_postre) VALUES 
    ('Pastel de chocolate'),
    ('Mangoneadas'),
    ('Frutos rojos'),
    ('Gelatina sabores varios'),
    ('Pastel de 3 leches'),
    ('Fruta picada');


-- Insertar recetas
-- Receta 1 (Menú 1 - Crêpes salados)
INSERT INTO Receta (id_comida, id_bebida, id_postre, procedimiento, porciones) 
VALUES 
(1, 1, 1, 'Disponer la harina de garbanzos en un cuenco o jarra con el agua... Continuar hasta terminar con toda la masa, rellenar con los ingredientes preparados y servir.', 5),  -- Crêpes salados (Comida), Agua de horchata (Bebida), Pastel de chocolate (Postre)
(2, 2, 3, 'Cocer las enchiladas y preparar la salsa con chile poblano...', 5),  -- Enchiladas verdes (Comida), Agua de pepino (Bebida), Frutos rojos (Postre)
(3, 3, 4, 'Cocer los tamales y prepararlos con salsa de tomate...', 5),  -- Tamales de verdura (Comida), Agua de piña (Bebida), Gelatina sabores varios (Postre)
(4, 4, 5, 'Preparar el mole con la carne y acompañar con arroz...', 5),  -- Mole poblano (Comida), Agua de melón (Bebida), Pastel de 3 leches (Postre)
(5, 5, 6, 'Cortar el ceviche y acompañarlo con un toque de limón...', 5),  -- Ceviche de soya (Comida), Agua de sandía (Bebida), Fruta picada (Postre)
(6, 6, 1, 'Tacos de carne asada preparados con cebolla y cilantro...', 5);  -- Tacos de carne asada (Comida), Limonada (Bebida), Pastel de chocolate (Postre)

-- Insertar ingredientes para las recetas
-- Receta 1: Crêpes salados
INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad, unidad) VALUES
(1, 1, 110, 'g'),  -- Harina de garbanzo en Crêpes salados
(1, 2, 250, 'ml'),  -- Agua en Crêpes salados
(1, 3, 15, 'ml'),   -- Aceite de oliva en Crêpes salados
(1, 4, 2, 'g'),     -- Sal en Crêpes salados
(1, 5, 10, 'g'),    -- Cebollino en Crêpes salados
(1, 6, 1, 'g'),     -- Pimienta negra en Crêpes salados
(1, 7, 1, 'unidad'),-- Aguacate en Crêpes salados
(1, 8, 1, 'unidad'),-- Cebolla morada en Crêpes salados
(1, 9, 1, 'unidad');-- Pimiento rojo en Crêpes salados

-- Receta 2: Enchiladas verdes
INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad, unidad) VALUES
(2, 10, 150, 'g'),  -- Chile poblano en Enchiladas verdes
(2, 11, 50, 'g'),   -- Queso en Enchiladas verdes
(2, 2, 200, 'ml'),  -- Agua en Enchiladas verdes
(2, 12, 5, 'g'),    -- Sal en Enchiladas verdes
(2, 7, 1, 'unidad');-- Aguacate en Enchiladas verdes

-- Receta 3: Tamales de verdura
INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad, unidad) VALUES
(3, 13, 100, 'g'),  -- Masa de maíz en Tamales
(3, 14, 50, 'g'),   -- Leche en Tamales
(3, 12, 5, 'g'),    -- Sal en Tamales
(3, 15, 100, 'g'),  -- Verduras en Tamales
(3, 9, 1, 'unidad');-- Pimiento en Tamales

-- Receta 4: Mole poblano
INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad, unidad) VALUES
(4, 16, 300, 'g'),  -- Pollo en Mole poblano
(4, 17, 50, 'g'),   -- Salsa de mole en Mole poblano
(4, 18, 200, 'g'),  -- Arroz en Mole poblano
(4, 11, 5, 'g');    -- Sal en Mole poblano

-- Receta 5: Ceviche de soya
INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad, unidad) VALUES
(5, 19, 100, 'g'),  -- Soya en Ceviche
(5, 2, 250, 'ml'),  -- Agua en Ceviche
(5, 20, 1, 'unidad'),-- Limón en Ceviche
(5, 7, 1, 'unidad');-- Aguacate en Ceviche

-- Receta 6: Tacos de carne asada
INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad, unidad) VALUES
(6, 21, 200, 'g'),  -- Carne asada en Tacos
(6, 22, 5, 'g'),    -- Cilantro en Tacos
(6, 23, 50, 'g'),   -- Cebolla en Tacos
(6, 24, 1, 'unidad');-- Limón en Tacos

--No se aun
-- Insertar pagos
INSERT INTO Pago (id_tutor, id_semana, total) VALUES
(1, 1, 150.00),  -- Tutor Carlos, Semana 1, Pago total de 150
(2, 2, 120.00),  -- Tutor María, Semana 2, Pago total de 120
(3, 3, 130.00),  -- Tutor Juan, Semana 3, Pago total de 130
(4, 4, 160.00),  -- Tutor Sofía, Semana 4, Pago total de 160
(5, 5, 140.00);  -- Tutor Luis, Semana 5, Pago total de 140

--ASOCIAR COMIDAS, BEBIDAS Y POSTRES AL MENÚ 1





INSERT INTO Semana (numero_semana) 
VALUES 
    (20), 
    (21);

SELECT * FROM SEMANA

-- Inserciones en la tabla Alimento
INSERT INTO Alimento (nombre, datos_nutricionales, tipo) 
VALUES
    ('Mole poblano', 'Rico en proteínas y carbohidratos', 'COMIDA'),
    ('Ceviche de soya', 'Alto en proteínas vegetales', 'COMIDA'),
    ('Verduras al vapor con puré de papa', 'Vitaminas y fibra', 'COMIDA'),
    ('Tacos de carne asada', 'Alto en proteínas y hierro', 'COMIDA'),
    ('Tamales de verdura', 'Carbohidratos y fibra', 'COMIDA'),
    ('Enchiladas verdes', 'Proteína y vitaminas', 'COMIDA'),
    ('Pollo a la plancha', 'Bajo en grasas, alto en proteína', 'COMIDA'),
    ('Agua de melón', 'Hidratación y vitaminas', 'BEBIDA'),
    ('Agua de sandía', 'Hidratación y antioxidantes', 'BEBIDA'),
    ('Agua de jamaica', 'Diurético y antioxidantes', 'BEBIDA'),
    ('Limonada', 'Vitamina C y refrescante', 'BEBIDA'),
    ('Agua de piña', 'Digestión y vitamina C', 'BEBIDA'),
    ('Agua de pepino', 'Hidratación y minerales', 'BEBIDA'),
    ('Agua de horchata', 'Calcio y energía', 'BEBIDA'),
    ('Gelatina sabores varios', 'Postre ligero y gelatina', 'POSTRE'),
    ('Pastel de 3 leches', 'Alto en carbohidratos y grasas', 'POSTRE'),
    ('Flan', 'Calcio y proteínas', 'POSTRE'),
    ('Fruta picada', 'Vitaminas y fibra', 'POSTRE'),
    ('Frutos rojos', 'Antioxidantes y fibra', 'POSTRE'),
    ('Mangoneadas', 'Vitamina C y sabor', 'POSTRE'),
    ('Pastel de chocolate', 'Energía y antioxidantes', 'POSTRE');

SELECT * FROM ALIMENTO

-- Inserciones en la tabla Menu
INSERT INTO Menu (nombre) 
VALUES
    ('Menú semana 1'),
    ('Menú semana 2'),
    ('Menú semana 3'),
    ('Menú semana 4'),
    ('Menú semana 5'),
    ('Menú semana 6'),
    ('Menú semana 7');

SELECT * FROM MENU

-- Relación entre Menu y Alimentos
INSERT INTO Menu_Alimento (id_menu, id_alimento) 
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (11, 11),
    (12, 12),
    (13, 13),
    (14, 14),
    (15, 15),
    (16, 16),
    (17, 17),
    (18, 18),
    (19, 19),
    (20, 20),
    (21, 21);

SELECT * FROM Menu_Alimento

-- Inserción en la tabla Receta con los nuevos atributos
INSERT INTO Receta (nombre, descripcion, porciones)
VALUES 
    ('Mole poblano', 'Receta tradicional mexicana con pollo y salsa de chile poblano.', 4),
    ('Ceviche de soya', 'Receta a base de soya, verduras y jugo de limón.', 2),
    ('Verduras al vapor con puré de papa', 'Plato ligero de verduras al vapor acompañado de puré de papa.', 3);

SELECT * FROM RECETA

-- Relación entre Menu y Receta
INSERT INTO Menu_Receta (id_menu, id_receta) 
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (11, 11),
    (12, 12),
    (13, 13),
    (14, 14),
    (15, 15),
    (16, 16),
    (17, 17),
    (18, 18),
    (19, 19),
    (20, 20),
    (21, 21);

-- Inserción de ingredientes
INSERT INTO Ingrediente (nombre, unidad) 
VALUES
    ('Limón', 'pieza'),
    ('Azúcar', 'gramo'),
    ('Agua', 'litro'),
    ('Harina', 'gramo'),
    ('Pollo', 'kg'),
    ('Carne', 'kg');

SELECT * FROM Ingrediente

-- Relación entre Receta e Ingredientes
INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad) 
VALUES
    (1, 1, 2), -- Mole poblano requiere 2 limones
    (2, 2, 100), -- Ceviche de soya requiere 100 gramos de azúcar
    (3, 3, 1), -- Verduras al vapor requiere 1 litro de agua
    (4, 4, 200), -- Tacos de carne requiere 200 gramos de harina
    (5, 5, 2), -- Tamales de verdura requiere 2 kg de pollo
    (6, 6, 1.5); -- Enchiladas verdes requiere 1.5 kg de carne

-- Inserción de consumo para los niños en las semanas
INSERT INTO Consumo (id_nino, id_menu, id_semana) 
VALUES 
    (1, 1, 20), -- Pedro consume Mole poblano en la semana 20
    (1, 2, 20), -- Pedro consume Ceviche de soya en la semana 20
    (2, 3, 21), -- Juan consume Verduras al vapor con puré de papa en la semana 21
    (2, 4, 21); -- Juan consume Tacos de carne asada en la semana 21

SELECT * FROM RECETA
SELECT * FROM CONSUMO


--***********************************************************
-- CONSULTA PARA VER EL CONSUMO DE UN NIÑO DURANTE LA SEMANA
SELECT 
    c.id_consumo, n.nombre_nino, s.fecha_inicio, c.dia_semana, 
    comida.nombre_comida, bebida.nombre_bebida, postre.nombre_postre
FROM Consumo c
JOIN Nino n ON c.id_nino = n.id_nino
JOIN Semana s ON c.id_semana = s.id_semana
JOIN Comida comida ON c.id_comida = comida.id_comida
JOIN Bebida bebida ON c.id_bebida = bebida.id_bebida
JOIN Postre postre ON c.id_postre = postre.id_postre
WHERE c.id_nino = 1
ORDER BY s.fecha_inicio, 
    CASE c.dia_semana
        WHEN 'Lunes' THEN 1
        WHEN 'Martes' THEN 2
        WHEN 'Miércoles' THEN 3
        WHEN 'Jueves' THEN 4
        WHEN 'Viernes' THEN 5
    END;


USE master;
GO
ALTER DATABASE Comedor SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE Comedor;