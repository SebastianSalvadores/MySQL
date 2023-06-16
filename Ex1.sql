SELECT nombre FROM jugadores ORDER BY nombre ASC;
SELECT * FROM jugadores WHERE posicion LIKE '%C%' AND peso > 200 ORDER BY nombre ASC;
SELECT nombre FROM equipos ORDER BY nombre ASC;
SELECT nombre FROM equipos WHERE conferencia = 'east';
SELECT * FROM equipos WHERE ciudad LIKE 'C%' ORDER BY nombre ASC;
SELECT nombre, nombre_equipo FROM jugadores ORDER BY nombre_equipo ASC;
SELECT * FROM jugadores WHERE nombre_equipo = 'RAPTORS' ORDER BY nombre ASC;
SELECT a.nombre, b.puntos_por_partido FROM jugadores a JOIN estadisticas b ON a.codigo = b.jugador WHERE a.nombre = 'Pau Gasol';
SELECT a.nombre, b.temporada, b.puntos_por_partido FROM jugadores a JOIN estadisticas b ON a.codigo = b.jugador WHERE a.nombre = 'Pau Gasol' AND b.temporada = '04/05';

/* los siguientes 2 son de la misma consulta total puntos en carrera, no supe cual es la correcta */
SELECT a.nombre, ROUND(SUM(b.puntos_por_partido)) as total FROM jugadores a JOIN estadisticas b ON a.codigo = b.jugador GROUP BY a.nombre ORDER BY total DESC;
SELECT a.nombre, COUNT(a.nombre) as temporadas, (SUM(b.puntos_por_partido) / COUNT(a.nombre)) as promedio_carrera FROM jugadores a JOIN estadisticas b ON a.codigo = b.jugador GROUP BY nombre ORDER BY promedio_carrera DESC;

SELECT COUNT(codigo) as jugadores, nombre_equipo FROM jugadores GROUP BY nombre_equipo;
SELECT a.nombre, ROUND(SUM(b.puntos_por_partido)) as total FROM jugadores a JOIN estadisticas b ON a.codigo = b.jugador GROUP BY a.nombre ORDER BY total DESC LIMIT 1;
SELECT a.nombre, a.altura, b.nombre, b.conferencia, b.division FROM jugadores a JOIN equipos b ON a.nombre_equipo = b.nombre ORDER BY altura DESC LIMIT 1;

SELECT SUM(puntos_local)  FROM partidos WHERE equipo_local IN (SELECT nombre FROM equipos WHERE division = "pacific");
SELECT SUM(puntos_visitante) FROM partidos WHERE equipo_visitante IN (SELECT nombre FROM equipos WHERE division = "pacific");

SELECT (suma1 + suma2) / 2 as media_puntos FROM (SELECT SUM(puntos_local) as suma1 FROM partidos WHERE equipo_local IN (SELECT nombre FROM equipos WHERE division = "pacific")) as tabla1 JOIN (SELECT SUM(puntos_visitante) as suma2 FROM partidos WHERE equipo_visitante IN (SELECT nombre FROM equipos WHERE division = "pacific")) as tabla2;

SELECT AVG(puntos) AS media_puntos
FROM (
  SELECT SUM(puntos_local) AS puntos
  FROM partidos
  WHERE equipo_local IN (SELECT nombre FROM equipos WHERE division = 'pacific')
  UNION
  SELECT SUM(puntos_visitante) AS puntos
  FROM partidos
  WHERE equipo_visitante IN (SELECT nombre FROM equipos WHERE division = 'pacific')
)AS subconsulta; /*CHAT GPT*/

SELECT equipo_local, equipo_visitante, ABS(puntos_local - puntos_visitante) AS diferencia FROM partidos;

SELECT * FROM partidos;
SELECT SUM(puntos_local) as sum1, equipo_local FROM partidos GROUP BY equipo_local;
SELECT SUM(puntos_visitante) as sum2, equipo_visitante FROM partidos GROUP BY equipo_visitante;

SELECT equipo_local as Equipo, (sum1 + sum2) as Total_puntos FROM (SELECT SUM(puntos_local) as sum1, equipo_local FROM partidos GROUP BY equipo_local) as tabla1 JOIN (SELECT SUM(puntos_visitante) as sum2, equipo_visitante FROM partidos GROUP BY equipo_visitante) as tabla2 ON tabla1.equipo_local = tabla2.equipo_visitante;
SELECT equipo_local as Equipo, puntos_local, puntos_visitante, (puntos_local + puntos_visitante) as Total_puntos FROM (SELECT SUM(puntos_local) as puntos_local, equipo_local FROM partidos GROUP BY equipo_local) as tabla1 JOIN (SELECT SUM(puntos_visitante) as puntos_visitante, equipo_visitante FROM partidos GROUP BY equipo_visitante) as tabla2 ON tabla1.equipo_local = tabla2.equipo_visitante;

SELECT * FROM partidos LIMIT 16000;
SELECT codigo, equipo_local FROM partidos WHERE puntos_local > puntos_visitante;
SELECT codigo, equipo_visitante FROM partidos WHERE puntos_local < puntos_visitante;


SELECT codigo, equipo_local, equipo_visitante, puntos_local, puntos_visitante,
    CASE
        WHEN puntos_local > puntos_visitante THEN equipo_local
        WHEN puntos_local < puntos_visitante THEN equipo_visitante
        ELSE NULL
    END AS equipo_ganador
FROM partidos; /* CHAT GPT 1 */

SELECT p.codigo, p.equipo_local, p.equipo_visitante,
       COALESCE(l.equipo_local, v.equipo_visitante) AS equipo_ganador
FROM partidos p
LEFT JOIN (SELECT codigo, equipo_local FROM partidos WHERE puntos_local > puntos_visitante) l
    ON p.codigo = l.codigo
LEFT JOIN (SELECT codigo, equipo_visitante FROM partidos WHERE puntos_local < puntos_visitante) v
    ON p.codigo = v.codigo; /* CHAT GPT 2 */

