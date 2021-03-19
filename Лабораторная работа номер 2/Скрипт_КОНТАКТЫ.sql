USE [K_MyBase]
GO

/****** Object:  Table [dbo].[КОНТАКТЫ]    Script Date: 05.02.2021 14:47:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[КОНТАКТЫ](
	[Контактное_лицо] [nvarchar](50) NOT NULL,
	[Название_предприятия] [nvarchar](20) NULL,
	[Телефон] [nvarchar](13) NULL,
 CONSTRAINT [PK_КОНТАКТЫ] PRIMARY KEY CLUSTERED 
(
	[Контактное_лицо] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[КОНТАКТЫ]  WITH CHECK ADD  CONSTRAINT [FK_КОНТАКТЫ_ПРЕДПРИЯТИЯ] FOREIGN KEY([Название_предприятия])
REFERENCES [dbo].[ПРЕДПРИЯТИЯ] ([Название_предприятия])
GO

ALTER TABLE [dbo].[КОНТАКТЫ] CHECK CONSTRAINT [FK_КОНТАКТЫ_ПРЕДПРИЯТИЯ]
GO


