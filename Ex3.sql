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

