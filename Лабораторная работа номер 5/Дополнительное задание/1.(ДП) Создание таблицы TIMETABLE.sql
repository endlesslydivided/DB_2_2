use K_UNIVER;


--DROP table TIMETABLE;

CREATE table TIMETABLE
(
	DAYWEEK		char(12)		NOT NULL	check (DAYWEEK in('Понедельник','Вторник','Среда','Четверг','Пятница','Суббота')),
	IDGROUP		int				NOT NULL		constraint FK_TIMETABLE_GROUP			foreign key (IDGROUP)		references [GROUP](IDGROUP), 
												constraint PK_TIMETABLE_DAYWEEK			primary key (DAYWEEK,IDGROUP,CLASS),
	[SUBJECT]	char(10)		NOT NULL		constraint FK_TIMETABLE_SUBJECT		foreign key ([SUBJECT])		references [SUBJECT]([SUBJECT]),
	AUDITORIUM	char(5)			NOT NULL		constraint FK_TIMETABLE_AUDITORIUM	foreign key (AUDITORIUM)	references AUDITORIUM(AUDITORIUM),
	TEACHER		char(10)		NOT NULL		constraint FK_TIMETABLE_TEACHER		foreign key (TEACHER)		references TEACHER(TEACHER),
	CLASS		time(0)			NOT NULL		check(CLASS between '8:00' and '19:20')
)

--CREATE table TIMETABLE
--(
--	DAYWEEKID	int				constraint PK_TIMETABLE		primary key (DAYWEEKID) ,
--	DAYWEEK		char(12)		NOT NULL		check (DAYWEEK in('Понедельник','Вторник','Среда','Четверг','Пятница','Суббота')),
--	IDGROUP		int				NOT NULL		constraint FK_TIMETABLE_GROUP		foreign key (IDGROUP)		references [GROUP](IDGROUP),
--	[SUBJECT]	char(10)		NOT NULL		constraint FK_TIMETABLE_SUBJECT		foreign key ([SUBJECT])		references [SUBJECT]([SUBJECT]),
--	AUDITORIUM	char(5)			NOT NULL		constraint FK_TIMETABLE_AUDITORIUM	foreign key (AUDITORIUM)	references AUDITORIUM(AUDITORIUM),
--	TEACHER		char(10)		NOT NULL		constraint FK_TIMETABLE_TEACHER		foreign key (TEACHER)		references TEACHER(TEACHER),
--	CLASS		time			NOT NULL		check(CLASS between '8:00' and '19:20')
--)

--DROP table TIMETABLE;