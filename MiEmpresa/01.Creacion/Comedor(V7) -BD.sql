USE master;
GO
ALTER DATABASE ComedorEsc SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE ComedorEsc;

CREATE DATABASE ComedorEsc;
GO

USE ComedorEsc;

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

-- Tabla Unidad
CREATE TABLE Unidad (
    id_unidad INT IDENTITY(1,1) PRIMARY KEY,
    unidadMedida VARCHAR(50)
);

-- Tabla Alimento
CREATE TABLE Alimento (
    id_alimento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) -- Comida, Bebida, Postre
);

-- Tabla Alimento_Ingrediente
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
    procedimiento TEXT,
    porciones INT,
    FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento)
);

-- Tabla Menu (fusionada con Semana)
CREATE TABLE Menu (
    id_menu INT IDENTITY(1,1) PRIMARY KEY,
    nombre_menu VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE,
    semana_del_anio AS DATEPART(WEEK, fecha_inicio) 
);

-- Tabla Menu_Alimento
CREATE TABLE Menu_Alimento (
    id_menu INT,
    id_alimento INT,
    PRIMARY KEY (id_menu, id_alimento),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento)
);

-- Tabla DiaSemana
CREATE TABLE DiaSemana (
    id_diaS INT IDENTITY(1,1) PRIMARY KEY,
    diaS VARCHAR(10) 
);

-- Tabla Consumo
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
    id_menu INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad_necesaria DECIMAL(10,2) NOT NULL CHECK (cantidad_necesaria > 0),
    fecha_compra DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente)
);

-- Tabla Pago
CREATE TABLE Pago (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_tutor INT NOT NULL,
    id_menu INT NOT NULL,
    total DECIMAL(10,2) NOT NULL CHECK (total > 0),
    fecha_pago DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu)
);

--************************** DATOS **********************
USE ComedorEsc;

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
INSERT INTO Receta (id_alimento, procedimiento, porciones) VALUES
(1, 'Hervir verduras y sazonar.', 20),
(2,'Exprimir naranjas.', 15),
(3, 'Preparar gelatina con agua caliente y dejar enfriar.', 25),
(4, 'Cocinar pollo y servir en tortilla.', 20),
(5, 'Mezclar limón, agua y azúcar.', 30),
(6, 'Hornear mezcla con cacao.', 15),
(7, 'Mezclar frutas picadas.', 20),
(8, 'Hervir arroz con leche y azúcar.', 20),
(9, 'Derretir queso en tortillas.', 20),
(10, 'Servir agua purificada.', 40);

-- MENU
INSERT INTO Menu (nombre_menu, fecha_inicio, fecha_fin) VALUES
('Semana 1', '2025-05-06', '2025-05-10'),
('Semana 2', '2025-05-13', '2025-05-17'),
('Semana 3', '2025-05-20', '2025-05-24'),
('Semana 4', '2025-05-27', '2025-05-31'),
('Semana 5', '2025-06-03', '2025-06-07'),
('Semana 6', '2025-06-10', '2025-06-14'),
('Semana 7', '2025-06-17', '2025-06-21'),
('Semana 8', '2025-06-24', '2025-06-28'),
('Semana 9', '2025-07-01', '2025-07-05'),
('Semana 10', '2025-07-08', '2025-07-12');

-- MENU_ALIMENTO
INSERT INTO Menu_Alimento (id_menu, id_alimento) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5), (2, 6),
(3, 7), (3, 8), (3, 9),
(4, 10), (4, 1), (4, 3);

-- DIASEMANA
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
(1, 1, '2025-05-06'),
(2, 2, '2025-05-07'),
(3, 3, '2025-05-08'),
(4, 4, '2025-05-09'),
(5, 5, '2025-05-10'),
(6, 6, '2025-05-11'),
(7, 7, '2025-05-12'),
(8, 8, '2025-05-13'),
(9, 9, '2025-05-14'),
(10, 10, '2025-05-15');


-- COMPRA
INSERT INTO Compra (id_menu, id_ingrediente, cantidad_necesaria, fecha_compra) VALUES
(1, 1, 10, '2025-05-01'),
(1, 2, 5, '2025-05-01'),
(2, 3, 8, '2025-05-08'),
(2, 4, 3, '2025-05-08'),
(3, 5, 6, '2025-05-15'),
(3, 6, 7, '2025-05-15'),
(4, 7, 4, '2025-05-22'),
(4, 8, 2, '2025-05-22'),
(5, 9, 5, '2025-05-29'),
(5, 10, 3, '2025-05-29');

-- PAGO
INSERT INTO Pago (id_tutor, id_menu, total, fecha_pago) VALUES
(1, 1, 120.00, '2025-05-01'),
(2, 1, 110.00, '2025-05-01'),
(3, 2, 115.00, '2025-05-08'),
(4, 2, 100.00, '2025-05-08'),
(5, 3, 130.00, '2025-05-15'),
(6, 3, 125.00, '2025-05-15'),
(7, 4, 135.00, '2025-05-22'),
(8, 4, 140.00, '2025-05-22'),
(9, 5, 145.00, '2025-05-29'),
(10, 5, 150.00, '2025-05-29');

--****************** TABLAS ****************
SELECT * FROM TUTOR
SELECT * FROM NINO
SELECT * FROM TIPO_ALERGIA
SELECT * FROM INGREDIENTE
SELECT * FROM Tipo_Alergia_Ingrediente
SELECT * FROM ALERGIA
SELECT * FROM UNIDAD
SELECT * FROM ALIMENTO
SELECT * FROM ALIMENTO_INGREDIENTE
SELECT * FROM Receta
SELECT * FROM MENU
SELECT * FROM MENU_ALIMENTO
SELECT * FROM DiaSemana
SELECT * FROM PAGO
SELECT * FROM COMPRA
SELECT * FROM CONSUMO


--trigger

USE ComedorEsc;
GO

CREATE TRIGGER trg_VerificarAlergias
ON Consumo
AFTER INSERT
AS
BEGIN
    -- Variable para almacenar el conteo de coincidencias de ingredientes alérgicos
    DECLARE @conteo INT;

    -- Consulta para contar cuántos ingredientes del alimento consumido coinciden con las alergias del niño
    SELECT @conteo = COUNT(*)
    FROM inserted i
    JOIN Alimento_Ingrediente ai ON i.id_alimento = ai.id_alimento
    JOIN Tipo_Alergia_Ingrediente tai ON ai.id_ingrediente = tai.id_ingrediente
    JOIN Alergia a ON i.id_nino = a.id_nino AND tai.id_tipo = a.id_tipo;

    -- Si hay coincidencias, lanzar un error y revertir el INSERT
    IF @conteo > 0
    BEGIN
        RAISERROR('El alimento seleccionado contiene ingredientes a los que el niño es alérgico.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- insert de prueba de trigger
INSERT INTO Consumo (id_nino, id_alimento, fecha_consumo)
VALUES (1, 1, '2025-05-28');

--Proceso Almacenado

USE ComedorEsc;
GO

CREATE PROCEDURE sp_RegistrarCompraIngredientes
    @fecha_inicio DATE,
    @fecha_fin DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_menu INT;

    -- Cursor para recorrer los menús del rango de fechas
    DECLARE cur CURSOR FOR
    SELECT id_menu
    FROM Menu
    WHERE fecha_inicio BETWEEN @fecha_inicio AND @fecha_fin;

    OPEN cur;

    FETCH NEXT FROM cur INTO @id_menu;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insertar los ingredientes necesarios para cada menú
        INSERT INTO Compra (id_menu, id_ingrediente, cantidad_necesaria, fecha_compra)
        SELECT
            m.id_menu,
            ai.id_ingrediente,
            SUM(ai.cantidad) AS cantidad_necesaria,
            GETDATE() -- Fecha de compra actual
        FROM Menu m
        JOIN Menu_Alimento ma ON m.id_menu = ma.id_menu
        JOIN Alimento_Ingrediente ai ON ma.id_alimento = ai.id_alimento
        WHERE m.id_menu = @id_menu
        GROUP BY m.id_menu, ai.id_ingrediente
        HAVING SUM(ai.cantidad) > 0;

        FETCH NEXT FROM cur INTO @id_menu;
    END

    CLOSE cur;
    DEALLOCATE cur;

    PRINT 'Se compraron lo ingredientes correctamente para las fechas seleccionadas.';
END;
GO

--Pruebas para procesos de almacenado

-- Para generar compras del 6 al 10 de mayo
EXEC sp_RegistrarCompraIngredientes @fecha_inicio = '2025-05-06', @fecha_fin = '2025-05-10';

-- Para generar compras del 20 al 24 de mayo
EXEC sp_RegistrarCompraIngredientes @fecha_inicio = '2025-05-20', @fecha_fin = '2025-05-24';


--verificar la tabla compra para ver el cambio de ingredientes comprados
SELECT * FROM COMPRA
