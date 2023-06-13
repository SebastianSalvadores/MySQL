SELECT * FROM fabricante;
SELECT * FROM producto;
SELECT * FROM producto RIGHT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo; /* RIGHT JOIN PARA MOSTRAR TODOS LOS FABRICANTES QUE NO TIENEN PRODUCTOS */
SELECT a.codigo, a.nombre, a.precio, b.nombre FROM producto a RIGHT JOIN fabricante b ON a.codigo_fabricante = b.codigo; /* LO MISMO, PERO SACANDO CODIGO DE FABRICANTE DE AMBAS TABLAS */

/* Comienzo de ejercicio 2 */
SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT codigo, nombre, ROUND(precio) precio_redondeado, codigo_fabricante FROM producto;
SELECT codigo_fabricante FROM producto;
SELECT DISTINCT codigo_fabricante FROM producto;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;
SELECT * from fabricante LIMIT 5;
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE precio <= 120;
SELECT * FROM producto WHERE precio BETWEEN 60 AND 200;
SELECT * FROM producto WHERE codigo_fabricante IN (1, 3, 5);
SELECT * FROM producto WHERE nombre LIKE '%portatil%';

/* CONSULTAS MULTITABLA */
SELECT a.codigo, a.nombre, a.codigo_fabricante, b.nombre FROM producto a JOIN fabricante b ON a.codigo_fabricante = b.codigo;
SELECT a.nombre nombre_producto, a.precio, b.nombre nombre_fabricante FROM producto a JOIN fabricante b ON a.codigo_fabricante = b.codigo ORDER BY nombre_fabricante ASC;
SELECT a.nombre producto, a.precio, b.nombre fabricante FROM producto a JOIN fabricante b ON a.codigo_fabricante = b.codigo ORDER BY a.precio ASC LIMIT 1;
SELECT a.nombre FROM producto a JOIN fabricante b ON a.codigo_fabricante = b.codigo WHERE b.nombre = "lenovo";
SELECT a.*, b.nombre FROM producto a JOIN fabricante b ON a.codigo_fabricante = b.codigo WHERE b.nombre = "crucial" AND a.precio > 200;
SELECT a.*, b.nombre FROM producto a JOIN fabricante b ON a.codigo_fabricante = b.codigo WHERE b.nombre IN ("asus", "hewlett-packard");
SELECT a.nombre AS nombre_producto, a.precio, b.nombre AS nombre_fabricante FROM producto a JOIN fabricante b ON a.codigo_fabricante = b.codigo WHERE a.precio >= 180 ORDER BY a.precio DESC, a.nombre ASC;

SELECT * FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
SELECT * FROM fabricante a WHERE NOT EXISTS (SELECT b.codigo_fabricante FROM producto b WHERE b.codigo_fabricante = a.codigo); /* ESTO ES LO QUE MUESTRA EL VIDEO DE EGG */
SELECT * FROM fabricante a LEFT JOIN producto b ON a.codigo = b.codigo_fabricante WHERE NOT EXISTS (SELECT b.codigo_fabricante FROM producto b WHERE b.codigo_fabricante = a.codigo); /*ACA USO LEFT JOIN COMO PIDE CONSIGNA */

/*Subconsultas (En la cláusula WHERE)
Con operadores básicos de comparación */
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "lenovo");
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "lenovo"));
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "lenovo") ORDER BY precio DESC LIMIT 1;
SELECT * FROM producto WHERE precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "asus")) AND codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "asus");

/* Subconsultas con IN y NOT IN */
SELECT * FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto);
SELECT * FROM fabricante WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);

/* Subconsultas (En la cláusula HAVING) 
Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.*/
SELECT nombre FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto GROUP BY codigo_fabricante HAVING COUNT(codigo) = (SELECT COUNT(codigo) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "lenovo")));
