use master;
go
create database K_MyBase
on primary
(name = N'K_MyBase_mdf', filename = N'C:\MyBase\K_MyBase.mdf',
	size = 5120Kb,maxsize = 10240Kb,filegrowth=1024Kb),
(name = N'K_MyBase_ndf', filename = N'C:\MyBase\K_MyBase.ndf',
	size = 5120Kb,maxsize = 10240Kb,filegrowth=10%),
filegroup FG1
(name = N'K_MyBase11_ndf', filename = N'C:\MyBase\K_MyBase11.ndf',
	size = 10240Kb,maxsize = 15360Kb,filegrowth=1024Kb),
(name = N'K_MyBase12_ndf', filename = N'C:\MyBase\K_MyBase12.ndf',
	size = 2048Kb,maxsize = 5120Kb,filegrowth=1024Kb),
filegroup FG2
(name = N'K_MyBase21_ndf', filename = N'C:\MyBase\K_MyBase21.ndf',
	size = 10240Kb,maxsize = 10240Kb,filegrowth=1024Kb),
(name = N'K_MyBase22_ndf', filename = N'C:\MyBase\K_MyBase22.ndf',
	size = 2048Kb,maxsize = 5120Kb,filegrowth=1024Kb)
log on
(name = N'K_MyBase_log', filename = N'C:\MyBase\K_MyBase.ldf',
	size = 10240Kb,maxsize = UNLIMITED,filegrowth=1024Kb);
