
CREATE TABLE Rol (
  ID_Rol INT PRIMARY KEY,
  Nombre_Rol VARCHAR
);

CREATE TABLE Empleado (
  ID_Empleado INT PRIMARY KEY,
  Rol INT REFERENCES Rol(ID_Rol),
  Primer_Nombre VARCHAR,
  Segundo_Nombre VARCHAR,
  Primer_Apellido VARCHAR,
  Segundo_Apellido VARCHAR,
  Tipo_Identificacion VARCHAR,
  Numero_Identificacion VARCHAR,
  Correo VARCHAR
);

CREATE TABLE Metodo (
  ID_Opcion INT PRIMARY KEY,
  Nombre_Metodo VARCHAR
);

CREATE TABLE MetodosPorRol (
  ID_Rol INT REFERENCES Rol(ID_Rol),
  ID_Opcion INT REFERENCES Metodo(ID_Opcion),
  PRIMARY KEY (ID_Rol, ID_Opcion)
);

CREATE TABLE Cliente (
  ID_Cliente INT PRIMARY KEY,
  Tipo_Identificacion VARCHAR,
  Numero_Identificacion VARCHAR,
  Direccion VARCHAR,
  Telefono VARCHAR,
  Medio_Pago_Preferido VARCHAR,
  Correo VARCHAR
);

CREATE TABLE CategoriaProducto (
  Categoria_id INT PRIMARY KEY,
  Nombre VARCHAR
);

CREATE TABLE Producto (
  ID_Producto INT PRIMARY KEY,
  Nombre VARCHAR,
  Categoria INT REFERENCES CategoriaProducto(Categoria_id),
  Precio DECIMAL,
  Referencia VARCHAR
);

CREATE TABLE EstadosPedido (
  ID_Estado INT PRIMARY KEY,
  Estado VARCHAR,
  Observaciones VARCHAR
);

CREATE TABLE DireccionEntrega (
  ID_Direccion_entrega INT PRIMARY KEY,
  Codigo_DANE VARCHAR,
  Coordenadas_geograficas VARCHAR,
  Direccion VARCHAR,
  Datos_adicionales VARCHAR,
  Ciudad VARCHAR,
  Barrio VARCHAR
);

CREATE TABLE Pedido (
  ID_Pedido INT PRIMARY KEY,
  Medio_Pago VARCHAR,
  No_Pedido VARCHAR,
  Datos_Cliente VARCHAR,
  Fecha DATE,
  Valor DECIMAL,
  Estado INT REFERENCES EstadosPedido(ID_Estado),
  Comision_domiciliario DECIMAL,
  ID_Cliente INT REFERENCES Cliente(ID_Cliente),
  ID_Direccion_entrega INT REFERENCES DireccionEntrega(ID_Direccion_entrega)
);

CREATE TABLE ProductosPorPedido (
  ID_Pedido INT REFERENCES Pedido(ID_Pedido),
  ID_Producto INT REFERENCES Producto(ID_Producto),
  Valor DECIMAL,
  Cantidad INT,
  PRIMARY KEY (ID_Pedido, ID_Producto)
);

CREATE TABLE Domiciliario (
  ID_Domiciliario INT PRIMARY KEY,
  Tipo_Identificacion VARCHAR,
  Identificacion VARCHAR,
  Nombre VARCHAR,
  Cedula VARCHAR,
  Direccion VARCHAR,
  Viajes INT,
  Calificacion INT
);

ALTER TABLE Pedido ADD COLUMN ID_Domiciliario INT REFERENCES Domiciliario(ID_Domiciliario);

CREATE TABLE Tienda (
  ID_Tienda INT PRIMARY KEY,
  Nombre VARCHAR,
  Ubicacion VARCHAR,
  Ciudad VARCHAR,
  Codigo VARCHAR
);

CREATE TABLE Proveedor (
  ID_Proveedor INT PRIMARY KEY,
  Tipo_Identificacion VARCHAR,
  Numero_Identificacion VARCHAR,
  Nombre VARCHAR,
  Categoria VARCHAR,
  Actividad_economica VARCHAR,
  Direccion_principal VARCHAR,
  Ciudad VARCHAR
);

CREATE TABLE ProductosPorTienda_Inventario (
  ID_Tienda INT REFERENCES Tienda(ID_Tienda),
  ID_Producto INT REFERENCES Producto(ID_Producto),
  Cantidad INT,
  ID_Proveedor INT REFERENCES Proveedor(ID_Proveedor),
  PRIMARY KEY (ID_Tienda, ID_Producto)
);

CREATE TABLE MetodoPago (
  ID_MetodoPago INT PRIMARY KEY,
  ID_Cliente INT REFERENCES Cliente(ID_Cliente),
  Nombre VARCHAR,
  Tipo VARCHAR,
  Estado VARCHAR,
  Datos_pago VARCHAR
);

CREATE TABLE Factura (
  ID_Factura INT PRIMARY KEY,
  ID_Pedido INT REFERENCES Pedido(ID_Pedido),
  ID_MetodoPago INT REFERENCES MetodoPago(ID_MetodoPago),
  Monto DECIMAL
);
