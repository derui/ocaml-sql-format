module Literal = struct
  type unsigned_integer = Unsigned_integer of string [@@deriving show, eq]

  and approximate_numeric = Approximate_numeric of string
  [@@deriving show, eq]

  and decimal_numeric = Decimal_numeric of string [@@deriving show, eq]

  type sql_string = string [@@deriving show, eq]

  type typed_string = string [@@deriving show, eq]

  type bin_string = string [@@deriving show, eq]

  type datetime_string =
    [ `date of string
    | `time of string
    | `timestamp of string
    ]
  [@@deriving show, eq]
end

type entry = Directly_executable_statement of directly_executable_statement
[@@deriving show, eq]

and directly_executable_statement = Query_expression of query_expression
[@@deriving show, eq]

and query_expression =
  { with_list : unit list
  ; body : query_expression_body
  }
[@@deriving show, eq]

and query_expression_body =
  | Query_expression_body of
      { term : query_term
      ; terms : (joiner * qualifier option * query_term) list
      ; order_by : order_by_clause option
      ; limit : limit_clause option
      }
[@@deriving show, eq]

and order_by_clause = Order_by_clause of sort_specification list
[@@deriving show, eq]

and limit_clause =
  | Limit_clause_limit of
      { count : integer_parameter
      ; offset :
          [ `comma of integer_parameter | `keyword of integer_parameter ] option
      }
  | Limit_clause_offset of
      { start : integer_parameter
      ; rows : [ `row | `rows ]
      ; fetch : fetch_clause option
      }
  | Limit_clause_fetch of fetch_clause
[@@deriving show, eq]

and integer_parameter =
  [ `unsigned_integer of Literal.unsigned_integer
  | `expression of unsigned_value_expression_primary
  ]
[@@deriving show, eq]

and fetch_clause =
  | Fetch_clause of
      { position : [ `first | `next ]
      ; param : integer_parameter option
      ; rows : [ `row | `rows ]
      }
[@@deriving show, eq]

and sort_specification =
  | Sort_specification of
      { key : sort_key
      ; order : [ `asc | `desc ] option
      ; null_order : [ `null_first | `null_last ] option
      }
[@@deriving show, eq]

and sort_key = expression [@@deriving show, eq]

and query_term = query_primary * (qualifier option * query_primary) list
[@@deriving show, eq]

and query_primary = Query of query [@@deriving show, eq]

and query =
  { clause : select_clause
  ; into : into_clause option
  ; from : from_clause option
  }
[@@deriving show, eq]

and from_clause =
  { tables : table_reference list
  ; where : where_clause option
  ; group_by : group_by_clause option
  ; having : having_clause option
  }
[@@deriving show, eq]

and where_clause = Where_clause of condition [@@deriving show, eq]

and group_by_clause =
  | Group_by_clause of
      [ `rollup of expression list | `default of expression list ]
[@@deriving show, eq]

and having_clause = Having_clause of condition [@@deriving show, eq]

and into_clause = Into_clause of identifier [@@deriving show, eq]

and select_clause =
  { qualifier : qualifier option
  ; select_list : [ `asterisk | `select_list of select_sublist list ]
  }
[@@deriving show, eq]

and joined_table = table_primary [@@deriving show, eq]

and table_primary = [ `table_name of identifier * identifier option ]
[@@deriving show, eq]

and table_reference = Joined_table of joined_table [@@deriving show, eq]

and qualifier =
  | Distinct
  | All
[@@deriving show, eq]

and joiner =
  | Union
  | Except
[@@deriving show, eq]

and select_sublist =
  | Select_derived_column of
      { exp : expression
      ; alias : identifier option
      }
  | All_in_group of string
[@@deriving show, eq]

and identifier = Ident of string [@@deriving show, eq]

and expression = condition [@@deriving show, eq]

and condition = boolean_value_expression [@@deriving show, eq]

and boolean_value_expression = boolean_term * boolean_term list
[@@deriving show, eq]

and boolean_term = boolean_factor * boolean_factor list [@@deriving show, eq]

and boolean_factor =
  [ `Not of boolean_primary
  | `Normal of boolean_primary
  ]
[@@deriving show, eq]

and boolean_primary =
  | Boolean_primary of
      { value : common_value_expression
      ; predicate : boolean_primary_predicate option
      }
[@@deriving show, eq]

and boolean_primary_predicate =
  [ `comparison of
    [ `eq | `ne | `ne2 | `ge | `gt | `le | `lt ] * common_value_expression
  | `is_null
  | `is_not_null
  | `between of common_value_expression * common_value_expression
  | `between_not of common_value_expression * common_value_expression
  | `like_regex of common_value_expression
  | `like_regex_not of common_value_expression
  ]
[@@deriving show, eq]

and common_value_expression =
  numeric_value_expression
  * ([ `amp | `concat ] * numeric_value_expression) list
[@@deriving show, eq]

and numeric_value_expression = term * ([ `plus | `minus ] * term) list
[@@deriving show, eq]

and term =
  value_expression_primary
  * ([ `star | `slash ] * value_expression_primary) list
[@@deriving show, eq]

and value_expression_primary =
  | Non_numeric_literal of non_numeric_literal
  | Unsigned_numeric_literal of
      [ `plus | `minus ] option * unsigned_numeric_literal
  | Unsigned_value_expression_primary of
      { exp : unsigned_value_expression_primary
      ; indices : numeric_value_expression list
      }
[@@deriving show, eq]

and unsigned_value_expression_primary =
  [ `parameter_qmark
  | `parameter_dollar of Literal.unsigned_integer
  | `identifier of identifier
  ]
[@@deriving show, eq]

and non_numeric_literal =
  [ `string of Literal.sql_string
  | `typed_string of Literal.typed_string
  | `bin_string of Literal.bin_string
  | `TRUE
  | `FALSE
  | `UNKNOWN
  | `NULL
  | `datetime_string of Literal.datetime_string
  ]
[@@deriving show, eq]

and unsigned_numeric_literal =
  [ `unsigned of Literal.unsigned_integer
  | `approximate of Literal.approximate_numeric
  | `decimal of Literal.decimal_numeric
  ]
[@@deriving show, eq]
