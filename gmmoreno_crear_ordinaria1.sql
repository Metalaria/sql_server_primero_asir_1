CREATE TABLE [huespedes](
  [numero_huesped] [int] IDENTITY(1001,1) NOT NULL,
	[Nombre] [varchar](20) NOT NULL,
	[Apellido1] [varchar](20) NOT NULL, 
	[Apellido2] [varchar](20) NULL,
	[DNI] [int] NOT NULL,
 CONSTRAINT [PK_huespedes] PRIMARY KEY ([numero_huesped])
)
GO
CREATE TABLE [Habitaciones](
	[numero_hab] [smallint] NOT NULL,
	[max] [smallint] NOT NULL default 2, --añado el dos como valor por defecto
	[tipo] [varchar](9) NOT NULL,
 CONSTRAINT [PK_Habitaciones] PRIMARY KEY ([numero_hab])
)
GO
-- Creación de la tabla intermedia
CREATE TABLE [hab_huesped](
	[habitacion] [smallint] NOT NULL,
	[huesped] [int] NOT NULL,
	[fecha_entrada] [smalldatetime] NOT NULL,
	[fecha_salida] [smalldatetime] NULL
)
GO
ALTER TABLE [dbo].[hab_huesped]  ADD  CONSTRAINT [FK_hab_huesped_habitacion] FOREIGN KEY([habitacion])
REFERENCES [dbo].[Habitaciones] ([numero_hab]) 
GO
ALTER TABLE [dbo].[hab_huesped]  ADD  CONSTRAINT [FK_hab_huesped_huesped] FOREIGN KEY([huesped])
REFERENCES [dbo].[huespedes] ([numero_huesped]) 
GO
ALTER TABLE [Habitaciones] --creación de la restricción check
ADD constraint CK_max_huespedes CHECK (max=1 OR max=2 OR max=3 OR max=4);
GO

CREATE TRIGGER ins_hab --creación del trigger para insertar la habitación
ON Habitaciones
INSTEAD OF  INSERT
--He elegido el tipo instead of porque el desencadenador tiene que tomar el control antes de que se ejecute la operacion de inserccion.
AS 
BEGIN
DECLARE @numero_hab smallINT,@max smallint, @tipo VARCHAR(9)
SET @numero_hab=(SELECT numero_hab FROM inserted)
set @max=(SELECT max FROM inserted)
SET @tipo=(SELECT tipo FROM inserted)

IF (@numero_hab>101 AND @numero_hab<999) --evalúa que el número de habitación sea correcto
	BEGIN
		INSERT INTO Habitaciones (numero_hab,max,tipo) VALUES (@numero_hab,@max,@tipo) --si es correcto realiza la inserción
	END
	ELSE
	BEGIN
		print N'No se ha podido insertar la habitación, el número de habitación no es válido' --si no es correcto saca este mensaje por pantalla
	END
END
GO
CREATE TRIGGER mod_hab --creación del trigger para la modificación de una habitación
ON Habitaciones
INSTEAD OF UPDATE
--He elegido el tipo instead of porque el desencadenador tiene que tomar el control antes de que se ejecute la operacion de modificación.
AS 
BEGIN
DECLARE @numero_hab smallINT,@max smallint, @tipo VARCHAR(9)
SET @numero_hab=(SELECT numero_hab FROM inserted)
set @max=(SELECT max FROM inserted)
SET @tipo=(SELECT tipo FROM inserted)
IF (@numero_hab>101 AND @numero_hab<999)  --evalúa que el número de habitación sea correcto
	BEGIN
		UPDATE Habitaciones SET numero_hab=@numero_hab WHERE max=@max AND tipo=@tipo --si es correcto realiza la actaulización
	END
	ELSE
	BEGIN
		print N'No se ha podido modificar la habitación, el número de habitación no es válido' --si no es correcto saca este mensaje por pantalla
	END
END
GO

create procedure Insertar_huesped_comprobando --creación del procedimiento para la inserción de un huésped
(@numero_huesped int, @nombre varchar(20), @apellido1 varchar(20), @apellido2 varchar(20), @dni int)
as
begin
if @numero_huesped not in (select numero_huesped from huespedes where numero_huesped=@numero_huesped) --comprueba que el huesped nuevo no exista ya
	begin -- si no existe el huesped realiza la inserción
		insert into huespedes(numero_huesped,nombre,apellido1,apellido2, DNI)
		values (@numero_huesped,@nombre,@apellido1,@apellido2, @dni)
		return (0) --si se realiza correctamente el valor de retorno es 0
	end
else
	begin
		select 'El huésped ya existe' --este mensaje muestra por qué no se ha podido insertar el huésped
		return (1) --en caso de que no se produza la inserción el valor de retorno es 1
end
	
end
