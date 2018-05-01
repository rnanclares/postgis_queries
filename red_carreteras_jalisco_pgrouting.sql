ALTER TABLE jalroute.caminos_carreteras_2012
ADD COLUMN "source" integer;

ALTER TABLE jalroute.caminos_carreteras_2012
ADD COLUMN "target" integer;

SELECT pgr_createTopology('jalroute.caminos_carreteras_2012', 1, 'geom', 'gid',
 'source', 'target', rows_where := 'true');

CREATE TABLE jalroute.node AS
   SELECT row_number() OVER (ORDER BY foo.p)::integer AS id,
          foo.p AS geom
   FROM (     
      SELECT DISTINCT caminos_carreteras_2012.source AS p FROM jalroute.caminos_carreteras_2012
      UNION
      SELECT DISTINCT caminos_carreteras_2012.target AS p FROM jalroute.caminos_carreteras_2012
   ) foo
   GROUP BY foo.p;

CREATE TABLE jalroute.network AS
   SELECT a.*, b.id as start_id, c.id as end_id
   FROM jalroute.caminos_carreteras_2012 AS a
      JOIN jalroute.node AS b ON a.source = b.geom
      JOIN jalroute.node AS c ON a.target = c.geom;


CREATE OR REPLACE VIEW jalroute.network_nodes AS 
SELECT foo.id,
 st_pointonsurface(st_collect(foo.pt)) AS geom 
FROM ( 
  SELECT network.source AS id,
         st_geometryn (st_multi(network.geom),1) AS pt 
  FROM jalroute.network
  UNION 
  SELECT network.target AS id, 
         st_boundary(st_multi(network.geom)) AS pt 
  FROM jalroute.network) foo 
GROUP BY foo.id;

ALTER TABLE jalroute.network ADD COLUMN tiempoviaje double precision;
ALTER TABLE jalroute.network ADD COLUMN longitud double precision;

UPDATE jalroute.network
SET longitud = st_length (geom);

UPDATE jalroute.network SET tiempoviaje = longitud / 110000*60 WHERE tipo = 'Cuota';
UPDATE jalroute.network SET tiempoviaje = longitud  / 80000*60 WHERE tipo = 'Libre';
UPDATE jalroute.network SET tiempoviaje = longitud  / 50000*60 WHERE tipo = 'Terracería';
UPDATE jalroute.network SET tiempoviaje = longitud  / 30000*60 WHERE tipo = 'Brecha';
UPDATE jalroute.network SET tiempoviaje = longitud  / 10000*60 WHERE tipo = 'Vereda';
UPDATE jalroute.network SET tiempoviaje = longitud  / 10000*60 WHERE tipo is null;

CREATE OR REPLACE VIEW jalroute.isocrona_test AS (
SELECT di.seq, 
       di.id1, 
       di.id2, 
       di.cost,
       di.aggcost, 
       pt.id, 
       pt.geom 
FROM pgr_drivingDistance('SELECT
     gid AS id, 
     source AS source, 
     target AS target,                                    
     tiempoviaje AS cost 
     FROM jalroute.network',5578,250000, false)
     di(seq, id1, id2, cost, aggcost)
JOIN jalroute.network_nodes pt ON di.id1 = pt.id);

SELECT * 
FROM jalroute.isocrona_test
LIMIT 3;
