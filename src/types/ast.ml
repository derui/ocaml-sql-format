open Literal

type ext = Ext.ext

type 'a sql_statement = Sql_statement of 'a

and 'a bind_parameter = Bind_parameter of 'a

and 'a schema_name = Schema_name of 'a identifier * 'a

and 'a table_name = Table_name of 'a identifier * 'a

and 'a column_name = Column_name of 'a identifier * 'a
