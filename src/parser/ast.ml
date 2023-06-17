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

(* no-info types *)
type qualifier =
  [ `Distinct
  | `All
  ]
[@@deriving show, eq]

and joiner =
  [ `Union
  | `Except
  ]
[@@deriving show, eq]

and row_variant_ =
  [ `row
  | `rows
  ]
[@@deriving show, eq]

type 'a identifier = [ `Identifier of string * 'a ]

and 'a unsigned_value_expression_primary =
  [ `Unsigned_value_expression_primary of
    [ `parameter_qmark
    | `parameter_dollar of Literal.unsigned_integer
    | `parameter_identifier of 'a identifier
    ]
    * 'a
  ]

and 'a non_numeric_literal =
  [ `Non_numeric_literal of
    [ `string of Literal.sql_string
    | `typed_string of Literal.typed_string
    | `bin_string of Literal.bin_string
    | `TRUE
    | `FALSE
    | `UNKNOWN
    | `NULL
    | `datetime_string of Literal.datetime_string
    ]
    * 'a
  ]

and 'a unsigned_numeric_literal =
  [ `Unsigned_numeric_literal of
    [ `unsigned of Literal.unsigned_integer
    | `approximate of Literal.approximate_numeric
    | `decimal of Literal.decimal_numeric
    ]
    * 'a
  ]

and 'a directly_executable_statement =
  [ `Directly_executable_statement of 'a query_expression * 'a ]

and 'a query_expression =
  [ `Query_expression of
    'a query_expression_body list * 'a query_expression_body * 'a
  ]

and 'a query_expression_body_ =
  { term : 'a query_term
  ; terms : (joiner * qualifier option * 'a query_term) list
  ; order_by : 'a order_by_clause option
  ; limit : 'a limit_clause option
  }

and 'a query_expression_body =
  [ `Query_expression_body of 'a query_expression_body_ * 'a ]

and 'a order_by_clause = [ `Order_by_clause of 'a sort_specification list * 'a ]

and 'a limit_clause_limit_ =
  { count : 'a integer_parameter
  ; offset :
      [ `comma of 'a integer_parameter | `keyword of 'a integer_parameter ]
      option
  }

and 'a limit_clause_offset_ =
  { start : 'a integer_parameter
  ; fetch : 'a fetch_clause option
  }

and 'a limit_clause =
  [ `Limit_clause of
    [ `limit of 'a limit_clause_limit_
    | `offset of 'a limit_clause_offset_ * row_variant_
    | `fetch of 'a fetch_clause
    ]
    * 'a
  ]

and 'a integer_parameter =
  [ `Integer_parameter of
    [ `unsigned_integer of Literal.unsigned_integer
    | `expression of 'a unsigned_value_expression_primary
    ]
    * 'a
  ]

and 'a fetch_clause_ =
  { position : [ `first | `next ]
  ; param : 'a integer_parameter option
  }

and 'a fetch_clause = [ `Fetch_clause of 'a fetch_clause_ * row_variant_ * 'a ]

and 'a sort_specification =
  [ `Sort_specification of
    'a sort_key
    * [ `asc | `desc ] option
    * [ `null_first | `null_last ] option
    * 'a
  ]

and 'a sort_key = [ `Sort_key of 'a expression * 'a ]

and 'a query_term =
  [ `Query_term of
    'a query_primary * (qualifier option * 'a query_primary) list * 'a
  ]

and 'a query_primary = [ `Query_primary of 'a query * 'a ]

and 'a query =
  [ `Query of
    'a select_clause * 'a into_clause option * 'a from_clause option * 'a
  ]

and 'a from_clause_ =
  { tables : 'a table_reference list
  ; where : 'a where_clause option
  ; group_by : 'a group_by_clause option
  ; having : 'a having_clause option
  }

and 'a from_clause = [ `From_clause of 'a from_clause_ * 'a ]

and 'a where_clause = [ `Where_clause of 'a condition * 'a ]

and 'a group_by_clause =
  [ `Group_by_clause of
    [ `rollup of 'a expression list | `default of 'a expression list ] * 'a
  ]

and 'a having_clause = [ `Having_clause of 'a condition * 'a ]

and 'a into_clause = [ `Into_clause of 'a identifier * 'a ]

and 'a select_clause =
  [ `Select_clause of
    qualifier option
    * [ `asterisk | `select_list of 'a select_sublist list ]
    * 'a
  ]

and 'a joined_table = [ `Joined_table of 'a table_primary * 'a ]

and 'a table_primary =
  [ `Table_primary of
    [ `table_name of 'a identifier * 'a identifier option ] * 'a
  ]

and 'a table_reference = [ `Table_reference of 'a joined_table * 'a ]

and 'a select_sublist =
  [ `Select_sublist of
    [ `Derived_column of 'a expression * 'a identifier option
    | `All_in_group of string
    ]
    * 'a
  ]

and 'a expression = [ `Expression of 'a condition * 'a ]

and 'a condition = [ `Condition of 'a boolean_value_expression * 'a ]

and 'a boolean_value_expression =
  [ `Boolean_value_expression of 'a boolean_term * 'a boolean_term list * 'a ]

and 'a boolean_term =
  [ `Boolean_term of 'a boolean_factor * 'a boolean_factor list * 'a ]

and 'a boolean_factor =
  [ `Boolean_factor of
    [ `not' of 'a boolean_primary | `normal of 'a boolean_primary ] * 'a
  ]

and 'a boolean_primary =
  [ `Boolean_primary of
    'a common_value_expression * 'a boolean_primary_predicate option * 'a
  ]

and 'a boolean_primary_predicate =
  [ `Boolean_primary_predicate of
    [ `comparison of 'a comparison_operator * 'a common_value_expression
    | `is_null
    | `is_not_null
    | `between of 'a common_value_expression * 'a common_value_expression
    | `between_not of 'a common_value_expression * 'a common_value_expression
    | `like_regex of 'a common_value_expression
    | `like_regex_not of 'a common_value_expression
    | `match' of
      [ `similar | `like ] * 'a common_value_expression * 'a character option
    | `match_not of
      [ `similar | `like ] * 'a common_value_expression * 'a character option
    | `quantified_exp of
      'a comparison_operator * [ `all | `some | `any ] * 'a expression
    | `quantified_query of
      'a comparison_operator * [ `all | `some | `any ] * 'a subquery
    ]
    * 'a
  ]

and 'a character = [ `Character of Literal.sql_string * 'a ]

and 'a subquery = [ `Subquery of [ `query of 'a query_expression ] * 'a ]

and 'a comparison_operator =
  [ `Comparison_operator of [ `eq | `ne | `ne2 | `ge | `gt | `le | `lt ] * 'a ]

and 'a common_value_expression =
  [ `Common_value_expression of
    'a numeric_value_expression
    * ([ `amp | `concat ] * 'a numeric_value_expression) list
    * 'a
  ]

and 'a numeric_value_expression =
  [ `Numeric_value_expression of
    'a term * ([ `plus | `minus ] * 'a term) list * 'a
  ]

and 'a term =
  [ `Term of
    'a value_expression_primary
    * ([ `star | `slash ] * 'a value_expression_primary) list
    * 'a
  ]

and 'a value_expression_primary =
  [ `Value_expression_primary of
    [ `non_numeric_literal of 'a non_numeric_literal
    | `unsigned_numeric_literal of
      [ `plus | `minus ] option * 'a unsigned_numeric_literal
    | `unsigned_value_expression_primary of
      'a unsigned_value_expression_primary * 'a numeric_value_expression list
    ]
    * 'a
  ]

type ext = unit

type entry = ext directly_executable_statement
