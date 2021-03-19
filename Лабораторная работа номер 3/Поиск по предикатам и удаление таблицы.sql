use KOVALEV_UNIVER

Select * From STUDENT Where Номер_зачётки
					Between 111111 And 444444;

Select Фамилия_студента From STUDENT Where Фамилия_студента
					Like 'К%';

Select Фамилия_студента,Номер_группы From STUDENT Where Номер_группы
					In (2,3,4);

Drop Table STUDENT;