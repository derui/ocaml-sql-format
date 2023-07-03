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

  type identifier = string [@@deriving show, eq]
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

and not_op = [ `not' ] option [@@deriving show, eq]

type 'a identifier =
  | Identifier of
      [ `literal of Literal.identifier
      | `non_reserved of 'a non_reserved_identifier
      ]
      * 'a

and 'a non_reserved_identifier =
  | Non_reserved_identifier of
      [ `exception'
      | `serial
      | `object'
      | `index
      | `json
      | `geometry
      | `geography
      | `basic of 'a basic_non_reserved
      ]
      * 'a

and 'a basic_non_reserved =
  | Basic_non_reserved of
      [ `instead
      | `view
      | `enabled
      | `disabled
      | `key
      | `textagg
      | `count
      | `count_big
      | `row_number
      | `rank
      | `dense_rank
      | `sum
      | `avg
      | `min
      | `max
      | `every
      | `stddev_pop
      | `stddev_samp
      | `var_samp
      | `var_pop
      | `document
      | `content
      | `trim
      | `empty
      | `ordinality
      | `path
      | `first
      | `last
      | `next
      | `substring
      | `extract
      | `to_chars
      | `to_bytes
      | `timestampadd
      | `timestampdiff
      | `querystring
      | `namespace
      | `result
      | `accesspattern
      | `auto_increment
      | `wellformed
      | `sql_tsi_frac_second
      | `sql_tsi_second
      | `sql_tsi_minute
      | `sql_tsi_hour
      | `sql_tsi_day
      | `sql_tsi_week
      | `sql_tsi_month
      | `sql_tsi_quarter
      | `sql_tsi_year
      | `texttable
      | `arraytable
      | `jsontable
      | `selector
      | `skip
      | `width
      | `passing
      | `name
      | `encoding
      | `columns
      | `delimiter
      | `quote
      | `header
      | `nulls
      | `objecttable
      | `version
      | `including
      | `excluding
      | `xmldeclaration
      | `variadic
      | `raise
      | `chain
      | `jsonarray_agg
      | `jsonobject
      | `preserve
      | `upsert
      | `after
      | `type'
      | `translator
      | `jaas
      | `condition
      | `mask
      | `access
      | `control
      | `none
      | `data
      | `database
      | `privileges
      | `role
      | `schema
      | `use
      | `repository
      | `rename
      | `domain
      | `usage
      | `position
      | `current
      | `unbounded
      | `preceding
      | `following
      | `listagg
      | `explain
      | `analyze
      | `text
      | `format
      | `yaml
      | `epoch
      | `quarter
      | `policy
      ]
      * 'a

and 'a unsigned_integer = Unsigned_integer of Literal.unsigned_integer * 'a

and 'a unsigned_value_expression_primary =
  | Unsigned_value_expression_primary of
      [ `parameter_qmark
      | `parameter_dollar of Literal.unsigned_integer
      | `parameter_identifier of 'a identifier
      | `parameter_subquery of 'a subquery
      | `case_expression of 'a case_expression
      | `searched_case_expression of 'a searched_case_expression
      | `nested_expression of 'a nested_expression
      | `unescaped_function of 'a unescaped_function
      ]
      * 'a

and 'a case_expression =
  | Case_expression of
      'a expression
      * ('a expression * 'a expression) list
      * 'a expression option
      * 'a

and 'a searched_case_expression =
  | Searched_case_expression of
      ('a expression * 'a expression) list * 'a expression option * 'a

and 'a nested_expression = Nested_expression of 'a expression list * 'a

and 'a non_numeric_literal =
  | Non_numeric_literal of
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

and 'a unsigned_numeric_literal =
  | Unsigned_numeric_literal of
      [ `unsigned of Literal.unsigned_integer
      | `approximate of Literal.approximate_numeric
      | `decimal of Literal.decimal_numeric
      ]
      * 'a

and 'a directly_executable_statement =
  | Directly_executable_statement of 'a query_expression * 'a

and 'a query_expression =
  | Query_expression of
      'a with_list_element list * 'a query_expression_body * 'a

and 'a with_list_element =
  | With_list_element of
      'a identifier * 'a column_list option * 'a query_expression * 'a

and 'a column_list = Column_list of 'a identifier list * 'a

and 'a query_expression_body_ =
  { term : 'a query_term
  ; terms : (joiner * qualifier option * 'a query_term) list
  ; order_by : 'a order_by_clause option
  ; limit : 'a limit_clause option
  }

and 'a query_expression_body =
  | Query_expression_body of 'a query_expression_body_ * 'a

and 'a order_by_clause = Order_by_clause of 'a sort_specification list * 'a

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
  | Limit_clause of
      [ `limit of 'a limit_clause_limit_
      | `offset of 'a limit_clause_offset_ * row_variant_
      | `fetch of 'a fetch_clause
      ]
      * 'a

and 'a integer_parameter =
  | Integer_parameter of
      [ `unsigned_integer of Literal.unsigned_integer
      | `expression of 'a unsigned_value_expression_primary
      ]
      * 'a

and 'a fetch_clause_ =
  { position : [ `first | `next ]
  ; param : 'a integer_parameter option
  }

and 'a fetch_clause = Fetch_clause of 'a fetch_clause_ * row_variant_ * 'a

and 'a sort_specification =
  | Sort_specification of
      'a sort_key
      * [ `asc | `desc ] option
      * [ `null_first | `null_last ] option
      * 'a

and 'a sort_key = Sort_key of 'a expression * 'a

and 'a query_term =
  | Query_term of
      'a query_primary * (qualifier option * 'a query_primary) list * 'a

and 'a query_primary =
  | Query_primary of
      [ `query of 'a query | `nested of 'a query_expression_body ] * 'a

and 'a query =
  | Query of
      'a select_clause * 'a into_clause option * 'a from_clause option * 'a

and 'a from_clause_ =
  { tables : 'a table_reference list
  ; where : 'a where_clause option
  ; group_by : 'a group_by_clause option
  ; having : 'a having_clause option
  }

and 'a from_clause = From_clause of 'a from_clause_ * 'a

and 'a where_clause = Where_clause of 'a condition * 'a

and 'a group_by_clause =
  | Group_by_clause of
      [ `rollup of 'a expression list | `default of 'a expression list ] * 'a

and 'a having_clause = Having_clause of 'a condition * 'a

and 'a into_clause = Into_clause of 'a identifier * 'a

and 'a select_clause =
  | Select_clause of
      qualifier option
      * [ `asterisk | `select_list of 'a select_sublist list ]
      * 'a

and 'a joined_table =
  | Joined_table of
      'a table_primary
      * [ `cross of [ `cross | `union ] * 'a table_primary
        | `qualified of
          [ `left | `right | `full | `inner ] option
          * 'a table_reference
          * 'a condition
        ]
        list
      * 'a

and 'a table_primary =
  | Table_primary of
      [ `table_name of 'a identifier * 'a identifier option
      | `table_subquery of 'a table_subquery
      | `joined of 'a joined_table
      ]
      * 'a

and 'a table_subquery =
  | Table_subquery of
      [ `table | `lateral ] option * 'a query_expression * 'a identifier * 'a

and 'a table_reference = Table_reference of 'a joined_table * 'a

and 'a select_sublist =
  | Select_sublist of
      [ `Select_derived_column of 'a expression * 'a identifier option
      | `All_in_group of string
      ]
      * 'a

and 'a expression = Expression of 'a condition * 'a

and 'a condition = Condition of 'a boolean_value_expression * 'a

and 'a boolean_value_expression =
  | Boolean_value_expression of 'a boolean_term * 'a boolean_term list * 'a

and 'a boolean_term =
  | Boolean_term of 'a boolean_factor * 'a boolean_factor list * 'a

and 'a boolean_factor = Boolean_factor of 'a boolean_primary * not_op * 'a

and 'a boolean_primary =
  | Boolean_primary of
      'a common_value_expression
      * [ `comparison of 'a comparison_predicate
        | `is_null of 'a is_null_predicate
        | `between of 'a between_predicate
        | `like_regex of 'a like_regex_predicate
        | `match' of 'a match_predicate
        | `quantified of 'a quantified_comparison_predicate
        | `in' of 'a in_predicate
        | `is_distinct of 'a is_distinct
        | `exists of 'a exists_predicate
        ]
        option
      * 'a

and 'a exists_predicate = Exists_predicate of 'a subquery * 'a

and 'a quantified_comparison_predicate =
  | Quantified_comparison_predicate of
      'a comparison_operator
      * [ `all | `some | `any ]
      * [ `expr of 'a expression | `query of 'a subquery ]
      * 'a

and 'a match_predicate =
  | Match_predicate of
      [ `similar | `like ]
      * 'a common_value_expression
      * 'a character option
      * not_op
      * 'a

and 'a like_regex_predicate =
  | Like_regex_predicate of 'a common_value_expression * not_op * 'a

and 'a between_predicate =
  | Between_predicate of
      'a common_value_expression * 'a common_value_expression * not_op * 'a

and 'a is_null_predicate = Is_null_predicate of not_op * 'a

and 'a comparison_predicate =
  | Comparison_predicate of
      'a comparison_operator * 'a common_value_expression * 'a

and 'a is_distinct = Is_distinct of 'a common_value_expression * not_op * 'a

and 'a in_predicate =
  | In_predicate of
      [ `query of 'a subquery | `values of 'a common_value_expression list ]
      * not_op
      * 'a

and 'a character = Character of Literal.sql_string * 'a

and 'a subquery = Subquery of [ `query of 'a query_expression ] * 'a

and 'a comparison_operator =
  | Comparison_operator of [ `eq | `ne | `ne2 | `ge | `gt | `le | `lt ] * 'a

and 'a common_value_expression =
  | Common_value_expression of
      'a numeric_value_expression
      * ([ `amp | `concat ] * 'a numeric_value_expression) list
      * 'a

and 'a numeric_value_expression =
  | Numeric_value_expression of
      'a term * ([ `plus | `minus ] * 'a term) list * 'a

and 'a term =
  | Term of
      'a value_expression_primary
      * ([ `star | `slash ] * 'a value_expression_primary) list
      * 'a

and 'a value_expression_primary =
  | Value_expression_primary of
      [ `non_numeric_literal of 'a non_numeric_literal
      | `unsigned_numeric_literal of
        [ `plus | `minus ] option * 'a unsigned_numeric_literal
      | `unsigned_value_expression_primary of
        'a unsigned_value_expression_primary * 'a numeric_value_expression list
      ]
      * 'a

and 'a unescaped_function =
  | Unescaped_function of
      [ `text_aggregate_function of
        'a text_aggregate_function
        * 'a filter_clause option
        * 'a window_specification option
      | `standard_aggregate_function of
        'a standard_aggregate_function
        * 'a filter_clause option
        * 'a window_specification option
      | `analytic_aggregate_function of
        'a analytic_aggregate_function
        * 'a filter_clause option
        * 'a window_specification
      | `function' of 'a function' * 'a window_specification option
      ]
      * 'a

and 'a derived_column =
  | Derived_column of 'a expression * 'a identifier option * 'a

and 'a text_aggregate_function =
  | Text_aggregate_function of
      'a derived_column list
      * 'a character option (* delimiter *)
      * [ `quote of 'a character | `no_quote ] option (* quote *)
      * 'a identifier option (* encoding *)
      * 'a order_by_clause option
      * 'a

and 'a standard_aggregate_function =
  | Standard_aggregate_function of
      [ `count_star
      | `count_big_star
      | `call of standard_aggregate_functions * qualifier option * 'a expression
      ]
      * 'a

and standard_aggregate_functions =
  [ `count
  | `count_big
  | `sum
  | `avg
  | `min
  | `max
  | `every
  | `stddev_pop
  | `stddev_samp
  | `var_samp
  | `var_pop
  | `some
  | `any
  ]

and 'a analytic_aggregate_function =
  | Analytic_aggregate_function of analytic_aggregate_functions * 'a

and analytic_aggregate_functions =
  [ `row_number
  | `rank
  | `dense_rank
  | `percent_rank
  | `cume_dist
  ]

and 'a filter_clause = Filter_clause of 'a boolean_primary * 'a

and 'a window_specification =
  | Window_specification of
      'a expression list
      * 'a order_by_clause option
      * 'a window_frame option
      * 'a

and 'a window_frame =
  | Window_frame of
      { typ : [ `range | `rows ]
      ; bound :
          [ `between of 'a window_frame_bound * 'a window_frame_bound
          | `raw of 'a window_frame_bound
          ]
      ; metadata : 'a
      }

and 'a window_frame_bound =
  | Window_frame_bound of
      [ `bounding of
        [ `unbounded | `bounded of 'a unsigned_integer ]
        * [ `following | `preceding ]
      | `current
      ]
      * 'a

and 'a simple_data_type =
  | Simple_data_type of
      [ `string of 'a unsigned_integer option
      | `varchar of 'a unsigned_integer option
      | `boolean
      | `byte
      | `tinyint
      | `short
      | `smallint
      | `char of 'a unsigned_integer option
      | `integer
      | `long
      | `bigint
      | `biginteger of 'a unsigned_integer option
      | `float
      | `real
      | `double
      | `bigdecimal of 'a unsigned_integer option * 'a unsigned_integer option
      | `decimal of 'a unsigned_integer option * 'a unsigned_integer option
      | `date
      | `time
      | `timestamp of 'a unsigned_integer option
      | `object' of 'a unsigned_integer option
      | `blob of 'a unsigned_integer option
      | `clob of 'a unsigned_integer option
      | `json
      | `varbinary of 'a unsigned_integer option
      | `geometry
      | `geography
      | `xml
      ]
      * 'a

and 'a basic_data_type = Basic_data_type of 'a simple_data_type * bool * 'a

and 'a data_type =
  | Data_type of
      [ `basic of 'a basic_data_type | `other of 'a identifier * bool ] * 'a

and 'a function' =
  | Function of
      [ `convert of 'a expression * 'a data_type
      | `cast of 'a expression * 'a data_type
      | `substring of
        'a expression
        * [ `from_for of 'a expression * 'a expression option
          | `list of 'a expression list
          ]
      | `extract of
        'a expression
        * [ `year
          | `month
          | `day
          | `hour
          | `minute
          | `second
          | `quarter
          | `epoch
          | `dow
          | `doy
          ]
      | `trim of
        [ `leading of 'a expression option
        | `trailing of 'a expression option
        | `both of 'a expression option
        | `no_trimmer of 'a expression
        ]
        option
        * 'a expression
      | `to_chars of 'a expression * Literal.sql_string * 'a expression option
      | `to_bytes of 'a expression * Literal.sql_string * 'a expression option
      | `timestampadd of 'a time_interval * 'a expression * 'a expression
      | `timestampdiff of 'a time_interval * 'a expression * 'a expression
      | `left of 'a expression list
      | `right of 'a expression list
      | `char of 'a expression list
      | `user of 'a expression list
      | `year of 'a expression list
      | `month of 'a expression list
      | `hour of 'a expression list
      | `minute of 'a expression list
      | `second of 'a expression list
      | `xmlconcat of 'a expression list
      | `xmlcomment of 'a expression list
      | `xmltext of 'a expression list
      | `insert of 'a expression list
      | `translate of 'a expression list
      | `position of 'a common_value_expression * 'a common_value_expression
      | `listagg of
        'a expression * Literal.sql_string option * 'a order_by_clause
      | `current_date
      | `call of
        'a identifier
        * qualifier option
        * 'a expression list
        * 'a order_by_clause option
        * 'a filter_clause option
      | `current_timestamp of 'a unsigned_integer option
      | `current_time of 'a unsigned_integer option
      | `session_user
      ]
      * 'a

and 'a time_interval =
  | Time_interval of
      [ `frac_second
      | `second
      | `minute
      | `hour
      | `day
      | `week
      | `month
      | `quarter
      | `year
      ]
      * 'a

type ext = unit

type entry = ext directly_executable_statement
