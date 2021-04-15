use master;


--								ЗАДАНИЕ 1
set nocount on
if  exists (select * from  SYS.OBJECTS where OBJECT_ID= object_id(N'DBO.MyTable') )	            
	begin
		drop table MyTable;        
	end;

declare @c int, @flag char = 'r';           
SET IMPLICIT_TRANSACTIONS  ON
	
CREATE table MyTable(
ID int identity(1,1), 
word nvarchar(20)
);                         

INSERT MyTable values ('Яблоко'),('Груша'),('Стол');
set @c = (select count(*) from MyTable);
print 'количество строк в таблице MyTable: ' + cast( @c as varchar(2));
if @flag = 'c'  
	begin
		commit;
	end;
else   
	begin
		rollback; 
	end; 

SET IMPLICIT_TRANSACTIONS  OFF   

if  exists (select * from  SYS.OBJECTS where OBJECT_ID= object_id(N'DBO.MyTable') )
	begin
		print 'таблица MyTable есть'; 
	end;
else   
    begin
		print 'таблицы MyTable нет';
	end;

--								ЗАДАНИЕ 2
use K_UNIVER;

begin try
	begin tran
		delete AUDITORIUM where AUDITORIUM_NAME = '301-1';
		insert into AUDITORIUM values('301-1','ЛБ-К','15','301-1');
		update AUDITORIUM set AUDITORIUM_CAPACITY = '30' where AUDITORIUM_NAME='301-1';
		raiserror('Балалала',1,1);
	commit tran;
end try
begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0 rollback tran;
end catch;

--								ЗАДАНИЕ 3
use K_UNIVER;

DECLARE @savepoint varchar(30);
begin try
	begin tran
		delete AUDITORIUM where AUDITORIUM_NAME = '301-1';									set @savepoint = 'save1'; save tran @savepoint;
		insert into AUDITORIUM values('301-1','ЛБ-К','15','301-1');							set @savepoint = 'save2'; save tran @savepoint;
		update AUDITORIUM set AUDITORIUM_CAPACITY = '30' where AUDITORIUM_NAME='301-1';		set @savepoint = 'save3'; save tran @savepoint;
	commit tran;
end try
begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0
		begin
			print 'Контрольная точка: ' + @savepoint;
			rollback tran @savepoint;
			commit tran;
		end;
end catch;	

INSERT into AUDITORIUM values('301-1','ЛБ-К','15','301-1');

--								ЗАДАНИЕ 4

-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

use K_UNIVER;
-- A ---
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID 'SID', 'insert AUDITORIUM' 'результат', * from SUBJECT 
	                                                                where SUBJECT = 'СТПИ';
																	             
	select @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='301-1';
	commit; 
	-------------------------- t2 -----------------

--- B --	
	begin transaction 
	select @@SPID 'SID';
	INSERT into SUBJECT values('СТПИ','Современные технологии программирования в  интернете','ПИ');   
	update AUDITORIUM set AUDITORIUM_CAPACITY = '15' where AUDITORIUM_NAME='301-1';	
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;

	delete SUBJECT where SUBJECT = 'СТПИ';
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

--								ЗАДАНИЕ 5

-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

-- A ---
    set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY = '30';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='301-1';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
    update AUDITORIUM set AUDITORIUM_CAPACITY = '30' where AUDITORIUM_NAME='301-1';	

      commit; 
	-------------------------- t2 --------------------	
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

--								ЗАДАНИЕ 6

-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

-- A ---
    set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select SUBJECT_NAME from SUBJECT where PULPIT = 'ПИ';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when SUBJECT = 'СТПИ' then 'insert  SUBJECT'  else ' ' 
end 'результат', SUBJECT_NAME from SUBJECT  where PULPIT = 'ПИ';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          	INSERT into SUBJECT values('СТПИ','Современные технологии программирования в  интернете','ПИ');   
          commit; 
	-------------------------- t2 --------------------

		delete SUBJECT where SUBJECT = 'СТПИ';
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

--								ЗАДАНИЕ 7

-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

-- A ---
set transaction isolation level SERIALIZABLE 
	begin transaction 
		delete SUBJECT where SUBJECT = 'СТПИ';
		INSERT into SUBJECT values('СТПИ','Современные технологии программирования в  интернете','ПИ');   ;
        update SUBJECT set SUBJECT_NAME = 'Современные технологии программирования в  INTERNET' where  SUBJECT = 'СТПИ';
	    select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ПИ';
	-------------------------- t1 -----------------
	 select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ПИ';
	-------------------------- t2 ------------------ 
	commit; 	

--- B ---	
	begin transaction 	  
		delete SUBJECT where SUBJECT = 'СТПИ';
		INSERT into SUBJECT values('СТПИ','Современные технологии программирования в  интернете','ПИ');
        update SUBJECT set SUBJECT_NAME = 'Современные технологии программирования в  INTERNET' where  SUBJECT = 'СТПИ';
	    select SUBJECT_NAME from SUBJECT where PULPIT = 'ПИ';
     -------------------------- t1 --------------------
     commit; 
     select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ПИ';
     -------------------------- t2 --------------------
	 		
	delete SUBJECT where SUBJECT = 'СТПИ';
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

--								ЗАДАНИЕ 8

delete SUBJECT where SUBJECT = 'СТПИ';

begin tran
		INSERT into SUBJECT values('СТПИ','Современные технологии программирования в  интернете','ПИ');   ;
		begin tran
		update SUBJECT set SUBJECT_NAME='СТПИ' where SUBJECT='СТПИ';
		commit
		if @@TRANCOUNT > 0 rollback;

select
		(select count(*) from SUBJECT where SUBJECT='СТПИ') 'Дисциплина',
		(select count(*) from TEACHER inner join SUBJECT on TEACHER.PULPIT = SUBJECT.PULPIT) 'Преподаватели'