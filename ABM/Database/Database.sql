USE [master]
GO
/****** Object:  Database [Pasantia]    Script Date: 29/11/2018 09:54:08 ******/
CREATE DATABASE [Pasantia]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pasantia', FILENAME = N'C:\DataBase\Pasantia.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pasantia_log', FILENAME = N'C:\DataBase\Pasantia_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Pasantia] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pasantia].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pasantia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pasantia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pasantia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pasantia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pasantia] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pasantia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Pasantia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pasantia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pasantia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pasantia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pasantia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pasantia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pasantia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pasantia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pasantia] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Pasantia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pasantia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pasantia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pasantia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pasantia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pasantia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pasantia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pasantia] SET RECOVERY FULL 
GO
ALTER DATABASE [Pasantia] SET  MULTI_USER 
GO
ALTER DATABASE [Pasantia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pasantia] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pasantia] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pasantia] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pasantia] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Pasantia', N'ON'
GO
ALTER DATABASE [Pasantia] SET QUERY_STORE = OFF
GO
USE [Pasantia]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_convertCommaSeparatedListToSingleColumn]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE	 FUNCTION [dbo].[FN_convertCommaSeparatedListToSingleColumn]  
(  
    @cslist VARCHAR(MAX)  
)  
RETURNS @t TABLE  
(  
	ID INT IDENTITY NOT NULL, 
    Item VARCHAR(501)  
) 
BEGIN   
    DECLARE @spot SMALLINT, @str VARCHAR(MAX) 
 
	--MP::15/07/2015:: Agrego RTRIM para que no surja el problema con las variables sin el Trim. Tambien agrego los LEFT a las variables por si tienen mas caracteres de los que permite la tabla
	SET  @cslist = RTRIM(@cslist) 
      
    WHILE @cslist <> ''   
    BEGIN   
        SET @spot = CHARINDEX(',', @cslist)   
        IF @spot>0   
        BEGIN   
            SET @str = LEFT(LEFT(@cslist, @spot-1),500)
            SET @cslist = RIGHT(@cslist, LEN(@cslist)-@spot)
        END   
        ELSE   
        BEGIN   
            SET @str = LEFT(@cslist,500)
            SET @cslist = ''   
        END   
 
        INSERT @t (Item) SELECT LTRIM(RTRIM(@str)) 
    END   
    RETURN  
END 
 
 

GO
/****** Object:  Table [dbo].[TB_MS_Employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_MS_Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](15) NOT NULL,
	[EmployeeLastName] [varchar](30) NOT NULL,
	[EmployeeDNI] [int] NOT NULL,
	[EmployeeRoleID] [int] NOT NULL,
	[EmployeeAddress] [varchar](100) NOT NULL,
	[EmployeeBirthdate] [date] NOT NULL,
	[EmployeeEmail] [varchar](61) NOT NULL,
	[EmployeeSalary] [money] NULL,
 CONSTRAINT [PK_TB_MS_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_MS_Employee_Roles]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_MS_Employee_Roles](
	[EmployeeRoleID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeRoleName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Employee_Roles] PRIMARY KEY CLUSTERED 
(
	[EmployeeRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_MS_Employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VW_MS_Employees] AS
SELECT
	EmployeeID,
    EmployeeName,
    EmployeeLastName,
    EmployeeDNI,
    E.EmployeeRoleID,
    EmployeeAddress,
    EmployeeBirthdate,
    EmployeeEmail,
	EmployeeSalary,
	R.EmployeeRoleName

FROM TB_MS_Employees E WITH(NOLOCK)

INNER JOIN TB_MS_Employee_Roles R 
	on E.EmployeeRoleID = R.EmployeeRoleID
GO
/****** Object:  Table [dbo].[TB_AC_EmployeeRoles]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_AC_EmployeeRoles](
	[EmployeeRoleID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeRoleName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_TB_AC_EmployeeRoles] PRIMARY KEY CLUSTERED 
(
	[EmployeeRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_AC_Employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_AC_Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](15) NOT NULL,
	[EmployeeLastName] [varchar](30) NOT NULL,
	[EmployeeDNI] [int] NOT NULL,
	[EmployeeRoleID] [int] NOT NULL,
	[EmployeeAddress] [varchar](100) NOT NULL,
	[EmployeeBirthDate] [date] NOT NULL,
	[EmployeeEmail] [varchar](60) NOT NULL,
	[EmployeeSalary] [money] NULL,
 CONSTRAINT [PK_TB_AC_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_AC_employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[VW_AC_employees]
as
select 
E.EmployeeID,
E.EmployeeName,
E.EmployeeLastName,
E.EmployeeDNI,
R.EmployeeRoleName,
E.EmployeeAddress ,
E.EmployeeBirthDate,
E.EmployeeEmail,
E.EmployeeRoleID,
E.EmployeeSalary

/*E.EmployeeRoleID*/
from TB_AC_Employees E 
WITH (NOLOCK)
Inner Join TB_AC_EmployeeRoles R 
ON E.EmployeeRoleID = R.EmployeeRoleID
GO
/****** Object:  Table [dbo].[TB_ML_Employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_ML_Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](15) NOT NULL,
	[EmployeeLastName] [varchar](30) NOT NULL,
	[EmployeeDNI] [int] NOT NULL,
	[EmployeeRoleID] [int] NOT NULL,
	[EmployeeAddress] [varchar](100) NOT NULL,
	[EmployeeBirthDate] [date] NOT NULL,
	[EmployeeeMail] [varchar](50) NOT NULL,
	[EmployeeSalary] [money] NULL,
 CONSTRAINT [PK_TB_ML_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_ML_Employee_Roles]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_ML_Employee_Roles](
	[EmployeeRoleID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeRoleName] [varchar](15) NOT NULL,
 CONSTRAINT [PK_TB_ML_Employee_Role] PRIMARY KEY CLUSTERED 
(
	[EmployeeRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_ML_Employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VW_ML_Employees]
AS
SELECT	E.EmployeeID,
		E.EmployeeName, 
		E.EmployeeLastName, 
		E.EmployeeBirthDate, 
		E.EmployeeDNI, 
		E.EmployeeAddress, 
		E.EmployeeeMail, 
		R.EmployeeRoleName,
		E.EmployeeRoleID,
		E.EmployeeSalary
FROM    
		
		dbo.TB_ML_Employees AS E WITH(NOLOCK)
		INNER JOIN
		dbo.TB_ML_Employee_Roles AS R 
			ON E.EmployeeRoleID = R.EmployeeRoleID

		

			


GO
/****** Object:  Table [dbo].[TB_AQ_Employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_AQ_Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](15) NOT NULL,
	[EmployeeSurname] [varchar](30) NOT NULL,
	[EmployeeDNI] [int] NOT NULL,
	[EmployeeBirthdate] [date] NOT NULL,
	[EmployeeRole] [int] NOT NULL,
	[EmployeeAddress] [varchar](100) NOT NULL,
	[EmployeeMail] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TB_AQ_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_AQ_EmployeeRoles]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_AQ_EmployeeRoles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_TB_AQ_EmployeeRoles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_AQ_Employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_AQ_Employees] AS
SELECT EmployeeID, EmployeeName,EmployeeSurname,EmployeeDNI,EmployeeBirthdate,RoleName,EmployeeAddress,EmployeeMail
FROM TB_AQ_Employees AS E
INNER JOIN TB_AQ_EmployeeRoles AS R
ON E.EmployeeRole = R.RoleID;
GO
/****** Object:  Table [dbo].[TB_GS_Employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_GS_Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](15) NOT NULL,
	[EmployeeLastName] [varchar](30) NOT NULL,
	[EmployeeDNI] [int] NOT NULL,
	[EmployeeRoleID] [int] NOT NULL,
	[EmployeeAddress] [varchar](100) NOT NULL,
	[EmployeeBirthDate] [date] NOT NULL,
	[EmployeeEmail] [varchar](60) NOT NULL,
	[EmployeeSalary] [money] NULL,
 CONSTRAINT [PK_TB_GS_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_GS_EmployeeRole]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_GS_EmployeeRole](
	[EmployeeRoleID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeRoleName] [varchar](40) NOT NULL,
 CONSTRAINT [PK_TB_GS_EmployeeRole] PRIMARY KEY CLUSTERED 
(
	[EmployeeRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_GS_Employees]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_GS_Employees] 
as
select
    EmployeeID,
	EmployeeName,
	EmployeeLastName,
	EmployeeDNI,
	E.EmployeeRoleID,
	EmployeeAddress,
	EmployeeBirthDate,
	RTRIM(EmployeeEmail) as EmployeeEmail,
	R.EmployeeRoleName,
	E.EmployeeSalary

from	TB_GS_Employees E with (NOLOCK)
inner join TB_GS_EmployeeRole R
on E.EmployeeRoleID = R.EmployeeRoleID

GO
/****** Object:  Table [dbo].[TB_AC_EmployeePhones]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_AC_EmployeePhones](
	[EmployeeID] [int] NOT NULL,
	[EmployeePhone] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TB_AC_EmployeePhones] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[EmployeePhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_AQ_EmployeePhones]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_AQ_EmployeePhones](
	[EmployeeID] [int] NOT NULL,
	[EmployeePhone] [int] NOT NULL,
 CONSTRAINT [PK_TB_AQ_EmployeePhones] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[EmployeePhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_GS_EmployeePhones]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_GS_EmployeePhones](
	[EmployeeID] [int] NOT NULL,
	[EmployeePhone] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TB_GS_EmployeePhones] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[EmployeePhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_ML_Employee_Phones]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_ML_Employee_Phones](
	[EmployeeID] [int] NOT NULL,
	[EmployeePhone] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CompID] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[EmployeePhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_MS_Employee_Phones]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_MS_Employee_Phones](
	[EmployeeID] [int] NOT NULL,
	[EmployeePhone] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Employee_Phones] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[EmployeePhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_AC_EmployeePhones]  WITH CHECK ADD  CONSTRAINT [FK_TB_AC_EmployeePhones_TB_AC_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TB_AC_Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[TB_AC_EmployeePhones] CHECK CONSTRAINT [FK_TB_AC_EmployeePhones_TB_AC_Employees]
GO
ALTER TABLE [dbo].[TB_AC_Employees]  WITH CHECK ADD  CONSTRAINT [FK_TB_AC_Employees_TB_AC_EmployeeRoles] FOREIGN KEY([EmployeeRoleID])
REFERENCES [dbo].[TB_AC_EmployeeRoles] ([EmployeeRoleID])
GO
ALTER TABLE [dbo].[TB_AC_Employees] CHECK CONSTRAINT [FK_TB_AC_Employees_TB_AC_EmployeeRoles]
GO
ALTER TABLE [dbo].[TB_AQ_EmployeePhones]  WITH CHECK ADD  CONSTRAINT [FK_TB_AQ_EmployeePhones_TB_AQ_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TB_AQ_Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[TB_AQ_EmployeePhones] CHECK CONSTRAINT [FK_TB_AQ_EmployeePhones_TB_AQ_Employees]
GO
ALTER TABLE [dbo].[TB_AQ_Employees]  WITH CHECK ADD  CONSTRAINT [FK_TB_AQ_Employees_TB_AQ_EmployeeRoles] FOREIGN KEY([EmployeeRole])
REFERENCES [dbo].[TB_AQ_EmployeeRoles] ([RoleID])
GO
ALTER TABLE [dbo].[TB_AQ_Employees] CHECK CONSTRAINT [FK_TB_AQ_Employees_TB_AQ_EmployeeRoles]
GO
ALTER TABLE [dbo].[TB_GS_EmployeePhones]  WITH CHECK ADD  CONSTRAINT [FK_TB_GS_EmployeePhones_TB_GS_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TB_GS_Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[TB_GS_EmployeePhones] CHECK CONSTRAINT [FK_TB_GS_EmployeePhones_TB_GS_Employees]
GO
ALTER TABLE [dbo].[TB_GS_Employees]  WITH CHECK ADD  CONSTRAINT [FK_TB_GS_Employees_TB_GS_EmployeeRole] FOREIGN KEY([EmployeeRoleID])
REFERENCES [dbo].[TB_GS_EmployeeRole] ([EmployeeRoleID])
GO
ALTER TABLE [dbo].[TB_GS_Employees] CHECK CONSTRAINT [FK_TB_GS_Employees_TB_GS_EmployeeRole]
GO
ALTER TABLE [dbo].[TB_ML_Employee_Phones]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeID] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TB_ML_Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[TB_ML_Employee_Phones] CHECK CONSTRAINT [FK_EmployeeID]
GO
ALTER TABLE [dbo].[TB_ML_Employees]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeRoleID] FOREIGN KEY([EmployeeRoleID])
REFERENCES [dbo].[TB_ML_Employee_Roles] ([EmployeeRoleID])
GO
ALTER TABLE [dbo].[TB_ML_Employees] CHECK CONSTRAINT [FK_EmployeeRoleID]
GO
ALTER TABLE [dbo].[TB_MS_Employee_Phones]  WITH CHECK ADD  CONSTRAINT [FK_TB_MS_Employee_Phones_TB_MS_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[TB_MS_Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[TB_MS_Employee_Phones] CHECK CONSTRAINT [FK_TB_MS_Employee_Phones_TB_MS_Employees]
GO
ALTER TABLE [dbo].[TB_MS_Employees]  WITH CHECK ADD  CONSTRAINT [FK_TB_MS_Employees_TB_MS_Employee_Roles] FOREIGN KEY([EmployeeRoleID])
REFERENCES [dbo].[TB_MS_Employee_Roles] ([EmployeeRoleID])
GO
ALTER TABLE [dbo].[TB_MS_Employees] CHECK CONSTRAINT [FK_TB_MS_Employees_TB_MS_Employee_Roles]
GO
/****** Object:  StoredProcedure [dbo].[SP_AC_Employees_Add]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_AC_Employees_Add]
	@eName VARCHAR(30),
	@eLastname VARCHAR(30),
	@eDNI INT,
	@eRole INT,
	@eAddress VARCHAR(30),
	@eBirthdate VARCHAR(10),	
	@eEmail VARCHAR(30),
	@EmployeePhonesStr varchar(MAX),
	@eSalary money,
	@errorDesc varchar (500) OUT,
	@EmployeeID INT OUT
	
AS
SET NOCOUNT ON
BEGIN TRY
		
		IF EXISTS(SELECT TOP 1 1 FROM TB_AC_Employees WITH(NOLOCK) WHERE EmployeeDNI=@eDNI)
			BEGIN
				SET @ErrorDesc='Ya existe un empleado con el DNI ingresado'
				RETURN -1
			END

		IF datediff(year, CONVERT(DATE,@eBirthdate), getdate()) < 18
			BEGIN
				SET @errorDesc='La fecha ingresada no es valida'
				RETURN -2
			END 
		IF NOT EXISTS (SELECT TOP 1 1 FROM TB_AC_EmployeeRoles WITH(NOLOCK) WHERE EmployeeRoleID= @eRole)
			BEGIN 
				SET @errorDesc ='El rol Ingresado no existe'
				RETURN -3
			END
		IF ISNULL(@EmployeePhonesStr,'')=''
			BEGIN
				SET @errorDesc = 'Se requiere un telefono'				
				RETURN -4
			END
		IF @eSalary<0
			BEGIN
				SET @errorDesc = 'Se requiere un Sueldo Valido'				
				RETURN -5
			END

BEGIN TRANSACTION

	INSERT INTO TB_AC_Employees(EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleId,EmployeeAddress,EmployeeBirthdate,EmployeeEmail,EmployeeSalary)
	VALUES(@eName,@eLastname,@eDNI,@eRole,@eAddress,@eBirthdate,@eEmail,@eSalary)
	
	SET @EmployeeID = SCOPE_IDENTITY()

	INSERT INTO TB_AC_EmployeePhones
	SELECT @EmployeeID, Item
	FROM FN_convertCommaSeparatedListToSingleColumn(@EmployeePhonesStr)
COMMIT TRANSACTION
RETURN 1

END TRY

BEGIN CATCH
	PRINT ERROR_LINE()
	PRINT ERROR_MESSAGE()
	ROLLBACK TRANSACTION
	SET @errorDesc='Ha ocurrido un error'
	RETURN -1
END CATCH





GO
/****** Object:  StoredProcedure [dbo].[SP_AC_Employees_Delete]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SP_AC_Employees_Delete]
	@EmployeeID INT,
	@ErrorDesc VARCHAR (500) OUT
AS

declare @trancount int = 0
set @trancount = @@TRANCOUNT

SET NOCOUNT ON 
BEGIN TRY
	IF @trancount = 0
	BEGIN TRANSACTION
		IF NOT EXISTS(SELECT TOP 1 1 FROM TB_AC_Employees WITH(NOLOCK) WHERE EmployeeID=@EmployeeID)
			BEGIN
				SET @ErrorDesc='El empleado que solicito no existe'
				IF @trancount = 0
				ROLLBACK TRANSACTION
				RETURN -1
			END
		IF EXISTS(SELECT TOP 1 1 FROM TB_AC_EmployeePhones WITH(NOLOCK) WHERE EmployeeID=@EmployeeID)
			BEGIN
				DELETE FROM TB_AC_EmployeePhones
				WHERE EmployeeID = @EmployeeID 
			END

		DELETE FROM TB_AC_Employees
		WHERE EmployeeID=@EmployeeID
		
	IF @trancount = 0
	COMMIT TRANSACTION
	RETURN 1

END TRY
BEGIN CATCH
	PRINT ERROR_LINE()
	PRINT ERROR_MESSAGE()
	ROLLBACK TRANSACTION
	SET @errorDesc='Ha ocurrido un error'
	RETURN -1
END CATCH

		



GO
/****** Object:  StoredProcedure [dbo].[SP_AC_Employees_Edit]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_AC_Employees_Edit]
	@EmployeeID INT,
	@eName VARCHAR(15),
	@eLastname VARCHAR(30),
	@eDNI INT,
	@eRole INT,
	@eAddress VARCHAR(100),
	@eBirthdate VARCHAR(10),	
	@eEmail VARCHAR(60),
	@EmployeePhonesStr VARCHAR(MAX),
	@eSalary money,
	@eliminar BIT,
	@errorDesc VARCHAR (500) OUT	
	
AS
declare @trancount int = 0
set @trancount = @@TRANCOUNT

SET NOCOUNT ON


BEGIN TRY
	
			IF EXISTS(SELECT TOP 1 1 FROM TB_AC_Employees WITH (NOLOCK) WHERE EmployeeDNI=@eDNI AND EmployeeID<>@EmployeeID)
					BEGIN
						SET @ErrorDesc='Ya existe un empleado con el DNI ingresado'
						RETURN -1
					END
					
				IF datediff(year, CONVERT(DATE,@eBirthdate), getdate()) < 18
					BEGIN
						SET @errorDesc='La fecha ingresada no es valida'
						RETURN -2
					END 
				IF NOT EXISTS (SELECT TOP 1 1 FROM TB_AC_EmployeeRoles WITH (NOLOCK) WHERE EmployeeRoleID= @eRole)
					BEGIN 
						SET @errorDesc ='El rol Ingresado no existe'
						RETURN -3
					END
				IF ISNULL(@EmployeePhonesStr,'')=''
					BEGIN
						SET @errorDesc = 'Se requiere un telefono'
						RETURN -4
					END
				IF @eSalary<0
					BEGIN
						SET @errorDesc = 'Se requiere un Sueldo Valido'				
						RETURN -5
					END

IF @trancount = 0
BEGIN TRANSACTION
			UPDATE TB_AC_Employees WITH (ROWLOCK)
			SET
				EmployeeName = @eName,
				EmployeeLastName = @eLastname,
				EmployeeDNI = @eDNI,
				EmployeeRoleID = @eRole,
				EmployeeAddress = @eAddress,
				EmployeeBirthdate = @eBirthdate,
				EmployeeEmail = @eEmail,
				EmployeeSalary = @eSalary

	
			WHERE EmployeeID = @EmployeeID
	
			DELETE  TB_AC_EmployeePhones WHERE EmployeeID=@EmployeeID

			INSERT INTO TB_AC_EmployeePhones
			SELECT @EmployeeID, Item
			FROM FN_convertCommaSeparatedListToSingleColumn(@EmployeePhonesStr)

			IF @eliminar=1
			BEGIN
				DECLARE @RC INT
				EXEC @RC = SP_AC_Employees_Delete 
				@EmployeeID = @EmployeeID,
				@ErrorDesc = @errorDesc OUT
			END

		    IF @RC <> 1
				BEGIN
					IF @trancount = 0
						rollback tran
					RETURN -1		
				END


IF @trancount = 0
		COMMIT TRANSACTION
	RETURN 1
END TRY

BEGIN CATCH
	PRINT ERROR_LINE()
	PRINT ERROR_MESSAGE()
	ROLLBACK TRANSACTION
	SET @errorDesc='Ha ocurrido un error'
	RETURN -1
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[SP_AC_Employees_Reportes]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_AC_Employees_Reportes]
	
	@errorDesc varchar (500) OUT
	
	
AS
SET NOCOUNT ON
BEGIN TRY
		
		
BEGIN TRANSACTION
SELECT * FROM VW_AC_employees  order by EmployeeRoleID
		 
COMMIT TRANSACTION
RETURN 1

END TRY

BEGIN CATCH
	PRINT ERROR_LINE()
	PRINT ERROR_MESSAGE()
	ROLLBACK TRANSACTION
	SET @errorDesc='Ha ocurrido un error'
	RETURN -1
END CATCH





GO
/****** Object:  StoredProcedure [dbo].[SP_AC_Employees_Search]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SP_AC_Employees_Search]
@filter varchar (30) 
as
set @filter = LTRIM(RTRIM(@filter))

select * from VW_AC_employees E
where   E.EmployeeName like CONCAT('%',@filter,'%') or 
		E.EmployeeLastName like CONCAT('%',@filter,'%') or  
		EmployeeRoleName like CONCAT('%',@filter,'%')
return 1
GO
/****** Object:  StoredProcedure [dbo].[SP_AC_Reportes]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_AC_Reportes]
	
	@errorDesc varchar (500) OUT
	
	
AS
SET NOCOUNT ON
BEGIN TRY
		
		
BEGIN TRANSACTION

	select
	   EmployeeRoleName,
	   SUM(EmployeeSalary) as Total_Sueldo,
	   AVG(EmployeeSalary) as Promedio_Sueldo,
	   MAX(EmployeeSalary) as Sueldo_Maximo,
	   COUNT(*) as Total_Empleados
	   FROM VW_AC_employees 
	   GROUP BY  EmployeeRoleName
	 
COMMIT TRANSACTION
RETURN 1

END TRY

BEGIN CATCH
	PRINT ERROR_LINE()
	PRINT ERROR_MESSAGE()
	ROLLBACK TRANSACTION
	SET @errorDesc='Ha ocurrido un error'
	RETURN -1
END CATCH





GO
/****** Object:  StoredProcedure [dbo].[SP_AQ_Employee_Delete]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SP_AQ_Employee_Delete]
	@EmployeeID INT,
	@ErrorDesc VARCHAR(500) OUT
AS
	BEGIN TRY
		IF NOT EXISTS(SELECT TOP 1 1 FROM TB_AQ_Employees WHERE EmployeeID = @EmployeeID)
		BEGIN
			SET @ErrorDesc = 'El empleado que se intento eliminar no existe en el sistema.'
			RETURN -1
		END

		BEGIN TRANSACTION
		IF EXISTS(SELECT TOP 1 1 FROM TB_AQ_EmployeePhones WHERE EmployeeID = @EmployeeID)
		BEGIN
			DELETE FROM TB_AQ_EmployeePhones
			WHERE EmployeeID = @EmployeeID
		END

		DELETE FROM TB_AQ_Employees
		WHERE EmployeeID = @EmployeeID
		COMMIT TRANSACTION
		RETURN 1
	END TRY
	BEGIN CATCH
		PRINT ERROR_LINE()
		PRINT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
		SET @ErrorDesc = 'Error critico'
		RETURN -5
	END CATCH


GO
/****** Object:  StoredProcedure [dbo].[SP_AQ_Employees_Add]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SP_AQ_Employees_Add]
	@eName VARCHAR(15),
	@eSurname VARCHAR(30),
	@eDNI INT,
	@eBirthdate DATE,
	@eRole INT,
	@eAddress VARCHAR(30),
	@eMail VARCHAR(30),
	@EmployeePhoneStr VARCHAR(MAX),
	@EmployeeID INT OUT,
	@ErrorDesc VARCHAR(500) OUT
AS
	BEGIN TRY
		IF EXISTS (SELECT TOP 1 1 FROM TB_AQ_Employees where EmployeeDNI = @eDNI)
		BEGIN
			SET @ErrorDesc = 'Ya existe un usuario con el DNI ingresado dentro del sistema.'
			PRINT @ErrorDesc
			RETURN -1
		END
		IF NOT EXISTS (SELECT TOP 1 1 FROM TB_AQ_EmployeeRoles where RoleID = @eRole)
		BEGIN
			SET @ErrorDesc = 'El cargo especificado no existe.'
			PRINT @ErrorDesc
			RETURN -2
		END
		IF ISNULL(@EmployeePhoneStr,'') = ''
		BEGIN
			SET @ErrorDesc = 'Se debe ingresar por lo menos un telefono.'
			PRINT @ErrorDesc
			RETURN -3
		END
		IF DATEDIFF(Year,@eBirthdate,GETDATE()) < 18
		BEGIN
			SET @ErrorDesc = 'La fecha ingresada es invalida.'
			PRINT @ErrorDesc
			RETURN -4
		END
	
		/*SELECT value from STRING_SPLIT(@EmployeePhoneStr, ', ') as TempEmployeePhoneStr*/
		BEGIN TRANSACTION
		INSERT INTO TB_AQ_Employees(EmployeeName,EmployeeSurname,EmployeeDNI,EmployeeBirthdate,EmployeeRole,EmployeeAddress,EmployeeMail)
		VALUES(@eName,@eSurname,@eDNI,@eBirthdate,@eRole,@eAddress,@eMail)
		SET @EmployeeID = SCOPE_IDENTITY()
		INSERT INTO TB_AQ_EmployeePhones(EmployeeID,EmployeePhone)
		SELECT @EmployeeID, Item FROM FN_convertCommaSeparatedListToSingleColumn(@EmployeePhoneStr)
		COMMIT TRANSACTION
		RETURN 1
	END TRY
	BEGIN CATCH
		PRINT ERROR_LINE()
		PRINT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
		SET @ErrorDesc = 'Error critico'
		RETURN -5
	END CATCH

GO
/****** Object:  StoredProcedure [dbo].[SP_AQ_Employees_Edit]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROC [dbo].[SP_AQ_Employees_Edit]
	@eName VARCHAR(15),
	@eSurname VARCHAR(30),
	@eDNI INT,
	@eBirthdate DATE,
	@eRole INT,
	@eMail VARCHAR(30),
	@eAddress VARCHAR(30),
	@EmployeePhoneStr VARCHAR(MAX),
	@EmployeeID INT,
	@ErrorDesc VARCHAR(500) OUT
AS
	BEGIN TRY
		IF EXISTS (SELECT TOP 1 1 FROM TB_AQ_Employees where EmployeeDNI = @eDNI AND EmployeeID <> @EmployeeID)
		BEGIN
			SET @ErrorDesc = 'Ya existe un usuario con el DNI ingresado dentro del sistema.'
			PRINT @ErrorDesc
			RETURN -1
		END

		IF NOT EXISTS (SELECT TOP 1 1 FROM TB_AQ_Employees where EmployeeRole = @eRole)
		BEGIN
			SET @ErrorDesc = 'El cargo especificado no existe.'
			PRINT @ErrorDesc
			RETURN -2
		END

		IF ISNULL(@EmployeePhoneStr,'') = ''
		BEGIN
			SET @ErrorDesc = 'Se debe ingresar por lo menos un telefono.'
			PRINT @ErrorDesc
			RETURN -3
		END

		SELECT CONVERT(DATE,@eBirthdate,11)
		IF DATEDIFF(Year,@eBirthdate,GETDATE()) < 18
		BEGIN
			SET @ErrorDesc = 'La fecha ingresada es invalida.'
			PRINT @ErrorDesc
			RETURN -4
		END

	
		BEGIN TRANSACTION
		UPDATE TB_AQ_Employees
		SET EmployeeName = @eName,
		EmployeeSurname = @eSurname,
		EmployeeDNI = @eDNI,
		EmployeeBirthdate = @eBirthdate,
		EmployeeRole = @eRole,
		EmployeeMail = @eMail,
		EmployeeAddress = @eAddress
		WHERE EmployeeID = @EmployeeID

		DELETE TB_AQ_EmployeePhones WHERE EmployeeID = @EmployeeID
		INSERT INTO TB_AQ_EmployeePhones(EmployeeID,EmployeePhone)
		SELECT @EmployeeID, Item FROM FN_convertCommaSeparatedListToSingleColumn(@EmployeePhoneStr)
		COMMIT TRANSACTION
		RETURN 1
	END TRY
	BEGIN CATCH
		PRINT ERROR_LINE()
		PRINT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
		SET @ErrorDesc = 'Error critico'
		RETURN -5
	END CATCH


GO
/****** Object:  StoredProcedure [dbo].[SP_AQ_Employees_Search]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_AQ_Employees_Search]
	@Filter VARCHAR(30) 
AS
	SET @Filter = LTRIM(RTRIM(@Filter))
	SELECT * from VW_AQ_Employees
	WHERE EmployeeName like CONCAT('%',@Filter,'%')
	OR EmployeeSurname like CONCAT('%',@Filter,'%')
	OR RoleName like CONCAT('%',@Filter,'%')
	RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[SP_GS_Employees_Add]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROC [dbo].[SP_GS_Employees_Add]
	@NameEmp VARCHAR(15),
	@SurnameEmp VARCHAR(30),
	@DNIEmp INT,
	@BirthdateEmp VARCHAR(10),
	@RoleEmp INT,
	@AddressEmp VARCHAR(100),
	@EmailEmp VARCHAR(60),
	@EmployeePhonesStr VARCHAR(MAX),
	@SalaryEmp MONEY,
	@ErorrDesc VARCHAR (500) OUT,
	@EmployeeID INT OUT
	
AS

 BEGIN TRY 
   

	  IF EXISTS (SELECT TOP 1 1 FROM TB_GS_Employees WHERE EmployeeDNI = @DNIEmp)
		BEGIN
		    
			SET @ErorrDesc = 'Ya existe un empleado con el DNI ingresado.'
			RETURN -1
		END

	  IF NOT EXISTS (SELECT TOP 1 1 FROM TB_GS_EmployeeRole WHERE EmployeeRoleID = @RoleEmp)
		BEGIN
		    
			SET @ErorrDesc = 'El cargo ingresado no es valido.'
			RETURN -2
		END

	  IF DATEDIFF(YEAR, CONVERT(DATE,@BirthdateEmp),GETDATE()) <18
		BEGIN
		    
			SET @ErorrDesc = 'La fecha ingresada no es valida.'
			RETURN -3
		END

	  IF ISNULL(@EmployeePhonesStr,'')=''
		BEGIN
		    
			SET @ErorrDesc = 'Se debe ingresar un telefono como minimo.'
			RETURN -4
	END

	BEGIN TRANSACTION


	INSERT INTO TB_GS_Employees(EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeBirthdate,EmployeeRoleID,EmployeeAddress,EmployeeEmail,EmployeeSalary)
	VALUES(@NameEmp,@SurnameEmp,@DNIEmp,@BirthdateEmp,@RoleEmp,@AddressEmp,@EmailEmp,@SalaryEmp)

	SET @EmployeeID = SCOPE_IDENTITY()

	
    INSERT INTO  TB_GS_EmployeePhones
    SELECT @EmployeeID,item
    FROM FN_convertCommaSeparatedListToSingleColumn(@EmployeePhonesStr)
    
   COMMIT TRANSACTION
   RETURN 1
 END TRY

  BEGIN CATCH
	PRINT ERROR_LINE()
	PRINT ERROR_MESSAGE()
    ROLLBACK TRANSACTION
    SET @ErorrDesc = 'Ha ocurrido un error'
    RETURN -1
  END CATCH



GO
/****** Object:  StoredProcedure [dbo].[SP_GS_Employees_Delete]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[SP_GS_Employees_Delete]
	@IDEmployee INT,
	@Errordesc VARCHAR(500) OUT
AS

declare @trancount int = 0
set @trancount = @@TRANCOUNT
SET NOCOUNT ON

BEGIN TRY
IF @trancount = 0
BEGIN TRANSACTION
   
    IF NOT EXISTS (SELECT TOP 1 1 FROM TB_GS_Employees WHERE EmployeeID = @IDEmployee)
		BEGIN 
		  SET @Errordesc = 'El empleado que desea eliminar no existe'
		  IF @trancount = 0
		  ROLLBACK TRANSACTION 
		  RETURN -1
		END
    IF EXISTS (SELECT TOP 1 1 FROM TB_GS_EmployeePhones WHERE EmployeeID = @IDEmployee)
	    BEGIN 
		  DELETE FROM TB_GS_EmployeePhones
		  WHERE EmployeeID = @IDEmployee
		END

	 DELETE FROM TB_GS_Employees
	  WHERE EmployeeID = @IDEmployee

	  IF @trancount = 0
	  COMMIT TRANSACTION
	  RETURN 1

	
   COMMIT TRANSACTION
   RETURN 1
 END TRY

  BEGIN CATCH
	PRINT ERROR_LINE()
	PRINT ERROR_MESSAGE()
    ROLLBACK TRANSACTION
    SET @ErrorDesc = 'Ha ocurrido un error'
    RETURN -1
  END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_GS_Employees_Edit]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_GS_Employees_Edit]
	
	@NameEmp VARCHAR(15),
	@LastNameEmp VARCHAR(30),
	@dniEmp INT,
	@RoleIDEmp INT,
	@AddressEmp VARCHAR(100),
	@BirthdateEmp VARCHAR(10),
	@EmailEmp VARCHAR(61),
	@EmployeePhonesStr VARCHAR(MAX),
	@SalaryEmp MONEY,
	@EmployeeID INT,
	@ErrorDesc VARCHAR(500) OUT
AS

BEGIN TRY 
   
	IF EXISTS (SELECT TOP 1 1 FROM TB_GS_Employees with (NOLOCK) WHERE EmployeeDNI = @dniEmp AND EmployeeID <> @EmployeeID)
		BEGIN
			SET @ErrorDesc = 'Ya existe un empleado con el DNI ingresado'
			RETURN -1
		END

	IF NOT EXISTS (SELECT TOP 1 1 FROM TB_GS_EmployeeRole with (NOLOCK) WHERE EmployeeRoleID = @RoleIDEmp)
		BEGIN
			SET @ErrorDesc = 'El cargo ingresado no es valido'
			RETURN -2
		END

	IF DATEDIFF(YEAR,CONVERT(DATE,@BirthdateEmp),GETDATE()) < 18
		BEGIN
			SET @ErrorDesc = 'La fecha ingresada no es válida'
			RETURN -3
		END

	IF ISNULL(@EmployeePhonesStr,'') = ''
		BEGIN
			SET @ErrorDesc = 'Se debe ingresar un telefono como minimo'
			RETURN -4
		END

		BEGIN TRANSACTION	
	
	UPDATE TB_GS_Employees with (ROWLOCK)
		SET
			EmployeeName = @NameEmp,
			EmployeeLastName = @LastNameEmp,
			EmployeeDNI = @dniEmp,
			EmployeeRoleID = @RoleIDEmp,
			EmployeeAddress = @AddressEmp,
			EmployeeBirthdate = @BirthdateEmp,
			EmployeeEmail = @EmailEmp,
			EmployeeSalary = @SalaryEmp
		WHERE
			EmployeeID = @EmployeeID

	DELETE TB_GS_EmployeePhones WHERE EmployeeID = @EmployeeID

	INSERT INTO TB_GS_EmployeePhones
	SELECT @EmployeeID,Item 
	FROM FN_convertCommaSeparatedListToSingleColumn(@EmployeePhonesStr)

	
   COMMIT TRANSACTION
   RETURN 1
 END TRY

  BEGIN CATCH
	PRINT ERROR_LINE()
	PRINT ERROR_MESSAGE()
    ROLLBACK TRANSACTION
    SET @ErrorDesc = 'Ha ocurrido un error'
    RETURN -1
  END CATCH
	
	
GO
/****** Object:  StoredProcedure [dbo].[SP_GS_Employees_search]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_GS_Employees_search]
@filter varchar (30)


as
set @filter = LTRIM(RTRIM(@filter))

select * from vw_GS_Employees E
where E.EmployeeName like concat('%',@filter,'%') 
      or E.EmployeeLastName like concat('%',@filter,'%') 
      or EmployeeRoleName like concat('%',@filter,'%')
return 8



GO
/****** Object:  StoredProcedure [dbo].[SP_GS_reports]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_GS_reports]

@erroDesc varchar (500) OUT
as
set nocount on
begin try

begin transaction 
select EmployeeRoleName,
   sum(EmployeeSalary) as total_sueldo,
   AVG(EmployeeSalary) as promedio_sueldo,
   MAX(EmployeeSalary) as sueldo_maximo,
   count(*) as total_empleados
   FROM VW_GS_Employees

   GROUP BY EmployeeRoleName
   
 commit transaction 
 return 1
 end try

 begin catch
 print error_line()
 print error_message()
 rollback transaction
 set @erroDesc = 'Ha ocurrido un error'
 return 1
 end catch






GO
/****** Object:  StoredProcedure [dbo].[SP_GS_Roles]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[SP_GS_Roles]

@erroDesc varchar (500) OUT
as
set nocount on
begin try

begin transaction 

 select * from vw_GS_Employees order by EmployeeRoleID
 commit transaction 
 return 1
 end try

 begin catch
 print error_line()
 print error_message()
 rollback transaction
 set @erroDesc = 'Ha ocurrido un error'
 return -1
 end catch

GO
/****** Object:  StoredProcedure [dbo].[SP_ML_Employees_Add]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SP_ML_Employees_Add] 
									@EmployeeID INT OUT,
									@EmployeeName VARCHAR(15),
									@EmployeeLastName VARCHAR(30),
									@EmployeeDNI int,
									@EmployeeRoleID int,
									@EmployeeSalary MONEY,
									@EmployeeAddress varchar(100),
									@EmployeeBirthDate date,
									@EmployeeeMail VARCHAR(50),
									@EmployeePhoneStr VARCHAR(MAX),
									@ErrorDesc VARCHAR(500) OUT
AS
BEGIN TRY
SET	@EmployeeName = LTRIM(RTRIM(@EmployeeName))
SET	@EmployeeLastName = LTRIM(RTRIM(@EmployeeLastName))
SET @EmployeeAddress = LTRIM(RTRIM(@EmployeeAddress))
SET @EmployeeeMail = LTRIM(RTRIM(@EmployeeeMail))
SET @EmployeePhoneStr = LTRIM(RTRIM(@EmployeePhoneStr))
SET @EmployeeSalary = LTRIM(RTRIM(@EmployeeSalary))

DECLARE @TRANCOUNT INT
SET @TRANCOUNT = @@TRANCOUNT

IF EXISTS(SELECT 1 FROM TB_ML_Employees WITH(NOLOCK) WHERE @EmployeeDNI = TB_ML_Employees.EmployeeDNI)
	BEGIN	
		SET @ErrorDesc = 'El DNI del empleado ya existe'
		RETURN -1
	END
IF NOT EXISTS(SELECT 1 FROM TB_ML_Employee_Roles WITH(NOLOCK) WHERE @EmployeeRoleID = TB_ML_Employee_Roles.EmployeeRoleID)
	BEGIN
		SET @ErrorDesc = ' El cargo seleccionado no existe'
	RETURN -2
	END	
IF(ISNULL(@EmployeePhoneStr,'') = '')
	BEGIN	
		SET @ErrorDesc = 'Debe de utilizar al menos un teléfono'
		RETURN -3
	END
IF (DATEDIFF(year,CONVERT(DATE,@EmployeeBirthDate,101),GETDATE()) < 18)
	BEGIN	
		SET @ErrorDesc = 'El empleado es menor de edad (18 años)'
		RETURN -4
	END

	IF @TRANCOUNT = 0
		BEGIN
			BEGIN TRANSACTION
		END
		
		INSERT INTO TB_ML_Employees(
			EmployeeName,
			EmployeeLastName,
			EmployeeDNI,
			EmployeeRoleID,
			EmployeeSalary,
			EmployeeAddress,
			EmployeeBirthDate,
			EmployeeeMail
			) 

		VALUES(	
			@EmployeeName,
			@EmployeeLastName,
			@EmployeeDNI,
			@EmployeeRoleID,
			@EmployeeSalary,
			@EmployeeAddress,
			@EmployeeBirthDate,
			@EmployeeeMail
		  )

		SET @EmployeeID = SCOPE_IDENTITY()
	
		INSERT INTO TB_ML_Employee_Phones(EmployeeID,
									  EmployeePhone) 
		SELECT @EmployeeID,
		   item 
		FROM FN_convertCommaSeparatedListToSingleColumn(@EmployeePhoneStr) 

		IF @TRANCOUNT = 0
			BEGIN
				COMMIT TRANSACTION;
			END
	RETURN 1

END TRY
BEGIN CATCH
	IF @TRANCOUNT = 0
		BEGIN
			ROLLBACK TRANSACTION
		END
	PRINT ERROR_LINE() 
	PRINT ERROR_MESSAGE() 
	SET @ErrorDesc = 'No se pudo agregar al empleado correctamente, intente de nuevo mas tarde'
	RETURN -1
	


END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_ML_Employees_Delete]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ML_Employees_Delete]  
	@EmployeeID int,
	@ErrorDesc VARCHAR(500) OUT
	AS
	BEGIN TRY 
	DECLARE @TRANCOUNT INT
	SET @TRANCOUNT = @@TRANCOUNT
		
		IF NOT EXISTS( SELECT TOP 1 1 FROM TB_ML_Employees WITH(NOLOCK) WHERE EmployeeID = @EmployeeID)
			BEGIN
				SET @ErrorDesc='El empleado no existe en la base de datos'
				RETURN -1 	
			END

	IF @TRANCOUNT = 0
		BEGIN
			BEGIN TRANSACTION
		END
	IF EXISTS(SELECT TOP 1 1 FROM TB_ML_Employee_Phones WITH(NOLOCK) WHERE EmployeeID = @EmployeeID)
		BEGIN
			DELETE FROM TB_ML_Employee_Phones WHERE EmployeeID = @EmployeeID
		END


		DELETE FROM TB_ML_Employees WHERE EmployeeID = @EmployeeID
		
		IF @TRANCOUNT = 0
			BEGIN
				COMMIT TRANSACTION;
			END

	RETURN 1
END TRY
BEGIN CATCH
	
	IF @TRANCOUNT = 0
		BEGIN
			ROLLBACK TRANSACTION
		END

	PRINT ERROR_LINE() 
	PRINT ERROR_MESSAGE() 
	SET @ErrorDesc = 'No se pudo eliminar al empleado correctamente, intente de nuevo mas tarde'
	RETURN -1

END CATCH

					
GO
/****** Object:  StoredProcedure [dbo].[SP_ML_Employees_Edit]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[SP_ML_Employees_Edit] 
				 @EmployeeID int,
				 @EmployeeName VARCHAR(15),
				 @EmployeeLastName VARCHAR(30),
				 @EmployeeDNI INT,
				 @EmployeeRoleID INT,
				 @EmployeeSalary MONEY,
				 @EmployeeAddress VARCHAR(100),
				 @EmployeeBirthDate DATE,
				 @EmployeeeMail VARCHAR(50), 
				 @EmployeePhoneStr VARCHAR(MAX),
				 @EmployeeDelete BIT,		
				 @ErrorDesc VARCHAR(500) OUT
				 
AS
DECLARE @TRANCOUNT INT = 0
SET @TRANCOUNT = @@TRANCOUNT
BEGIN TRY
SET	@EmployeeName = LTRIM(RTRIM(@EmployeeName))
SET	@EmployeeLastName = LTRIM(RTRIM(@EmployeeLastName))
SET @EmployeeAddress = LTRIM(RTRIM(@EmployeeAddress))
SET @EmployeeeMail = LTRIM(RTRIM(@EmployeeeMail))
SET @EmployeePhoneStr = LTRIM(RTRIM(@EmployeePhoneStr))
SET @EmployeeSalary= LTRIM(RTRIM(@EmployeeSalary))

DECLARE @RC INT

IF EXISTS(SELECT 1 FROM TB_ML_Employees WITH(NOLOCK) WHERE @EmployeeID = TB_ML_Employees.EmployeeID AND EmployeeID<>@EmployeeID)
BEGIN	
	SET @ErrorDesc = 'El empleado no existe'
	RETURN -1
END

IF NOT EXISTS(SELECT 1 FROM TB_ML_Employee_Roles WITH(NOLOCK) WHERE @EmployeeRoleID = TB_ML_Employee_Roles.EmployeeRoleID)
BEGIN
	SET @ErrorDesc = ' El cargo seleccionado no existe'
	RETURN -2
END	
IF(ISNULL(@EmployeePhoneStr,'') = '')
BEGIN	
	SET @ErrorDesc = 'Debe de utilizar al menos un teléfono'
	RETURN -3
END
IF (DATEDIFF(year,CONVERT(DATE,@EmployeeBirthDate,101),GETDATE()) < 18)
BEGIN	
	SET @ErrorDesc = 'El empleado es menor de edad (18 años)'
	RETURN -4
END

IF EXISTS(SELECT TOP 1 1 FROM TB_ML_Employees WITH(NOLOCK) WHERE TB_ML_Employees.EmployeeDNI = @EmployeeDNI AND TB_ML_Employees.EmployeeID <> @EmployeeID)
BEGIN	
	SET @ErrorDesc = 'El DNI ya existe'
	RETURN -5
END

IF @TRANCOUNT = 0 
BEGIN TRANSACTION


	DELETE TB_ML_Employee_Phones
	WHERE TB_ML_Employee_Phones.EmployeeID = @EmployeeID

	INSERT INTO TB_ML_Employee_Phones(
								  EmployeeID,
								  EmployeePhone
								 ) 
	SELECT @EmployeeID,
	    item 
	FROM	FN_convertCommaSeparatedListToSingleColumn(@EmployeePhoneStr)

	UPDATE TB_ML_Employees WITH(ROWLOCK)

	SET			EmployeeName = @EmployeeName,
				EmployeeLastName = @EmployeeLastName,
				EmployeeDNI = @EmployeeDNI,
				EmployeeRoleID = @EmployeeRoleID,
				EmployeeSalary =  @EmployeeSalary,
				EmployeeAddress = @EmployeeAddress,
				EmployeeBirthDate = @EmployeeBirthDate,
				EmployeeeMail = @EmployeeeMail

	WHERE EmployeeID = @EmployeeID

	IF @TRANCOUNT = 0 AND @EmployeeDelete = 1
	BEGIN
	EXEC @RC = SP_ML_Employees_Delete @EmployeeID,@Errordesc OUT
	END 
	IF @TRANCOUNT = 0
	
	COMMIT TRANSACTION;
		RETURN 1
		
END TRY
BEGIN CATCH
	
	IF @TRANCOUNT = 0
	ROLLBACK TRANSACTION
	PRINT ERROR_LINE() 
    PRINT ERROR_MESSAGE() 
	SET @ErrorDesc = 'No se pudo editar al empleado correctamente, intente de nuevo mas tarde'
	RETURN -1

END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_ML_Employees_Roles_Reports]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_ML_Employees_Roles_Reports]
@ERRORDESC VARCHAR(500) OUT
AS

SELECT * 
	FROM
		VW_ML_Employees
	ORDER BY EmployeeRoleID
GO
/****** Object:  StoredProcedure [dbo].[SP_ML_Employees_Salary_Report]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_ML_Employees_Salary_Report]

AS
BEGIN TRY
	BEGIN TRANSACTION

	SELECT EmployeeRoleID,
		EmployeeRoleName,
		SUM(Salary) as Salary,
		AVG(Salary) as AvgSalary,
		MAX(Salary) as MaxSalary

FROM VW_ML_Employees

GROUP BY EmployeeRoleID,
		 EmployeeRoleName
		 COMMIT TRANSACTION
		 RETURN 1
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
RETURN -1
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_ML_Employees_Search]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[SP_ML_Employees_Search] @Filter VARCHAR(30)
AS

SET @Filter = LTRIM(RTRIM(@Filter))
SELECT * FROM VW_ML_Employees WITH(NOLOCK)
WHERE	EmployeeName LIKE CONCAT('%', @Filter ,'%') 
		OR EmployeeLastName LIKE CONCAT('%', @Filter ,'%') 
		OR EmployeeRoleName LIKE CONCAT('%', @Filter ,'%')  
		OR EmployeeDNI LIKE CONCAT('%', @Filter ,'%') 
		OR EmployeeSalary LIKE CONCAT('%', @Filter ,'%') 
RETURN 1

GO
/****** Object:  StoredProcedure [dbo].[SP_MS_Employees_Add]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROC [dbo].[SP_MS_Employees_Add]
	@E_Name VARCHAR(15),
	@E_LastName VARCHAR(30),
	@E_DNI INT,
	@E_RoleID INT,
	@E_Address VARCHAR(100),
	@E_Birthdate VARCHAR(10),
	@E_Email VARCHAR(61),
	@E_Salary MONEY,
	@EmployeePhoneStr VARCHAR(MAX),
	@EmployeeID INT OUT,
	@ErrorDesc nVARCHAR(500) OUT
AS
	BEGIN TRY

			IF EXISTS (SELECT TOP 1 1 FROM TB_MS_Employees WITH(NOLOCK) WHERE EmployeeDNI = @E_DNI)
				BEGIN
					SET @ErrorDesc = 'El número de DNI ingresado ya corresponde a un empleado'
					RETURN -1
				END

			IF NOT EXISTS (SELECT TOP 1 1 FROM TB_MS_Employee_Roles WITH(NOLOCK) WHERE EmployeeRoleID = @E_RoleID)
				BEGIN
					SET @ErrorDesc = 'El cargo especificado no existe'
					RETURN -2
				END

			IF DATEDIFF(YEAR,CONVERT(DATE,@E_Birthdate),GETDATE()) < 18
				BEGIN
					
					SET @ErrorDesc = 'La fecha ingresada no es válida'
					print 'hola'

					RETURN -3
					print 'hola'
				END

			IF @E_Salary < = 0
				BEGIN
					SET @ErrorDesc = 'Ingrese un sueldo válido'
					RETURN -4
				END


			IF ISNULL(@EmployeePhoneStr,'') = ''
				BEGIN
					SET @ErrorDesc = 'Usted debe ingresar un télefono como mínimo'
					RETURN -5
				END

			

	BEGIN TRANSACTION

			INSERT INTO TB_MS_Employees(EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmployeeAddress,EmployeeBirthdate,EmployeeSalary,EmployeeEmail)
			VALUES(@E_Name,@E_LastName,@E_DNI,@E_RoleID,@E_Address,@E_Birthdate,@E_Salary,@E_Email)

			SET @EmployeeID = SCOPE_IDENTITY()

			INSERT INTO TB_MS_Employee_Phones
			SELECT @EmployeeID,Item 
			FROM FN_convertCommaSeparatedListToSingleColumn(@EmployeePhoneStr)

			COMMIT TRANSACTION
			RETURN 1
	END TRY
	
	BEGIN CATCH 
		PRINT ERROR_LINE()
		PRINT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
		SET @ErrorDesc = 'Se ha producido un error crítico' 
		RETURN -1
	END CATCH



GO
/****** Object:  StoredProcedure [dbo].[SP_MS_Employees_Delete]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROC [dbo].[SP_MS_Employees_Delete]
	@ID_Employee INT,
	@ErrorDesc VARCHAR(500) OUT
AS
	DECLARE	@Trancount INT = 0
	SET @Trancount = @@TRANCOUNT

	SET NOCOUNT ON
	BEGIN TRY	
		
			IF NOT EXISTS (SELECT TOP 1 1 FROM TB_MS_Employees WHERE EmployeeID = @ID_Employee)	
				BEGIN
					SET @ErrorDesc = 'El empleado que desea eliminar no existe'
					RETURN -1
				END

			IF EXISTS(SELECT TOP 1 1 FROM TB_MS_Employee_Phones WHERE EmployeeID = @ID_Employee)
				BEGIN
					DELETE FROM TB_MS_Employee_Phones
					WHERE EmployeeID = @ID_Employee
				END

	IF @Trancount = 0
	BEGIN TRANSACTION

			DELETE FROM TB_MS_Employees
			WHERE EmployeeID = @ID_Employee

	IF @Trancount = 0
			COMMIT TRANSACTION
			RETURN 1
	END TRY
	
	BEGIN CATCH 
		PRINT ERROR_LINE()
		PRINT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
		SET @ErrorDesc = 'Se ha producido un error crítico' 
		RETURN -1
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_MS_Employees_Edit]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE PROC [dbo].[SP_MS_Employees_Edit]
	@E_Name VARCHAR(15),
	@E_LastName VARCHAR(30),
	@E_DNI INT,
	@E_RoleID INT,
	@E_Address VARCHAR(100),
	@E_Birthdate VARCHAR(10),
	@E_Email VARCHAR(61),
	@E_Salary MONEY,
	@EmployeePhoneStr VARCHAR(MAX),
	@EmployeeID INT,
	@ErrorDesc VARCHAR(500) OUT,
	@Delete BIT
AS
	DECLARE	@Trancount INT = 0
	SET @Trancount = @@TRANCOUNT
	SET NOCOUNT ON

	BEGIN TRY
	
			IF EXISTS (SELECT TOP 1 1 FROM TB_MS_Employees WITH(NOLOCK) WHERE EmployeeDNI = @E_DNI AND EmployeeID <> @EmployeeID)
				BEGIN
					SET @ErrorDesc = 'El número de DNI ingresado ya corresponde a un empleado'
					RETURN -1
				END

			IF NOT EXISTS (SELECT TOP 1 1 FROM TB_MS_Employees WITH(NOLOCK) WHERE EmployeeRoleID = @E_RoleID)
				BEGIN
					SET @ErrorDesc = 'El cargo especificado no existe'
					RETURN -2
				END

			IF DATEDIFF(YEAR,CONVERT(DATE,@E_Birthdate),GETDATE()) < 18
				BEGIN
					SET @ErrorDesc = 'La fecha ingresada no es válida'
					RETURN -3
				END

			IF @E_Salary < = 0
				BEGIN
					SET @ErrorDesc = 'Ingrese un sueldo válido'
					RETURN -4
				END

			IF ISNULL(@EmployeePhoneStr,'') = ''
				BEGIN
					SET @ErrorDesc = 'Usted debe ingresar un télefono como mínimo'
					RETURN -5
				END

	IF @Trancount = 0

	BEGIN TRANSACTION

			UPDATE TB_MS_Employees WITH(ROWLOCK)
				SET
					EmployeeName = @E_Name,
					EmployeeLastName = @E_LastName,
					EmployeeDNI = @E_DNI,
					EmployeeRoleID = @E_RoleID,
					EmployeeAddress = @E_Address,
					EmployeeBirthdate = @E_Birthdate,
					EmployeeSalary = @E_Salary,
					EmployeeEmail = @E_Email
			WHERE
				EmployeeID = @EmployeeID

			DELETE TB_MS_Employee_Phones WHERE EmployeeID = @EmployeeID

			INSERT INTO TB_MS_Employee_Phones
			SELECT @EmployeeID,Item 
			FROM FN_convertCommaSeparatedListToSingleColumn(@EmployeePhoneStr)

			IF @Delete = 1
				BEGIN 
					DECLARE @RC INT
					EXEC @RC = SP_MS_Employees_Delete

					@ID_Employee = @EmployeeID,
					@ErrorDesc = @ErrorDesc OUT
			END

			IF @RC <> 1
				BEGIN 
					IF @Trancount = 0
						ROLLBACK TRANSACTION
					RETURN -1
				END

			IF @Trancount = 0
			COMMIT  TRANSACTION
			RETURN 1
	END TRY

	BEGIN CATCH 
		PRINT ERROR_LINE()
		PRINT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
		SET @ErrorDesc = 'Se ha producido un error crítico' 
		RETURN -1
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_MS_Employees_RolesReport]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_MS_Employees_RolesReport]
@ErrorDesc VARCHAR(500) OUT

AS

SET NOCOUNT ON

BEGIN TRY

	BEGIN TRANSACTION

		SELECT *

		FROM VW_MS_Employees 

		ORDER BY EmployeeRoleID
	
	COMMIT TRANSACTION 
	RETURN 1
END TRY

BEGIN CATCH 
		PRINT ERROR_LINE()
		PRINT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
		SET @ErrorDesc = 'Se ha producido un error crítico' 
		RETURN -1
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_MS_Employees_SalaryReport]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_MS_Employees_SalaryReport] 

@ErrorDesc VARCHAR(500) OUT

AS

SET NOCOUNT ON

BEGIN TRY 

	BEGIN TRANSACTION

		SELECT 
			EmployeeRoleID,
			EmployeeRoleName,
			SUM(EmployeeSalary) AS Total,
			AVG(EmployeeSalary) AS Promedio,
			MAX(EmployeeSalary) AS Máximo

			FROM VW_MS_Employees 

			GROUP BY EmployeeRoleID,EmployeeRoleName

	COMMIT TRANSACTION 
	RETURN 1

END TRY

BEGIN CATCH 
		PRINT ERROR_LINE()
		PRINT ERROR_MESSAGE()
		ROLLBACK TRANSACTION
		SET @ErrorDesc = 'Se ha producido un error crítico' 
		RETURN -1
END CATCH
	
GO
/****** Object:  StoredProcedure [dbo].[SP_MS_Employees_Search]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[SP_MS_Employees_Search]
	@filter VARCHAR(30)
AS
	SET @filter = LTRIM(RTRIM(@filter))

	SELECT * FROM VW_MS_Employees WITH(NOLOCK)
		WHERE
			EmployeeRoleName like CONCAT('%',@filter,'%')
			or
			EmployeeName like CONCAT('%',@filter,'%')
			or
			EmployeeLastName like CONCAT('%',@filter,'%')
	RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[SP1]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP1]
@param1 int
	
AS

declare @trancount int = 0
set @trancount = @@TRANCOUNT

print concat('SP1 -> @trancount: ', @trancount)

SET NOCOUNT ON
BEGIN TRY
	/*
	Bloque de validaciones
	*/
	IF @trancount = 0
		BEGIN TRANSACTION
		
	print concat('SP1 -> @trancount: ', @trancount)

	--Hago todo lo que tenga que hacer
	declare @parametro_para_sp2 int	 = 10

	DECLARE @RC INT
	EXEC @RC = SP2  @parametro_para_sp2
	
	print concat('SP1 -> @RC: ', @RC)
	if @RC <> 1
	begin
		IF @trancount = 0
			rollback tran
		RETURN -1		
	end	


	IF @trancount = 0
		COMMIT TRANSACTION

	return 1
end	TRY
begin catch
	print	'catch'
end catch
GO
/****** Object:  StoredProcedure [dbo].[SP2]    Script Date: 29/11/2018 09:54:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP2]
@param1 int
	
AS

declare @trancount int = 0
set @trancount = @@TRANCOUNT

print concat('SP2 -> @trancount: ', @trancount)

SET NOCOUNT ON
BEGIN TRY
	/*
	Bloque de validaciones
	*/
	IF @trancount = 0
		BEGIN TRANSACTION

	
	print concat('SP2 -> @trancount: ', @trancount)

	--Hago todo lo que tenga que hacer

		IF @param1 <> 5
		BEGIN
			IF @trancount = 0
				rollback tran
			RETURN -1
		END

	
	IF @trancount = 0
		COMMIT TRANSACTION

	return 1
end	TRY
begin catch
	print	'catch'
end catch
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "E"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "R"
            Begin Extent = 
               Top = 6
               Left = 270
               Bottom = 102
               Right = 466
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "P"
            Begin Extent = 
               Top = 102
               Left = 270
               Bottom = 198
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2085
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_ML_Employees'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_ML_Employees'
GO
USE [master]
GO
ALTER DATABASE [Pasantia] SET  READ_WRITE 
GO
