CREATE DATABASE Comedor

go

USE Comedor

-- Tablas

CREATE TABLE Nino (
    id_nino INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL,
    edad INT CHECK (edad > 0),
    grado VARCHAR(50) NOT NULL,
    nivel VARCHAR(50) NOT NULL,
    alergias_alimenticias TEXT,
    id_tutor INT,
    FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Tutor (
    id_tutor INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    telefono_celular VARCHAR(15),
    lugar_trabajo VARCHAR(255)
)

CREATE TABLE Menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
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
    id_alimento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    datos_nutricionales TEXT NOT NULL,
    tipo ENUM('COMIDA', 'POSTRE', 'BEBIDA') NOT NULL
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
    id_receta INT AUTO_INCREMENT PRIMARY KEY,
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
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    unidad VARCHAR(50) NOT NULL
)

CREATE TABLE Receta_Ingrediente (
    id_receta INT,
    id_ingrediente INT,
    cantidad DECIMAL(10,2) CHECK (cantidad > 0),
    PRIMARY KEY (id_receta, id_ingrediente),
    FOREIGN KEY (id_receta) REFERENCES Receta(id_receta) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente) ON DELETE CASCADE ON UPDATE CASCADE
)

-- Datos
INSERT INTO Tutor (nombres, apellido_paterno, apellido_materno, telefono, telefono_celular, lugar_trabajo) VALUES
('Juan', 'Perez', 'Gomez', '1234567890', '0987654321', 'Empresa A'),
('Maria', 'Lopez', 'Fernandez', '2345678901', '1234567890', 'Empresa B'),
('Carlos', 'Sanchez', 'Hernandez', '3456789012', '2345678901', 'Empresa C'),
('Ana', 'Martinez', 'Diaz', '4567890123', '3456789012', 'Empresa D'),
('Luis', 'Gonzalez', 'Ruiz', '5678901234', '4567890123', 'Empresa E');

INSERT INTO Nino (nombres, apellido_paterno, apellido_materno, edad, grado, nivel, alergias_alimenticias, id_tutor) VALUES
('Pedro', 'Perez', 'Gomez', 7, 'Primero', 'Primaria', 'Ninguna', 1),
('Lucia', 'Lopez', 'Fernandez', 8, 'Segundo', 'Primaria', 'Gluten', 2),
('Miguel', 'Sanchez', 'Hernandez', 9, 'Tercero', 'Primaria', 'Lactosa', 3),
('Elena', 'Martinez', 'Diaz', 10, 'Cuarto', 'Primaria', 'Nueces', 4),
('Javier', 'Gonzalez', 'Ruiz', 11, 'Quinto', 'Primaria', 'Ninguna', 5);