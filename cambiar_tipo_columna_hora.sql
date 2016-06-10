select 'alter table '||table_schema||'.'||table_name||' alter column '||column_name||' type timestamp USING hora::timestamp without time zone;'
from information_schema.columns
where table_schema = 'caabsa'
  and column_name = 'hora'
  and data_type = 'character varying';