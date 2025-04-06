USE master;
GO
ALTER DATABASE Comedor SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE Comedor;


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
    fecha_nacimiento DATE NOT NULL,
    grado NVARCHAR(50) NOT NULL,
    nivel NVARCHAR(50) NOT NULL,
    alergias_alimenticias NVARCHAR(MAX),
    id_tutor INT,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE Nino

ALTER TABLE Nino DROP CONSTRAINT FK_Ninoid_tutor_619B8048;

ALTER TABLE Nino DROP COLUMN edad;

ALTER TABLE Nino ADD fecha_nacimiento DATE NOT NULL;

--Consumo del niño
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


--
-- La relacion entre menu-alimento
CREATE TABLE Menu_Alimento (
    id_menu INT,
    id_alimento INT,
    PRIMARY KEY (id_menu, id_alimento),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_alimento) REFERENCES Alimento(id_alimento) ON DELETE CASCADE ON UPDATE CASCADE
)

--Nombre, ingredientes, porciones
CREATE TABLE Receta (
    id_receta INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    porciones INT CHECK (porciones > 0)
    --Falta forein key de receta_ingrediente
)


--Relacion entre menu-receta
CREATE TABLE Menu_Receta (
    id_menu INT,
    id_receta INT,
    PRIMARY KEY (id_menu, id_receta),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_receta) REFERENCES Receta(id_receta) ON DELETE CASCADE ON UPDATE CASCADE
    --falta foreing de ingrediente
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

--Tabla Operaciones

CREATE TABLE Detalles_Comida (
    id_Detalles_Comida DATE PRIMARY KEY,
    nombre_Menu_del_dia NVARCHAR(50) NOT NULL,
    Numero_de_Comidas_Servidas INT NOT NULL,
    Numero_de_Bebidas_Servidas INT NOT NULL,
    Numero_de_Postres_Servidos INT NOT NULL,
)


CREATE TABLE Detalles_Pago (
    id_Detalles_Pago INT IDENTITY(1,1) PRIMARY KEY,
    id_Tutor INT,
    fecha_Limite_Pago DATE NOT NULL,
    fecha_Realizado DATE NOT NULL,
    cantidad_Pago DECIMAL(10,2) NOT NULL,
);

SELECT * FROM DETALLES_PAGO



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


DELETE FROM NINO;
SELECT * FROM Tutor
SELECT * FROM NINO
INSERT INTO Nino (nombre, apellido_paterno, apellido_materno, fecha_nacimiento, grado, nivel, alergias_alimenticias, id_tutor) 
VALUES
    ('Pedro', 'Perez', 'Gomez', '2005-03-28', 'Primero', 'Primaria', 'Ninguna', 1);
    

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

   
--Insercciones de tablas de operaciones

INSERT INTO Detalles_Comida ( id_Detalles_Comida, nombre_Menu_del_dia, Numero_de_Comidas_Servidas, Numero_de_Bebidas_Servidas, Numero_de_Postres_Servidos  ) VALUES
('2025-04-01', 'Menú Italiano', 50, 30, 20),
('2025-04-02', 'Menú Mexicano', 45, 25, 15),
('2025-04-03', 'Menú Vegetariano', 60, 35, 25),
('2025-04-04', 'Menú de Mariscos', 55, 40, 30),
('2025-04-05', 'Menú de Parrilla', 70, 45, 35),
('2025-04-06', 'Menú Asiático', 65, 50, 40),
('2025-04-07', 'Menú Mediterráneo', 80, 60, 50),
('2025-04-08', 'Menú Clásico', 90, 70, 55),
('2025-04-09', 'Menú Saludable', 75, 55, 45),
('2025-04-10', 'Menú Casero', 85, 65, 50),
('2025-04-11', 'Menú Rápido', 95, 75, 60),
('2025-04-12', 'Menú Económico', 40, 20, 10),
('2025-04-13', 'Menú Gourmet', 100, 80, 70),
('2025-04-14', 'Menú Ligero', 55, 30, 25),
('2025-04-15', 'Menú Criollo', 60, 40, 30),
('2025-04-16', 'Menú Tradicional', 50, 35, 20),
('2025-04-17', 'Menú Especial', 70, 45, 35),
('2025-04-18', 'Menú Campestre', 85, 55, 40),
('2025-04-19', 'Menú de Invierno', 90, 60, 50),
('2025-04-20', 'Menú de Verano', 80, 50, 45),
('2025-04-21', 'Menú de Primavera', 75, 40, 35),
('2025-04-22', 'Menú de Otoño', 70, 45, 30),
('2025-04-23', 'Menú Del Día', 95, 70, 60),
('2025-04-24', 'Menú del Chef', 100, 80, 75),
('2025-04-25', 'Menú Vegano', 60, 35, 20),
('2025-04-26', 'Menú Keto', 50, 30, 15),
('2025-04-27', 'Menú Sin Gluten', 45, 25, 10),
('2025-04-28', 'Menú Clásico', 70, 55, 40),
('2025-04-29', 'Menú Ejecutivo', 85, 65, 50),
('2025-04-30', 'Menú Familiar', 90, 70, 55),
('2025-05-01', 'Menú Buffet', 100, 90, 80),
('2025-05-02', 'Menú Express', 55, 35, 25),
('2025-05-03', 'Menú Festivo', 95, 75, 60),
('2025-05-04', 'Menú de Gala', 120, 100, 90),
('2025-05-05', 'Menú de Bodas', 110, 90, 85),
('2025-05-06', 'Menú Infantil', 80, 60, 50),
('2025-05-07', 'Menú Casual', 70, 50, 40),
('2025-05-08', 'Menú Regional', 85, 65, 55),
('2025-05-09', 'Menú Artesanal', 75, 55, 45),
('2025-05-10', 'Menú a la Carta', 90, 70, 60),
('2025-05-11', 'Menú Tradicional', 50, 30, 20),
('2025-05-12', 'Menú Ligero', 65, 45, 35),
('2025-05-13', 'Menú Delicatessen', 110, 85, 75),
('2025-05-14', 'Menú Experimental', 80, 60, 50),
('2025-05-15', 'Menú Internacional', 95, 70, 60),
('2025-05-16', 'Menú de Autor', 100, 80, 70),
('2025-05-17', 'Menú Orgánico', 55, 40, 30),
('2025-05-18', 'Menú Rústico', 70, 50, 40),
('2025-05-19', 'Menú Carnívoro', 90, 70, 60),
('2025-05-20', 'Menú Pescador', 85, 60, 55),
('2025-05-21', 'Menú Clásico', 75, 55, 50),
('2025-05-22', 'Menú Fusión', 95, 75, 65),
('2025-05-23', 'Menú Moderno', 100, 80, 70),
('2025-05-24', 'Menú Especial', 110, 90, 80),
('2025-05-25', 'Menú Económico', 50, 30, 20),
('2025-05-26', 'Menú Gourmet', 90, 65, 55),
('2025-05-27', 'Menú Temático', 85, 60, 50),
('2025-05-28', 'Menú Dietético', 75, 50, 40),
('2025-05-29', 'Menú Sostenible', 70, 45, 35),
('2025-05-30', 'Menú Regional', 95, 70, 60),
('2025-05-31', 'Menú Experimental', 100, 80, 70),
('2025-06-01', 'Menú Vegetariano', 55, 35, 25),
('2025-06-02', 'Menú de Temporada', 60, 40, 30),
('2025-06-03', 'Menú Familiar', 80, 60, 50),
('2025-06-04', 'Menú Ejecutivo', 85, 65, 55),
('2025-06-05', 'Menú Express', 90, 70, 60),
('2025-06-06', 'Menú Buffet', 120, 100, 90);


INSERT INTO Detalles_Pago  (id_Tutor,fecha_Limite_Pago, fecha_Realizado, cantidad_Pago) VALUES
(1, '2023-10-31', '2023-10-30', 100),
('María', '2023-10-31', '2023-10-29', 150),
('Juan', '2023-10-31', '2023-10-28', 200),
('Ana', '2023-10-31', '2023-10-27', 250),
('Pedro', '2023-10-31', '2023-10-26', 300),
('Laura', '2023-10-31', '2023-10-25', 350),
('Jorge', '2023-10-31', '2023-10-24', 400),
('Andrea', '2023-10-31', '2023-10-23', 450),
('Luis', '2023-10-31', '2023-10-22', 500),
('Gabriela', '2023-10-31', '2023-10-21', 550),
('Roberto', '2023-10-31', '2023-10-20', 600),
('Elena', '2023-10-31', '2023-10-19', 650),
('Miguel', '2023-10-31', '2023-10-18', 700),
('Sofía', '2023-10-31', '2023-10-17', 750),
('Fernando', '2023-10-31', '2023-10-16', 800),
('Carmen', '2023-10-31', '2023-10-15', 850),
('Raúl', '2023-10-31', '2023-10-14', 900),
('Patricia', '2023-10-31', '2023-10-13', 950),
('Alejandro', '2023-10-31', '2023-10-12', 1000),
('Daniela', '2023-10-31', '2023-10-11', 1050),
('Carlos', '2023-10-31', '2023-10-10', 1100),
('María', '2023-10-31', '2023-10-09', 1150),
('Juan', '2023-10-31', '2023-10-08', 1200),
('Ana', '2023-10-31', '2023-10-07', 1250),
('Pedro', '2023-10-31', '2023-10-06', 1300),
('Laura', '2023-10-31', '2023-10-05', 1350),
('Jorge', '2023-10-31', '2023-10-04', 1400),
('Andrea', '2023-10-31', '2023-10-03', 1450),
('Luis', '2023-10-31', '2023-10-02', 1500),
('Gabriela', '2023-10-31', '2023-10-01', 1550),
('Roberto', '2023-10-31', '2023-09-30', 1600),
('Elena', '2023-10-31', '2023-09-29', 1650),
('Miguel', '2023-10-31', '2023-09-28', 1700),
('Sofía', '2023-10-31', '2023-09-27', 1750),
('Fernando', '2023-10-31', '2023-09-26', 1800),
('Carmen', '2023-10-31', '2023-09-25', 1850),
('Raúl', '2023-10-31', '2023-09-24', 1900),
('Patricia', '2023-10-31', '2023-09-23', 1950),
('Alejandro', '2023-10-31', '2023-09-22', 2000),
('Carlos González Pérez', '2025-04-10', '2025-04-08', 1500.00),
('María López García', '2025-04-15', '2025-04-14', 2000.00),
('Juan Martínez Hernández', '2025-04-20', '2025-04-18', 1750.00),
('Ana Ramírez Torres', '2025-04-25', '2025-04-24', 2200.00),
('Pedro Sánchez Vargas', '2025-05-01', '2025-04-30', 1800.00),
('Laura Fernández Díaz', '2025-05-05', '2025-05-04', 2100.00),
('Jorge Ortega Castillo', '2025-05-10', '2025-05-09', 1900.00),
('Andrea Mendoza Rojas', '2025-05-15', '2025-05-13', 1700.00),
('Luis Cruz Moreno', '2025-05-20', '2025-05-18', 1600.00),
('Gabriela Reyes Núñez', '2025-05-25', '2025-05-22', 2300.00),
('Roberto Gómez Luna', '2025-06-01', '2025-05-30', 1750.00),
('Elena Hernández Pérez', '2025-06-05', '2025-06-04', 2200.00),
('Miguel Vargas Gómez', '2025-06-10', '2025-06-08', 1950.00),
('Sofía Jiménez Flores', '2025-06-15', '2025-06-13', 1850.00),
('Fernando Díaz Hernández', '2025-06-20', '2025-06-18', 2000.00),
('Carmen Torres Ramírez', '2025-06-25', '2025-06-23', 2100.00),
('Raúl Castillo Santos', '2025-07-01', '2025-06-29', 1700.00),
('Patricia Morales Ortega', '2025-07-05', '2025-07-03', 1950.00),
('Alejandro López Fernández', '2025-07-10', '2025-07-08', 1800.00),
('Daniela Reyes García', '2025-07-15', '2025-07-14', 2250.00),
('Carlos González Pérez', '2025-07-20', '2025-07-19', 2000.00),
('María López García', '2025-07-25', '2025-07-24', 2150.00),
('Juan Martínez Hernández', '2025-08-01', '2025-07-30', 1750.00),
('Ana Ramírez Torres', '2025-08-05', '2025-08-03', 2400.00),
('Pedro Sánchez Vargas', '2025-08-10', '2025-08-08', 1850.00),
('Laura Fernández Díaz', '2025-08-15', '2025-08-13', 2050.00),
('Jorge Ortega Castillo', '2025-08-20', '2025-08-18', 1900.00),
('Andrea Mendoza Rojas', '2025-08-25', '2025-08-22', 1700.00),
('Luis Cruz Moreno', '2025-09-01', '2025-08-30', 2000.00),
('Gabriela Reyes Núñez', '2025-09-05', '2025-09-03', 2300.00),
('Roberto Gómez Luna', '2025-09-10', '2025-09-08', 1900.00),
('Elena Hernández Pérez', '2025-09-15', '2025-09-13', 1800.00),
('Miguel Vargas Gómez', '2025-09-20', '2025-09-18', 1950.00),
('Sofía Jiménez Flores', '2025-09-25', '2025-09-22', 2000.00),
('Fernando Díaz Hernández', '2025-10-01', '2025-09-30', 2100.00),
('Carmen Torres Ramírez', '2025-10-05', '2025-10-03', 1700.00),
('Raúl Castillo Santos', '2025-10-10', '2025-10-08', 2200.00),
('Patricia Morales Ortega', '2025-10-15', '2025-10-13', 1750.00),
('Alejandro López Fernández', '2025-10-20', '2025-10-18', 1850.00),
('Daniela Reyes García', '2025-10-25', '2025-10-22', 2250.00),
('Carlos González Pérez', '2025-11-01', '2025-10-30', 2150.00),
('María López García', '2025-11-05', '2025-11-03', 1950.00),
('Juan Martínez Hernández', '2025-11-10', '2025-11-08', 1750.00),
('Ana Ramírez Torres', '2025-11-15', '2025-11-13', 2050.00),
('Pedro Sánchez Vargas', '2025-11-20', '2025-11-18', 1900.00),
('Laura Fernández Díaz', '2025-11-25', '2025-11-22', 2300.00),
('Jorge Ortega Castillo', '2025-12-01', '2025-11-30', 2100.00),
('Andrea Mendoza Rojas', '2025-12-05', '2025-12-03', 1700.00);

SELECT * FROM Nino 
SELECT * FROM Tutor
SELECT * FROM Alimento
SELECT * FROM Ingrediente
SELECT * FROM Detalles_Comida
SELECT * FROM Detalles_Pago

--consultas