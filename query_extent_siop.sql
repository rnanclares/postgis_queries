SELECT string_agg(replace(replace(replace(ST_AsText(geom),'POINT(',''),')',''),' ',','), ',')
FROM (
  SELECT (ST_DumpPoints(g.geom)).*
  FROM
    (SELECT ST_EXTENT(ST_buffer(geom,50)) as geom FROM catastro.predios_utm_13n
	WHERE clavegdl = 'D66A2358031') AS g
  ) j WHERE path=ARRAY[1, 1] OR path=ARRAY[1,3];
  
  
--http://localhost/geoserver/gdlsig/wms?request=GetMap&layers=gdlsig:predios_utm_13n,gdlsig:red_vial_utm_13n&width=800&height=600&format=image/png&BBOX=675055.213075813,2288751.61023266,675176.19788201,2288865.68751845&SRS=epsg:32613&cql_filter=(clavegdl=%27D66A2358031%27);INCLUDE

--//http://localhost/geoserver/wms?request=GetMap&layers=leafletvisor:Predios_Catastro,gdlsig:predios_utm_13n,gdlsig:red_vial_utm_13n&width=800&height=600&format=image/png&BBOX=675055.213075813,2288751.61023266,675176.19788201,2288865.68751845&SRS=epsg:32613&cql_filter=INCLUDE;(clavegdl=%27D66A2358031%27);INCLUDE
