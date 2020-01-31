UPDATE geo.intersecciones_cruces
set cve_mun = subquery.cve_mun,
	cve_loc = subquery.cve_loc
FROM (SELECT gid, geom
	 FROM geo.intersecciones_cruces
	 WHERE cve_mun is null
	  ) p,
	  lateral
	  (SELECT localidades_pol.cve_mun, localidades_pol.cve_loc
	  FROM geo.localidades_pol
	  ORDER BY p.geom <-> localidades_pol.geom
	  LIMIT 1) subquery
WHERE intersecciones_cruces.gid = p.gid;
