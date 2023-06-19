SELECT nombre FROM pokemon;
SELECT * FROM pokemon WHERE peso < 10;
SELECT a.*, c.nombre FROM pokemon a INNER JOIN pokemon_tipo b ON a.numero_pokedex = b.numero_pokedex INNER JOIN tipo c ON b.id_tipo = c.id_tipo WHERE c.nombre = 'agua';
SELECT a.*, c.nombre FROM pokemon a INNER JOIN pokemon_tipo b ON a.numero_pokedex = b.numero_pokedex INNER JOIN tipo c ON b.id_tipo = c.id_tipo WHERE c.nombre IN ('agua', 'fuego', 'tierra') ORDER BY c.nombre;
SELECT a.*, c.nombre FROM pokemon a INNER JOIN pokemon_tipo b ON a.numero_pokedex = b.numero_pokedex INNER JOIN tipo c ON b.id_tipo = c.id_tipo WHERE c.nombre IN ('fuego', 'volador') ORDER BY c.nombre;
SELECT a.*, b.ps FROM pokemon a INNER JOIN estadisticas_base b ON a.numero_pokedex = b.numero_pokedex WHERE b.ps >= 200;
SELECT nombre, peso, altura FROM pokemon WHERE numero_pokedex = (SELECT pokemon_origen FROM evoluciona_de WHERE pokemon_evolucionado = (SELECT numero_pokedex FROM pokemon WHERE nombre = 'arbok'));

SELECT * FROM pokemon WHERE numero_pokedex IN (SELECT numero_pokedex FROM pokemon_forma_evolucion WHERE id_forma_evolucion = (SELECT id_forma_evolucion FROM forma_evolucion WHERE tipo_evolucion = (SELECT id_tipo_evolucion FROM tipo_evolucion WHERE tipo_evolucion = 'intercambio')));
SELECT a.* FROM pokemon a INNER JOIN pokemon_forma_evolucion b ON a.numero_pokedex = b.numero_pokedex INNER JOIN forma_evolucion c ON b.id_forma_evolucion = c.id_forma_evolucion INNER JOIN tipo_evolucion d ON c.tipo_evolucion = d.id_tipo_evolucion WHERE d.tipo_evolucion = 'intercambio';

SELECT nombre FROM movimiento WHERE prioridad = (SELECT MAX(prioridad) FROM movimiento);
/* 10. Mostrar el pokemon más pesado. */
SELECT * FROM pokemon ORDER BY peso DESC LIMIT 1;
SELECT * FROM pokemon WHERE peso = (SELECT MAX(peso) FROM pokemon);
SELECT * FROM pokemon WHERE peso >= ALL(SELECT peso FROM pokemon);

SELECT a.nombre, a.potencia, b.nombre as tipo FROM movimiento a INNER JOIN tipo b ON a.id_tipo = b.id_tipo WHERE potencia = (SELECT MAX(potencia) FROM movimiento);
SELECT b.nombre as tipo, COUNT(a.id_movimiento) as cantidad_movimientos FROM movimiento a INNER JOIN tipo b ON a.id_tipo = b.id_tipo GROUP BY tipo;
/* SOLO EXISTE ENVENENAMIENTO LEVE EN LA BBDD*/
SELECT a.*, c.efecto_secundario FROM movimiento a LEFT JOIN movimiento_efecto_secundario b ON a.id_movimiento = b.id_movimiento LEFT JOIN efecto_secundario c ON b.id_efecto_secundario = c.id_efecto_secundario WHERE c.efecto_secundario LIKE 'envenenamiento%' OR a.descripcion LIKE '%envenena%';
SELECT * FROM movimiento WHERE potencia > 0 OR descripcion LIKE '%quita%ps%' ORDER BY nombre;

SELECT a.nombre, c.nombre, e.tipo_aprendizaje FROM pokemon a INNER JOIN pokemon_movimiento_forma b ON a.numero_pokedex = b.numero_pokedex
INNER JOIN movimiento c ON b.id_movimiento = c.id_movimiento
INNER JOIN forma_aprendizaje d ON b.id_forma_aprendizaje = d.id_forma_aprendizaje
INNER JOIN tipo_forma_aprendizaje e ON d.id_tipo_aprendizaje = e.id_tipo_aprendizaje
WHERE a.nombre = 'pikachu';

SELECT a.nombre, c.nombre, mt.MT FROM pokemon a INNER JOIN pokemon_movimiento_forma b ON a.numero_pokedex = b.numero_pokedex
INNER JOIN movimiento c ON b.id_movimiento = c.id_movimiento
INNER JOIN forma_aprendizaje d ON b.id_forma_aprendizaje = d.id_forma_aprendizaje
INNER JOIN tipo_forma_aprendizaje e ON d.id_tipo_aprendizaje = e.id_tipo_aprendizaje
INNER JOIN mt ON b.id_forma_aprendizaje = mt.id_forma_aprendizaje
WHERE a.nombre = 'pikachu';

SELECT a.nombre, c.nombre, na.nivel, f.nombre FROM pokemon a INNER JOIN pokemon_movimiento_forma b ON a.numero_pokedex = b.numero_pokedex
INNER JOIN movimiento c ON b.id_movimiento = c.id_movimiento
INNER JOIN forma_aprendizaje d ON b.id_forma_aprendizaje = d.id_forma_aprendizaje
INNER JOIN tipo_forma_aprendizaje e ON d.id_tipo_aprendizaje = e.id_tipo_aprendizaje
INNER JOIN tipo f ON c.id_tipo = f.id_tipo
RIGHT JOIN nivel_aprendizaje na ON b.id_forma_aprendizaje = na.id_forma_aprendizaje
WHERE a.nombre = 'pikachu' AND f.nombre = 'normal'
ORDER BY na.nivel;

SELECT a.nombre, b.probabilidad, c.efecto_secundario FROM movimiento a
INNER JOIN movimiento_efecto_secundario b ON a.id_movimiento = b.id_movimiento
INNER JOIN efecto_secundario c ON b.id_efecto_secundario = c.id_efecto_secundario
WHERE b.probabilidad > 30;

SELECT a.nombre, d.tipo_evolucion, f.nombre_piedra FROM pokemon a
INNER JOIN pokemon_forma_evolucion b ON a.numero_pokedex = b.numero_pokedex
INNER JOIN forma_evolucion c ON b.id_forma_evolucion = c.id_forma_evolucion
INNER JOIN tipo_evolucion d ON c.tipo_evolucion = d.id_tipo_evolucion
INNER JOIN piedra e ON c.id_forma_evolucion = e.id_forma_evolucion
INNER JOIN tipo_piedra f ON e.id_tipo_piedra = f.id_tipo_piedra
WHERE d.tipo_evolucion = 'piedra';


SELECT nombre FROM pokemon WHERE numero_pokedex NOT IN (SELECT numero_pokedex FROM pokemon_forma_evolucion);

SELECT COUNT(a.numero_pokedex) as cantidad, c.nombre as tipo FROM pokemon a
INNER JOIN pokemon_tipo b ON a.numero_pokedex = b.numero_pokedex
INNER JOIN tipo c ON b.id_tipo = c.id_tipo
GROUP BY tipo;