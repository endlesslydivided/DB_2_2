use KOVALEV_UNIVER
ALTER table STUDENT ADD Дата_поступления date default '01.01.2015' check (Дата_поступления> '01.01.2015' AND Дата_поступления< '01.01.2021');