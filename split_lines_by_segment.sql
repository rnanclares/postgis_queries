WITH segments AS (
SELECT gid, clavegdl, ST_MakeLine(lag((pt).geom, 1, NULL) OVER (PARTITION BY gid ORDER BY gid, (pt).path), (pt).geom) AS geom
	FROM (SELECT gid, clavegdl, ST_DumpPoints(geom) AS pt FROM anchos.predios_test_lineas) as dumps
    )
SELECT row_number() over (order by segments.gid) as gid_pkey, * FROM segments WHERE geom IS NOT NULL;
