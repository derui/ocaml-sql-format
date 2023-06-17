module A = Parser.Ast
module Options = Options

let identifier () = Identifier.((module Make () : S))

let unsigned_value_expression_primary () =
  Unsigned_value_expression_primary.(
    (module Make (struct
      type t = A.ext A.identifier

      let generate = identifier
    end) : S))

let non_numeric_literal () = Non_numeric_literal.((module Make () : S))

let unsigned_numeric_literal () =
  Unsigned_numeric_literal.((module Make () : S))

let rec directly_executable_statement () =
  Directly_executable_statement.(
    (module Make (struct
      type t = A.ext A.query_expression

      let generate = query_expression
    end) : S))

and query_expression () =
  Query_expression.(
    (module Make (struct
      type t = A.ext A.query_expression_body

      let generate = query_expression_body
    end) : S))

and query_expression_body () =
  Query_expression_body.(
    (module Make
              (struct
                type t = A.ext A.query_term

                let generate = query_term
              end)
              (struct
                type t = A.ext A.order_by_clause

                let generate = order_by_clause
              end)
              (struct
                type t = A.ext A.limit_clause

                let generate = limit_clause
              end) : S))

and order_by_clause () =
  Order_by_clause.(
    (module Make (struct
      type t = A.ext A.sort_specification

      let generate = sort_specification
    end) : S))

and sort_specification () =
  Sort_specification.(
    (module Make (struct
      type t = A.ext A.sort_key

      let generate = sort_key
    end) : S))

and sort_key () =
  Sort_key.(
    (module Make (struct
      type t = A.ext A.expression

      let generate = expression
    end) : S))

and limit_clause () =
  Limit_clause.(
    (module Make
              (struct
                type t = A.ext A.integer_parameter

                let generate = integer_parameter
              end)
              (struct
                type t = A.ext A.fetch_clause

                let generate = fetch_clause
              end) : S))

and integer_parameter () =
  Integer_parameter.(
    (module Make (struct
      type t = A.ext A.unsigned_value_expression_primary

      let generate = unsigned_value_expression_primary
    end) : S))

and fetch_clause () =
  Fetch_clause.(
    (module Make (struct
      type t = A.ext A.integer_parameter

      let generate = integer_parameter
    end) : S))

and query_term () =
  Query_term.(
    (module Make (struct
      type t = A.ext A.query_primary

      let generate = query_primary
    end) : S))

and query_primary () =
  Query_primary.(
    (module Make (struct
      type t = A.ext A.query

      let generate = query
    end) : S))

and query () =
  Query.(
    (module Make
              (struct
                type t = A.ext A.select_clause

                let generate = select_clause
              end)
              (struct
                type t = A.ext A.into_clause

                let generate = into_clause
              end)
              (struct
                type t = A.ext A.from_clause

                let generate = from_clause
              end) : S))

and into_clause () =
  Into_clause.(
    (module Make (struct
      type t = A.ext A.identifier

      let generate = identifier
    end) : S))

and from_clause () =
  From_clause.(
    (module Make
              (struct
                type t = A.ext A.table_reference

                let generate = table_reference
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
              end) : S))

and table_reference () =
  Table_reference.(
    (module Make (struct
      type t = A.ext A.joined_table

      let generate = joined_table
    end) : S))

and joined_table () =
  Joined_table.(
    (module Make (struct
      type t = A.ext A.table_primary

      let generate = table_primary
    end) : S))

and table_primary () =
  Table_primary.(
    (module Make (struct
      type t = A.ext A.identifier

      let generate = identifier
    end) : S))

and where_clause () =
  Where_clause.(
    (module Make (struct
      type t = A.ext A.condition

      let generate = condition
    end) : S))

and group_by_clause () =
  Group_by_clause.(
    (module Make (struct
      type t = A.ext A.expression

      let generate = expression
    end) : S))

and having_clause () =
  Having_clause.(
    (module Make (struct
      type t = A.ext A.condition

      let generate = condition
    end) : S))

and select_clause () =
  Select_clause.(
    (module Make (struct
      type t = A.ext A.select_sublist

      let generate = select_sublist
    end) : S))

and select_sublist () =
  Select_sublist.(
    (module Make
              (struct
                type t = A.ext A.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.expression

                let generate = expression
              end) : S))

and expression () =
  Expression.(
    (module Make (struct
      type t = A.ext A.condition

      let generate = condition
    end) : S))

and condition () =
  Condition.(
    (module Make (struct
      type t = A.ext A.boolean_value_expression

      let generate = boolean_value_expression
    end) : S))

and boolean_value_expression () =
  Boolean_value_expression.(
    (module Make (struct
      type t = A.ext A.boolean_term

      let generate = boolean_term
    end) : S))

and boolean_term () =
  Boolean_term.(
    (module Make (struct
      type t = A.ext A.boolean_factor

      let generate = boolean_factor
    end) : S))

and boolean_factor () =
  Boolean_factor.(
    (module Make (struct
      type t = A.ext A.boolean_primary

      let generate = boolean_primary
    end) : S))

and boolean_primary () =
  Boolean_primary.(
    (module Make
              (struct
                type t = A.ext A.common_value_expression

                let generate = common_value_expression
              end)
              (struct
                type t = A.ext A.boolean_primary_predicate

                let generate = boolean_primary_predicate
              end) : S))

and common_value_expression () =
  Common_value_expression.(
    (module Make (struct
      type t = A.ext A.numeric_value_expression

      let generate = numeric_value_expression
    end) : S))

and boolean_primary_predicate () =
  Boolean_primary_predicate.(
    (module Make
              (struct
                type t = A.ext A.comparison_operator

                let generate = comparison_operator
              end)
              (struct
                type t = A.ext A.common_value_expression

                let generate = common_value_expression
              end)
              (struct
                type t = A.ext A.subquery

                let generate = subquery
              end)
              (struct
                type t = A.ext A.expression

                let generate = expression
              end)
              (struct
                type t = A.ext A.character

                let generate = character
              end) : S))

and subquery () =
  Subquery.(
    (module Make (struct
      type t = A.ext A.query_expression

      let generate = query_expression
    end) : S))

and comparison_operator () = Comparison_operator.((module Make () : S))

and numeric_value_expression () =
  Numeric_value_expression.(
    (module Make (struct
      type t = A.ext A.term

      let generate = term
    end) : S))

and term () =
  Term.(
    (module Make (struct
      type t = A.ext A.value_expression_primary

      let generate = value_expression_primary
    end) : S))

and value_expression_primary () =
  Value_expression_primary.(
    (module Make
              (struct
                type t = A.ext A.non_numeric_literal

                let generate = non_numeric_literal
              end)
              (struct
                type t = A.ext A.unsigned_numeric_literal

                let generate = unsigned_numeric_literal
              end)
              (struct
                type t = A.ext A.unsigned_value_expression_primary

                let generate = unsigned_value_expression_primary
              end)
              (struct
                type t = A.ext A.numeric_value_expression

                let generate = numeric_value_expression
              end) : S))

and character () = Character.((module Make () : S))
