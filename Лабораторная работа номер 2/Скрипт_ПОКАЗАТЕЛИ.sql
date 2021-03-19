USE [K_MyBase]
GO

/****** Object:  Table [dbo].[ПОКАЗАТЕЛИ]    Script Date: 05.02.2021 14:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ПОКАЗАТЕЛИ](
	[Название_показателя] [nvarchar](20) NOT NULL,
	[Важность_показателя] [real] NULL,
 CONSTRAINT [PK_ПОКАЗАТЕЛИ] PRIMARY KEY CLUSTERED 
(
	[Название_показателя] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


