use K_UNIVER
CREATE table FACULTY
(
	FACULTY char(10) NOT NULL constraint PK_FACULTY primary key(FACULTY),
	FACULTY_NAME varchar(50) default '???'
)ON [PRIMARY];

CREATE table PROFESSION
(
	PROFESSION char(20) NOT NULL constraint PK_PROFESSION primary key(PROFESSION),
	FACULTY char(10) NOT NULL constraint FK_PROFESSION_FACULTY foreign key(FACULTY) references FACULTY(FACULTY),
	PROFESSION_NAME varchar(100) NULL,
	QUALIFICATION varchar(50) NULL
)ON [PRIMARY];

CREATE table PULPIT
(
	PULPIT char(20) NOT NULL constraint PK_PULPIT primary key(PULPIT),
	PULPIT_NAME varchar(100) NULL,
	FACULTY char(10) NOT NULL constraint FK_PULPIT_FACULTY foreign key(FACULTY) references FACULTY(FACULTY)
)on [FG1];

CREATE table TEACHER
(
	TEACHER char(10) NOT NULL constraint PK_TEACHER primary key(TEACHER),
	TEACHER_NAME varchar(100) NULL,
	GENDER char(1) check(GENDER in('ì','æ')),
	PULPIT char(20) NOT NULL constraint FK_TEACHER_PULPIT foreign key(PULPIT) references PULPIT(PULPIT)
)on [FG1];

CREATE table [SUBJECT]
(
	[SUBJECT] char(10) NOT NULL constraint PK_SUBJECT primary key([SUBJECT]),
	SUBJECT_NAME varchar(100) NULL unique,
	PULPIT char(20) NOT NULL constraint FK_SUBJECT_PULPIT foreign key(PULPIT) references PULPIT(PULPIT)
)on [FG1];

CREATE table [AUDITORIUM TYPE]
(
	AUDITORIUM_TYPE char(10) NOT NULL constraint [PK_AUDITORIUM TYPE] primary key(AUDITORIUM_TYPE),
	AUDITORIUM_TYPENAME varchar(30) NULL
)ON [PRIMARY];

CREATE table AUDITORIUM
(
	AUDITORIUM char(5) NOT NULL constraint PK_AUDITORIUM primary key(AUDITORIUM),
	AUDITORIUM_TYPE char(10) NOT NULL constraint [FK_AUDITORIUM_AUDITORIUM TYPE] foreign key(AUDITORIUM_TYPE) references [AUDITORIUM TYPE](AUDITORIUM_TYPE),
	AUDITORIUM_CAPACITY int default 1 check(AUDITORIUM_CAPACITY between 1 and 300),
	AUDITORIUM_NAME varchar(50) NULL
)on [FG2];

CREATE table [GROUP]
(
	IDGROUP int NOT NULL constraint PK_GROUP primary key(IDGROUP),
	FACULTY char(10) NOT NULL constraint FK_GROUPS_FACULTY foreign key (FACULTY) references FACULTY(FACULTY),
	PROFESSION char(20) NOT NULL constraint FK_GROUPS_PROFESSION foreign key (PROFESSION) references PROFESSION(PROFESSION),
	YEAR_FIRST smallint check (YEAR_FIRST < YEAR(GETDATE ())+2),
	COURSE  as CAST((YEAR(GETDATE ()) - YEAR_FIRST) as tinyint)
)on [FG1];

CREATE table STUDENT 
(
	IDSTUDENT int constraint PK_STUDETN primary key(IDSTUDENT) identity(1000,1),
	IDGROUP int NOT NULL constraint FK_STUDENT_GROUP foreign key(IDGROUP) references [GROUP](IDGROUP), 
	[NAME] nvarchar(100),
	BDAY date,
	STAMP timestamp,
	INFO xml default null,
	FOTO varbinary(max) default null
);

CREATE table PROGRESS
(
	[SUBJECT] char(10) constraint FK_PROGRESS_SUBJECT foreign key([SUBJECT]) references [SUBJECT]([SUBJECT]),
	IDSTUDENT int constraint FK_PROGRESS_STUDENT foreign key(IDSTUDENT) references STUDENT(IDSTUDENT),
	PDATE date,
	NOTE int check(NOTE between 1 and 10)
);
