module A = Types.Ast
module L = Types.Literal
module B = Types.Basic
module Options = Options

let identifier () = Identifier.((module Make () : S))

let rec literal_value () =
  Literal_value.(
    (module Make
              (struct
                type t = A.ext L.string_literal

                let generate = string_literal
              end)
              (struct
                type t = A.ext L.numeric_literal

                let generate = numeric_literal
              end)
              (struct
                type t = A.ext L.blob_literal

                let generate = blob_literal
              end) : S))

and numeric_literal () = Numeric_literal.((module Make () : S))

and string_literal () = String_literal.((module Make () : S))

and blob_literal () = Blob_literal.((module Make () : S))

and bind_parameter () = Bind_parameter.((module Make () : S))

and schema_name () =
  Schema_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and table_name () =
  Table_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and column_name () =
  Column_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and type_name () =
  Type_name.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.signed_number

                let generate = signed_number
              end) : S))

and signed_number () =
  Signed_number.(
    (module Make (struct
      type t = A.ext L.numeric_literal

      let generate = numeric_literal
    end) : S))

and qualified_name () =
  Qualified_name.(
    (module Make
              (struct
                type t = A.ext A.schema_name

                let generate = schema_name
              end)
              (struct
                type t = A.ext A.table_name

                let generate = table_name
              end)
              (struct
                type t = A.ext A.column_name

                let generate = column_name
              end) : S))

and expr () =
  Expr.(
    (module Make
              (struct
                type t = A.ext L.literal_value

                let generate = literal_value
              end)
              (struct
                type t = A.ext A.bind_parameter

                let generate = bind_parameter
              end)
              (struct
                type t = A.ext A.qualified_name

                let generate = qualified_name
              end)
              (struct
                type t = A.ext A.unary_operator

                let generate = unary_operator
              end)
              (struct
                type t = A.ext A.binary_operator

                let generate = binary_operator
              end)
              (struct
                type t = A.ext A.function_name

                let generate = function_name
              end)
              (struct
                type t = A.ext A.type_name

                let generate = type_name
              end)
              (struct
                type t = A.ext A.collation_name

                let generate = collation_name
              end)
              (struct
                type t = A.ext A.select_statement

                let generate = select_statement
              end)
              (struct
                type t = A.ext A.schema_name

                let generate = schema_name
              end)
              (struct
                type t = A.ext A.table_name

                let generate = table_name
              end)
              (struct
                type t = A.ext A.function'

                let generate = function'
              end) : S))

and sql_statement () =
  Sql_statement.(
    (module Make
              (struct
                type t = A.ext A.select_statement

                let generate = select_statement
              end)
              (struct
                type t = A.ext A.update_statement

                let generate = update_statement
              end) : S))

and select_statement () =
  Select_statement.(
    (module Make
              (struct
                type t = A.ext A.select_core

                let generate = select_core
              end)
              (struct
                type t = A.ext A.limit_clause

                let generate = limit_clause
              end)
              (struct
                type t = A.ext A.order_by_clause

                let generate = order_by_clause
              end)
              (struct
                type t = A.ext A.with_clause

                let generate = with_clause
              end)
              (struct
                type t = A.ext A.compound_operator

                let generate = compound_operator
              end) : S))

and select_core () =
  Select_core.(
    (module Make
              (struct
                type t = A.ext A.select_clause

                let generate = select_clause
              end)
              (struct
                type t = A.ext A.from_clause

                let generate = from_clause
              end)
              (struct
                type t = A.ext A.where_clause

                let generate = where_clause
              end)
              (struct
                type t = A.ext A.group_by_clause

                let generate = group_by_clause
              end)
              (struct
                type t = A.ext A.having_clause

                let generate = having_clause
              end)
              (struct
                type t = A.ext A.window_clause

                let generate = window_clause
              end) : S))

and result_column () =
  Result_column.(
    (module Make
              (struct
                type t = A.ext A.table_name

                let generate = table_name
              end)
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.expr

                let generate = expr
              end) : S))

and table_or_subquery () =
  Table_or_subquery.(
    (module Make
              (struct
                type t = A.ext A.schema_name

                let generate = schema_name
              end)
              (struct
                type t = A.ext A.table_name

                let generate = table_name
              end)
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.select_statement

                let generate = select_statement
              end)
              (struct
                type t = A.ext A.join_clause

                let generate = join_clause
              end) : S))

and select_clause () =
  Select_clause.(
    (module Make (struct
      type t = A.ext A.result_column

      let generate = result_column
    end) : S))

and from_clause () =
  From_clause.(
    (module Make
              (struct
                type t = A.ext A.table_or_subquery

                let generate = table_or_subquery
              end)
              (struct
                type t = A.ext A.join_clause

                let generate = join_clause
              end) : S))

and where_clause () =
  Where_clause.(
    (module Make (struct
      type t = A.ext A.expr

      let generate = expr
    end) : S))

and group_by_clause () =
  Group_by_clause.(
    (module Make (struct
      type t = A.ext A.expr

      let generate = expr
    end) : S))

and window_clause () =
  Window_clause.(
    (module Make
              (struct
                type t = A.ext A.window_name

                let generate = window_name
              end)
              (struct
                type t = A.ext A.window_defn

                let generate = window_defn
              end) : S))

and having_clause () =
  Having_clause.(
    (module Make (struct
      type t = A.ext A.expr

      let generate = expr
    end) : S))

and window_name () =
  Window_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and window_defn () =
  Window_defn.(
    (module Make
              (struct
                type t = A.ext A.base_window_name

                let generate = base_window_name
              end)
              (struct
                type t = A.ext A.partition_clause

                let generate = partition_clause
              end)
              (struct
                type t = A.ext A.order_by_clause

                let generate = order_by_clause
              end)
              (struct
                type t = A.ext A.frame_spec

                let generate = frame_spec
              end) : S))

and base_window_name () =
  Base_window_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and order_by_clause () =
  Order_by_clause.(
    (module Make (struct
      type t = A.ext A.ordering_term

      let generate = ordering_term
    end) : S))

and frame_spec () =
  Frame_spec.(
    (module Make
              (struct
                type t = A.ext A.frame_spec_core

                let generate = frame_spec_core
              end)
              (struct
                type t = A.ext A.frame_spec_excluding

                let generate = frame_spec_excluding
              end) : S))

and ordering_term () =
  Ordering_term.(
    (module Make
              (struct
                type t = A.ext A.expr

                let generate = expr
              end)
              (struct
                type t = A.ext A.collation_name

                let generate = collation_name
              end) : S))

and partition_clause () =
  Partition_clause.(
    (module Make (struct
      type t = A.ext A.expr

      let generate = expr
    end) : S))

and collation_name () =
  Collation_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and frame_spec_between () =
  Frame_spec_between.(
    (module Make
              (struct
                type t = A.ext A.frame_spec_between_1

                let generate = frame_spec_between_1
              end)
              (struct
                type t = A.ext A.frame_spec_between_2

                let generate = frame_spec_between_2
              end) : S))

and frame_spec_between_1 () =
  Frame_spec_between_1.(
    (module Make (struct
      type t = A.ext A.expr

      let generate = expr
    end) : S))

and frame_spec_between_2 () =
  Frame_spec_between_2.(
    (module Make (struct
      type t = A.ext A.expr

      let generate = expr
    end) : S))

and frame_spec_core () =
  Frame_spec_core.(
    (module Make
              (struct
                type t = A.ext A.expr

                let generate = expr
              end)
              (struct
                type t = A.ext A.frame_spec_between

                let generate = frame_spec_between
              end) : S))

and frame_spec_excluding () = Frame_spec_excluding.((module Make () : S))

and join_operator () = Join_operator.((module Make () : S))

and join_constraint () =
  Join_constraint.(
    (module Make
              (struct
                type t = A.ext A.expr

                let generate = expr
              end)
              (struct
                type t = A.ext A.column_name

                let generate = column_name
              end) : S))

and join_clause () =
  Join_clause.(
    (module Make
              (struct
                type t = A.ext A.table_or_subquery

                let generate = table_or_subquery
              end)
              (struct
                type t = A.ext A.join_operator

                let generate = join_operator
              end)
              (struct
                type t = A.ext A.join_constraint

                let generate = join_constraint
              end) : S))

and unary_operator () = Unary_operator.((module Make () : S))

and binary_operator () = Binary_operator.((module Make () : S))

and function_name () =
  Function_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and function' () =
  Function.(
    (module Make
              (struct
                type t = A.ext A.expr

                let generate = expr
              end)
              (struct
                type t = A.ext A.function_name

                let generate = function_name
              end)
              (struct
                type t = A.ext A.filter_clause

                let generate = filter_clause
              end)
              (struct
                type t = A.ext A.over_clause

                let generate = over_clause
              end) : S))

and filter_clause () =
  Filter_clause.(
    (module Make (struct
      type t = A.ext A.expr

      let generate = expr
    end) : S))

and limit_clause () =
  Limit_clause.(
    (module Make (struct
      type t = A.ext A.expr

      let generate = expr
    end) : S))

and over_clause () =
  Over_clause.(
    (module Make
              (struct
                type t = A.ext A.window_defn

                let generate = window_defn
              end)
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end) : S))

and common_table_expression () =
  Common_table_expression.(
    (module Make
              (struct
                type t = A.ext A.table_name

                let generate = table_name
              end)
              (struct
                type t = A.ext A.column_name

                let generate = column_name
              end)
              (struct
                type t = A.ext A.select_statement

                let generate = select_statement
              end) : S))

and with_clause () =
  With_clause.(
    (module Make (struct
      type t = A.ext A.common_table_expression

      let generate = common_table_expression
    end) : S))

and compound_operator () = Compound_operator.((module Make () : S))

and update_statement () =
  Update_statement.(
    (module Make
              (struct
                type t = A.ext A.column_name

                let generate = column_name
              end)
              (struct
                type t = A.ext A.qualified_table_name

                let generate = qualified_table_name
              end)
              (struct
                type t = A.ext A.expr

                let generate = expr
              end)
              (struct
                type t = A.ext A.from_clause

                let generate = from_clause
              end)
              (struct
                type t = A.ext A.where_clause

                let generate = where_clause
              end) : S))

and qualified_table_name () =
  Qualified_table_name.(
    (module Make
              (struct
                type t = A.ext A.table_name

                let generate = table_name
              end)
              (struct
                type t = A.ext A.schema_name

                let generate = schema_name
              end) : S))
