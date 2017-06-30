CREATE MATERIALIZED VIEW caabsa2julio AS
SELECT *, row_number() OVER (PARTITION BY id 
ORDER BY "fecha_y_hora") AS orden
FROM   basura.caabsa_20170602;
