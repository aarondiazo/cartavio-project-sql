-- Pre-entrega 2: Tablas principales con restricciones y datos iniciales
-- Alumno: Aaron Diaz Olivares

-- PASO 1: Data Definition Language (DDL)

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
    stock INTEGER NOT NULL,
    CONSTRAINT chk_precio_positivo CHECK (precio > 0),
    CONSTRAINT chk_stock_no_negativo CHECK (stock >= 0)
);

CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES clientes(id_cliente),
    id_producto INTEGER NOT NULL REFERENCES productos(id_producto),
    fecha_venta DATE NOT NULL,
    cantidad INTEGER NOT NULL,
    CONSTRAINT chk_cantidad_positiva CHECK (cantidad > 0)
);

-- PASO 2: Data Manipulation Language (DML)
-- Carga inicial segura dentro de una transacción explícita

BEGIN;

INSERT INTO clientes (nombre_cliente, email) VALUES
    ('Maclabis', 'admin@maclabis.com'),
    ('Backus', 'admin@backus.com'),
    ('Mary e hijos', 'admin@maryehijos.com'),
    ('Strategio', 'admin@strategio.com'),
    ('Tambo+', 'admin@tambo.com');

INSERT INTO productos (nombre_producto, precio, stock) VALUES
    ('Cartavio Black', 10.00, 10000),
    ('Cartavio Blanco', 10.00, 10000),
    ('Cartavio Superior', 15.00, 10000),
    ('Cartavio Mango', 12.50, 10000),
    ('Cartavio Coco', 12.50, 10000),
    ('producto de prueba', 1.00, 1);

INSERT INTO ventas (id_cliente, id_producto, fecha_venta, cantidad) VALUES
    (1, 1, '2026-10-18', 10),
    (2, 2, '2026-10-18', 10),
    (3, 3, '2026-10-18', 10),
    (4, 4, '2026-10-18', 10),
    (5, 5, '2026-10-18', 10);

COMMIT;

-- PASO 3: Mantenimiento de datos

-- 3.1 Actualización masiva de precios por inflación (10%) para productos mayores a 10.00
UPDATE productos
SET precio = precio * 1.10
WHERE precio > 10.00;

-- 3.2 Eliminación controlada del registro de prueba
DELETE FROM productos 
WHERE nombre_producto = 'producto de prueba';
