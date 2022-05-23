USE [master]
GO
/****** Object:  Database [ManejoPresupuesto]    Script Date: 23/05/2022 04:21:18 p. m. ******/

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
/****** Object:  Table [dbo].[Categorias]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[TipoOperacionId] [int] NOT NULL,
	[UsuarioId] [int] NOT NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cuentas]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cuentas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[TipoCuentaId] [int] NOT NULL,
	[Balance] [decimal](18, 2) NULL,
	[Descripcion] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Cuentas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposCuentas]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposCuentas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Orden] [int] NOT NULL,
 CONSTRAINT [PK_TiposCuentas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposOperaciones]    Script Date: 23/05/2022 04:21:19 p. m. ******/
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
/****** Object:  Table [dbo].[Transacciones]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transacciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[FechaTransaccion] [datetime] NOT NULL,
	[Monto] [decimal](18, 2) NOT NULL,
	[Nota] [nvarchar](1000) NULL,
	[CuentaId] [int] NOT NULL,
	[CategoriaId] [int] NOT NULL,
 CONSTRAINT [PK_Transacciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[EmailNormalizado] [nvarchar](256) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 
GO
INSERT [dbo].[Categorias] ([id], [Nombre], [TipoOperacionId], [UsuarioId]) VALUES (1, N'Libros', 2, 1)
GO
INSERT [dbo].[Categorias] ([id], [Nombre], [TipoOperacionId], [UsuarioId]) VALUES (2, N'Salario', 1, 1)
GO
INSERT [dbo].[Categorias] ([id], [Nombre], [TipoOperacionId], [UsuarioId]) VALUES (3, N'Comida', 2, 1)
GO
INSERT [dbo].[Categorias] ([id], [Nombre], [TipoOperacionId], [UsuarioId]) VALUES (4, N'Dividendos', 1, 1)
GO
INSERT [dbo].[Categorias] ([id], [Nombre], [TipoOperacionId], [UsuarioId]) VALUES (5, N'Mascotas', 2, 1)
GO
INSERT [dbo].[Categorias] ([id], [Nombre], [TipoOperacionId], [UsuarioId]) VALUES (6, N'Libros', 2, 6)
GO
INSERT [dbo].[Categorias] ([id], [Nombre], [TipoOperacionId], [UsuarioId]) VALUES (7, N'Salario', 1, 6)
GO
INSERT [dbo].[Categorias] ([id], [Nombre], [TipoOperacionId], [UsuarioId]) VALUES (8, N'Mesada', 1, 6)
GO
INSERT [dbo].[Categorias] ([id], [Nombre], [TipoOperacionId], [UsuarioId]) VALUES (9, N'Comida', 2, 6)
GO
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[Cuentas] ON 
GO
INSERT [dbo].[Cuentas] ([Id], [Nombre], [TipoCuentaId], [Balance], [Descripcion]) VALUES (2, N'Tarjeta de Banco', 3, CAST(4593.00 AS Decimal(18, 2)), N'Esta siempre la debo.')
GO
INSERT [dbo].[Cuentas] ([Id], [Nombre], [TipoCuentaId], [Balance], [Descripcion]) VALUES (3, N'Efectivo', 2, CAST(3682.00 AS Decimal(18, 2)), N'Nuevo Comentario')
GO
INSERT [dbo].[Cuentas] ([Id], [Nombre], [TipoCuentaId], [Balance], [Descripcion]) VALUES (4, N'Prestamo del carro', 4, CAST(-5000.00 AS Decimal(18, 2)), NULL)
GO
INSERT [dbo].[Cuentas] ([Id], [Nombre], [TipoCuentaId], [Balance], [Descripcion]) VALUES (5, N'Efectivo', 8, CAST(2000.00 AS Decimal(18, 2)), NULL)
GO
INSERT [dbo].[Cuentas] ([Id], [Nombre], [TipoCuentaId], [Balance], [Descripcion]) VALUES (6, N'Cuentas de Banco', 9, CAST(0.00 AS Decimal(18, 2)), NULL)
GO
INSERT [dbo].[Cuentas] ([Id], [Nombre], [TipoCuentaId], [Balance], [Descripcion]) VALUES (7, N'Tarjetas', 10, CAST(0.00 AS Decimal(18, 2)), NULL)
GO
SET IDENTITY_INSERT [dbo].[Cuentas] OFF
GO
SET IDENTITY_INSERT [dbo].[TiposCuentas] ON 
GO
INSERT [dbo].[TiposCuentas] ([Id], [Nombre], [UsuarioId], [Orden]) VALUES (1, N'Efectivo', 1, 2)
GO
INSERT [dbo].[TiposCuentas] ([Id], [Nombre], [UsuarioId], [Orden]) VALUES (2, N'Cuentas de Banco', 1, 1)
GO
INSERT [dbo].[TiposCuentas] ([Id], [Nombre], [UsuarioId], [Orden]) VALUES (3, N'Tarjetas', 1, 5)
GO
INSERT [dbo].[TiposCuentas] ([Id], [Nombre], [UsuarioId], [Orden]) VALUES (4, N'Prestamos', 1, 4)
GO
INSERT [dbo].[TiposCuentas] ([Id], [Nombre], [UsuarioId], [Orden]) VALUES (8, N'Efectivo', 6, 1)
GO
INSERT [dbo].[TiposCuentas] ([Id], [Nombre], [UsuarioId], [Orden]) VALUES (9, N'Cuentas de Banco', 6, 2)
GO
INSERT [dbo].[TiposCuentas] ([Id], [Nombre], [UsuarioId], [Orden]) VALUES (10, N'Tarjetas', 6, 3)
GO
SET IDENTITY_INSERT [dbo].[TiposCuentas] OFF
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
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (1, 1, CAST(N'2022-08-12T00:00:00.000' AS DateTime), CAST(12.00 AS Decimal(18, 2)), N'Ejemplo Modificado SP 4', 3, 2)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (2, 1, CAST(N'2022-05-12T00:00:00.000' AS DateTime), CAST(101.00 AS Decimal(18, 2)), N'Ejemplo2.', 3, 2)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (3, 1, CAST(N'2022-05-12T00:00:00.000' AS DateTime), CAST(7.00 AS Decimal(18, 2)), NULL, 2, 1)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (5, 1, CAST(N'2022-05-13T00:00:00.000' AS DateTime), CAST(200.00 AS Decimal(18, 2)), NULL, 2, 5)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (6, 1, CAST(N'2022-05-13T00:00:00.000' AS DateTime), CAST(100.00 AS Decimal(18, 2)), NULL, 2, 2)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (7, 1, CAST(N'2022-05-13T00:00:00.000' AS DateTime), CAST(30.00 AS Decimal(18, 2)), NULL, 3, 5)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (8, 1, CAST(N'2022-05-21T00:00:00.000' AS DateTime), CAST(100.00 AS Decimal(18, 2)), NULL, 3, 2)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (9, 1, CAST(N'2022-05-03T00:00:00.000' AS DateTime), CAST(100.00 AS Decimal(18, 2)), NULL, 3, 4)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (10, 1, CAST(N'2022-05-09T00:00:00.000' AS DateTime), CAST(100.00 AS Decimal(18, 2)), NULL, 2, 3)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (11, 1, CAST(N'2022-05-25T00:00:00.000' AS DateTime), CAST(100.00 AS Decimal(18, 2)), NULL, 3, 3)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (12, 1, CAST(N'2022-05-25T00:00:00.000' AS DateTime), CAST(1000.00 AS Decimal(18, 2)), NULL, 3, 2)
GO
INSERT [dbo].[Transacciones] ([Id], [UsuarioId], [FechaTransaccion], [Monto], [Nota], [CuentaId], [CategoriaId]) VALUES (13, 6, CAST(N'2022-05-23T00:00:00.000' AS DateTime), CAST(2000.00 AS Decimal(18, 2)), NULL, 5, 7)
GO
SET IDENTITY_INSERT [dbo].[Transacciones] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [EmailNormalizado], [PasswordHash]) VALUES (1, N'prueba@abc.d', N'prueba@abc.d', N'abc')
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [EmailNormalizado], [PasswordHash]) VALUES (2, N'a@b.com', N'A@B.COM', N'AQAAAAEAACcQAAAAELgYquZI9mEdC+MPRBkss+IL2PCjTw6Olo9WsIjRFhNYvDVt8TtxDQtkOIfzD1BDqA==')
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [EmailNormalizado], [PasswordHash]) VALUES (3, N'a2@b.com', N'A2@B.COM', N'AQAAAAEAACcQAAAAEBoGw9XwBu+R5gm5aZ9o5CkcChGvBfdblQeAX3vq/ApOJrKNaDYY+s3bX7RJuaIi9Q==')
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [EmailNormalizado], [PasswordHash]) VALUES (4, N'a3@b.com', N'A3@B.COM', N'AQAAAAEAACcQAAAAEDxgarUup3ky9jYB+ZxaacW29rf74Sr0bUbcIpW5Xj1f40Cf1C+Io+fTHjXzRfqp5A==')
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [EmailNormalizado], [PasswordHash]) VALUES (5, N'a4@b.com', N'A4@B.COM', N'AQAAAAEAACcQAAAAENtUNnBAELxmKdxMNvXz6pWYf9qJI9rKYzLoSjP7ttiWnE9oE/SPldshwBYk7EyoLA==')
GO
INSERT [dbo].[Usuarios] ([Id], [Email], [EmailNormalizado], [PasswordHash]) VALUES (6, N'a5@b.com', N'A5@B.COM', N'AQAAAAEAACcQAAAAENmaQKZuOF54QXmfn+cB7MeSltVfHej2HIKFzfcBmbR/vBE9bQNYD7LTIIcT4P0B+w==')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
ALTER TABLE [dbo].[Categorias]  WITH CHECK ADD  CONSTRAINT [FK_Categorias_TiposOperaciones] FOREIGN KEY([TipoOperacionId])
REFERENCES [dbo].[TiposOperaciones] ([id])
GO
ALTER TABLE [dbo].[Categorias] CHECK CONSTRAINT [FK_Categorias_TiposOperaciones]
GO
ALTER TABLE [dbo].[Categorias]  WITH CHECK ADD  CONSTRAINT [FK_Categorias_Usuarios] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Categorias] CHECK CONSTRAINT [FK_Categorias_Usuarios]
GO
ALTER TABLE [dbo].[Cuentas]  WITH CHECK ADD  CONSTRAINT [FK_Cuentas_TiposCuentas] FOREIGN KEY([TipoCuentaId])
REFERENCES [dbo].[TiposCuentas] ([Id])
GO
ALTER TABLE [dbo].[Cuentas] CHECK CONSTRAINT [FK_Cuentas_TiposCuentas]
GO
ALTER TABLE [dbo].[TiposCuentas]  WITH CHECK ADD  CONSTRAINT [FK_TiposCuentas_Usuarios] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[TiposCuentas] CHECK CONSTRAINT [FK_TiposCuentas_Usuarios]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Categorias] FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[Categorias] ([id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Categorias]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Cuentas] FOREIGN KEY([CuentaId])
REFERENCES [dbo].[Cuentas] ([Id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Cuentas]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [FK_Transacciones_Usuarios] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuarios] ([Id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [FK_Transacciones_Usuarios]
GO
/****** Object:  StoredProcedure [dbo].[CrearDatosDeUsuarioNuevo]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CrearDatosDeUsuarioNuevo]
	@UsuarioId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Efectivo  nvarchar(50) ='Efectivo';
	Declare @CuentasDeBancos  nvarchar(50) ='Cuentas de Banco';
	Declare @Tarjetas  nvarchar(50) ='Tarjetas';

	Insert into TiposCuentas (Nombre, UsuarioId, Orden)
	values (@Efectivo, @UsuarioId, 1),
	 (@CuentasDeBancos , @UsuarioId, 2),
	 (@Tarjetas, @UsuarioId, 3);

	Insert Into Cuentas (Nombre, Balance, TipoCuentaId)
	Select Nombre, 0, Id
	from TiposCuentas
	Where UsuarioId = @UsuarioId;

	Insert into Categorias(Nombre, TipoOperacionId, UsuarioId)
	values
	('Libros', 2,@UsuarioId),
	('Salario', 1,@UsuarioId),
	('Mesada', 1,@UsuarioId),
	('Comida', 2,@UsuarioId)

END
GO
/****** Object:  StoredProcedure [dbo].[TiposCuentas_Insertar]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TiposCuentas_Insertar]
	@Nombre nvarchar(50),
	@UsuarioId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Orden int;
	Select @Orden = Coalesce(max(Orden), 0)+1
	from TiposCuentas
	Where UsuarioId = @UsuarioId

	Insert Into TiposCuentas (Nombre, UsuarioId, Orden)
	values (@Nombre, @UsuarioId, @Orden);

	Select SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[Transacciones_Actualizar]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Transacciones_Actualizar]
	-- Add the parameters for the stored procedure here
	@Id int,
	@FechaTransaccion datetime,
	@Monto decimal(18,2),
	@MontoAnterior decimal(18,2),
	@CuentaId int,
	@CuentaAnteriorId int,
	@CategoriaId int,
	@Nota nvarchar(1000) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Revertir transaccion anterior
	Update Cuentas 
	Set Balance -= @MontoAnterior 
	Where Id = @CuentaAnteriorId;
	
	-- Realizar nueva Transaccion
	Update Cuentas 
	Set Balance += @Monto 
	Where Id = @CuentaId;

	Update Transacciones
	Set Monto = ABS(@Monto), FechaTransaccion = @FechaTransaccion, CategoriaId = @CategoriaId,
	CuentaId = @CuentaId, Nota = @Nota
	Where Id = @Id;

END
GO
/****** Object:  StoredProcedure [dbo].[Transacciones_Borrar]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Transacciones_Borrar]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @Monto decimal(18,2);
	Declare @CuentaId int;
	Declare @TipoOperacionId int;

	Select @Monto = Monto, @CuentaId = CuentaId, @TipoOperacionId = cat.TipoOperacionId
	From Transacciones
	inner join Categorias cat
	on cat.id = Transacciones.CategoriaId
	Where Transacciones.Id = @Id
    
	Declare @FactorMultiplicativo int = 1;

	If(@TipoOperacionId = 2)
		Set @FactorMultiplicativo = -1;
	Set @Monto = @Monto * @FactorMultiplicativo;

	Update Cuentas
	Set Balance -= @Monto Where Id = @CuentaId;

	Delete Transacciones Where Id = @Id;
	
END
GO
/****** Object:  StoredProcedure [dbo].[Transacciones_Insertar]    Script Date: 23/05/2022 04:21:19 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Transacciones_Insertar]
	@UsuarioId nvarchar(450),
	@FechaTransaccion date,
	@Monto decimal(18,2),
	@CategoriaId int,
	@CuentaId int,
	@Nota nvarchar (1000)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Insert Into Transacciones(UsuarioId, FechaTransaccion, Monto, CategoriaId, CuentaId, Nota)
	Values(@UsuarioId, @FechaTransaccion, ABS(@Monto), @CategoriaId, @CuentaId, @Nota)

	Update Cuentas
	Set Balance += @Monto Where id = @CuentaId;
	Select SCOPE_IDENTITY();


END
GO
USE [master]
GO
ALTER DATABASE [ManejoPresupuesto] SET  READ_WRITE 
GO
