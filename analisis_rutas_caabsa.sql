SELECT dia, hora_dia, (188 - count(distinct(clave_identificadora))) as numero_camiones
FROM caabsa.rutas_dentro, caabsa.bases_pol
WHERE st_intersects(rutas_dentro.geom, bases_pol.geom)
GROUP BY dia, hora_dia;


CREATE TABLE caabsa.rutas_lineas as 
(SELECT clave_identificadora, dia, st_makeline(rutas.geom order by hora) as new_geom
FROM caabsa.rutas 
group by clave_identificadora, dia);

ALTER TABLE caabsa.rutas_lineas
ADD column id_linea serial primary key;


SELECT clave_identificadora,dia
FROM caabsa.rutas_lineas, caabsa.bases_pol
WHERE st_contains(bases_pol.geom, rutas_lineas.new_geom);


SELECT zona, clave_identificadora, dia, count(rutas.geom) 
FROM caabsa.rutas, caabsa.geocercas
WHERE st_intersects(rutas.geom, geocercas.geom)
GROUP BY zona, clave_identificadora, dia
ORDER BY zona, count desc;
