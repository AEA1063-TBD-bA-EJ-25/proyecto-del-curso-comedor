create database Comedor;

go;

use comedor;

create TABLE Niño (
 CURP CHAR(18) NOT NULL PRIMARY KEY,
 Nombre nvarchar(50) NOT NULL,
 Edad CHAR(2) NOT NULL,
 Grado CHAR(2) NOT NULL,
 Nivel CHAR(2) NOT NULL,
 Alergias-Alimenticias nvarchar(60) NULL,
)


create TABLE Tutor (
 ID CHAR(5) NOT NULL PRIMARY KEY,
 Nombre nvarchar(50) NOT NULL,
 Telefono-Celular CHAR(11) NOT NULL,
 Telefono CHAR(11) NULL,
 Lugar-Trabajo nvarchar(60) NULL
)



create TABLE Alimento (
 ID CHAR(3) NOT NULL PRIMARY KEY,
 Nombre nvarchar(20) NOT NULL,
 Datos-Nutricionales nvarchar(60) NOT NULL
)



create TABLE Receta (
 ID CHAR(3) NOT NULL PRIMARY KEY,
 Porciones nvarchar(3) NOT NULL

)


create TABLE Ingrediente (
 ID CHAR(3) NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Receta(ID) ,
 Cantidad CHAR(3)
 Unidad CHAR(2)

)

INSERT INTO Niño (CURP, Nombre, Edad, Grado, Nivel,Alergias-Alimenticias )
     VALUES('PEMJ190101HDFLRR09', 'Juan Pérez Martínez', 5, '3°', 'Kinder', 'Maní'),
     VALUES('LOSA180202MDFTRR12', 'María López Sánchez', 6, '1°', 'Primaria', 'Ninguna'),
     VALUES('RATJ170303HDFMRN05', 'José Ramírez Torres', 4, '2°', 'Kinder', 'Lácteos'),
('CAMA160404MDFLRN08', 'Ana Castillo Méndez', 7, '2°', 'Primaria', 'Mariscos'),
('HEDC150505HDFPRS03', 'Carlos Hernández Díaz', 5, '3°', 'Kinder', 'Gluten'),
('RUMF140606MDFLRL06', 'Fernanda Ruiz Morales', 8, '3°', 'Primaria', 'Ninguna'),
('TOVM130707HDFRMR07', 'Miguel Ángel Torres Vargas', 6, '1°', 'Primaria', 'Frutos secos'),
('MACH120808MDFTRS10', 'Luisa Martínez Chávez', 4, '2°', 'Kinder', 'Pescado'),
('JIOR110909HDFTRS02', 'Roberto Jiménez Orozco', 7, '2°', 'Primaria', 'Huevo'),
('FUOG101010MDFPRS07', 'Gabriela Fuentes Ortega', 5, '3°', 'Kinder', 'Soya'),
('SORD090911MDFLRS06', 'Daniela Solano Ríos', 6, '1°', 'Primaria', 'Mariscos'),
('ESBH080812HDFMRL03', 'Hugo Estrada Bautista', 8, '3°', 'Primaria', 'Ninguna'),
('CADV070913MDFPRS02', 'Verónica Castro Delgado', 4, '2°', 'Kinder', 'Chocolate'),
('GOPR060814HDFLRL01', 'Ricardo González Pineda', 6, '1°', 'Primaria', 'Maní'),
('VESC050915MDFTRS04', 'Carmen Velázquez Soto', 7, '2°', 'Primaria', 'Lácteos'),
('ORNF040916HDFMRL05', 'Francisco Ortega Nájera', 5, '3°', 'Kinder', 'Ninguna'),
('MERJ030917MDFLRS02', 'Jazmín Medina Robles', 8, '3°', 'Primaria', 'Gluten'),
('NUES020918HDFMRL09', 'Salvador Núñez Espinoza', 4, '2°', 'Kinder', 'Frutos secos'),
('AGRE010919HDFMRL07', 'Esteban Aguilar Romero', 7, '2°', 'Primaria', 'Huevo'),
('DOVP200920MDFPRS05', 'Patricia Domínguez Vargas', 6, '1°', 'Primaria', 'Soya');


INSERT INTO Tutor (ID, Nombre, Telefono-Celular, Telefono, Lugar-Trabajo)
     VALUES(1, 'Juan Pérez', '5523456789', '5512345678', 'Google'),
     VALUES(2, 'María López', '5545671234', '5532145678', 'Microsoft'),
     VALUES(3, 'José Ramírez', '5578912345', '5523456789', 'Amazon'),
     VALUES(4, 'Ana Castillo', '5587654321', '5543218765', 'Facebook'),
     VALUES(5, 'Carlos Hernández', '5598765432', '5556784321', 'Apple'),
     VALUES(6, 'Fernanda Ruiz', '5512345678', '5576543219', 'Tesla'),
     VALUES(7, 'Miguel Ángel Torres', '5523459876', '5587654320', 'IBM'),
     VALUES(8, 'Luisa Martínez', '5545678912', '5598765431', 'Netflix'),
     VALUES(9, 'Roberto Jiménez', '5576543210', '5512348765', 'Airbnb'),
     VALUES(10, 'Gabriela Fuentes', '5598765439', '5532146789', 'Spotify'),
     VALUES(11, 'Daniela Solano', '5512346789', '5576543298', 'Uber'),
     VALUES(12, 'Hugo Estrada', '5523457891', '5543219876', 'Intel'),
     VALUES(13, 'Verónica Castro', '5545678901', '5598763214', 'Nvidia'),
     VALUES(14, 'Ricardo González', '5578910234', '5512347890', 'Samsung'),
     VALUES(15, 'Carmen Velázquez', '5587650987', '5532146780', 'Huawei'),
     VALUES(16, 'Francisco Ortega', '5598760123', '5556789012', 'Oracle'),
     VALUES(17, 'Jazmín Medina', '5512345670', '5576543212', 'Adobe'),
     VALUES(18, 'Salvador Núñez', '5523456788', '5587654323', 'SpaceX'),
     VALUES(19, 'Esteban Aguilar', '5545678907', '5598765434', 'Sony'),
     VALUES(20, 'Patricia Domínguez', '5578912340', '5512347654', 'Siemens');
