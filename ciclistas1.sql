USE gmmoreno_1;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'FK_VEHICULOS')
ALTER TABLE [VEHICULOS]
DROP constraint FK_VEHICULOS;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'FK_Ciclistas_Equipos1')
ALTER TABLE[Ciclistas_Equipos]
DROP constraint FK_Ciclistas_Equipos1 ;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'FK_Ciclistas_Equipos2')
ALTER TABLE [Ciclistas_Equipos]
DROP constraint FK_Ciclistas_Equipos2;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'FK_Ediciones_Ciclistas1')
ALTER TABLE [Ediciones_Ciclistas]
DROP constraint FK_Ediciones_Ciclistas1;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'FK_Ediciones_Ciclistas2')
ALTER TABLE [Ediciones_Ciclistas]
DROP constraint FK_Ediciones_Ciclistas2;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'FK_Etapas_Ciclistas1')
ALTER TABLE [Etapas_Ciclistas]
DROP constraint FK_Etapas_Ciclistas1;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'FK_Etapas_Ciclistas2')
ALTER TABLE [Etapas_Ciclistas]
DROP constraint FK_Etapas_Ciclistas2;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'FK_Etapas')
ALTER TABLE [Etapas]
DROP constraint FK_Etapas;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'Ciclistas')
DROP TABLE [Ciclistas];
GO

CREATE TABLE [Ciclistas](
[DNI] [int] constraint PK_Ciclistas PRIMARY KEY,
[Nombre] [varchar](20) NOT NULL,
[Apellido1] [varchar] (20) NOT NULL,
[Apellido2] [varchar] (20),
[Fecha_Nac] [datetime] NOT NULL,
[Edad] [int]);
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'Equipos')
DROP TABLE [Equipos];
GO

CREATE TABLE [Equipos](
[Id_Equipo] [char](4)constraint PK_Equipos PRIMARY KEY,
[Nombre] [varchar](20) NOT NULL,
[Nacionalidad] [varchar](20) NOT NULL);
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'Ediciones')
DROP TABLE [Ediciones];
GO

CREATE TABLE [Ediciones](
[Edición][smallint] constraint PK_Ediciones PRIMARY KEY,
[Fecha_Inicio][datetime] NOT NULL,
[Fecha_Fin][datetime] NOT NULL,
[N_Etapa][integer] NOT NULL default '20',
[Año][integer] NOT NULL);
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'Etapas')
DROP TABLE [Etapas];
GO

CREATE TABLE [Etapas](
[Edición][smallint],
[Etapa][smallint],
[Ciudad_Origen][varchar](50) NOT NULL,
[Ciudad_Destino][varchar](50) NOT NULL,
[Tipo_Etapa] [varchar](30) NOT NULL,
[N_Kilometros][float] NOT NULL,
constraint PK_Etapas PRIMARY KEY (Edición, Etapa));
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'VEHICULOS')
DROP TABLE [VEHICULOS];
GO

CREATE TABLE [VEHICULOS](
[Matrícula][char](7) constraint PK_VEHICULOS PRIMARY KEY,
[Tipo][varchar](20) NOT NULL default 'Turismo',
[Id_Equipo][char](4));
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'Ciclistas_Equipos')
DROP TABLE [Ciclistas_Equipos];
GO

CREATE TABLE [Ciclistas_Equipos](
[Id_Ciclista][int],
[Id_Equipo][char](4),
[Fecha_Inicial][datetime],
[N_Años_Cont][smallint],
constraint PK_Ciclistas_Equipos PRIMARY KEY (Id_Ciclista,Id_Equipo));
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'Ediciones_Ciclistas')
DROP TABLE [Ediciones_Ciclistas];
GO

CREATE TABLE [Ediciones_Ciclistas](
[Id_Ciclista][int],
[Edición][smallint],
[Tiempo][real],
[Posición][smallint],
constraint PK_Edición_Ciclista PRIMARY KEY (Id_Ciclista,Edición));
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'Etapas_Ciclistas')
DROP TABLE [Etapas_Ciclistas];
GO

CREATE TABLE[Etapas_Ciclistas](
[Edición][smallint],
[Etapa][smallint],
[Id_Ciclista][int],
[Tiempo][float],
[Posición][int],
constraint PK_Etapas_Ciclistas PRIMARY KEY (Edición,Etapa,Id_Ciclista));
GO

ALTER TABLE [VEHICULOS]
ADD constraint FK_VEHICULOS FOREIGN KEY (Id_Equipo) REFERENCES Equipos (Id_Equipo);
GO

ALTER TABLE[Ciclistas_Equipos]
ADD constraint FK_Ciclistas_Equipos1 FOREIGN KEY (Id_Ciclista) REFERENCES Ciclistas (DNI);
GO

ALTER TABLE [Ciclistas_Equipos]
ADD constraint FK_Ciclistas_Equipos2 FOREIGN KEY (Id_Equipo) REFERENCES Equipos(Id_Equipo);
GO

ALTER TABLE [Ediciones_Ciclistas]
ADD constraint FK_Ediciones_Ciclistas1 FOREIGN KEY (Id_Ciclista) REFERENCES Ciclistas (DNI);
GO

ALTER TABLE [Ediciones_Ciclistas]
ADD constraint FK_Ediciones_Ciclistas2 FOREIGN KEY (Edición) REFERENCES Ediciones (Edición);
GO

ALTER TABLE [Etapas_Ciclistas]
ADD constraint FK_Etapas_Ciclistas1 FOREIGN KEY (Id_Ciclista) REFERENCES Ciclistas (DNI);
GO

ALTER TABLE [Etapas_Ciclistas]
ADD constraint FK_Etapas_Ciclistas2 FOREIGN KEY (Edición, Etapa) REFERENCES Etapas (Edición, Etapa);
GO

ALTER TABLE [Etapas]
ADD constraint FK_Etapas FOREIGN KEY (Edición) REFERENCES Ediciones (Edición);
GO

ALTER TABLE [Ediciones]
ADD constraint CK_Ediciones_Etapas CHECK ([N_Etapa]>=20 AND [N_Etapa]<=25);
GO

ALTER TABLE [Ediciones]
ADD constraint CK_Ediciones_Fecha CHECK ([Año]>=1980 AND [Año]<=2020);
GO

ALTER TABLE [Ediciones]
ADD constraint CK_Ediciones_Edición CHECK ([Edición]>=1);
GO

ALTER TABLE [Ediciones]
ADD constraint CK_Ediciones_Fechas CHECK ([Fecha_Inicio]<[Fecha_Fin]);
GO

ALTER TABLE [Etapas]
ADD constraint CK_Etapas CHECK ([Etapa]>=1 AND [Etapa]<=25);
GO

ALTER TABLE [Etapas]
ADD constraint CK_Etapas_Tipo CHECK (Tipo_Etapa='Llana' OR Tipo_Etapa='Montaña' OR Tipo_Etapa='Contrarreloj equipos' OR Tipo_Etapa='Contrarreloj individual');
GO

ALTER TABLE [Etapas]
ADD constraint CK_Etapas_N_Kilometros CHECK ([N_Kilometros]>=0 AND [N_Kilometros]<=500);
GO

ALTER TABLE [Etapas]
ADD constraint CK_Etapas_Edición CHECK ([Edición]>=1);
GO

ALTER TABLE [Equipos]
ADD constraint CK_Equipos_Id CHECK ([Id_Equipo] like '[0-9][0-9][B-D,F-H,J-N,P-T,V-Z][B-D,F-H,J-N,P-T,V-Z]');
GO

ALTER TABLE [Ciclistas]
ADD constraint CK_Ciclistas_DNI CHECK (DNI>0 and DNI<99999999);
GO

ALTER TABLE [Ciclistas]
ADD [Edad] (gatedate()-[Fecha_Nac]);
GO

ALTER TABLE [Ciclistas_Equipos]
ADD constraint CK_Equipos_Años_Cont CHECK([N_Años_Cont]>=1);
GO

ALTER TABLE [Ciclistas_Equipos]
ADD constraint CK_Equipos_Año CHECK([Fecha_Inicial]>=01/01/1980);
GO

ALTER TABLE [VEHICULOS]
ADD constraint CK_VEHICULOS_Matrícula CHECK ([Matrícula] like '[0-9][0-9][0-9][0-9][B-D,F-H,J-N,P-T,V-Z][B-D,F-H,J-N,P-T,V-Z][B-D,F-H,J-N,P-T,V-Z]');
GO

ALTER TABLE [VEHICULOS]
ADD constraint CK_VEHICULOS_Tipo CHECK (Tipo='Turismo' OR Tipo='Camión' OR Tipo='Motocicleta');
GO

--EJERCICIOS VISTAS
ALTER TABLE [VEHICULOS]
ADD [ITV] [Datetime];
GO

ALTER TABLE [VEHICULOS]
ADD constraint CK_VEHICULOS_ITV CHECK ([ITV]>getdate());
GO


DROP VIEW [Vista_VEHICULOS];
GO

CREATE VIEW Vista_VEHICULOS AS
SELECT Matrícula, Tipo, Id_Equipo
FROM [VEHICULOS]
WHERE Tipo='Motocicleta';
GO

ALTER VIEW Vista_VEHICULOS AS
SELECT Matrícula, Tipo, Id_Equipo, ITV
FROM [VEHICULOS]
WHERE [ITV]<=getdate()+20 AND Tipo='Motocicleta';
GO

ALTER VIEW Vista_VEHICULOS WITH SCHEMABINDING AS
SELECT Matrícula, Tipo, Id_Equipo, ITV
FROM dbo.VEHICULOS
WHERE [ITV]<=getdate()+20 AND Tipo='Motocicleta'
WITH CHECK OPTION;
GO
