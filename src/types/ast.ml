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

and 'a window_clause =
  | Window_clause of ('a window_name * 'a window_defn) list * 'a

and 'a having_clause = Having_clause of 'a expr * 'a

and 'a window_name = Window_name of 'a identifier * 'a

and 'a window_defn =
  | Window_defn of
      'a base_window_name option
      * 'a partition_clause option
      * 'a order_by_clause option
      * 'a frame_spec option
      * 'a

and 'a base_window_name = Base_window_name of 'a identifier * 'a

and 'a order_by_clause = Order_by_clause of 'a ordering_term * 'a

and 'a frame_spec =
  | Frame_spec of
      [ `range | `rows | `groups ]
      * 'a frame_spec_core
      * 'a frame_spec_excluding option
      * 'a

and 'a ordering_term =
  | Ordering_term of
      'a expr
      * 'a collation_name option
      * [ `asc | `desc ] option
      * [ `first | `last ] option
      * 'a

and 'a partition_clause = Partition_clause of 'a expr list * 'a

and 'a collation_name = Collation_name of 'a identifier * 'a

and 'a frame_spec_between =
  | Frame_spec_between of 'a frame_spec_between_1 * 'a frame_spec_between_2 * 'a

and 'a frame_spec_between_1 =
  | Frame_spec_between_1 of
      [ `unbounded
      | `preceding of 'a expr
      | `following of 'a expr
      | `current_row
      ]
      * 'a

and 'a frame_spec_between_2 =
  | Frame_spec_between_2 of
      [ `unbounded
      | `preceding of 'a expr
      | `following of 'a expr
      | `current_row
      ]
      * 'a

and 'a frame_spec_core =
  | Frame_spec_core of
      [ `between of 'a frame_spec_between
      | `unbounded
      | `preceding of 'a expr
      | `current_row
      ]
      * 'a

and 'a frame_spec_excluding =
  | Frame_spec_excluding of [ `no_others | `current_row | `group | `ties ] * 'a

and 'a join_operator =
  | Join_operator of
      [ `comma
      | `cross
      | `simple
      | `natural
      | `inner of [ `natural ] option
      | `outer of [ `natural ] option * [ `left | `right | `full ]
      ]
      * 'a

and 'a join_constraint =
  | Join_constraint of [ `expr of 'a expr | `using of 'a column_name list ] * 'a

and 'a join_clause =
  | Join_clause of
      'a table_or_subquery
      * ('a join_operator * 'a table_or_subquery * 'a join_constraint) list
      * 'a
