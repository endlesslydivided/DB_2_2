USE [K_MyBase]
GO

/****** Object:  Table [dbo].[ОТЧЁТЫ]    Script Date: 05.02.2021 14:48:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ОТЧЁТЫ](
	[Дата_отчёта] [date] NOT NULL,
	[Названия_предприятия] [nvarchar](20) NULL,
	[Название_показателя] [nvarchar](20) NULL,
	[Значение_показателя] [real] NULL,
 CONSTRAINT [PK_Отчёты] PRIMARY KEY CLUSTERED 
(
	[Дата_отчёта] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ОТЧЁТЫ]  WITH CHECK ADD  CONSTRAINT [FK_ОТЧЁТЫ_ПОКАЗАТЕЛИ] FOREIGN KEY([Названия_предприятия])
REFERENCES [dbo].[ПОКАЗАТЕЛИ] ([Название_показателя])
GO

ALTER TABLE [dbo].[ОТЧЁТЫ] CHECK CONSTRAINT [FK_ОТЧЁТЫ_ПОКАЗАТЕЛИ]
GO

ALTER TABLE [dbo].[ОТЧЁТЫ]  WITH CHECK ADD  CONSTRAINT [FK_ОТЧЁТЫ_ПРЕДПРИЯТИЯ] FOREIGN KEY([Названия_предприятия])
REFERENCES [dbo].[ПРЕДПРИЯТИЯ] ([Название_предприятия])
GO

ALTER TABLE [dbo].[ОТЧЁТЫ] CHECK CONSTRAINT [FK_ОТЧЁТЫ_ПРЕДПРИЯТИЯ]
GO


