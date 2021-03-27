use K_MyBase;

DROP TABLE TR_AUDIT;

CREATE TABLE TR_AUDIT
(
ID int identity,
STMT varchar(20) check (STMT in ('INS','DEL','UPD')),
TRNAME varchar(50),
CC varchar(800)
)

--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_ОТЧЁТЫ_INS;

go
CREATE TRIGGER TR_ОТЧЁТЫ_INS on ОТЧЁТЫ after INSERT as
insert into TR_AUDIT values ('INS','TR_TEACHER_INS','Дата:' + rtrim((SELECT Дата_отчёта from INSERTED)) + 
													'. Предприятие:' + rtrim((SELECT Название_предприятия from INSERTED)) + 
													'. Показатель:' + rtrim((SELECT Название_показателя from INSERTED)) + 
													'. Значение: ' + cast((SELECT Значение_показателя from INSERTED) as varchar));

INSERT into ОТЧЁТЫ(Дата_отчёта,Название_предприятия,Название_показателя,Значение_показателя)
VALUES ('15/06/20','БГТУ','Рост количества посетителей','20')
													

--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_ОТЧЁТЫ_DEL;

go
CREATE TRIGGER TR_ОТЧЁТЫ_DEL on ОТЧЁТЫ after DELETE as
insert into TR_AUDIT values ('DEL','TR_ОТЧЁТЫ_DEL','Дата:' + rtrim((SELECT Дата_отчёта from DELETED)) + 
													'. Предприятие:' + rtrim((SELECT Название_предприятия from DELETED)) + 
													'. Показатель:' + rtrim((SELECT Название_показателя from DELETED)) + 
													'. Значение: ' + cast((SELECT Значение_показателя from DELETED) as varchar));

												
DELETE FROM ОТЧЁТЫ where Название_предприятия  = 'БГТУ' and Дата_отчёта ='15/06/20' and Название_показателя='Рост количества посетителей' ;


--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_TEACHER_UPD;

go
CREATE TRIGGER TR_ОТЧЁТЫ_UPD on ОТЧЁТЫ after UPDATE as
insert into TR_AUDIT values ('UPD','TR_ОТЧЁТЫ_UPD','Дата:' + rtrim((SELECT Дата_отчёта from INSERTED)) + 
													'. Предприятие:' + rtrim((SELECT Название_предприятия from INSERTED)) + 
													'. Показатель:' + rtrim((SELECT Название_показателя from INSERTED)) + 
													'. Значение: ' + cast((SELECT Значение_показателя from INSERTED) as varchar));

UPDATE  ОТЧЁТЫ SET [Значение_показателя]='10' where Название_предприятия  = 'БГТУ' and Дата_отчёта ='15/06/20' and Название_показателя='Рост количества посетителей' ;
