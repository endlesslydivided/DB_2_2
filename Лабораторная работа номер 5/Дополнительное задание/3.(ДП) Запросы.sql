use K_UNIVER;

SELECT DISTINCT AUDITORIUM.AUDITORIUM ,TIMETABLE.DAYWEEK,TIMETABLE.CLASS
		From AUDITORIUM cross join TIMETABLE
		where TIMETABLE.AUDITORIUM != AUDITORIUM.AUDITORIUM and  TIMETABLE.CLASS ='8:00';

SELECT DISTINCT AUDITORIUM.AUDITORIUM ,TIMETABLE.DAYWEEK,TIMETABLE.CLASS
		From AUDITORIUM cross join TIMETABLE
		where TIMETABLE.AUDITORIUM != AUDITORIUM.AUDITORIUM and  TIMETABLE.DAYWEEK ='???????';


SELECT DISTINCT TEACHER.TEACHER ,TIMETABLE.DAYWEEK,TIMETABLE.CLASS
					From TEACHER right outer join TIMETABLE
					ON TEACHER.TEACHER != TIMETABLE.TEACHER
	
SELECT DISTINCT TIMETABLE.IDGROUP ,TIMETABLE.DAYWEEK,TIMETABLE.CLASS
					From [GROUP] right outer join TIMETABLE
					on [GROUP].IDGROUP != TIMETABLE.IDGROUP	