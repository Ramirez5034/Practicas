USE master;
GO
IF DB_ID(N'Tienda')IS NOT NULL
DROP DATABASE Tienda;
GO
CREATE DATABASE Tienda
ON
(NAME = Tienda_dat,
FILENAME= 'C:\BaseDatos\Tienda.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
LOG ON 
(NAME =Tienda_log,
FILENAME = 'C:\BaseDatos\Tienda.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB);
GO
USE Tienda;
GO
CREATE TABLE Sucursal
(
idSucursal INT identity (1,1),
numero INT NOT NULL,
telefono VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Proveedor
(
idProveedor INT identity (1,1),
nombre VARCHAR (50) NOT NULL,
telefono VARCHAR (50) NOT NULL,
idRepresentante INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Representante
(
idRepresentante INT identity (1,1),
nombre VARCHAR (50) NOT NULL,
apellidopaterno VARCHAR (50) NOT NULL,
apellidomaterno VARCHAR (50) NOT NULL,
telefono VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Empleado
(
idEmpleado INT identity (1,1),
nombre VARCHAR (50) NOT NULL,
apellidopaterno VARCHAR (50) NOT NULL,
apellidomaterno VARCHAR (50) NOT NULL,
telefono VARCHAR (50) NOT NULL,
idSucursal INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Contrato
(
idContrato INT identity (1,1),
numero VARCHAR (50) NOT NULL,
tipo VARCHAR (50) NOT NULL,
idEmpleado INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Reparacion
(
idReparacion INT identity (1,1),
numero VARCHAR (50) NOT NULL,
articulo VARCHAR (50) NOT NULL,
idEmpleado INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Cliente
(
idCliente INT identity (1,1),
nombre VARCHAR (50) NOT NULL,
apellidopaterno VARCHAR (50) NOT NULL,
apellidomaterno VARCHAR (50) NOT NULL,
telefono VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Compra
(
idCompra INT identity (1,1),
numero VARCHAR (50) NOT NULL,
metodopago VARCHAR (50) NOT NULL,
idCliente INT NOT NULL,
idTicket INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Ticket
(
idTicket INT identity (1,1),
numero INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE Mercancia
(
idMercancia INT identity (1,1),
numero INT NOT NULL,
tipo VARCHAR (50) NOT NULL,
precio VARCHAR (50) NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE SucursalProveedor
(
idSucursalProveedor INT identity (1,1),
idSucursal INT NOT NULL,
idProveedor INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE TABLE SucursalCliente
(
idSucursalCliente INT identity (1,1),
idSucursal INT NOT NULL,
idCliente INT NOT NULL,
estatus BIT DEFAULT 1 NOT NULL
);
GO
CREATE INDEX IX_Sucursal ON Sucursal(idSucursal);
GO
CREATE INDEX IX_Proveedor ON Proveedor(idProveedor);
GO
CREATE INDEX IX_Representante ON Representante(idRepresentante);
GO
CREATE INDEX IX_Empleado ON Empleado(idEmpleado);
GO
CREATE INDEX IX_Contrato ON Contrato(idContrato);
GO
CREATE INDEX IX_Reparacion ON Reparacion(idReparacion);
GO
CREATE INDEX IX_Cliente ON Cliente(idCliente);
GO
CREATE INDEX IX_Compra ON Compra(idCompra);
GO
CREATE INDEX IX_Ticket ON Ticket(idTicket);
GO
CREATE INDEX IX_Mercancia ON Mercancia(idMercancia);
GO
CREATE INDEX IX_SucursalProveedor ON SucursalProveedor (idSucursalProveedor);
GO
CREATE INDEX IX_SucursalCliente ON SucursalCliente(idSucursalCliente);
GO
ALTER TABLE Sucursal ADD CONSTRAINT PK_Sucursal PRIMARY KEY (idSucursal)
ALTER TABLE Proveedor ADD CONSTRAINT PK_Proveedor PRIMARY KEY (idProveedor)
ALTER TABLE Representante ADD CONSTRAINT PK_Representante PRIMARY KEY (idRepresentante)
ALTER TABLE Empleado ADD CONSTRAINT PK_Empleado PRIMARY KEY (idEmpleado)
ALTER TABLE Contrato ADD CONSTRAINT PK_Contrato PRIMARY KEY (idContrato)
ALTER TABLE Reparacion ADD CONSTRAINT PK_Reparacion PRIMARY KEY (idReparacion)
ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente PRIMARY KEY (idCliente)
ALTER TABLE Compra ADD CONSTRAINT PK_Compra PRIMARY KEY (idCompra)
ALTER TABLE Ticket ADD CONSTRAINT PK_Ticket PRIMARY KEY (idTicket)
ALTER TABLE Mercancia ADD CONSTRAINT PK_Mercancia PRIMARY KEY (idMercancia)
ALTER TABLE SucursalProveedor ADD CONSTRAINT PK_SucursalProveedor PRIMARY KEY (idSucursalProveedor)
ALTER TABLE SucursalCliente ADD CONSTRAINT PK_SucursalCliente PRIMARY KEY (idSucursalCliente)

ALTER TABLE Proveedor ADD CONSTRAINT FK_ProveedorRepresentante
FOREIGN  KEY(idRepresentante) REFERENCES Representante(idRepresentante)
GO
ALTER TABLE Empleado ADD CONSTRAINT FK_EmpleadoSucursal
FOREIGN  KEY(idSucursal) REFERENCES Sucursal(idSucursal)
GO
ALTER TABLE Contrato ADD CONSTRAINT FK_ContratoEmpleado
FOREIGN  KEY(idEmpleado) REFERENCES Empleado(idEmpleado)
GO
ALTER TABLE Reparacion ADD CONSTRAINT FK_ReparacionEmpleado
FOREIGN  KEY(idEmpleado) REFERENCES Empleado(idEmpleado)
GO
ALTER TABLE Compra ADD CONSTRAINT FK_CompraCliente
FOREIGN  KEY(idCliente) REFERENCES Cliente(idCliente)
GO
ALTER TABLE Compra ADD CONSTRAINT FK_CompraTciket
FOREIGN  KEY(idTicket) REFERENCES Ticket(idTicket)
GO
ALTER TABLE SucursalProveedor ADD CONSTRAINT FK_SucursalProveedorSucursal
FOREIGN  KEY(idSucursal) REFERENCES Sucursal(idSucursal)
GO
ALTER TABLE SucursalProveedor ADD CONSTRAINT FK_SucursalProveedorProveedor
FOREIGN  KEY(idProveedor) REFERENCES Proveedor(idProveedor)
GO
ALTER TABLE SucursalCliente ADD CONSTRAINT FK_SucursalClienteSucursal
FOREIGN  KEY(idSucursal) REFERENCES Sucursal(idSucursal)
GO
ALTER TABLE SucursalCliente ADD CONSTRAINT FK_SucursalClienteCliente
FOREIGN  KEY(idCliente) REFERENCES Cliente(idCliente)
GO