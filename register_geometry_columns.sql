WITH
t AS (SELECT table_schema, table_name
                FROM information_schema.tables
                WHERE table_schema = 'caabsa' AND table_type = 'BASE TABLE')
SELECT Populate_Geometry_Columns((table_schema::text || '.' || table_name::text)::regclass)FROM t
