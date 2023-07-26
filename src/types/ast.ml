open Literal
open Basic

type ext = Ext.ext

type 'a sql_statement = Sql_statement of 'a

and 'a bind_parameter = Bind_parameter of 'a

and 'a schema_name = Schema_name of 'a identifier * 'a

and 'a table_name = Table_name of 'a identifier * 'a

and 'a column_name = Column_name of 'a identifier * 'a

and 'a type_name =
  | Type_name of
      'a identifier list
      * [ `name_only
        | `size of 'a signed_number
        | `with_max of 'a signed_number * 'a signed_number
        ]
      * 'a

and 'a signed_number = Signed_number of sign * 'a numeric_literal * 'a
