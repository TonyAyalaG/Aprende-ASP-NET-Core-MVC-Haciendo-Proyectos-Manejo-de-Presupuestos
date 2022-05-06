USE [master]
GO
/****** Object:  Database [ManejoPresupuesto]    Script Date: 5/6/2022 7:48:28 AM ******/
ALTER DATABASE [ManejoPresupuesto] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ManejoPresupuesto].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ManejoPresupuesto] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET ARITHABORT OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ManejoPresupuesto] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ManejoPresupuesto] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ManejoPresupuesto] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ManejoPresupuesto] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET RECOVERY FULL 
GO
ALTER DATABASE [ManejoPresupuesto] SET  MULTI_USER 
GO
ALTER DATABASE [ManejoPresupuesto] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ManejoPresupuesto] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ManejoPresupuesto] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ManejoPresupuesto] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ManejoPresupuesto] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ManejoPresupuesto] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ManejoPresupuesto', N'ON'
GO
ALTER DATABASE [ManejoPresupuesto] SET QUERY_STORE = OFF
GO
USE [ManejoPresupuesto]
GO
/****** Object:  Table [dbo].[TiposOperaciones]    Script Date: 5/6/2022 7:48:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposOperaciones](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TiposOperaciones] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transacciones]    Script Date: 5/6/2022 7:48:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transacciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [nvarchar](450) NOT NULL,
	[FechaTransaccion] [datetime] NOT NULL,
	[Monto] [decimal](18, 2) NOT NULL,
	[TipoOperacionId] [int] NOT NULL,
	[Nota] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Transacciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TiposOperaciones] ON 
GO
INSERT [dbo].[TiposOperaciones] ([id], [Descripcion]) VALUES (1, N'Ingresos')
GO
INSERT [dbo].[TiposOperaciones] ([id], [Descripcion]) VALUES (2, N'Gastos')
GO
SET IDENTITY_INSERT [dbo].[TiposOperaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[Transacciones] ON 
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (1, N'Felipe', CAST(N'2021-11-09T00:00:00.000' AS DateTime), CAST(4780.00 AS Decimal(18, 2)), 1, N'Nota actualizada 2')
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (2, N'Felipe', CAST(N'2021-11-08T00:00:00.000' AS DateTime), CAST(350.00 AS Decimal(18, 2)), 2, NULL)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (4, N'Felipe', CAST(N'2021-10-03T00:00:00.000' AS DateTime), CAST(1500.00 AS Decimal(18, 2)), 1, N'Esto vino de un QUERY')
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (5, N'Felipe', CAST(N'2021-10-03T00:00:00.000' AS DateTime), CAST(1500.00 AS Decimal(18, 2)), 1, NULL)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (6, N'Guillermo', CAST(N'2021-11-07T00:00:00.000' AS DateTime), CAST(501.00 AS Decimal(18, 2)), 2, NULL)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (7, N'Federico', CAST(N'2021-11-01T00:00:00.000' AS DateTime), CAST(499.99 AS Decimal(18, 2)), 1, N'Nota de ejemplo')
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (8, N'Penelope', CAST(N'2021-11-02T00:00:00.000' AS DateTime), CAST(2101.95 AS Decimal(18, 2)), 1, NULL)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (11, N'rafael', CAST(N'2021-01-01T00:00:00.000' AS DateTime), CAST(789.00 AS Decimal(18, 2)), 2, NULL)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (12, N'penelope', CAST(N'2020-05-08T00:00:00.000' AS DateTime), CAST(485.57 AS Decimal(18, 2)), 1, NULL)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [TipoOperacionId], [Nota]) VALUES (14, N'Felipe', CAST(N'2021-07-08T00:00:00.000' AS DateTime), CAST(123.00 AS Decimal(18, 2)), 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[Transacciones] OFF
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_TiposOperaciones] FOREIGN KEY([TipoOperacionId])
REFERENCES [dbo].[TiposOperaciones] ([id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_TiposOperaciones]
GO
USE [master]
GO
ALTER DATABASE [ManejoPresupuesto] SET  READ_WRITE 
GO
