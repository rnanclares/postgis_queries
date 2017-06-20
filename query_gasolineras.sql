SELECT b.id,count((st_intersects(a.geom, b.geom) AND a.id <> b.id)) as cuenta, b.geom
FROM antroestacionservicio.gdl_gasolineras_denue_2017 a, antroestacionservicio.buffer_500mts_2017 b
WHERE (st_intersects(a.geom, b.geom) AND a.id <> b.id)
GROUP BY b.id, b.geom
ORDER BY cuenta desc;
