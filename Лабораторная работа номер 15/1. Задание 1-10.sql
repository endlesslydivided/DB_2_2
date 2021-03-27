use K_UNIVER;

--INSERT into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
--VALUES ('НСКВ','Носков Михаил Трофимович',NULL,'ТТЛП'),
--('ПРКП','Прокопенко Николай Иванович',NULL,'ТНХСиППМ'),
--('МРЗВ','Морозова Елена Степановна',NULL,'ИСиТ'),
--('РМНВ','Романов Дмитрий Михайлович',NULL,'ИСиТ'),
--('СМЛВ','Смелов Владимир Владиславович',NULL,'ИСиТ'),
--('КРЛВ','Крылов Павел Павлович',NULL,'ИСиТ'),
--('ЧРН','Чернова Анна Викторовна',NULL,'ХПД');

--								ЗАДАНИЕ 1

DROP TABLE TR_AUDIT;

CREATE TABLE TR_AUDIT
(
ID int identity,
STMT varchar(20) check (STMT in ('INS','DEL','UPD')),
TRNAME varchar(50),
CC varchar(800)
)

--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_TEACHER_INS;

go
CREATE TRIGGER TR_TEACHER_INS on TEACHER after INSERT as
insert into TR_AUDIT values ('INS','TR_TEACHER_INS','Преподаватель:' + rtrim((SELECT TEACHER from INSERTED)) + 
													'. Имя:' + rtrim((SELECT TEACHER_NAME from INSERTED)) + 
													'. Пол:' + rtrim((SELECT GENDER from INSERTED)) + 
													'. Кафедра: ' + rtrim((SELECT PULPIT from INSERTED)));


INSERT into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
VALUES ('НСКВ','Носков Михаил Трофимович','М','ТТЛП')

--								ЗАДАНИЕ 2

--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_TEACHER_DEL;

go
CREATE TRIGGER TR_TEACHER_DEL on TEACHER after DELETE as
insert into TR_AUDIT values ('DEL','TR_TEACHER_INS','Преподаватель:' + rtrim((SELECT TEACHER from DELETED)) + 
													'. Имя:' + rtrim((SELECT TEACHER_NAME from DELETED)) + 
													'. Пол:' + rtrim((SELECT GENDER from DELETED)) + 
													'. Кафедра: ' + rtrim((SELECT PULPIT from DELETED)));

DELETE FROM TEACHER where TEACHER = 'НСКВ';

--								ЗАДАНИЕ 3

--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_TEACHER_UPD;

go
CREATE TRIGGER TR_TEACHER_UPD on TEACHER after UPDATE as
insert into TR_AUDIT values ('UPD','TR_TEACHER_INS','Преподаватель:' + rtrim((SELECT TEACHER from INSERTED)) + 
													'. Имя:' + rtrim((SELECT TEACHER_NAME from INSERTED)) + 
													'. Пол:' + rtrim((SELECT GENDER from INSERTED)) + 
													'. Кафедра: ' + rtrim((SELECT PULPIT from INSERTED)));

UPDATE TEACHER SET PULPIT = 'ИСиТ' where TEACHER = 'НСКВ';

--								ЗАДАНИЕ 4

--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_TEACHER;

go
create trigger TR_TEACHER  on TEACHER after INSERT, DELETE, UPDATE  
as 
declare @ins int = (select count(*) from inserted),
         @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print 'Событие: INSERT';
     insert into TR_AUDIT values ('INS','TR_TEACHER_INS','Преподаватель:' + rtrim((SELECT TEACHER from INSERTED)) + 
													'. Имя:' + rtrim((SELECT TEACHER_NAME from INSERTED)) + 
													'. Пол:' + rtrim((SELECT GENDER from INSERTED)) + 
													'. Кафедра: ' + rtrim((SELECT PULPIT from INSERTED)));
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
    print 'Событие: DELETE';
   insert into TR_AUDIT values ('DEL','TR_TEACHER_INS','Преподаватель:' + rtrim((SELECT TEACHER from DELETED)) + 
													'. Имя:' + rtrim((SELECT TEACHER_NAME from DELETED)) + 
													'. Пол:' + rtrim((SELECT GENDER from DELETED)) + 
													'. Кафедра: ' + rtrim((SELECT PULPIT from DELETED)));
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
    print 'Событие: UPDATE'; 
   insert into TR_AUDIT values ('UPD','TR_TEACHER_INS','Преподаватель:' + rtrim((SELECT TEACHER from INSERTED)) + 
													'. Имя:' + rtrim((SELECT TEACHER_NAME from INSERTED)) + 
													'. Пол:' + rtrim((SELECT GENDER from INSERTED)) + 
													'. Кафедра: ' + rtrim((SELECT PULPIT from INSERTED)));
end;  
return;  

DELETE FROM TEACHER where TEACHER = 'НСКВ';
INSERT into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT) VALUES ('НСКВ','Носков Михаил Трофимович','М','ТТЛП')
UPDATE TEACHER SET PULPIT = 'ИСиТ' where TEACHER = 'НСКВ';


--								ЗАДАНИЕ 5
alter table TEACHER  add constraint PULPIT_LEN  check(len(PULPIT) <=4)

go UPDATE TEACHER SET PULPIT = 'ИСиТИК' where TEACHER = 'НСКВ';

alter table TEACHER  drop constraint PULPIT_LEN;

--								ЗАДАНИЕ 6

--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_TEACHER_DEL1;
--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_TEACHER_DEL2;
--▬▬▬▬▬▬▬▬         DROP TRIGGER TR_TEACHER_DEL3;

go
CREATE TRIGGER TR_TEACHER_DEL1 on TEACHER after DELETE as
insert into TR_AUDIT values ('DEL','TR_TEACHER_INS','Преподаватель:' + rtrim((SELECT TEACHER from DELETED)) + 
													'. Имя:' + rtrim((SELECT TEACHER_NAME from DELETED)) + 
													'. Пол:' + rtrim((SELECT GENDER from DELETED)) + 
													'. Кафедра: ' + rtrim((SELECT PULPIT from DELETED)));
print('Вызван TR_TEACHER_DEL1');
go
CREATE TRIGGER TR_TEACHER_DEL2 on TEACHER after DELETE as
insert into TR_AUDIT values ('DEL','TR_TEACHER_INS','Преподаватель:' + rtrim((SELECT TEACHER from DELETED)) + 
													'. Имя:' + rtrim((SELECT TEACHER_NAME from DELETED)) + 
													'. Пол:' + rtrim((SELECT GENDER from DELETED)) + 
													'. Кафедра: ' + rtrim((SELECT PULPIT from DELETED)));
print('Вызван TR_TEACHER_DEL2');
go
CREATE TRIGGER TR_TEACHER_DEL3 on TEACHER after DELETE as
insert into TR_AUDIT values ('DEL','TR_TEACHER_INS','Преподаватель:' + rtrim((SELECT TEACHER from DELETED)) + 
													'. Имя:' + rtrim((SELECT TEACHER_NAME from DELETED)) + 
													'. Пол:' + rtrim((SELECT GENDER from DELETED)) + 
													'. Кафедра: ' + rtrim((SELECT PULPIT from DELETED)));
print('Вызван TR_TEACHER_DEL3');

go    
select t.name, e.type_desc 
         from sys.triggers  t join  sys.trigger_events e  
                  on t.object_id = e.object_id  
                            where OBJECT_NAME(t.parent_id) = 'TEACHER' and 
	                                                                        e.type_desc = 'DELETE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';

--DELETE FROM TEACHER where TEACHER = 'НСКВ';
--INSERT into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT) VALUES ('НСКВ','Носков Михаил Трофимович','М','ТТЛП')

--								ЗАДАНИЕ 7

--▬▬▬▬▬▬▬▬         DROP TRIGGER TEACHER_TRAN;

go
create trigger TEACHER_TRAN on TEACHER after INSERT, DELETE, UPDATE  
as 
declare @count int = (select  count(*) from TEACHER);
if (@count >= 9)
	begin
		raiserror('Количество преподавателей не больше 9!',10,1);
		rollback;
	end;
return;

INSERT into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT) VALUES ('НСКВ','Носков Михаил Трофимович','М','ТТЛП')

--								ЗАДАНИЕ 8

--▬▬▬▬▬▬▬▬         DROP TRIGGER FACULTY_INSTEAD_OF;

go 
create trigger FACULTY_INSTEAD_OF on FACULTY instead of DELETE as raiserror(N'Удаление запрещено',10,1);
return;

delete from FACULTY where FACULTY ='ИТ';

--DROP TRIGGER TR_TEACHER_INS;
--DROP TRIGGER TR_TEACHER_DEL;
--DROP TRIGGER TR_TEACHER_UPD;
--DROP TRIGGER TR_TEACHER;
--DROP TRIGGER TR_TEACHER_DEL1;
--DROP TRIGGER TR_TEACHER_DEL2;
--DROP TRIGGER TR_TEACHER_DEL3;
--DROP TRIGGER FACULTY_INSTEAD_OF;

--								ЗАДАНИЕ 9
use K_UNIVER;
go	
create  trigger DDL_UNIVER on database  for DDL_DATABASE_LEVEL_EVENTS  
as   
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INS-TANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectType)[1]', 'varchar(50)'); 
       print 'Тип события: '+@t;
       print 'Имя объекта: '+@t1;
       print 'Тип объекта: '+@t2;
       raiserror( N'Операции с таблицами запрещены ', 16, 1);  
       rollback;    

use master;
--DROP TRIGGER DDL_UNIVER;

CREATE TABLE BUBUB
(
ID int identity(1,1)
)