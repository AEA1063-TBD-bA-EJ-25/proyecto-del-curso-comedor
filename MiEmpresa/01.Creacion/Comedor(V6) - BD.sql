USE master;
GO
ALTER DATABASE Comedor SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE Comedor;

CREATE DATABASE Comedor;
GO

USE Comedor;

-- Tabla Tutor
CREATE TABLE Tutor (
    id_tutor INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido_paterno NVARCHAR(100) NOT NULL,
    apellido_materno NVARCHAR(100) NOT NULL,
    telefono NVARCHAR(15) NOT NULL,
    telefono_celular NVARCHAR(15),
    lugar_trabajo NVARCHAR(255)
);

-- Tabla Niño 
CREATE TABLE Nino (
    id_nino INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido_paterno NVARCHAR(100) NOT NULL,
    apellido_materno NVARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    grado NVARCHAR(50) NOT NULL,
    nivel NVARCHAR(50) NOT NULL,
    id_tutor INT NOT NULL,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla Tipo_Alergia 
CREATE TABLE Tipo_Alergia (
    id_tipo INT IDENTITY(1,1) PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL
);

-- Tabla Ingrediente
CREATE TABLE Ingrediente (
    id_ingrediente INT IDENTITY(1,1) PRIMARY KEY,
    nombre_ingrediente VARCHAR(100) NOT NULL
);

-- Tabla que vincula tipos de alergia con ingredientes específicos
CREATE TABLE Tipo_Alergia_Ingrediente (
    id_tipo INT,
    id_ingrediente INT,
    PRIMARY KEY (id_tipo, id_ingrediente),
    FOREIGN KEY (id_tipo) REFERENCES Tipo_Alergia(id_tipo),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente)
);

-- Tabla Alergia
CREATE TABLE Alergia (
    id_nino INT,
    id_tipo INT,
    PRIMARY KEY (id_nino, id_tipo),
    FOREIGN KEY (id_nino) REFERENCES Nino(id_nino),
    FOREIGN KEY (id_tipo) REFERENCES Tipo_Alergia(id_tipo)
);

-- Tabla Unidad de medida
CREATE TABLE Unidad (
    id_unidad INT IDENTITY(1,1) PRIMARY KEY,
    unidadMedida VARCHAR(50)
);

-- Tabla Alimento
CREATE TABLE Alimento (
    id_alimento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) --Comida, Bebida, Postre
);

-- Tabla Relación Alimento-Consumo
CREATE TABLE Alimento_Ingrediente (
    id_alimento INT,
    id_ingrediente INT,
    cantidad DECIMAL(10,2),
    id_unidad INT,
    PRIMARY KEY (id_alimento, id_ingrediente, id_unidad),
    FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente),
    FOREIGN KEY (id_unidad) REFERENCES Unidad(id_unidad)
);

-- Tabla Receta
CREATE TABLE Receta (
    id_receta INT IDENTITY(1,1) PRIMARY KEY,
    id_alimento INT,
    nombre VARCHAR(100) NOT NULL,
    procedimiento TEXT,
    porciones INT,
    FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento)
)

-- Tabla Menú y Semana
CREATE TABLE Menu (
    id_menu INT IDENTITY(1,1) PRIMARY KEY,
    nombre_menu VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE,
    semana_del_anio AS DATEPART(WEEK, fecha_inicio) -- columna calculada
);


-- Tabla que relaciona Menú-Alimentos
CREATE TABLE Menu_Alimento (
    id_menu INT,
    id_alimento INT,
    PRIMARY KEY (id_menu, id_alimento),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento)
);

-- Tabla Día de la semana
CREATE TABLE DiaSemana (
    id_diaS INT IDENTITY(1,1) PRIMARY KEY,
    diaS VARCHAR(10)
);

-- Tabla Consumo que solo registra alimento, niño y fecha
CREATE TABLE Consumo (
    id_consumo INT IDENTITY(1,1) PRIMARY KEY,
    id_nino INT NOT NULL,
    id_alimento INT NOT NULL,
    fecha_consumo DATE NOT NULL,
    FOREIGN KEY (id_nino) REFERENCES Nino(id_nino),
    FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento)
);

-- Tabla Compra
CREATE TABLE Compra (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    id_semana INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad_necesaria DECIMAL(10,2) NOT NULL CHECK (cantidad_necesaria > 0),
    fecha_compra DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_semana) REFERENCES Semana(id_semana),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente)
);

-- Tabla Pago
CREATE TABLE Pago (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_tutor INT NOT NULL,
    id_semana INT NOT NULL,
    total DECIMAL(10,2) NOT NULL CHECK (total > 0),
    fecha_pago DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor),
    FOREIGN KEY (id_semana) REFERENCES Semana(id_semana)
);


--********************************** INSERCIONES DE DATOS *************************************

USE Comedor;

-- TUTORES
INSERT INTO Tutor (nombre, apellido_paterno, apellido_materno, telefono, telefono_celular, lugar_trabajo) VALUES
('Laura', 'González', 'Ramos', '5551234567', '5512345678', 'Escuela Primaria #1'),
('Carlos', 'Hernández', 'Lopez', '5552345678', '5523456789', 'Oficina SAT'),
('Martha', 'Ramírez', 'Soto', '5553456789', '5534567890', 'Hospital General'),
('Roberto', 'Martínez', 'Gómez', '5554567890', '5545678901', 'IMSS'),
('Lucía', 'Torres', 'Díaz', '5555678901', '5556789012', 'Clínica Familiar'),
('Juan', 'Fernández', 'Jiménez', '5556789012', '5567890123', 'Policía Federal'),
('Patricia', 'Reyes', 'Luna', '5557890123', '5578901234', 'Banco Azteca'),
('David', 'Cruz', 'Morales', '5558901234', '5589012345', 'CONAGUA'),
('Sandra', 'Flores', 'Castañeda', '5559012345', '5590123456', 'INE'),
('José', 'Chávez', 'Ruiz', '5560123456', '5601234567', 'Televisa');

-- NIÑOS
INSERT INTO Nino (nombre, apellido_paterno, apellido_materno, fecha_nacimiento, grado, nivel, id_tutor) VALUES
('Felipe', 'González', 'Ramos', '2019-05-29', '1ro', 'Primaria', 1),
('Valeria', 'Hernández', 'Lopez', '2018-05-29', '2do', 'Primaria', 2),
('Carlos', 'Ramírez', 'Soto', '2017-05-29', '3ro', 'Primaria', 3),
('Ana', 'Martínez', 'Gómez', '2019-05-29', '1ro', 'Primaria', 4),
('Emiliano', 'Torres', 'Díaz', '2013-05-30', '6to', 'Primaria', 5),
('Camila', 'Fernández', 'Jiménez', '2015-05-30', '4to', 'Primaria', 6),
('Mateo', 'Reyes', 'Luna', '2014-05-30', '5to', 'Primaria', 7),
('Sofía', 'Cruz', 'Morales', '2014-05-30', '5to', 'Primaria', 8),
('Diego', 'Flores', 'Castañeda', '2018-05-29', '2do', 'Primaria', 9),
('Ximena', 'Chávez', 'Ruiz', '2013-05-30', '6to', 'Primaria', 10);

-- TIPO ALERGIA
INSERT INTO Tipo_Alergia (nombre_tipo) VALUES
('Lácteos'),
('Gluten'),
('Frutos secos'),
('Mariscos'),
('Soya'),
('Huevos'),
('Pescado'),
('Cacahuates'),
('Fresas'),
('Chocolate');

-- INGREDIENTES
INSERT INTO Ingrediente (nombre_ingrediente) VALUES
('Leche'),
('Harina de trigo'),
('Nueces'),
('Camarón'),
('Soya'),
('Huevo'),
('Atún'),
('Cacahuate'),
('Fresa'),
('Cacao');

-- RELACIÓN tipo alergia - ingrediente
INSERT INTO Tipo_Alergia_Ingrediente (id_tipo, id_ingrediente) VALUES
(1, 1), -- Lácteos - Leche
(2, 2), -- Gluten - Harina
(3, 3), -- Frutos secos - Nueces
(4, 4), -- Mariscos - Camarón
(5, 5), -- Soya - Soya
(6, 6), -- Huevos - Huevo
(7, 7), -- Pescado - Atún
(8, 8), -- Cacahuates - Cacahuate
(9, 9), -- Fresas - Fresa
(10, 10); -- Chocolate - Cacao

-- ALERGIAS de NIÑOS
INSERT INTO Alergia (id_nino, id_tipo) VALUES
(1, 1), -- Felipe - Lácteos
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- UNIDADES
INSERT INTO Unidad (unidadMedida) VALUES
('gramos'),
('mililitros'),
('piezas'),
('tazas'),
('cucharadas'),
('litros'),
('rebanadas'),
('cucharaditas'),
('porciones'),
('tazas pequeñas');

-- ALIMENTOS
INSERT INTO Alimento (nombre, tipo) VALUES
('Sopa de verduras', 'Comida'),
('Jugo de naranja', 'Bebida'),
('Gelatina de fresa', 'Postre'),
('Tacos de pollo', 'Comida'),
('Agua de limón', 'Bebida'),
('Pastel de chocolate', 'Postre'),
('Ensalada de frutas', 'Postre'),
('Arroz con leche', 'Postre'),
('Quesadillas', 'Comida'),
('Agua natural', 'Bebida');

-- ALIMENTO_INGREDIENTE (relación)
INSERT INTO Alimento_Ingrediente (id_alimento, id_ingrediente, cantidad, id_unidad) VALUES
(1, 1, 200, 1),
(2, 9, 100, 2),
(3, 9, 100, 2),
(4, 2, 150, 1),
(5, 5, 50, 2),
(6, 10, 150, 1),
(7, 9, 120, 1),
(8, 1, 300, 6),
(9, 1, 150, 1),
(10, 5, 200, 6);

-- RECETA
INSERT INTO Receta (id_alimento, nombre, procedimiento, porciones) VALUES
(1, 'Sopa de verduras', 'Hervir verduras y sazonar.', 20),
(2, 'Jugo de naranja','Exprimir naranjas.', 15),
(3, 'Gelatina de fresa', 'Preparar gelatina con agua caliente y dejar enfriar.', 25),
(4, 'Tacos de pollo', 'Cocinar pollo y servir en tortilla.', 20),
(5, 'Agua de limón', 'Mezclar limón, agua y azúcar.', 30),
(6, 'Pastel de chocolate', 'Hornear mezcla con cacao.', 15),
(7, 'Ensalada de frutas', 'Mezclar frutas picadas.', 20),
(8, 'Arroz con leche', 'Hervir arroz con leche y azúcar.', 20),
(9, 'Quesadillas', 'Derretir queso en tortillas.', 20),
(10, 'Agua natural', 'Servir agua purificada.', 40);

-- MENU
INSERT INTO Menu (nombre_menu) VALUES
('Menú semana 1'),
('Menú semana 2'),
('Menú semana 3'),
('Menú semana 4'),
('Menú semana 5'),
('Menú semana 6'),
('Menú semana 7'),
('Menú semana 8'),
('Menú semana 9'),
('Menú semana 10');

-- MENU_ALIMENTO
INSERT INTO Menu_Alimento (id_menu, id_alimento) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5), (2, 6),
(3, 7), (3, 8), (3, 9),
(4, 1), (4, 5), (4, 10),
(5, 2), (5, 4), (5, 6),
(6, 3), (6, 5), (6, 9),
(7, 7), (7, 8), (7, 10),
(8, 1), (8, 4), (8, 6),
(9, 3), (9, 5), (9, 9),
(10, 2), (10, 4), (10, 7);

-- SEMANA
INSERT INTO Semana (fecha_inicio, fecha_fin, id_menu) VALUES
('2024-01-01', '2024-01-05', 1),
('2024-01-08', '2024-01-12', 2),
('2024-01-15', '2024-01-19', 3),
('2024-01-22', '2024-01-26', 4),
('2024-01-29', '2024-02-02', 5),
('2024-02-05', '2024-02-09', 6),
('2024-02-12', '2024-02-16', 7),
('2024-02-19', '2024-02-23', 8),
('2024-02-26', '2024-03-01', 9),
('2024-03-04', '2024-03-08', 10);

-- DIAS DE LA SEMANA
INSERT INTO DiaSemana (diaS) VALUES
('Lunes'),
('Martes'),
('Miércoles'),
('Jueves'),
('Viernes'),
('Sábado'),
('Domingo');

-- CONSUMO
INSERT INTO Consumo (id_nino, id_alimento, fecha_consumo) VALUES
(1, 1, '2024-01-01'),
(2, 2, '2024-01-01'),
(3, 3, '2024-01-01'),
(4, 4, '2024-01-02'),
(5, 5, '2024-01-02'),
(6, 6, '2024-01-03'),
(7, 7, '2024-01-03'),
(8, 8, '2024-01-04'),
(9, 9, '2024-01-04'),
(10, 10, '2024-01-05');


SELECT * FROM TUTOR
SELECT * FROM NINO
SELECT * FROM TIPO_ALERGIA
SELECT * FROM INGREDIENTE
SELECT * FROM TIPO_ALERGIA
SELECT * FROM ALERGIA
SELECT * FROM UNIDAD
SELECT * FROM ALIMENTO
SELECT * FROM ALIMENTO_INGREDIENTE
SELECT * FROM MENU
SELECT * FROM MENU_ALIMENTO
SELECT * FROM SEMANA
SELECT * FROM DIASEMANA
SELECT * FROM CONSUMO

