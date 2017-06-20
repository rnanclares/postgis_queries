select gid,
	"clave identificadora",
	 hora,
     extract(seconds from hora - lag(hora) over (order by "clave identificadora", hora)) as incremento,
	 geom
from basura.caabsa_20170614;
