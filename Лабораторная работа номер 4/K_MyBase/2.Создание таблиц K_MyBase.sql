use K_MyBase


CREATE table ПРЕДПРИЯТИЯ
(
	Название_предприятия nvarchar(20) NOT NULL constraint PK_ПРЕДПРИЯТИЯ primary key(Название_предприятия),
	Банковские_реквизиты nvarchar(50) default '???'
)ON [PRIMARY];

CREATE table ПОКАЗАТЕЛИ
(
	Название_показателя nvarchar(50) NOT NULL constraint PK_ПОКАЗАТЕЛИ primary key(Название_показателя),
	Важность_показателя real NOT NULL,
)ON [PRIMARY];

CREATE table ОТЧЁТЫ
(
	Номер_Отчёта int constraint PK_ОТЧЁТЫ primary key(Номер_Отчёта) identity(1,1),
	Дата_отчёта nvarchar(20) NOT NULL,
	Название_предприятия nvarchar(20) NOT NULL constraint FK_ОТЧЁТЫ_ПРЕДПРИЯТИЯ foreign key(Название_предприятия) references ПРЕДПРИЯТИЯ(Название_предприятия),
	Название_показателя nvarchar(50) NOT NULL constraint FK_ОТЧЁТЫ_ПОКАЗАТЕЛИ foreign key(Название_показателя) references ПОКАЗАТЕЛИ(Название_показателя),
	Значение_показателя real NOT NULL
)on [FG1];

CREATE table КОНТАКТЫ
(
	Контактное_лицо nvarchar(50) NOT NULL constraint PK_КОНТАКТЫ primary key(Контактное_лицо),
	Название_предприятия nvarchar(20) NOT NULL constraint FK_КОНТАКТЫ_ПРЕДПРИЯТИЯ foreign key(Название_предприятия) references ПРЕДПРИЯТИЯ(Название_предприятия),
	Телефон nvarchar(13) NULL
)on [FG2];

