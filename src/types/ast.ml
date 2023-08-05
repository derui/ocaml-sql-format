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
        | `array
        | `size of 'a signed_number * [ `array ] option
        | `with_max of 'a signed_number * 'a signed_number * [ `array ] option
        ]
      * 'a

and 'a signed_number = Signed_number of sign option * 'a numeric_literal * 'a

and 'a qualified_name =
  | Qualified_name of
      'a schema_name option * 'a table_name option * 'a column_name * 'a

and 'a expr =
  | Expr of
      [ `literal of 'a literal_value
      | `parameter of 'a bind_parameter
      | `name of 'a qualified_name
      | `unary of 'a unary_operator * 'a expr
      | `binary of 'a expr * 'a binary_operator * 'a expr
      | `function' of 'a function'
      | `nested of 'a expr list
      | `cast of 'a expr * 'a type_name
      | `collate of 'a expr * 'a collation_name
      | `like of 'a expr * [ `not' ] option * 'a expr * 'a expr option
      | `glob of 'a expr * [ `not' ] option * 'a expr
      | `regexp of 'a expr * [ `not' ] option * 'a expr
      | `match' of 'a expr * [ `not' ] option * 'a expr
      | `is of 'a expr * [ `not' ] option * 'a expr
      | `is_distinct of 'a expr * [ `not' ] option * 'a expr
      | `between of 'a expr * [ `not' ] option * 'a expr * 'a expr
      | `in' of
        'a expr
        * [ `not' ] option
        * [ `stmt of 'a select_statement
          | `expr of 'a expr list
          | `table of 'a schema_name option * 'a table_name
          | `function' of
            'a schema_name option * 'a function_name * 'a expr list
          ]
      | `exists of 'a expr * [ `not' ] option * 'a select_statement
      | `case of 'a expr option * ('a expr * 'a expr) list * 'a expr option
      ]
      * 'a

and 'a sql_statement =
  | Sql_statement of
      [ `select of 'a select_statement | `update of 'a update_statement ] * 'a

and 'a select_statement =
  | Select_statement of
      'a with_clause option
      * ('a compound_operator option * 'a select_core) list
      * 'a order_by_clause option
      * 'a limit_clause option
      * 'a

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
      [ `name of 'a schema_name option * 'a table_name * 'a identifier option
      | `statement of 'a select_statement * 'a identifier option
      | `nested of 'a table_or_subquery list
      | `join of 'a join_clause
      ]
      * 'a

and 'a select_clause =
  | Select_clause of quantifier option * 'a result_column list * 'a

and 'a from_clause =
  | From_clause of
      [ `table_or_subquery of 'a table_or_subquery list
      | `join of 'a join_clause
      ]
      * 'a

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

and 'a order_by_clause = Order_by_clause of 'a ordering_term list * 'a

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
      * ('a join_operator * 'a table_or_subquery * 'a join_constraint option)
        list
      * 'a

and 'a unary_operator =
  | Unary_operator of [ `tilda | `plus | `minus | `not' ] * 'a

and 'a binary_operator =
  | Binary_operator of
      [ `concat (* || *)
      | `extract (* -> *)
      | `extract_2 (* ->> *)
      | `asterisk (* * *)
      | `divide (* / *)
      | `plus (* + *)
      | `minus (* - *)
      | `land' (* & *)
      | `lor' (* | *)
      | `lshift (* << *)
      | `rshift (* >> *)
      | `lt (* < *)
      | `gt (* > *)
      | `le (* <= *)
      | `ge (* >= *)
      | `eq (* = *)
      | `eq2 (* == *)
      | `ne (* <> *)
      | `ne2 (* != *)
      | `and' (* AND *)
      | `or' (* OR *)
      ]
      * 'a

and 'a function_name = Function_name of 'a identifier * 'a

and 'a function' =
  | Function of
      [ `no_arg of
        'a function_name * 'a filter_clause option * 'a over_clause option
      | `asterisk of
        'a function_name * 'a filter_clause option * 'a over_clause option
      | `generic of
        'a function_name
        * [ `distinct ] option
        * 'a expr list
        * 'a filter_clause option
        * 'a over_clause option
      | `extract of
        [ `year
        | `month
        | `day
        | `hour
        | `minute
        | `second
        | `quarter
        | `epoch
        ]
        * 'a expr
      | `position of 'a expr * 'a expr
      | `trim of
        [ `leading | `trailing | `both ] option * 'a expr option * 'a expr
      ]
      * 'a

and 'a filter_clause = Filter_clause of 'a expr * 'a

and 'a limit_clause =
  | Limit_clause of
      'a expr * [ `no_offset | `offset of 'a expr | `comma of 'a expr ] * 'a

and 'a over_clause =
  | Over_clause of [ `name of 'a identifier | `defn of 'a window_defn ] * 'a

and 'a common_table_expression =
  | Common_table_expression of
      'a table_name
      * 'a column_name list option
      * [ `not_materialized | `materialized ] option
      * 'a select_statement
      * 'a

and 'a with_clause =
  | With_clause of [ `recursive ] option * 'a common_table_expression list * 'a

and 'a compound_operator =
  | Compound_operator of [ `union | `union_all | `intersect | `except ] * 'a

and 'a update_statement =
  | Update_statement of
      [ `abort | `fail | `ignore | `replace | `rollback ] option
      * 'a qualified_table_name
      * [ `column of 'a column_name * 'a expr
        | `list of 'a column_name list * 'a expr
        ]
        list
      * 'a from_clause option
      * 'a where_clause option
      * 'a returning_clause option
      * 'a

and 'a qualified_table_name =
  | Qualified_table_name of
      'a schema_name option * 'a table_name * 'a identifier option * 'a

and 'a returning_clause =
  | Returning_clause of
      [ `asterisk | `expr of 'a expr * 'a identifier option ] list * 'a
