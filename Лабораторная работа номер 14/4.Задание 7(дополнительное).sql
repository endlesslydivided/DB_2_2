--								ЗАДАНИЕ 7 (дополнительное)
use K_UNIVER;

-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
CREATE PROCEDURE PRINT_REPORTX @f CHAR(10) = NULL, @p CHAR(10) = NULL
as
	DECLARE @faculty varchar(150), @pulpit varchar(200), @discipline varchar(200), @discipline_list varchar(200) = '', 
			@qteacher varchar(3), @temp_faculty varchar(50), @temp_pulpit varchar(50), @q int = 0;

	DECLARE GET_REPORT_CURSOR CURSOR LOCAL STATIC for
	SELECT FACULTY.FACULTY,PULPIT.PULPIT,dbo.FSUBJECTS(PULPIT.PULPIT), count(TEACHER.TEACHER_NAME)
		from FACULTY inner join PULPIT
		on PULPIT.FACULTY = FACULTY.FACULTY left outer join SUBJECT
		on SUBJECT.PULPIT = PULPIT.PULPIT left outer join TEACHER
		on TEACHER.PULPIT = PULPIT.PULPIT
		group by FACULTY.FACULTY,PULPIT.PULPIT,SUBJECT.SUBJECT order by FACULTY, PULPIT asc;
	begin try
		IF(@f is not NULL and @p is NULL)
			begin
				OPEN GET_REPORT_CURSOR
				FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
				while(@@FETCH_STATUS = 0)
					begin
						if(@faculty != @f)
							FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
						while (@faculty = @f)
							begin
								print ' ▬ Факультет: ' + rtrim(@f);;
								print '		►Кафедра: ' + rtrim(@pulpit);
								print '			•Количество преподавателей: '+ cast(dbo.FTEACHER(@pulpit) as varchar) ;
								set @discipline_list = '			•Дисциплины: ';
								set @discipline_list +=@discipline;
								set @temp_pulpit = @pulpit;																
										FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
								if(@discipline_list != '			•Дисциплины: ')
									begin
										print rtrim(@discipline_list) ;
										set @discipline_list = '			•Дисциплины: ';
									end
								else
									begin
										print rtrim(@discipline_list) + ' нет' ;
									end;
								if(@@FETCH_STATUS != 0)
									begin
										break;
									end;
							end;
						end;
				CLOSE GET_REPORT_CURSOR;
				return @q;
			end
		ELSE IF(@f is not NULL and @p is not NULL)
			begin
				OPEN GET_REPORT_CURSOR
				FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
				set @discipline_list = '			•Дисциплины: ';
				while(@@FETCH_STATUS = 0)
					begin
						if(@faculty != @f)
						FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
						while (@faculty = @f)
							begin
									set @discipline_list = '			•Дисциплины: ';
								set @discipline_list +=@discipline;
							end;
						if(@discipline_list != '			•Дисциплины: ')
									begin
										print rtrim(@discipline_list) ;
										set @discipline_list = '			•Дисциплины: ';
									end
								else
									begin
										print rtrim(@discipline_list) + ' нет' ;
									end;
						return @q;
				end;
				CLOSE GET_REPORT_CURSOR;
			end;
		ELSE IF(@f is NULL and @p is not NULL)
			begin
				OPEN GET_REPORT_CURSOR
				FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
				while(@@FETCH_STATUS = 0)
					begin
						if(@pulpit != @p)
						FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
						set @temp_faculty = @faculty;
						while (@faculty = @temp_faculty and @pulpit = @p)
							begin
								print ' ▬ Факультет: ' + rtrim(@temp_faculty);
								print '		►Кафедра: ' + rtrim(@pulpit);
								print '			•Количество преподавателей: '+ cast(dbo.FTEACHER(@pulpit) as varchar) ;
								set @discipline_list = '			•Дисциплины: ';
								set @discipline_list +=@discipline;
								set @temp_pulpit = @pulpit;
								if(@discipline_list != '			•Дисциплины: ')
									begin
										print rtrim(@discipline_list) ;
										set @discipline_list = '			•Дисциплины: ';
									end
								else
									begin
										print rtrim(@discipline_list) + ' нет' ;
									end;
								return @q;
						end;
				end;
				CLOSE GET_REPORT_CURSOR;
				if (@q = 0)
					raiserror('Ошибочные параметры',11,1);
			end;
	end try
	
	begin catch
		print 'Код ошибки: ' + cast(ERROR_NUMBER() as varchar(6));
		print 'Сообщение об ошибке: ' + ERROR_MESSAGE();
		print 'Строка ошибки: ' + cast(ERROR_LINE()as varchar(8));
		if ERROR_PROCEDURE() is not null
			print 'Имя процедуры ошибки: ' + ERROR_PROCEDURE();
		print 'Уровень серьёзности ошибки: ' + cast(ERROR_SEVERITY()as varchar(6));
		print 'Метка ошибки: ' + cast(ERROR_STATE()as varchar(8));
	end catch;
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
go
SELECT FACULTY.FACULTY,PULPIT.PULPIT,SUBJECT.SUBJECT, count(TEACHER.TEACHER_NAME)
		from FACULTY inner join PULPIT
		on PULPIT.FACULTY = FACULTY.FACULTY left outer join SUBJECT
		on SUBJECT.PULPIT = PULPIT.PULPIT left outer join TEACHER
		on TEACHER.PULPIT = PULPIT.PULPIT
		group by FACULTY.FACULTY,PULPIT.PULPIT,SUBJECT.SUBJECT order by FACULTY, PULPIT asc;

print '▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ Заданы параметры @f и @p ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬';
	EXEC PRINT_REPORTX @f = 'ИТ',@p = 'ИСиТ';
print '▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ Задан параметр @f  ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬';
	EXEC PRINT_REPORTX @f = 'ИТ';
print '▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ Задан параметр @p  ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬';
	EXEC PRINT_REPORTX @p = 'ЭТиМ';
print '▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ Неверный параметр  ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬';		
	EXEC PRINT_REPORTX @p = '123';

DROP PROCEDURE PRINT_REPORTX;