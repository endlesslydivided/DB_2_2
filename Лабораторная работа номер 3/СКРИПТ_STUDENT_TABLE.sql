use KOVALEV_UNIVER
CREATE table STUDENT
(
Номер_зачётки int primary key,
Фамилия_студента nvarchar(20),
Номер_группы tinyint check(Номер_группы >0 AND  Номер_группы<5)
);


