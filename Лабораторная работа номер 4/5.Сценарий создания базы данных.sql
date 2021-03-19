use master;
go
create database K_UNIVER
on primary
(name = N'K_UNIVER_mdf', filename = N'C:\UNIVER\K_UNIVER.mdf',
	size = 5120Kb,maxsize = 10240Kb,filegrowth=1024Kb),
(name = N'K_UNIVER_ndf', filename = N'C:\UNIVER\K_UNIVER.ndf',
	size = 5120Kb,maxsize = 10240Kb,filegrowth=10%),
filegroup FG1
(name = N'K_UNIVER11_ndf', filename = N'C:\UNIVER\K_UNIVER11.ndf',
	size = 10240Kb,maxsize = 15360Kb,filegrowth=1024Kb),
(name = N'K_UNIVER12_ndf', filename = N'C:\UNIVER\K_UNIVER12.ndf',
	size = 2048Kb,maxsize = 5120Kb,filegrowth=1024Kb),
filegroup FG2
(name = N'K_UNIVER21_ndf', filename = N'C:\UNIVER\K_UNIVER21.ndf',
	size = 10240Kb,maxsize = 10240Kb,filegrowth=1024Kb),
(name = N'K_UNIVER22_ndf', filename = N'C:\UNIVER\K_UNIVER22.ndf',
	size = 2048Kb,maxsize = 5120Kb,filegrowth=1024Kb)
log on
(name = N'K_UNIVER_log', filename = N'C:\UNIVER\K_UNIVER.ldf',
	size = 10240Kb,maxsize = UNLIMITED,filegrowth=1024Kb);
