-- Replace 'New_Database' with your database name
IF NOT EXISTS 
    ( SELECT name FROM master.dbo.sysdatabases WHERE name = N'New_Database' ) 
    CREATE DATABASE [COMEDOR]
ELSE
    BEGIN
        DROP DATABASE [COMEDOR]
    END
go

USE COMEDOR;

