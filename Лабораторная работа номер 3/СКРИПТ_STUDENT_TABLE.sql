use KOVALEV_UNIVER
CREATE table STUDENT
(
�����_������� int primary key,
�������_�������� nvarchar(20),
�����_������ tinyint check(�����_������ >0 AND  �����_������<5)
);


