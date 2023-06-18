SELECT * FROM cliente;
SELECT * FROM detalle_pedido;
SELECT * FROM empleado;
SELECT * FROM gama_producto;
SELECT * FROM oficina;
SELECT * FROM pago;
SELECT * FROM pedido;
SELECT * FROM producto;

SELECT codigo_oficina, ciudad FROM oficina;
SELECT ciudad, telefono FROM oficina WHERE pais = 'españa';
SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = 7;
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_empleado = 1;
SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto != 'representante ventas';
SELECT nombre_cliente FROM cliente WHERE pais = 'Spain';
SELECT estado FROM pedido GROUP BY estado;
SELECT DISTINCT codigo_cliente FROM pago WHERE fecha_pago LIKE '2008%';
SELECT DISTINCT codigo_cliente FROM pago WHERE YEAR(fecha_pago) = 2008;
SELECT DISTINCT codigo_cliente FROM pago WHERE DATE_FORMAT(fecha_pago, '%Y') = 2008;
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega > fecha_esperada;
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE ADDDATE(fecha_entrega, 2) <= fecha_esperada;
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
SELECT * FROM pedido WHERE YEAR(fecha_pedido) = 2009 AND estado = 'rechazado';
SELECT * FROM pedido WHERE MONTH(fecha_entrega) = 1 AND estado = 'entregado';
SELECT * FROM pago WHERE YEAR(fecha_pago) = 2008 AND forma_pago = 'PayPal' ORDER BY total DESC;
SELECT DISTINCT forma_pago FROM pago;
SELECT * FROM producto WHERE gama = 'ornamentales' AND cantidad_en_stock >= 100 ORDER BY precio_proveedor DESC;
SELECT * FROM cliente WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11, 30);

SELECT a.nombre_cliente, b.nombre, b.apellido1, b.apellido2 FROM cliente a INNER JOIN empleado b ON a.codigo_empleado_rep_ventas = b.codigo_empleado;
SELECT b.nombre_cliente, c.nombre as nombre_rep_ventas, c.apellido1, c.apellido2 FROM pago a INNER JOIN cliente b ON a.codigo_cliente = b.codigo_cliente INNER JOIN empleado c ON b.codigo_empleado_rep_ventas = c.codigo_empleado GROUP BY a.codigo_cliente;
SELECT a.nombre_cliente, b.nombre as nombre_rep_ventas, b.apellido1, b.apellido2 FROM cliente a INNER JOIN empleado b ON a.codigo_empleado_rep_ventas = b.codigo_empleado WHERE NOT EXISTS(SELECT codigo_cliente FROM pago c WHERE a.codigo_cliente = c.codigo_cliente);
SELECT b.nombre_cliente, c.nombre as nombre_rep_ventas, c.apellido1, c.apellido2, d.ciudad as ciudad_oficina FROM pago a INNER JOIN cliente b ON a.codigo_cliente = b.codigo_cliente INNER JOIN empleado c ON b.codigo_empleado_rep_ventas = c.codigo_empleado INNER JOIN oficina d ON c.codigo_oficina = d.codigo_oficina GROUP BY a.codigo_cliente;
SELECT a.nombre_cliente, b.nombre as nombre_rep_ventas, b.apellido1, b.apellido2, d.ciudad FROM cliente a INNER JOIN empleado b ON a.codigo_empleado_rep_ventas = b.codigo_empleado INNER JOIN oficina d ON b.codigo_oficina = d.codigo_oficina WHERE NOT EXISTS(SELECT codigo_cliente FROM pago c WHERE a.codigo_cliente = c.codigo_cliente);

SELECT c.linea_direccion1, c.linea_direccion2 from cliente a INNER JOIN empleado b ON a.codigo_empleado_rep_ventas = b.codigo_empleado INNER JOIN oficina c ON b.codigo_oficina = c.codigo_oficina WHERE a.ciudad = 'fuenlabrada';
SELECT a.nombre_cliente, b.nombre as nombre_rep_ventas, b.apellido1, b.apellido2, c.ciudad as ciudad_oficina FROM cliente a INNER JOIN empleado b ON a.codigo_empleado_rep_ventas = b.codigo_empleado INNER JOIN oficina c ON b.codigo_oficina = c.codigo_oficina;
SELECT a.codigo_empleado, a.nombre as nombre_empleado, a.apellido1 as apellido1_empleado, a.apellido2 as apellido2_empleado, a.codigo_jefe, b.nombre as nombre_jefe, b.apellido1 as apellido1_jefe, b.apellido2 as apellido2_jefe FROM empleado a LEFT JOIN empleado b ON a.codigo_jefe = b.codigo_empleado;
SELECT b.nombre_cliente FROM pedido a INNER JOIN cliente b ON a.codigo_cliente = b.codigo_cliente WHERE a.fecha_entrega > a.fecha_esperada GROUP BY a.codigo_cliente;

/* Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente. */
SELECT a.nombre_cliente, d.gama FROM cliente a INNER JOIN pedido b ON a.codigo_cliente = b.codigo_cliente INNER JOIN detalle_pedido c ON b.codigo_pedido = c.codigo_pedido INNER JOIN producto d ON c.codigo_producto = d.codigo_producto GROUP BY a.nombre_cliente, d.gama;

SELECT a.nombre_cliente FROM cliente a LEFT JOIN pago b ON a.codigo_cliente = b.codigo_cliente WHERE b.codigo_cliente IS NULL;
SELECT a.nombre_cliente FROM cliente a LEFT JOIN pago b ON a.codigo_cliente = b.codigo_cliente WHERE NOT EXISTS(SELECT 1 FROM pago c WHERE a.codigo_cliente = c.codigo_cliente);

SELECT a.nombre_cliente FROM cliente a LEFT JOIN pedido b ON a.codigo_cliente = b.codigo_cliente WHERE b.codigo_cliente IS NULL;
SELECT a.nombre_cliente FROM cliente a LEFT JOIN pago b ON a.codigo_cliente = b.codigo_cliente LEFT JOIN pedido c ON a.codigo_cliente = c.codigo_cliente WHERE b.codigo_cliente IS NULL AND c.codigo_cliente IS NULL;
SELECT a.nombre, a.apellido1, a.apellido2, b.pais FROM empleado a LEFT JOIN oficina b ON a.codigo_oficina = b.codigo_oficina WHERE b.codigo_oficina IS NULL;
SELECT b.* FROM cliente a RIGHT JOIN empleado b ON a.codigo_empleado_rep_ventas = b.codigo_empleado WHERE a.codigo_empleado_rep_ventas IS NULL;
SELECT b.* FROM cliente a RIGHT JOIN empleado b ON a.codigo_empleado_rep_ventas = b.codigo_empleado LEFT JOIN oficina c ON b.codigo_oficina = c.codigo_oficina WHERE a.codigo_empleado_rep_ventas IS NULL AND c.codigo_oficina IS NULL;

SELECT b.* FROM detalle_pedido a RIGHT JOIN producto b ON a.codigo_producto = b.codigo_producto WHERE a.codigo_producto IS NULL;

/*Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
representantes de ventas de algún cliente que haya realizado la compra de algún producto
de la gama Frutales.*/
SELECT DISTINCT f.* FROM cliente a LEFT JOIN pedido b ON a.codigo_cliente = b.codigo_cliente LEFT JOIN detalle_pedido c ON b.codigo_pedido = c.codigo_pedido LEFT JOIN producto d ON c.codigo_producto = d.codigo_producto LEFT JOIN empleado e ON a.codigo_empleado_rep_ventas = e.codigo_empleado LEFT JOIN oficina f ON e.codigo_oficina = f.codigo_oficina WHERE d.gama = 'frutales';

SELECT DISTINCT a.* FROM oficina a LEFT JOIN empleado b ON a.codigo_oficina = b.codigo_oficina JOIN cliente c ON b.codigo_empleado = c.codigo_empleado_rep_ventas JOIN pedido d ON c.codigo_cliente = d.codigo_pedido JOIN detalle_pedido e ON d.codigo_pedido = e.codigo_pedido JOIN producto f ON e.codigo_producto = f.codigo_producto WHERE f.gama = 'frutales';

SELECT DISTINCT f.*
FROM oficina f
LEFT JOIN empleado e ON f.codigo_oficina = e.codigo_oficina
WHERE e.codigo_empleado NOT IN (
    SELECT DISTINCT a.codigo_empleado_rep_ventas
    FROM cliente a
    JOIN pedido b ON a.codigo_cliente = b.codigo_cliente
    JOIN detalle_pedido c ON b.codigo_pedido = c.codigo_pedido
    JOIN producto d ON c.codigo_producto = d.codigo_producto
    WHERE d.gama = 'Frutales'
); /* CHAT GPT */

SELECT DISTINCT a.* FROM cliente a RIGHT JOIN pedido b ON a.codigo_cliente = b.codigo_cliente LEFT JOIN pago c ON a.codigo_cliente = c.codigo_cliente WHERE c.codigo_cliente IS NULL;
SELECT b.codigo_empleado, b.nombre as nombre_empleado, b.apellido1 as apellido1_empleado, b.apellido2 as apellido2_empleado, c.nombre as nombre_jefe, c.apellido1 as apellido1_jefe, c.apellido2 as apellido2_jefe FROM cliente a RIGHT JOIN empleado b ON a.codigo_empleado_rep_ventas = b.codigo_empleado LEFT JOIN empleado c ON b.codigo_jefe = c.codigo_empleado WHERE a.codigo_cliente IS NULL;

SELECT COUNT(codigo_empleado) FROM empleado;
SELECT COUNT(codigo_cliente), pais FROM cliente GROUP BY pais;
SELECT AVG(total) FROM pago WHERE YEAR(fecha_pago) = 2009;

SELECT COUNT(b.codigo_pedido) as numero_pedidos, d.region, d.pais FROM cliente a INNER JOIN pedido b ON a.codigo_cliente = b.codigo_cliente INNER JOIN empleado c ON a.codigo_empleado_rep_ventas = c.codigo_empleado INNER JOIN oficina d ON c.codigo_oficina = d.codigo_oficina GROUP BY d.region, d.pais ORDER BY numero_pedidos DESC;
SELECT MAX(precio_venta), MIN(precio_venta) FROM producto;
SELECT COUNT(codigo_cliente), ciudad FROM cliente WHERE ciudad = 'madrid';
SELECT COUNT(codigo_cliente), ciudad FROM cliente WHERE ciudad LIKE 'M%' GROUP BY ciudad;
SELECT a.nombre, a.apellido1, a.apellido2, COUNT(a.codigo_empleado) as cantidad_clientes FROM empleado a INNER JOIN cliente b ON a.codigo_empleado = b.codigo_empleado_rep_ventas GROUP BY nombre, apellido1, apellido2 ORDER BY cantidad_clientes DESC;
SELECT COUNT(a.codigo_cliente) FROM cliente a INNER JOIN empleado b ON a.codigo_empleado_rep_ventas = b.codigo_empleado WHERE puesto != 'representante ventas';
SELECT b.nombre_cliente, b.nombre_contacto, b.apellido_contacto, MIN(a.fecha_pago) AS primer_pago, MAX(a.fecha_pago) AS ultimo_pago FROM pago a INNER JOIN cliente b ON a.codigo_cliente = b.codigo_cliente GROUP BY b.nombre_cliente, b.nombre_contacto, b.apellido_contacto;
SELECT codigo_pedido, COUNT(codigo_producto) FROM detalle_pedido GROUP BY codigo_pedido;
SELECT COUNT(codigo_pedido), codigo_producto FROM detalle_pedido GROUP BY codigo_producto;
SELECT SUM(cantidad) FROM detalle_pedido;
SELECT codigo_producto, SUM(cantidad) as total FROM detalle_pedido GROUP BY codigo_producto ORDER BY total DESC LIMIT 20;
SELECT *, (cantidad * precio_unidad) as base_imponible, (cantidad * precio_unidad * 0.21) as IVA, ((cantidad * precio_unidad) + (cantidad * precio_unidad * 0.21)) as total FROM detalle_pedido;
SELECT codigo_producto, sum(cantidad) as cantidad, precio_unidad, (sum(cantidad) * precio_unidad) as base_imponible, (sum(cantidad) * precio_unidad * 0.21) as IVA, ((sum(cantidad) * precio_unidad) + (sum(cantidad) * precio_unidad * 0.21)) as total FROM detalle_pedido GROUP BY codigo_producto, precio_unidad;
SELECT codigo_producto, sum(cantidad) as cantidad, precio_unidad, (sum(cantidad) * precio_unidad) as base_imponible, (sum(cantidad) * precio_unidad * 0.21) as IVA, ((sum(cantidad) * precio_unidad) + (sum(cantidad) * precio_unidad * 0.21)) as total FROM detalle_pedido WHERE codigo_producto LIKE 'OR%' GROUP BY codigo_producto, precio_unidad;
SELECT b.nombre, sum(a.cantidad) as unidades_vendidas, (sum(a.cantidad) * a.precio_unidad) as total_facturado, ((sum(a.cantidad) * a.precio_unidad) + (sum(a.cantidad) * a.precio_unidad * 0.21)) as total_con_IVA FROM detalle_pedido a INNER JOIN producto b ON a.codigo_producto = b.codigo_producto GROUP BY b.nombre, a.precio_unidad HAVING total_facturado > 3000 ORDER BY total_con_IVA DESC;

SELECT nombre_cliente FROM cliente ORDER BY limite_credito DESC LIMIT 1; /* SIN SUBCONSULTA */
SELECT nombre_cliente FROM cliente WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente); /*CON SUBCONSULTA PERO NO ES NECESARIO HACER EL MAX() EN UNA SUBCONSULTA */
SELECT nombre_cliente FROM cliente WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente); /* ALL COMPARA TODOS LOS REGISTROS (OTROS COMPARADORES SON ANY/SOME, O EXISTS)*/
SELECT nombre FROM producto WHERE precio_venta >= ALL(SELECT precio_venta FROM producto);

SELECT a.codigo_producto, b.nombre FROM detalle_pedido a INNER JOIN producto b ON a.codigo_producto = b.codigo_producto GROUP BY a.codigo_producto HAVING SUM(a.cantidad) = (SELECT MAX(total_suma) FROM (SELECT codigo_producto, SUM(cantidad) AS total_suma FROM detalle_pedido GROUP BY codigo_producto) AS subconsulta);

SELECT a.codigo_cliente, SUM(a.total) as total FROM pago a GROUP BY codigo_cliente HAVING total > ANY(SELECT limite_credito FROM cliente);
SELECT nombre_cliente FROM cliente WHERE codigo_cliente IN (SELECT codigo_cliente FROM (SELECT a.codigo_cliente, SUM(a.total) as total FROM pago a GROUP BY codigo_cliente HAVING total > ANY(SELECT limite_credito FROM cliente)) AS subconsulta);
SELECT a.codigo_cliente, SUM(a.total) as total, b.nombre_cliente FROM pago a INNER JOIN cliente b ON a.codigo_cliente = b.codigo_cliente GROUP BY a.codigo_cliente HAVING total > ANY(SELECT limite_credito FROM cliente);

SELECT nombre, cantidad_en_stock FROM producto WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);
SELECT nombre, cantidad_en_stock FROM producto WHERE cantidad_en_stock >= ALL(SELECT cantidad_en_stock FROM producto);

SELECT nombre, cantidad_en_stock FROM producto WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);
SELECT nombre, cantidad_en_stock FROM producto WHERE cantidad_en_stock <= ALL(SELECT cantidad_en_stock FROM producto);

SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = (SELECT codigo_empleado FROM empleado WHERE nombre = 'alberto' AND apellido1 = 'soria');

SELECT nombre_cliente FROM cliente WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente); /* same line 99 */
SELECT nombre FROM producto WHERE precio_venta >= ALL(SELECT precio_venta FROM producto);
SELECT nombre, cantidad_en_stock FROM producto WHERE cantidad_en_stock <= ALL(SELECT cantidad_en_stock FROM producto);

SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);
SELECT nombre_cliente FROM cliente WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);
SELECT nombre_cliente FROM cliente WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago);
SELECT * FROM producto WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);
SELECT a.nombre, a.apellido1, a.apellido2, a.puesto, b.telefono FROM empleado a INNER JOIN oficina b ON a.codigo_oficina = b.codigo_oficina WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

SELECT * FROM cliente WHERE NOT EXISTS (SELECT * FROM pago WHERE cliente.codigo_cliente = pago.codigo_cliente);
SELECT * FROM cliente WHERE EXISTS (SELECT * FROM pago WHERE cliente.codigo_cliente = pago.codigo_cliente);
SELECT * FROM producto WHERE NOT EXISTS (SELECT * FROM detalle_pedido WHERE producto.codigo_producto = detalle_pedido.codigo_producto);
SELECT * FROM producto WHERE EXISTS (SELECT * FROM detalle_pedido WHERE producto.codigo_producto = detalle_pedido.codigo_producto);