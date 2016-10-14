-- Query para obtener las coordenadas xmax,ymax,xmin,ymin para enviar como parámetro bbox a GeoServer.
-- Hay que comprobar que realmente los elementos 1 y 3 del array siempre sean los adecuados.
SELECT string_agg(replace(replace(replace(ST_AsText(geom),'POINT(',''),')',''),' ',','), ',')
FROM (
  SELECT (ST_DumpPoints(g.geom)).*
  FROM
    (SELECT ST_EXTENT(ST_buffer(geom,50)) as geom FROM catastro.predios_utm_13n
	WHERE clavegdl = 'D66A2358031') AS g
  ) j WHERE path=ARRAY[1, 1] OR path=ARRAY[1,3];
