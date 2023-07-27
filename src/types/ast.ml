open Literal
open Basic

type ext = Ext.ext

type 'a bind_parameter = Bind_parameter of 'a

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

and 'a qualified_name =
  | Qualified_name of
      'a schema_name option * 'a table_name option * 'a column_name * 'a

and 'a expr =
  | Expr of
      [ `literal of 'a literal_value
      | `parameter of 'a bind_parameter
      | `name of 'a qualified_name
      ]
      * 'a

and 'a sql_statement =
  | Sql_statement of [ `select of 'a select_statement ] * 'a

and 'a select_statement = Select_statement of 'a select_core * 'a

and 'a select_core =
  | Select_core of
      [ `select of
        'a select_clause
        * 'a from_clause option
        * 'a where_clause option
        * 'a group_by_clause option
        * 'a having_clause option
        * 'a window_clause option
      ]
      * 'a
(* TODO *)

and 'a result_column =
  | Result_column of
      [ `expr of 'a expr * 'a identifier option
      | `asterisk
      | `qualified_asterisk of 'a table_name
      ]
      * 'a

and 'a table_or_subquery =
  | Table_or_subquery of
      [ `name of 'a schema_name option * 'a table_name * 'a identifier option ]
      * 'a

and 'a select_clause =
  | Select_clause of quantifier option * 'a result_column list * 'a

and 'a from_clause =
  | From_clause of [ `table_or_subquery of 'a table_or_subquery list ] * 'a

and 'a where_clause = Where_clause of 'a expr * 'a

and 'a group_by_clause = Group_by_clause of 'a expr list * 'a

and 'a window_clause = Window_clause of 'a (* TODO *)

and 'a having_clause = Having_clause of 'a (* TODO *)
