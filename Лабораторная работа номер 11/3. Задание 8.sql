go
use K_UNIVER;
DECLARE @faculty varchar(150), @pulpit varchar(200), @discipline varchar(10), @discipline_list varchar(200) = '', @qteacher varchar(3), @temp_faculty varchar(50), @temp_pulpit varchar(50);
SELECT FACULTY.FACULTY_NAME,PULPIT.PULPIT_NAME,SUBJECT.SUBJECT, count(TEACHER.TEACHER_NAME)
		from FACULTY inner join PULPIT
		on PULPIT.FACULTY = FACULTY.FACULTY left outer join SUBJECT
		on SUBJECT.PULPIT = PULPIT.PULPIT left outer join TEACHER
		on TEACHER.PULPIT = PULPIT.PULPIT
		group by FACULTY.FACULTY_NAME,PULPIT.PULPIT_NAME,SUBJECT.SUBJECT order by FACULTY_NAME, PULPIT_NAME asc;
DECLARE GET_REPORT_CURSOR CURSOR LOCAL STATIC for
	SELECT FACULTY.FACULTY_NAME,PULPIT.PULPIT_NAME,SUBJECT.SUBJECT, count(TEACHER.TEACHER_NAME)
		from FACULTY inner join PULPIT
		on PULPIT.FACULTY = FACULTY.FACULTY left outer join SUBJECT
		on SUBJECT.PULPIT = PULPIT.PULPIT left outer join TEACHER
		on TEACHER.PULPIT = PULPIT.PULPIT
		group by FACULTY.FACULTY_NAME,PULPIT.PULPIT_NAME,SUBJECT.SUBJECT order by FACULTY_NAME, PULPIT_NAME asc;

OPEN GET_REPORT_CURSOR
FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
while(@@FETCH_STATUS = 0)
	begin
		print ' ▬ Факультет: ' + rtrim(@faculty);
		set @temp_faculty = @faculty;
		while (@faculty = @temp_faculty)
			begin
				print '		►Кафедра: ' + rtrim(@pulpit);
				print '			•Количество преподавателей: '+ rtrim(@qteacher) ;
				set @discipline_list = '			•Дисциплины: ';
				set @temp_pulpit = @pulpit;
						if(@discipline != '')
							begin	
								if(@discipline_list = '			•Дисциплины: ')
									begin
										set @discipline_list += @discipline;
									end
								else
									begin
										set @discipline_list = rtrim(@discipline_list) + ', ' + @discipline;
									end;
							end;
				FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
				while (@pulpit = @temp_pulpit)
					begin
						if(@discipline != '')
							begin	
								if(@discipline_list = '			•Дисциплины: ')
									begin
										set @discipline_list += @discipline;
									end
								else
									begin
										set @discipline_list = rtrim(@discipline_list) + ', ' + @discipline;
									end;
							end;
						FETCH GET_REPORT_CURSOR into @faculty,@pulpit,@discipline,@qteacher;
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
					if(@@FETCH_STATUS != 0)
						begin
							break;
						end;
			end;
	end;
CLOSE GET_REPORT_CURSOR;
