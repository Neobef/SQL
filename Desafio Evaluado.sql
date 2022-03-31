-- 1) Cargar el respaldo de la base de datos unidad2.sql
-- \set AUTOCOMMIT off
CREATE DATABASE unidad2;

-- psql -U postgres unidad2 < unidad2.sql
-- 2. El cliente usuario01 ha realizado la siguiente compra:
-- ● producto: producto9.
-- ● cantidad: 5.
-- ● fecha: fecha del sistema
-- Se realiza una consulta para conocer datos relevantes de las compras que ha hecho el cliente 'usuario01' en el producto 'producto9'.
SELECT
    cliente.nombre AS nombre_cliente,
    producto.descripcion,
    detalle_compra.cantidad AS cantidad_comprada,
    producto.stock AS cantidad_en_stock,
    compra.fecha AS fecha_compra
FROM
    cliente
    INNER JOIN compra ON cliente.id = compra.cliente_id
    INNER JOIN detalle_compra ON compra.id = detalle_compra.compra_id
    INNER JOIN producto ON detalle_compra.producto_id = producto.id
WHERE
    cliente.nombre = 'usuario01'
    AND detalle_compra.producto_id = 9
    AND producto.descripcion = 'producto9';

-- Transacción pedida:
BEGIN TRANSACTION;

INSERT INTO
    compra (id, cliente_id, fecha)
VALUES
    (33, 1, '2021-12-09') RETURNING *;

INSERT INTO
    detalle_compra (id, producto_id, compra_id, cantidad)
VALUES
    (43, 9, 33, 5) RETURNING *;

UPDATE
    producto
SET
    stock = stock - 5
WHERE
    producto.id = 9
    AND producto.descripcion = 'producto9' RETURNING *;

END TRANSACTION;

-- 3. El cliente usuario02 ha realizado la siguiente compra:
-- ● producto: producto1, producto 2, producto 8.
-- ● cantidad: 3 de cada producto.
-- ● fecha: fecha del sistema.
-- Se realiza una consulta para conocer las compras del cliente 'usuario02' en los productos seleccionados y ver el stock.
SELECT
    cliente.nombre AS nombre_cliente,
    producto.descripcion,
    detalle_compra.cantidad AS cantidad_comprada,
    producto.stock AS cantidad_en_stock,
    compra.fecha AS fecha_compra
FROM
    cliente
    INNER JOIN compra ON cliente.id = compra.cliente_id
    INNER JOIN detalle_compra ON compra.id = detalle_compra.compra_id
    INNER JOIN producto ON detalle_compra.producto_id = producto.id
WHERE
    cliente.nombre = 'usuario02'
    AND detalle_compra.producto_id IN(1, 2, 8)
    AND producto.descripcion IN('producto1', 'producto2', 'producto8');

-- Transacción pedida:
BEGIN TRANSACTION;

INSERT INTO
    compra (id, cliente_id, fecha)
VALUES
    (34, 2, '2021-12-09') RETURNING *;

INSERT INTO
    detalle_compra (id, producto_id, compra_id, cantidad)
VALUES
    (44, 1, 34, 3) RETURNING *;

UPDATE
    producto
SET
    stock = stock - 3
WHERE
    producto.id = 1
    AND producto.descripcion = 'producto1' RETURNING *;

INSERT INTO
    detalle_compra (id, producto_id, compra_id, cantidad)
VALUES
    (45, 2, 34, 3) RETURNING *;

UPDATE
    producto
SET
    stock = stock - 3
WHERE
    producto.id = 2
    AND producto.descripcion = 'producto2' RETURNING *;

SAVEPOINT checkpoint;

INSERT INTO
    detalle_compra (id, producto_id, compra_id, cantidad)
VALUES
    (46, 8, 34, 3) RETURNING *;

UPDATE
    producto
SET
    stock = stock - 3
WHERE
    producto.id = 8
    AND producto.descripcion = 'producto8' RETURNING *;

ROLLBACK TO checkpoint;

END TRANSACTION;

-- 4. Realizar las siguientes consultas 

-- a. Deshabilitar el AUTOCOMMIT.
-- \set AUTOCOMMIT off

-- b. Insertar un nuevo cliente.
BEGIN TRANSACTION;

SAVEPOINT nuevo_cliente;

INSERT INTO
    cliente(id, nombre, email)
VALUES
    (11, 'usuario011', 'usuario011@hotmail.com');

-- c. Confirmar que fue agregado en la tabla cliente.
SELECT
    *
FROM
    cliente
ORDER BY
    cliente.id ASC;

-- d. Realizar un ROLLBACK.
ROLLBACK TO nuevo_cliente;

-- e. Confirmar que se restauró la información, sin considerar la inserción del punto b.
SELECT
    *
FROM
    cliente
ORDER BY
    cliente.id ASC;

END TRANSACTION;

-- f. Habilitar de nuevo el AUTOCOMMIT.
-- \set AUTOCOMMIT on