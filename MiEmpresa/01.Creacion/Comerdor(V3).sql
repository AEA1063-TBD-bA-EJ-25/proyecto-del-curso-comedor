CREATE DATABASE Comedor;
go

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

CREATE TABLE Tipo (
    id_tipo INT IDENTITY(1,1) PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL
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

-- Tabla Receta
CREATE TABLE Receta (
    id_receta INT IDENTITY(1,1) PRIMARY KEY,
    nombre_receta VARCHAR(100),
    id_tipo INT,
    FOREIGN KEY (id_tipo) REFERENCES Tipo(id_tipo)
);

--Tabla Menu 
CREATE TABLE Menu (
    id_menu INT IDENTITY(1,1) PRIMARY KEY,
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

--Tipo de unidad de medida
CREATE TABLE Unidad (
    id_unidad INT IDENTITY(1,1) PRIMARY KEY,
    unidadMedida VARCHAR(50)
);

--Relación Receta_Comida, Receta_Bebida, Receta_Postre con Ingredientes
CREATE TABLE Receta_Ingrediente (
    id_receta INT,
    id_ingrediente INT,
    cantidad DECIMAL(10,2),
    id_unidad INT,
    PRIMARY KEY (id_receta, id_ingrediente, id_unidad),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente),
    FOREIGN KEY (id_unidad) REFERENCES Unidad(id_unidad)
);


-- Tabla Semana
CREATE TABLE Semana (
    id_semana INT IDENTITY(1,1) PRIMARY KEY,
    fecha_inicio DATE,
    fecha_fin DATE,
    id_menu INT,
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu)
);

--Dias de la semana
CREATE TABLE DiaSemana (
    id_diaS INT IDENTITY(1,1) PRIMARY KEY,
    diaS VARCHAR (10)
);

-- Relación entre Niño y Menú (Consumo)
CREATE TABLE Consumo (
    id_consumo INT IDENTITY(1,1) PRIMARY KEY,
    id_semana INT,
    id_nino INT,
    id_menu INT,
    id_diaS INT,
    cantidad_porciones INT,
    FOREIGN KEY (id_nino) REFERENCES Nino(id_nino),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (id_semana) REFERENCES Semana(id_semana),
    FOREIGN KEY (id_diaS) REFERENCES DiaSemana(id_diaS)
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


--********************INSERCIONES

-- Inserciones en la tabla Tutor
INSERT INTO Tutor (nombre, apellido_paterno, apellido_materno, telefono, telefono_celular, lugar_trabajo) VALUES 
    ('Carlos', 'González', 'Pérez', '6621234567', '6629876543', 'Escuela Primaria X'),
    ('María', 'López', 'García', '6627654321', '6621122334', 'Hospital Y'),
    ('Juan', 'Martínez', 'Hernández', '6623344556', '6629988776', 'Universidad Z'),
    ('Sofía', 'Ramírez', 'Jiménez', '6628765432', '6622233445', 'Oficina A'),
    ('Luis', 'Rodríguez', 'Mendoza', '6629988777', '6623344556', 'Colegio B'),
    ('Ana', 'Fernández', 'Ruiz', '6621112233', '6624445566', 'Escuela Secundaria C'),
    ('Pedro', 'Hernández', 'López', '6622223344', '6625556677', 'Universidad D'),
    ('Laura', 'Gómez', 'Sánchez', '6623334455', '6626667788', 'Hospital E'),
    ('Ricardo', 'Díaz', 'Castro', '6624445566', '6627778899', 'Empresa F'),
    ('Carmen', 'Medina', 'Ortiz', '6625556677', '6628889900', 'Escuela Primaria G'),
    ('Jorge', 'Vargas', 'Silva', '6626667788', '6629990011', 'Oficina H'),
    ('Isabel', 'Jiménez', 'Reyes', '6627778899', '6620001122', 'Colegio I'),
    ('Alberto', 'Santos', 'Morales', '6628889900', '6621112233', 'Universidad J'),
    ('Elena', 'Pérez', 'Gómez', '6629990011', '6622223344', 'Escuela K'),
    ('Daniel', 'Cruz', 'Ramírez', '6620001122', '6623334455', 'Oficina L'),
    ('Rosa', 'Ortega', 'Vega', '6621231234', '6629879876', 'Hospital M'),
    ('Manuel', 'Ríos', 'Guzmán', '6622342345', '6628768765', 'Empresa N'),
    ('Patricia', 'Navarro', 'Torres', '6623453456', '6627657654', 'Universidad O'),
    ('Gabriel', 'Flores', 'Méndez', '6624564567', '6626546543', 'Escuela P'),
    ('Andrea', 'Suárez', 'Delgado', '6625675678', '6625435432', 'Colegio Q');


-- Inserciones en la tabla Niño
INSERT INTO Nino (nombre, apellido_paterno, apellido_materno, fecha_nacimiento, grado, nivel, alergias_alimenticias, id_tutor) VALUES
    ('Pedro', 'Perez', 'Gomez', '2005-03-28', 'Primero', 'Primaria', 'Ninguna', 1),
    ('Juan', 'Ramírez', 'López', '2007-06-15', 'Cuarto', 'Primaria', 'Ninguna', 2),
    ('Ana', 'Martínez', 'López', '2005-06-18', 'Tercero', 'Primaria', 'Camarón', 3),
    ('Luis', 'Gómez', 'Vega', '2006-05-14', 'Segundo', 'Primaria', 'Ninguna', 4),
    ('María', 'Hernández', 'López', '2008-08-30', 'Primero', 'Primaria', 'Frutos secos', 5),
     ('Sofía', 'Díaz', 'Mendoza', '2009-01-12', 'Quinto', 'Primaria', 'Ninguna', 6),
    ('Carlos', 'Fernández', 'Ruiz', '2010-09-25', 'Sexto', 'Primaria', 'Gluten', 7),
    ('Valeria', 'Ortega', 'Sánchez', '2007-11-05', 'Cuarto', 'Primaria', 'Lácteos', 8),
    ('Javier', 'López', 'Castro', '2006-07-18', 'Tercero', 'Primaria', 'Ninguna', 9),
    ('Elena', 'Jiménez', 'Ortiz', '2005-10-22', 'Segundo', 'Primaria', 'Maní', 10),
    ('Diego', 'Vargas', 'Reyes', '2011-02-14', 'Primero', 'Primaria', 'Ninguna', 11),
    ('Camila', 'Suárez', 'Morales', '2009-04-19', 'Quinto', 'Primaria', 'Mariscos', 12),
    ('Mateo', 'Navarro', 'Silva', '2008-06-30', 'Cuarto', 'Primaria', 'Ninguna', 13),
    ('Lucía', 'Cruz', 'Pérez', '2010-12-05', 'Sexto', 'Primaria', 'Ninguna', 14),
    ('Emilio', 'Torres', 'Delgado', '2007-08-07', 'Tercero', 'Primaria', 'Huevo', 15),
    ('Regina', 'Gómez', 'Méndez', '2006-09-15', 'Segundo', 'Primaria', 'Ninguna', 1),
    ('Andrés', 'Hernández', 'Ríos', '2005-03-03', 'Primero', 'Primaria', 'Lácteos', 2),
    ('Natalia', 'Rodríguez', 'García', '2009-07-22', 'Quinto', 'Primaria', 'Cacahuates', 3),
    ('Manuel', 'Pérez', 'Flores', '2008-05-28', 'Cuarto', 'Primaria', 'Ninguna', 4),
    ('Victoria', 'Santos', 'Guzmán', '2011-11-11', 'Primero', 'Primaria', 'Fresas', 5);

--Tabla tipo
INSERT INTO Tipo (nombre_tipo) VALUES 
    ('Comida'),
    ('Bebida'),
    ('Postre');

-- Inserciones en la tabla Comida
INSERT INTO Receta_Comida (nombre_comida, procedimiento, porciones) VALUES 
    ('Crêpes salados', 'Disponer la harina de garbanzo en un cuenco o jarra con el agua. Continuar hasta terminar con toda la masa, rellenar con los ingredientes preparados y servir.', 5),
    ('Tacos al pastor', 'Marinar la carne de cerdo con achiote, especias y jugo de piña. Cocinarla en el trompo y servir en tortillas con cebolla, cilantro y salsa.', 3),
    ('Ensalada César', 'Mezclar lechuga romana, croutones, aderezo César, queso parmesano y pollo a la parrilla.', 7),
    ('Spaghetti Bolognese', 'Cocinar la carne molida con cebolla, ajo, tomate, y especias. Mezclar con la pasta cocida y servir con queso parmesano.', 5),
    ('Sopes de pollo', 'Cocer el pollo y desmenuzarlo. Preparar sopes con masa, freírlos y agregar pollo, lechuga, crema, queso y salsa al gusto.', 2),
    ('Chiles en nogada', 'Rellenar los chiles poblanos asados con picadillo de carne, frutas y especias. Cubrir con salsa de nuez y decorar con granada y perejil.', 5),
    ('Guacamole', 'Machacar aguacates y mezclar con jitomate, cebolla, cilantro, limón y sal.', 4),
    ('Quesadillas de champiñones', 'Saltear champiñones con ajo y cebolla. Rellenar tortillas con queso y champiñones, y dorarlas en un comal.', 3),
    ('Sopa de tortilla', 'Freír tiras de tortilla y servir en un caldo de jitomate con chile pasilla, crema, queso y aguacate.', 5),
    ('Enchiladas verdes', 'Rellenar tortillas con pollo desmenuzado, cubrir con salsa verde y gratinar con queso.', 4),
    ('Tostadas de tinga', 'Cocinar pollo desmenuzado con cebolla, jitomate y chipotle. Servir sobre tostadas con crema, queso y lechuga.', 5),
    ('Gorditas de chicharrón', 'Mezclar masa con chicharrón prensado, formar gorditas y cocer en el comal. Rellenar con frijoles y queso.', 3),
    ('Tamales de rajas', 'Preparar masa de maíz con manteca y caldo. Rellenar con rajas de chile poblano y queso. Envolver en hojas de maíz y cocer al vapor.', 4),
    ('Flautas de res', 'Rellenar tortillas con carne deshebrada, enrollarlas y freírlas hasta dorar. Servir con crema, queso y salsa.', 5),
    ('Pozole rojo', 'Cocinar carne de cerdo con maíz cacahuazintle en un caldo con chile guajillo. Servir con lechuga, rábano y orégano.', 5),
    ('Sopes de frijol', 'Preparar sopes con masa de maíz, freírlos y agregar frijoles refritos, lechuga, crema y queso.', 4),
    ('Pambazos', 'Rellenar bolillos bañados en salsa de guajillo con papas con chorizo y freírlos ligeramente. Servir con crema y lechuga.', 3),
    ('Tlacoyos', 'Formar masa con forma ovalada y rellenar con frijoles, habas o chicharrón. Cocinar en el comal y servir con nopales y queso.', 5),
    ('Caldo tlalpeño', 'Cocer pollo con garbanzos, zanahoria, papa y chipotle. Servir con limón y aguacate.', 4),
    ('Pico de gallo', 'Picar jitomate, cebolla, chile serrano y cilantro. Mezclar con limón y sal.', 3);
     
INSERT INTO Comida (nombre_comida, id_receta_comida) VALUES 
    ('Crêpes salados', 1),
    ('Tacos al pastor', 2),
    ('Ensalada César', 3),
    ('Spaghetti Bolognese', 4),
    ('Sopes de pollo', 5),
    ('Chiles en nogada',6),
    ('Guacamole', 7),
    ('Quesadillas de champiñones', 8),
    ('Sopa de tortilla', 9),
    ('Enchiladas verdes', 10),
    ('Tostadas de tinga', 11),
    ('Gorditas de chicharrón', 12),
    ('Tamales de rajas', 13),
    ('Flautas de res', 14),
    ('Pozole rojo', 15),
    ('Sopes de frijol', 16),
    ('Pambazos', 17),
    ('Tlacoyos', 18),
    ('Caldo tlalpeño', 19),
    ('Pico de gallo', 20);




INSERT INTO Menu_Comida (id_menuC, id_receta_comida) VALUES 
    (1, 1),  -- Crêpes salados
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 5),
    (3, 6),  -- Chiles en nogada
    (4, 7),  -- Guacamole
    (4, 8),  -- Quesadillas de champiñones
    (5, 9),  -- Sopa de tortilla
    (5, 10), -- Enchiladas verdes
    (6, 11), -- Tostadas de tinga
    (6, 12), -- Gorditas de chicharrón
    (7, 13), -- Tamales de rajas
    (7, 14), -- Flautas de res
    (8, 15), -- Pozole rojo
    (8, 16), -- Sopes de frijol
    (9, 17), -- Pambazos
    (9, 18), -- Tlacoyos
    (10, 19), -- Caldo tlalpeño
    (10, 20); -- Pico de gallo

-- Inserciones en la tabla Bebida
INSERT INTO Receta_Bebida (nombre_bebida, procedimiento, porciones) VALUES 
    ('Jugo de naranja', 'Exprimir las naranjas y servir.', 5),
    ('Agua natural', 'Servir agua fresca.', 5),
    ('Limonada', 'Exprimir limones, añadir agua y azúcar.', 5),
    ('Refresco de cola', 'Abrir la lata y servir.', 5),
    ('Agua con gas', 'Servir agua con gas al gusto.', 5),
    ('Té helado', 'Preparar té, enfriar y servir con hielo y limón.', 5),
    ('Café americano', 'Preparar café filtrado y servir caliente.', 5),
    ('Chocolate caliente', 'Calentar leche y mezclar con cacao y azúcar.', 5),
    ('Horchata', 'Licuar arroz con agua, canela y azúcar. Colar y servir.', 5),
    ('Agua de jamaica', 'Hervir flor de jamaica, colar y endulzar.', 5),
    ('Agua de tamarindo', 'Hervir tamarindo, colar y mezclar con agua y azúcar.', 5),
    ('Licuado de plátano', 'Licuar plátano con leche y azúcar.', 5),
    ('Jugo verde', 'Licuar espinaca, piña, apio y limón con agua.', 5),
    ('Batido de fresa', 'Licuar fresas con leche y azúcar.', 5),
    ('Agua de coco', 'Servir agua de coco fresca.', 5),
    ('Piña colada sin alcohol', 'Licuar piña, crema de coco y hielo.', 5),
    ('Té de manzanilla', 'Infusionar manzanilla en agua caliente.', 5),
    ('Café con leche', 'Mezclar café recién hecho con leche caliente.', 5),
    ('Jugo de zanahoria', 'Licuar zanahorias con agua y colar.', 5),
    ('Smoothie de mango', 'Licuar mango con yogur y hielo.', 5);

INSERT INTO Bebida (nombre_bebida, id_receta_bebida) VALUES 
    ('Jugo de naranja', 1),
    ('Agua natural', 2),
    ('Limonada', 3),
    ('Refresco de cola', 4),
    ('Agua con gas', 5),
    ('Té helado',6),
    ('Café americano', 7),
    ('Chocolate caliente', 8),
    ('Horchata',  9),
    ('Agua de jamaica', 10),
    ('Agua de tamarindo', 11),
    ('Licuado de plátano', 12),
    ('Jugo verde',13),
    ('Batido de fresa', 14),
    ('Agua de coco', 15),
    ('Piña colada sin alcohol', 16),
    ('Té de manzanilla', 17),
    ('Café con leche', 18),
    ('Jugo de zanahoria', 19),
    ('Smoothie de mango', 20);


INSERT INTO Menu_Bebida (id_menuB, id_receta_bebida) VALUES 
    (1, 1),  -- Jugo de naranja
    (1, 2),  -- Agua natural
    (2, 3),  -- Limonada
    (2, 4),  -- Refresco de cola
    (3, 5),  -- Agua con gas
    (3, 6),  -- Té helado
    (4, 7),  -- Café americano
    (4, 8),  -- Chocolate caliente
    (5, 9),  -- Horchata
    (5, 10), -- Agua de jamaica
    (6, 11), -- Agua de tamarindo
    (6, 12), -- Licuado de plátano
    (7, 13), -- Jugo verde
    (7, 14), -- Batido de fresa
    (8, 15), -- Agua de coco
    (8, 16), -- Piña colada sin alcohol
    (9, 17), -- Té de manzanilla
    (9, 18), -- Café con leche
    (10, 19), -- Jugo de zanahoria
    (10, 20); -- Smoothie de mango

-- Inserciones en la tabla Postre
INSERT INTO Receta_Postre (nombre_postre, procedimiento, porciones) VALUES 
    ('Pastel de chocolate', 'Preparar el pastel con chocolate, harina y huevos. Hornear y servir.', 5),
    ('Flan', 'Mezclar leche, huevos y azúcar. Cocinar al baño maría y enfriar.', 5),
    ('Gelatina de frutas', 'Disolver gelatina en agua, agregar frutas y refrigerar.', 5),
    ('Tarta de manzana', 'Preparar masa, colocar manzanas y hornear.', 5),
    ('Brownie', 'Mezclar chocolate, harina y azúcar. Hornear y servir.', 5),
    ('Cheesecake', 'Preparar base de galleta, mezclar queso crema con azúcar y hornear.', 5),
    ('Helado de vainilla', 'Mezclar crema, leche y vainilla. Congelar.', 4),
    ('Galletas de avena', 'Mezclar avena, harina y azúcar. Hornear.', 5),
    ('Crepas de Nutella', 'Preparar crepas y rellenar con Nutella.', 4),
    ('Pudín de arroz', 'Cocinar arroz con leche, azúcar y canela.', 5),
    ('Tiramisú', 'Mezclar queso mascarpone con café y bizcochos. Refrigerar.', 5),
    ('Churros', 'Preparar masa de harina, freír y espolvorear azúcar.', 5),
    ('Pay de limón', 'Preparar base de galleta y rellenar con crema de limón. Refrigerar.', 5),
    ('Mousse de chocolate', 'Mezclar chocolate derretido con crema batida y refrigerar.', 4),
    ('Macarons', 'Preparar merengue, mezclar con almendra y hornear.', 4),
    ('Buñuelos', 'Freír masa delgada y espolvorear azúcar y canela.', 5),
    ('Soufflé de chocolate', 'Mezclar chocolate derretido con claras montadas y hornear.', 4),
    ('Panqué de plátano', 'Mezclar plátano con harina y hornear.', 5),
    ('Tres leches', 'Hornear bizcocho y remojar en tres tipos de leche.', 5),
    ('Fresas con crema', 'Mezclar fresas con crema y azúcar.', 4);

INSERT INTO Postre (nombre_postre, id_receta_postre) VALUES 
    ('Pastel de chocolate', 1),
    ('Flan', 2),
    ('Gelatina de frutas', 3),
    ('Tarta de manzana', 4),
    ('Brownie', 5),
    ('Cheesecake', 6),
    ('Helado de vainilla', 7),
    ('Galletas de avena', 8),
    ('Crepas de Nutella', 9),
    ('Pudín de arroz', 10),
    ('Tiramisú', 11),
    ('Churros', 12),
    ('Pay de limón', 13),
    ('Mousse de chocolate', 14),
    ('Macarons', 15),
    ('Buñuelos', 16),
    ('Soufflé de chocolate', 17),
    ('Panqué de plátano', 18),
    ('Tres leches', 19),
    ('Fresas con crema', 20);

INSERT INTO Menu_Postre (id_menuP, id_receta_postre) VALUES 
    (1, 1),  -- Pastel de chocolate
    (1, 2),  -- Flan
    (2, 3),  -- Gelatina de frutas
    (2, 4),  -- Tarta de manzana
    (3, 5),  -- Brownie
    (3, 6),  -- Cheesecake
    (4, 7),  -- Helado de vainilla
    (4, 8),  -- Galletas de avena
    (5, 9),  -- Crepas de Nutella
    (5, 10), -- Pudín de arroz
    (6, 11), -- Tiramisú
    (6, 12), -- Churros
    (7, 13), -- Pay de limón
    (7, 14), -- Mousse de chocolate
    (8, 15), -- Macarons
    (8, 16), -- Buñuelos
    (9, 17), -- Soufflé de chocolate
    (9, 18), -- Panqué de plátano
    (10, 19), -- Tres leches
    (10, 20); -- Fresas con crema

-- Inserciones en la tabla Menu
INSERT INTO Menu (id_comida, id_bebida, id_postre) VALUES 
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10),
    (11, 11, 11),
    (12, 12, 12),
    (13, 13, 13),
    (14, 14, 14),
    (15, 15, 15),
    (16, 16, 16),
    (17, 17, 17),
    (18, 18, 18),
    (19, 19, 19),
    (20, 20, 20);

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
    ('Pimiento rojo picante o dulce'),
    ('Carne de cerdo'),
    ('Achiote'),
    ('Jugo de piña'),
    ('Tortillas de maíz'),
    ('Lechuga romana'),
    ('Croutones'),
    ('Queso parmesano'),
    ('Pollo desmenuzado'),
    ('Jitomate'),
    ('Chile chipotle'),
    ('Masa de maíz'),
    ('Frijoles refritos'),
    ('Queso fresco'),
    ('Crema ácida'),
    ('Chile poblano'),
    ('Azúcar'),
    ('Harina de trigo'),
    ('Mantequilla'),
    ('Leche'),
    ('Huevo'),
    ('Vainilla'),
    ('Chocolate amargo'),
    ('Chocolate con leche'),
    ('Chocolate blanco'),
    ('Cocoa en polvo'),
    ('Canela en polvo'),
    ('Nuez moscada'),
    ('Clavo de olor'),
    ('Miel'),
    ('Jarabe de maple'),
    ('Jarabe de maíz'),
    ('Leche condensada'),
    ('Leche evaporada'),
    ('Crema para batir'),
    ('Queso crema'),
    ('Coco rallado'),
    ('Almendras'),
    ('Nueces'),
    ('Avellanas'),
    ('Pistaches'),
    ('Arándanos secos'),
    ('Pasas'),
    ('Dátiles'),
    ('Fresas'),
    ('Frambuesas'),
    ('Moras'),
    ('Mango'),
    ('Piña'),
    ('Plátano'),
    ('Manzana'),
    ('Pera'),
    ('Durazno'),
    ('Ciruela'),
    ('Limón'),
    ('Naranja'),
    ('Mandarina'),
    ('Maracuyá'),
    ('Gelatina sin sabor'),
    ('Grenetina'),
    ('Maicena'),
    ('Esencia de almendra'),
    ('Ron'),
    ('Licor de café'),
    ('Café soluble'),
    ('Té verde'),
    ('Té negro'),
    ('Té de manzanilla'),
    ('Té de menta'),
    ('Cerveza'),
    ('Vino tinto'),
    ('Vino blanco'),
    ('Champaña'),
    ('Agua mineral'),
    ('Jugo de naranja'),
    ('Jugo de limón'),
    ('Jugo de arándano'),
    ('Jugo de manzana');

INSERT INTO Unidad (unidadMedida) VALUES
    ('g'),
    ('ml'),
    ('pz');

--RECETA 1 OCUPAMOS, 9 INGREDIENTES
INSERT INTO Receta_Ingrediente (id_receta, id_ingrediente, cantidad, id_unidad) VALUES
    --Receta 1
    (1, 1, 110, 1), --Harina de garbanzo
    (1, 2, 250, 2), --Agua
    (1, 3, 15, 2), --Aceite
    (1, 4, 2, 1),    --Sal
    (1, 5, 10, 1),  --Cebollino
    (1, 6, 1, 1),   --Pimienta negra
    (1, 7, 1, 3),   --Aguacate
    (1, 8, 1, 3),   --Cebolla morada
    (1, 9, 1, 3);   --Pimiento rojo

    --Receta 2

INSERT INTO Receta (nombre_receta, id_tipo) VALUES
    --COMIDA
    ('Crêpes salados', 1),
    ('Tacos al pastor', 1),
    ('Ensalada César', 1),
    --BEBIDAS
    ('Jugo de naranja', 2),
    ('Agua natural', 2),
    ('Limonada', 2),
    --POSTRE
    ('Pastel de chocolate', 3),
    ('Flan', 3),
    ('Gelatina de frutas', 3);

--Inserciones en la tabla Semana
INSERT INTO Semana (fecha_inicio, fecha_fin, id_menu) VALUES 
    ('2024-04-01', '2024-04-07', 1),
    ('2024-04-08', '2024-04-14', 2),
    ('2024-04-15', '2024-04-21', 3),
    ('2024-04-22', '2024-04-28', 4),
    ('2024-04-29', '2024-05-05', 5),
    ('2024-05-06', '2024-05-12', 6),
    ('2024-05-13', '2024-05-19', 7),
    ('2024-05-20', '2024-05-26', 8),
    ('2024-05-27', '2024-06-02', 9),
    ('2024-06-03', '2024-06-09', 10),
    ('2024-06-10', '2024-06-16', 11),
    ('2024-06-17', '2024-06-23', 12),
    ('2024-06-24', '2024-06-30', 13),
    ('2024-07-01', '2024-07-07', 14),
    ('2024-07-08', '2024-07-14', 15),
    ('2024-07-15', '2024-07-21', 16),
    ('2024-07-22', '2024-07-28', 17),
    ('2024-07-29', '2024-08-04', 18),
    ('2024-08-05', '2024-08-11', 19),
    ('2024-08-12', '2024-08-18', 20),
    ('2024-08-19', '2024-08-25', 9),
    ('2024-08-26', '2024-09-01', 20),
    ('2024-09-02', '2024-09-08', 18),
    ('2024-09-09', '2024-09-15', 18),
    ('2024-09-16', '2024-09-22', 13),
    ('2024-09-23', '2024-09-29', 3),
    ('2024-09-30', '2024-10-06', 1),
    ('2024-10-07', '2024-10-13', 20),
    ('2024-10-14', '2024-10-20', 6),
    ('2024-10-21', '2024-10-27', 1),
    ('2024-10-28', '2024-11-03', 18),
    ('2024-11-04', '2024-11-10', 3),
    ('2024-11-11', '2024-11-17', 20),
    ('2024-11-18', '2024-11-24', 20),
    ('2024-11-25', '2024-12-01', 9),
    ('2024-12-02', '2024-12-08', 7),
    ('2024-12-09', '2024-12-15', 8),
    ('2024-12-16', '2024-12-22', 19),
    ('2024-12-23', '2024-12-29', 14),
    ('2024-12-30', '2025-01-05', 16),
    ('2025-01-06', '2025-01-12', 19),
    ('2025-01-13', '2025-01-19', 16),
    ('2025-01-20', '2025-01-26', 10),
    ('2025-01-27', '2025-02-02', 14),
    ('2025-02-03', '2025-02-09', 19),
    ('2025-02-10', '2025-02-16', 13),
    ('2025-02-17', '2025-02-23', 1),
    ('2025-02-24', '2025-03-02', 12),
    ('2025-03-03', '2025-03-09', 13),
    ('2025-03-10', '2025-03-16', 11),
    ('2025-03-17', '2025-03-23', 10),
    ('2025-03-24', '2025-03-30', 1),
    ('2025-03-31', '2025-04-06', 8),
    ('2025-04-07', '2025-04-13', 10),
    ('2025-04-14', '2025-04-20', 5),
    ('2025-04-21', '2025-04-27', 13),
    ('2025-04-28', '2025-05-04', 10),
    ('2025-05-05', '2025-05-11', 5),
    ('2025-05-12', '2025-05-18', 10),
    ('2025-05-19', '2025-05-25', 18),
    ('2025-05-26', '2025-06-01', 4),
    ('2025-06-02', '2025-06-08', 20),
    ('2025-06-09', '2025-06-15', 2),
    ('2025-06-16', '2025-06-22', 1),
    ('2025-06-23', '2025-06-29', 4),
    ('2025-06-30', '2025-07-06', 4),
    ('2025-07-07', '2025-07-13', 8),
    ('2025-07-14', '2025-07-20', 17),
    ('2025-07-21', '2025-07-27', 19),
    ('2025-07-28', '2025-08-03', 12),
    ('2025-08-04', '2025-08-10', 19),
    ('2025-08-11', '2025-08-17', 13),
    ('2025-08-18', '2025-08-24', 17),
    ('2025-08-25', '2025-08-31', 4),
    ('2025-09-01', '2025-09-07', 17),
    ('2025-09-08', '2025-09-14', 18),
    ('2025-09-15', '2025-09-21', 7),
    ('2025-09-22', '2025-09-28', 13),
    ('2025-09-29', '2025-10-05', 1),
    ('2025-10-06', '2025-10-12', 19),
    ('2025-10-13', '2025-10-19', 17),
    ('2025-10-20', '2025-10-26', 1),
    ('2025-10-27', '2025-11-02', 4),
    ('2025-11-03', '2025-11-09', 17),
    ('2025-11-10', '2025-11-16', 9),
    ('2025-11-17', '2025-11-23', 19),
    ('2025-11-24', '2025-11-30', 9),
    ('2025-12-01', '2025-12-07', 11),
    ('2025-12-08', '2025-12-14', 4),
    ('2025-12-15', '2025-12-21', 1),
    ('2025-12-22', '2025-12-28', 2),
    ('2025-12-29', '2026-01-04', 19),
    ('2026-01-05', '2026-01-11', 10),
    ('2026-01-12', '2026-01-18', 9),
    ('2026-01-19', '2026-01-25', 2),
    ('2026-01-26', '2026-02-01', 17),
    ('2026-02-02', '2026-02-08', 11),
    ('2026-02-09', '2026-02-15', 4),
    ('2026-02-16', '2026-02-22', 12),
    ('2026-02-23', '2026-03-01', 1);

--Dias de la semana
INSERT INTO DiaSemana (diaS) VALUES
    ('Lunes'),
    ('Martes'),
    ('Miercoles'),
    ('Jueves'),
    ('Viernes'),
    ('Sabado'),
    ('Domingo');

--Inserciones en la tabla Consumo 
INSERT INTO Consumo (id_semana, id_nino, id_menu, id_diaS, cantidad_porciones) VALUES 
    (1, 1, 1, 1, 1),
    (1, 1, 2, 2, 1), 
    (1, 1, 3, 3, 1),
    (1, 1, 4, 4, 1),
    (1, 1, 5, 5, 1),

   (1, 2, 1, 1, 1),
   (1, 2, 2, 2,  1), 
   (1, 2, 3, 3, 1),
   (1, 2, 4, 4, 1),
   (1, 2, 5, 5, 1),

   (1, 3, 1, 1, 1),
   (1, 3, 2, 2, 1), 
   (1, 3, 3, 3, 1),
   (1, 3, 4, 4, 1),
   (1, 3, 5, 5, 1),

   (1, 4, 1, 1, 1),
   (1, 4, 2, 2, 1), 
   (1, 4, 3, 3, 1),
   (1, 4, 4, 4, 1),
   (1, 4, 5, 5, 1),

   (1, 5, 1, 1, 1),
   (1, 5, 2, 2, 1), 
   (1, 5, 3, 3, 1),
   (1, 5, 4, 4, 1),
   (1, 5, 5, 5, 1),

    (1, 6, 1, 1, 1),
    (1, 6, 2, 2, 1),
    (1, 6, 3, 3, 1),
    (1, 6, 4, 4, 1),
    (1, 6, 5, 5, 1),

   (1, 7, 1, 1, 1),
   (1, 7, 2, 2, 1), 
   (1, 7, 3, 3, 1),
   (1, 7, 4, 4, 1),
   (1, 7, 5, 5, 1),

   (1, 8, 1, 1, 1),
   (1, 8, 2, 2, 1), 
   (1, 8, 3, 3, 1),
   (1, 8, 4, 4, 1),
   (1, 8, 5, 5, 1),

   (1, 9, 1, 1, 1),
   (1, 9, 2, 2, 1), 
   (1, 9, 3, 3, 1),
   (1, 9, 4, 4, 1),
   (1, 9, 5, 5, 1),

   (1, 10, 1, 1, 1),
   (1, 10, 2, 2, 1), 
   (1, 10, 3, 3, 1),
   (1, 10, 4, 4, 1),
   (1, 10, 5, 5, 1),

    (1, 11, 1, 1, 1),
    (1, 11, 2, 2, 1), 
    (1, 11, 3, 3, 1),
    (1, 11, 4, 4, 1),
    (1, 11, 5, 5, 1),

   (1, 12, 1, 1, 1),
   (1, 12, 2, 2, 1),
   (1, 12, 3, 3, 1),
   (1, 12, 4, 4, 1),
   (1, 12, 5, 5, 1),

   (1, 13, 1, 1, 1),
   (1, 13, 2, 2, 1), 
   (1, 13, 3, 3, 1),
   (1, 13, 4, 4, 1),
   (1, 13, 5, 5, 1),

   (1, 14, 1, 1, 1),
   (1, 14, 2, 2, 1),
   (1, 14, 3, 3, 1),
   (1, 14, 4, 4, 1),
   (1, 14, 5, 5, 1),

   (1, 15, 1, 1, 1),
   (1, 15, 2, 2, 1), 
   (1, 15, 3, 3, 1),
   (1, 15, 4, 4, 1),
   (1, 15, 5, 5, 1),

    (1, 16, 1, 1, 1),
    (1, 16, 2, 2, 1), 
    (1, 16, 3, 3, 1),
    (1, 16, 4, 4, 1),
    (1, 16, 5, 5, 1),

   (1, 17, 1, 1, 1),
   (1, 17, 2, 2, 1), 
   (1, 17, 3, 3, 1),
   (1, 17, 4, 4, 1),
   (1, 17, 5, 5, 1),

   (1, 18, 1, 1, 1),
   (1, 18, 2, 2, 1), 
   (1, 18, 3, 3, 1),
   (1, 18, 4, 4, 1),
   (1, 18, 5, 5, 1),

   (1, 19, 1, 1, 1),
   (1, 19, 2, 2, 1), 
   (1, 19, 3, 3, 1),
   (1, 19, 4, 4, 1),
   (1, 19, 5, 5, 1),

   (1, 20, 1, 1, 1),
   (1, 20, 2, 2, 1), 
   (1, 20, 3, 3, 1),
   (1, 20, 4, 4, 1),
   (1, 20, 5, 5, 1);


-- Inserciones en la tabla Compra
INSERT INTO Compra (id_semana, id_ingrediente, cantidad_necesaria, fecha_compra) VALUES
    -- Semana 1
    (1, 1, 500, '2025-03-30'),  -- Harina de garbanzo
    (1, 2, 1200, '2025-03-30'),  -- Agua
    (1, 3, 100, '2025-03-30'),   -- Aceite de oliva virgen extra
    (1, 4, 30, '2025-03-30'),    -- Sal
    (1, 5, 50, '2025-03-30'),    -- Cebollino
    
    -- Semana 2
    (2, 6, 500, '2025-04-06'), 
    (2, 7, 1200, '2025-04-06'), 
    (2, 8, 100, '2025-04-06'),  
    (2, 9, 30, '2025-04-06'),    
    (2, 10, 50, '2025-04-06'),  
    
    -- Semana 3
    (3, 11, 500, '2025-04-14'),  
    (3, 12, 1200, '2025-04-14'), 
    (3, 13, 100, '2025-04-14'),   
    (3, 14, 30, '2025-04-14'),    
    (3, 15, 50, '2025-04-14'),    
    
    -- Semana 4
    (4, 16, 500, '2025-04-22'),  
    (4, 17, 1200, '2025-04-22'),  
    (4, 18, 100, '2025-04-22'),   
    (4, 19, 30, '2025-04-22'),    
    (4, 20, 50, '2025-04-22'),   

    -- Semana 5
    (5, 1, 600, '2025-04-29'),
    (5, 3, 150, '2025-04-29'),
    (5, 6, 700, '2025-04-29'),
    (5, 10, 80, '2025-04-29'),
    (5, 13, 900, '2025-04-29'),
    (5, 60, 400, '2025-04-29'),

    -- Semana 6
    (6, 2, 1300, '2025-05-06'),  
    (6, 4, 50, '2025-05-06'),
    (6, 7, 800, '2025-05-06'),
    (6, 9, 60, '2025-05-06'),
    (6, 56, 750, '2025-05-06'),
    (6, 35, 500, '2025-05-06'),
    
    -- Semana 7
    (7, 11, 550, '2025-05-13'),
    (7, 13, 120, '2025-05-13'),
    (7, 16, 450, '2025-05-13'),
    (7, 19, 70, '2025-05-13'),
    (7, 60, 650, '2025-05-13'),
    (7, 83, 380, '2025-05-13');

-- Inserciones en la tabla Pago
INSERT INTO Pago (id_tutor, id_semana, total, fecha_pago) VALUES 
    (1, 1, 100.00, '2025-04-01'),
    (2, 2, 120.00, '2025-04-08'),
    (3, 3, 150.00, '2025-04-15'),
    (4, 4, 130.00, '2025-04-22'),
    (5, 5, 180.00, '2025-04-29'),
    (6, 6, 140.00, '2025-05-06'),
    (7, 7, 120.00, '2025-05-14'),
    (8, 8, 170.00, '2025-05-22'),
    (9, 9, 130.00, '2025-05-30'),
    (10, 10, 130.00, '2025-06-08'),
    (11, 11, 100.00, '2025-06-16'),
    (12, 12, 160.00, '2025-06-24'),
    (13, 13, 150.00, '2025-06-15'),
    (14, 14, 130.00, '2025-06-22'),
    (15, 15, 180.00, '2025-06-29'),
    (16, 16, 170.00, '2025-07-06'),
    (17, 17, 190.00, '2025-07-14'),
    (18, 18, 170.00, '2025-07-22'),
    (19, 19, 150.00, '2025-07-30'),
    (20, 20, 130.00, '2025-08-08');


---*TABLAS
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
SELECT * FROM Receta
SELECT * FROM Unidad
SELECT * FROM Receta_Ingrediente
SELECT * FROM Ingrediente
SELECT * FROM Receta_Ingrediente
SELECT * FROM Consumo
SELECT * FROM Semana
SELECT * FROM DiaSemana
SELECT * FROM Compra
SELECT * FROM Pago


--******************************CONSULTAS
   