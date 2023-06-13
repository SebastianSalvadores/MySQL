/* A continuación, realizar las siguientes consultas sobre la base de datos personal:
1. Obtener los datos completos de los empleados.
2. Obtener los datos completos de los departamentos.
3. Listar el nombre de los departamentos.
4. Obtener el nombre y salario de todos los empleados.
5. Listar todas las comisiones.
6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
7. Obtener los datos de los empleados vendedores, ordenados por nombre
alfabéticamente.
8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a
mayor.
9. Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad
de “Ciudad Real”
10. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las
respectivas tablas de empleados.
11. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado
por comisión de menor a mayor.
12. Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta
de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del
empleado y el total a pagar, en orden alfabético.
13. Muestra los empleados cuyo nombre empiece con la letra J.
14. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos
empleados que tienen comisión superior a 1000.
15. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen
comisión.
16. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
17. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
18. Hallar los empleados cuyo nombre no contiene la cadena “MA”
19. Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o
‘Mantenimiento.
20. Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni
“Investigación” ni ‘Mantenimiento.
21. Mostrar el salario más alto de la empresa.
22. Mostrar el nombre del último empleado de la lista por orden alfabético.
23. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
24. Hallar el salario promedio por departamento.
Consultas con Having
25. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de
empleados de esos departamentos.
26. Hallar los departamentos que no tienen empleados
Consulta Multitabla (Uso de la sentencia JOIN/LEFT JOIN/RIGHT JOIN)
27. Mostrar la lista de empleados, con su respectivo departamento y el jefe de cada
departamento.
Consulta con Subconsulta
28. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la
empresa. Ordenarlo por departamento. */

SELECT * FROM departamentos;
SELECT * FROM empleados;

SELECT nombre_depto FROM departamentos GROUP BY nombre_depto;
SELECT DISTINCT nombre_depto FROM departamentos; /*esta consulta hace lo mismo que el de arriba */
SELECT nombre, sal_emp FROM empleados;
SELECT comision_emp FROM empleados GROUP BY comision_emp ORDER BY comision_emp ASC;
SELECT * FROM empleados WHERE cargo_emp = "Secretaria";
SELECT * FROM empleados WHERE cargo_emp = "Vendedor" ORDER BY nombre ASC;
SELECT nombre, cargo_emp FROM empleados ORDER BY sal_emp ASC;
SELECT nombre_jefe_depto FROM departamentos WHERE ciudad = "CIUDAD REAL";
SELECT nombre Nombre, cargo_emp Cargo FROM empleados;
SELECT sal_emp Salario, comision_emp Comision FROM empleados WHERE id_depto = 2000 ORDER BY comision_emp ASC, salario ASC;
SELECT nombre Nombre, SUM(sal_emp + comision_emp + 500) AS Total FROM empleados WHERE id_depto = 3000 GROUP BY nombre ORDER BY nombre ASC;
SELECT * FROM empleados WHERE nombre LIKE 'j%';
SELECT nombre Nombre, sal_emp Salario, comision_emp Comision, SUM(sal_emp + comision_emp) AS Total FROM empleados WHERE comision_emp > 1000 GROUP BY nombre, sal_emp, comision_emp;
SELECT nombre Nombre, sal_emp Salario, comision_emp Comision, SUM(sal_emp + comision_emp) AS Total FROM empleados WHERE comision_emp = 0 GROUP BY nombre, sal_emp, comision_emp;
SELECT * FROM empleados WHERE comision_emp > sal_emp;
SELECT * FROM empleados WHERE comision_emp <= (sal_emp * 0.3);
SELECT * FROM empleados WHERE nombre NOT LIKE '%ma%';
SELECT * FROM departamentos WHERE nombre_depto = 'ventas' OR nombre_depto = 'investigacion' OR nombre_depto = 'mantenimiento';
SELECT * FROM departamentos WHERE nombre_depto != 'ventas' AND nombre_depto != 'investigacion' AND nombre_depto != 'mantenimiento';
SELECT MAX(sal_emp) FROM empleados;
SELECT * FROM empleados ORDER BY nombre DESC LIMIT 1;
SELECT MAX(sal_emp) AS maximo, MIN(sal_emp) AS minimo, (MAX(sal_emp) - MIN(sal_emp)) AS diferencia FROM empleados;
SELECT AVG(sal_emp), id_depto FROM empleados GROUP BY id_depto;
/* En la siguiente linea, hago lo mismo que en la anterior pero con un INNER JOIN para mostrar tambien el nombre del departamento */
SELECT AVG(sal_emp), departamentos.nombre_depto, departamentos.id_depto FROM empleados INNER JOIN departamentos ON departamentos.id_depto = empleados.id_depto GROUP BY empleados.id_depto;

SELECT COUNT(id_emp) AS Cant_Empleados, id_depto FROM empleados GROUP BY id_depto HAVING Cant_Empleados > 3;
SELECT COUNT(id_emp) AS Cant_Empleados, id_depto FROM empleados GROUP BY id_depto HAVING Cant_Empleados = 0;

SELECT a.nombre, b.nombre_depto, b.nombre_jefe_depto FROM empleados a INNER JOIN departamentos b ON a.id_depto = b.id_depto;

SELECT * FROM empleados WHERE sal_emp >= (SELECT AVG(sal_emp) FROM empleados) ORDER BY id_depto;
