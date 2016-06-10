select 'alter table '||table_schema||'.'||table_name||' rename column '||column_name||' to clave_id;'
from information_schema.columns
where table_schema = 'caabsa'
  and column_name = 'clave iden';