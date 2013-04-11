use gmmoreno_1
go
alter table vehiculos add ITV datetime NULL; 
go
alter table vehiculos 
add constraint fecha_itv check (ITV>getdate());
go
create view vista_vehiculos as 
select matricula, tipo, equipo from vehiculos where tipo like 'motocicleta';
go
insert into vista_vehiculos values (1234, 'motocicleta', 1);
go
alter view vista_vehiculos as select itv from vehiculos
where (itv)<=getdate()+20 and tipo ='motocicleta';
go
alter view vista_vehiculos  as 
select matricula, tipo, equipo, itv from vehiculos 
where (itv)<=getdate()+20
with check option ;
go
alter view vista_vehiculos with SCHEMABINDING as 
select matricula, tipo, equipo, itv from dbo.vehiculos 
where (itv)<=getdate()+20;
