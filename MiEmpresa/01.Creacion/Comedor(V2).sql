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

--Tabla Receta_Comida (Recetas específicas de comida)
CREATE TABLE Receta_Comida (
    id_receta_comida INT IDENTITY(1,1) PRIMARY KEY,
    nombre_comida VARCHAR(100),
    procedimiento TEXT,
    porciones INT
);

--Tabla Comida
CREATE TABLE Comida (
    id_comida INT IDENTITY(1,1) PRIMARY KEY,
    nombre_comida VARCHAR(100),
    id_receta_comida INT,
    FOREIGN KEY (id_receta_comida) REFERENCES Receta_Comida(id_receta_comida)
);

--Tabla Relacion Menu y Receta_Comida
CREATE TABLE Menu_Comida (
    id_menuC INT,
    id_receta_comida INT,
    PRIMARY KEY (id_menuC, id_receta_comida),
    FOREIGN KEY (id_receta_comida) REFERENCES Receta_Comida(id_receta_comida)
);

--Tabla Receta_Bebida (Recetas específicas de bebidas)
CREATE TABLE Receta_Bebida (
    id_receta_bebida INT IDENTITY(1,1) PRIMARY KEY,
    nombre_bebida VARCHAR(100),
    procedimiento TEXT,
    porciones INT
);

--Tabla Bebida
CREATE TABLE Bebida (
    id_bebida INT IDENTITY(1,1) PRIMARY KEY,
    nombre_bebida VARCHAR(100),
    id_receta_bebida INT,
    FOREIGN KEY (id_receta_bebida) REFERENCES Receta_Bebida(id_receta_bebida)
);

--Tabla Relacion Menu y Receta_Bebida
CREATE TABLE Menu_Bebida (
    id_menuB INT,
    id_receta_bebida INT,
    PRIMARY KEY (id_menuB, id_receta_bebida),
    FOREIGN KEY (id_receta_bebida) REFERENCES Receta_Bebida(id_receta_bebida)
);

--Tabla Receta_Postre (Recetas específicas de postres)
CREATE TABLE Receta_Postre (
    id_receta_postre INT IDENTITY(1,1) PRIMARY KEY,
    nombre_postre VARCHAR(100),
    procedimiento TEXT,
    porciones INT
);

--Tabla Postre
CREATE TABLE Postre (
    id_postre INT IDENTITY(1,1) PRIMARY KEY,
    nombre_postre VARCHAR(100),
    id_receta_postre INT,
    FOREIGN KEY (id_receta_postre) REFERENCES Receta_Postre(id_receta_postre)
);

--Tabla Relacion Menu y Receta_Postre
CREATE TABLE Menu_Postre (
    id_menuP INT,
    id_receta_postre INT,
    PRIMARY KEY (id_menuP, id_receta_postre),
    FOREIGN KEY (id_receta_postre) REFERENCES Receta_Postre(id_receta_postre)
);

--Tabla Menu 
CREATE TABLE Menu (
    id_menu INT IDENTITY(1,1) PRIMARY KEY,
    nombre_menu VARCHAR(100),
    id_comida INT,
    id_bebida INT,
    id_postre INT,
    FOREIGN KEY (id_comida) REFERENCES Comida(id_comida),
    FOREIGN KEY (id_bebida) REFERENCES Bebida(id_Bebida),
    FOREIGN KEY (id_postre) REFERENCES Postre(id_postre)
);





--Tabla Ingredientes
CREATE TABLE Ingrediente (
    id_ingrediente INT IDENTITY(1,1) PRIMARY KEY,
    nombre_ingrediente VARCHAR(100)
);

--Relación Receta_Comida, Receta_Bebida, Receta_Postre con Ingredientes
CREATE TABLE Receta_Ingrediente (
    id_receta INT,
    id_ingrediente INT,
    cantidad DECIMAL(10,2),
    unidad VARCHAR(50),
    PRIMARY KEY (id_receta, id_ingrediente),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente)
);

-- Tabla Semana
CREATE TABLE Semana (
    id_semana INT IDENTITY(1,1) PRIMARY KEY,
    fecha_inicio DATE,
    fecha_fin DATE,
    id_menu INT,
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu)
);


-- Relación entre Niño y Menú (Consumo)
CREATE TABLE Consumo (
    id_consumo INT IDENTITY(1,1) PRIMARY KEY,
    id_semana INT,
    id_nino INT,
    id_menu INT,
    dia_semana VARCHAR(10),
    cantidad_porciones INT,
    FOREIGN KEY (id_nino) REFERENCES Nino(id_nino),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (id_semana) REFERENCES Semana(id_semana)
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








--******************************INSERCIONES
-- Inserciones en la tabla Tutor
INSERT INTO Tutor (nombre, apellido_paterno, apellido_materno, telefono, telefono_celular, lugar_trabajo) VALUES 
    ('Carlos', 'González', 'Pérez', '6621234567', '6629876543', 'Escuela Primaria X'),
    ('María', 'López', 'García', '6627654321', '6621122334', 'Hospital Y'),
    ('Juan', 'Martínez', 'Hernández', '6623344556', '6629988776', 'Universidad Z'),
    ('Sofía', 'Ramírez', 'Jiménez', '6628765432', '6622233445', 'Oficina A'),
    ('Luis', 'Rodríguez', 'Mendoza', '6629988777', '6623344556', 'Colegio B');

-- Inserciones en la tabla Niño
INSERT INTO Nino (nombre, apellido_paterno, apellido_materno, fecha_nacimiento, grado, nivel, alergias_alimenticias, id_tutor) VALUES
    ('Pedro', 'Perez', 'Gomez', '2005-03-28', 'Primero', 'Primaria', 'Ninguna', 1),
    ('Juan', 'Ramírez', 'López', '2007-06-15', 'Cuarto', 'Primaria', 'Ninguna', 2),
    ('Ana', 'Martínez', 'López', '2005-06-18', 'Tercero', 'Primaria', 'Camarón', 3),
    ('Luis', 'Gómez', 'Vega', '2006-05-14', 'Segundo', 'Primaria', 'Ninguna', 4),
    ('María', 'Hernández', 'López', '2008-08-30', 'Primero', 'Primaria', 'Frutos secos', 5);

-- Inserciones en la tabla Comida
INSERT INTO Receta_Comida (nombre_comida, procedimiento, porciones) VALUES 
    ('Crêpes salados', 'Disponer la harina de garbanzo en un cuenco o jarra con el agua. Continuar hasta terminar con toda la masa, rellenar con los ingredientes preparados y servir.', 5),
    ('Tacos al pastor', 'Marinar la carne de cerdo con achiote, especias y jugo de piña. Cocinarla en el trompo y servir en tortillas con cebolla, cilantro y salsa.', 3),
    ('Ensalada César', 'Mezclar lechuga romana, croutones, aderezo César, queso parmesano y pollo a la parrilla.', 7),
    ('Spaghetti Bolognese', 'Cocinar la carne molida con cebolla, ajo, tomate, y especias. Mezclar con la pasta cocida y servir con queso parmesano.', 5),
    ('Sopes de pollo', 'Cocer el pollo y desmenuzarlo. Preparar sopes con masa, freírlos y agregar pollo, lechuga, crema, queso y salsa al gusto.', 2);

INSERT INTO Comida (nombre_comida, id_receta_comida) VALUES 
    ('Crêpes salados', 1),
    ('Tacos al pastor', 2),
    ('Ensalada César', 3),
    ('Spaghetti Bolognese', 4),
    ('Sopes de pollo', 5);

INSERT INTO Menu_Comida (id_menuC, id_receta_comida) VALUES 
    (1, 1),  -- Crêpes salados
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 5);

-- Inserciones en la tabla Bebida
INSERT INTO Receta_Bebida (nombre_bebida, procedimiento, porciones) VALUES 
    ('Jugo de naranja', 'Exprimir las naranjas y servir.', 5),
    ('Agua natural', 'Servir agua fresca.', 5),
    ('Limonada', 'Exprimir limones, añadir agua y azúcar.', 5),
    ('Refresco de cola', 'Abrir la lata y servir.', 5),
    ('Agua con gas', 'Servir agua con gas al gusto.', 5);

INSERT INTO Bebida (nombre_bebida, id_receta_bebida) VALUES 
    ('Jugo de naranja', 1),
    ('Agua natural', 2),
    ('Limonada', 3),
    ('Refresco de cola', 4),
    ('Agua con gas', 5);


INSERT INTO Menu_Bebida (id_menuB, id_receta_bebida) VALUES 
    (1, 1),  -- Jugo de naranja
    (1, 2),  -- Agua natural
    (2, 3),  -- Limonada
    (2, 4),  -- Refresco de cola
    (3, 5);  -- Agua con gas

-- Inserciones en la tabla Postre
INSERT INTO Receta_Postre (nombre_postre, procedimiento, porciones) VALUES 
    ('Pastel de chocolate', 'Preparar el pastel con chocolate, harina y huevos. Hornear y servir.', 5),
    ('Flan', 'Mezclar leche, huevos y azúcar. Cocinar al baño maría y enfriar.', 5),
    ('Gelatina de frutas', 'Disolver gelatina en agua, agregar frutas y refrigerar.', 5),
    ('Tarta de manzana', 'Preparar masa, colocar manzanas y hornear.', 5),
    ('Brownie', 'Mezclar chocolate, harina y azúcar. Hornear y servir.', 5);

INSERT INTO Postre (nombre_postre, id_receta_postre) VALUES 
    ('Pastel de chocolate', 1),
    ('Flan', 2),
    ('Gelatina de frutas', 3),
    ('Tarta de manzana', 4),
    ('Brownie', 5);

INSERT INTO Menu_Postre (id_menuP, id_receta_postre) VALUES 
    (1, 1),  -- Pastel de chocolate
    (1, 2),  -- Flan
    (2, 3),  -- Gelatina de frutas
    (2, 4),  -- Tarta de manzana
    (3, 5);  -- Brownie

-- Inserciones en la tabla Menu
INSERT INTO Menu (nombre_menu, id_comida, id_bebida, id_postre) VALUES 
    ('Menú 1', 1, 1, 1),
    ('Menú 2', 2, 2, 2),
    ('Menú 3', 3, 3, 3),
    ('Menú 4', 4, 4, 4),
    ('Menú 5', 5, 5, 5);

--Inserción de Ingredientes
INSERT INTO Ingrediente (nombre_ingrediente) VALUES 
    ('Harina de garbanzo'),
    ('Agua'),
    ('Aceite de oliva virgen extra'),
    ('Sal'),
    ('Cebollino'),
    ('Pimienta negra molida'),
    ('Aguacate'),
    ('Cebolla morada'),
    ('Pimiento rojo picante o dulce');

-- Ingredientes para la receta (porciones y cantidad)
--Consulta tambien 
--RECETA 1 OCUPAMOS, 9 INGREDIENTES
INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad, unidad) VALUES
    (1, (SELECT id_ingrediente FROM Ingrediente WHERE nombre_ingrediente = 'Harina de garbanzo'), 110, 'g'),
    (1, (SELECT id_ingrediente FROM Ingrediente WHERE nombre_ingrediente = 'Agua'), 250, 'ml'),
    (1, (SELECT id_ingrediente FROM Ingrediente WHERE nombre_ingrediente = 'Aceite de oliva virgen extra'), 15, 'ml'),
    (1, (SELECT id_ingrediente FROM Ingrediente WHERE nombre_ingrediente = 'Sal'), 2, 'g'),
    (1, (SELECT id_ingrediente FROM Ingrediente WHERE nombre_ingrediente = 'Cebollino'), 10, 'g'),
    (1, (SELECT id_ingrediente FROM Ingrediente WHERE nombre_ingrediente = 'Pimienta negra molida'), 1, 'g'),
    (1, (SELECT id_ingrediente FROM Ingrediente WHERE nombre_ingrediente = 'Aguacate'), 1, 'unidad'),
    (1, (SELECT id_ingrediente FROM Ingrediente WHERE nombre_ingrediente = 'Cebolla morada'), 1, 'unidad'),
    (1, (SELECT id_ingrediente FROM Ingrediente WHERE nombre_ingrediente = 'Pimiento rojo picante o dulce'), 1, 'unidad');

--Inserciones en la tabla Semana
INSERT INTO Semana (fecha_inicio, fecha_fin, id_menu) VALUES 
    ('2024-04-01', '2024-04-07', 1),
    ('2024-04-08', '2024-04-14', 2),
    ('2024-04-15', '2024-04-21', 3),
    ('2024-04-22', '2024-04-28', 4),
    ('2024-04-29', '2024-05-05', 5);

--Inserciones en la tabla Consumo 
INSERT INTO Consumo (id_semana, id_nino, id_menu, dia_semana, cantidad_porciones) VALUES 
    (1, 1, 1, 'Lunes', 1),
    (1, 1, 2, 'Martes', 1),
    (1, 2, 2, 'Martes', 1),
    (1, 3, 3, 'Miércoles', 1),
    (1, 4, 4, 'Jueves', 1),
    (1, 5, 5, 'Viernes', 1),
    (2, 1, 2, 'Lunes', 1);




-- Inserciones en la tabla Compra
INSERT INTO Compra (id_semana, id_ingrediente, cantidad_necesaria, fecha_compra) VALUES 
    (1, 1, 500, '2025-03-30'),  -- Harina de garbanzo
    (1, 2, 1200, '2025-03-30'),  -- Agua
    (1, 3, 100, '2025-03-30'),   -- Aceite de oliva virgen extra
    (1, 4, 30, '2025-03-30'),    -- Sal
    (1, 5, 50, '2025-03-30');    -- Cebollino

-- Inserciones en la tabla Pago
INSERT INTO Pago (id_tutor, id_semana, total, fecha_pago) VALUES 
    (1, 1, 100.00, '2025-04-01'),
    (2, 2, 120.00, '2025-04-08'),
    (3, 3, 150.00, '2025-04-15'),
    (4, 4, 130.00, '2025-04-22'),
    (5, 5, 110.00, '2025-04-29');


---*********************TABLAS
SELECT * FROM TUTOR
SELECT * FROM NINO
SELECT * FROM MENU
SELECT * FROM COMIDA
SELECT * FROM RECETA_COMIDA
SELECT * FROM MENU_COMIDA
SELECT * FROM BEBIDA
SELECT * FROM Receta_Bebida
SELECT * FROM Menu_Bebida
SELECT * FROM Postre
SELECT * FROM Receta_Postre
SELECT * FROM Menu_Postre
SELECT * FROM Ingrediente
SELECT * FROM Receta_Ingrediente
SELECT * FROM Consumo
SELECT * FROM Semana
SELECT * FROM Compra
SELECT * FROM Pago