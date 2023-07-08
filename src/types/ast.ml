open Basic
open Literal

(** statements *)
type 'a directly_executable_statement =
  | Directly_executable_statement of 'a query_expression * 'a

and 'a unsigned_value_expression_primary =
  | Unsigned_value_expression_primary of
      [ `parameter_qmark
      | `parameter_dollar of 'a unsigned_integer
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
      [ `unsigned_integer of 'a unsigned_integer
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

and 'a query = Query of 'a

and 'a into_clause = Into_clause of 'a identifier * 'a

and 'a expression = Expression of 'a condition * 'a

and 'a condition = Condition of 'a

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

and 'a character = Character of string * 'a

and 'a subquery = Subquery of [ `query of 'a query_expression ] * 'a

and 'a comparison_operator =
  | Comparison_operator of [ `eq | `ne | `ne2 | `ge | `gt | `le | `lt ] * 'a

and 'a common_value_expression = Common_value_expression of 'a

and 'a term =
  | Term of
      'a value_expression_primary
      * ([ `star | `slash ] * 'a value_expression_primary) list
      * 'a

and 'a value_expression_primary = Value_expression_primary of 'a

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

and 'a text_aggregate_function =
  | Text_aggregate_function of
      'a character option (* delimiter *)
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
      | `to_chars of 'a expression * string * 'a expression option
      | `to_bytes of 'a expression * string * 'a expression option
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
      | `listagg of 'a expression * string option * 'a order_by_clause
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

(** START query specification *)
type 'a query_specification =
  | Query_specification of
      qualifier option * 'a select_list * 'a table_expression * 'a

and 'a select_list =
  | Select_list of
      [ `asterisk | `list of 'a select_sublist * 'a select_sublist list ] * 'a

and 'a select_sublist =
  | Select_sublist of
      [ `derived of 'a derived_column | `qualified of 'a qualified_asterisk ]
      * 'a

and 'a derived_column =
  | Derived_column of 'a value_expression * 'a as_clause option * 'a

and 'a as_clause = As_clause of 'a identifier * 'a

and 'a qualified_asterisk =
  | Qualified_asterisk of
      [ `chain of 'a asterisked_identifier_chain
      | `all of 'a all_fields_reference
      ]
      * 'a

and 'a asterisked_identifier_chain =
  | Asterisked_identifier_chain of 'a identifier * 'a identifier list * 'a

and 'a all_fields_reference =
  | All_fields_reference of
      'a value_expression_primary * 'a all_field_column_name_list option * 'a

and 'a all_field_column_name_list =
  | All_field_column_name_list of 'a column_name_list * 'a
      (** table reference *)

and 'a column_name_list =
  | Column_name_list of 'a identifier * 'a identifier list * 'a
(* END query specification *)

(* START table expression *)
and 'a table_expression =
  | Table_expression of
      'a from_clause
      * 'a where_clause option
      * 'a group_by_clause option
      * 'a having_clause option
      * 'a window_clause option
      * 'a

(* TODO *)
(* END table expression *)

(* START from clause *)
and 'a from_clause = From_clause of 'a table_reference_list * 'a

and 'a table_reference_list =
  | Table_reference_list of 'a table_reference * 'a table_reference list * 'a
(* END from clause *)

(* START group by clause *)
and 'a group_by_clause =
  | Group_by_clause of
      qualifier option * 'a grouping_element_list * 'a (* TODO *)

and 'a grouping_element_list =
  | Grouping_element_list of
      'a grouping_element * 'a grouping_element list * 'a (* TODO *)

and 'a grouping_element = Grouping_element of 'a (* TODO *)

and 'a rollup_list = Rollup_list of 'a ordinary_grouping_set_list * 'a

and 'a cube_list = Cube_list of 'a ordinary_grouping_set_list * 'a

and 'a ordinary_grouping_set_list =
  | Ordinary_grouping_set_list of
      'a ordinary_grouping_set * 'a ordinary_grouping_set list * 'a

and 'a ordinary_grouping_set =
  | Ordinary_grouping_set of
      [ `column of 'a grouping_column_reference
      | `list of 'a grouping_column_reference_list
      ]
      * 'a

and 'a grouping_column_reference =
  | Grouping_column_reference of
      'a column_reference * 'a collate_clause option * 'a

and 'a grouping_column_reference_list =
  | Grouping_column_reference_list of
      'a grouping_column_reference * 'a grouping_column_reference list * 'a

and 'a grouping_set =
  | Grouping_set of
      [ `ordinary of 'a ordinary_grouping_set
      | `rollup of 'a rollup_list
      | `cube of 'a cube_list
      | `spec of 'a grouping_sets_specification
      | `empty of 'a empty_grouping_set
      ]
      * 'a

and 'a grouping_sets_specification =
  | Grouping_sets_specification of 'a grouping_set_list * 'a

and 'a grouping_set_list =
  | Grouping_set_list of 'a grouping_set * 'a grouping_set list * 'a

and 'a empty_grouping_set = Empty_grouping_set of 'a

and 'a column_reference =
  | Column_reference of
      [ `chain of 'a identifier_chain
      | `module' of 'a identifier * 'a identifier
      ]
      * 'a
(* END group by clause *)

(* START where clause  *)
and 'a where_clause = Where_clause of 'a search_condition * 'a
(* END where clause  *)

(* START having clause  *)
and 'a having_clause = Having_clause of 'a search_condition * 'a
(* END having clause  *)

(* START table reference  *)
and 'a table_reference =
  | Table_reference of
      [ `primary of 'a table_primary | `joined of 'a joined_table ]
      * 'a sample_clause option
      * 'a

and 'a table_primary =
  | Table_primary of
      [ `table_or_query of
        'a table_or_query_name
        * ('a identifier * 'a derived_column_list option) option
      | `derived of
        'a derived_table * 'a identifier * 'a derived_column_list option
      | `lateral of
        'a lateral_derived_table * 'a identifier * 'a derived_column_list option
      | `collection of
        'a collection_derived_table
        * 'a identifier
        * 'a derived_column_list option
      | `table_function of
        'a table_function_derived_table
        * 'a identifier
        * 'a derived_column_list option
      | `only of
        'a only_spec * ('a identifier * 'a derived_column_list option) option
      | `joined of 'a joined_table
      ]
      * 'a

and 'a joined_table = Joined_table of 'a (* TODO *)

and 'a sample_clause =
  | Sample_clause of
      [ `bernoulli | `system ]
      * 'a numeric_value_expression
      * 'a repeatable_clause option
      * 'a

and 'a repeatable_clause =
  | Repeatable_clause of 'a numeric_value_expression * 'a

and 'a only_spec = Only_spec of 'a table_or_query_name * 'a

and 'a lateral_derived_table = Lateral_derived_table of 'a table_subquery * 'a

and 'a collection_derived_table =
  | Collection_derived_table of
      'a collection_value_expression * [ `ordinality ] option * 'a

and 'a table_function_derived_table =
  | Table_function_derived_table of 'a collection_value_expression * 'a

and 'a derived_table = Derived_table of 'a table_subquery * 'a

and 'a table_or_query_name =
  | Table_or_query_name of
      [ `table of 'a table_name | `query of 'a query_name ] * 'a

and 'a table_name =
  | Table_name of
      [ `module' | `schema of 'a schema_name ] option * 'a identifier * 'a

and 'a schema_name = Schema_name of 'a identifier option * 'a identifier * 'a

and 'a schema_qualified_name =
  | Schema_qualified_name of 'a schema_name option * 'a identifier * 'a

and 'a identifier_chain =
  | Identifier_chain of 'a identifier * 'a identifier list * 'a

and 'a collate_name = Collate_name of 'a schema_qualified_name * 'a

and 'a query_name = Query_name of 'a identifier * 'a

and 'a derived_column_list = Derived_column_list of 'a column_name_list * 'a
(* END table reference  *)

and 'a search_condition = Search_condition of 'a boolean_value_expression * 'a

and 'a table_subquery = Table_subquery of 'a (* TODO *)

and 'a window_clause = Window_clause of 'a (* TODO *)

and 'a boolean_value_expression = Boolean_value_expression of 'a (* TODO *)

and 'a value_expression = Value_expression of 'a (* TODO *)

and 'a numeric_value_expression = Numeric_value_expression of 'a (* TODO *)

and 'a collection_value_expression =
  | Collection_value_expression of 'a (* TODO *)

and 'a collate_clause = Collate_clause of 'a collate_name * 'a

type ext = Ext.ext

type entry = ext directly_executable_statement
