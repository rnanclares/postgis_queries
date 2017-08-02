select 'alter table '||f_table_schema||'.'||f_table_name||' alter column geom type geometry('||type||',3857) using ST_Transform(geom, '||srid||');'
from public.geometry_columns
where srid = 32719
and f_table_schema = 'tu_schema';
