open Basic
open Literal

type ext = Ext.ext

(* START query specification *)
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
(* END table expression *)

(* START from clause *)
and 'a from_clause = From_clause of 'a table_reference_list * 'a

and 'a table_reference_list =
  | Table_reference_list of 'a table_reference * 'a table_reference list * 'a
(* END from clause *)

(* START group by clause *)
and 'a group_by_clause =
  | Group_by_clause of qualifier option * 'a grouping_element_list * 'a

and 'a grouping_element_list =
  | Grouping_element_list of 'a grouping_element * 'a grouping_element list * 'a

and 'a grouping_element =
  | Grouping_element of
      [ `ordinary of 'a ordinary_grouping_set
      | `rollup of 'a rollup_list
      | `cube of 'a cube_list
      | `spec of 'a grouping_sets_specification
      | `empty of 'a empty_grouping_set
      ]
      * 'a

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

and 'a joined_table =
  | Joined_table of
      [ `cross of 'a cross_join
      | `qualified of 'a qualified_join
      | `natural of 'a natural_join
      | `union of 'a union_join
      ]
      * 'a

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

and 'a value_expression = Value_expression of 'a (* TODO *)

and 'a collection_value_expression =
  | Collection_value_expression of 'a (* TODO *)

and 'a collate_clause = Collate_clause of 'a collate_name * 'a

and 'a window_clause = Window_clause of 'a window_definition_list * 'a

and 'a window_definition_list =
  | Window_definition_list of
      'a window_definition * 'a window_definition list * 'a

and 'a window_definition =
  | Window_definition of 'a new_window_name * 'a window_specification * 'a

and 'a new_window_name = New_window_name of 'a identifier * 'a

and 'a window_specification =
  | Window_specification of 'a window_specification_detail * 'a

and 'a window_specification_detail =
  | Window_specification_detail of
      'a identifier option
      * 'a window_partition_clause option
      * 'a window_order_clause option
      * 'a window_frame_clause option
      * 'a

and 'a existing_window_name = Existing_window_name of 'a identifier * 'a

and 'a window_partition_clause =
  | Window_partition_clause of 'a window_partition_column_reference_list * 'a

and 'a window_partition_column_reference_list =
  | Window_partition_column_reference_list of
      'a window_partition_column_reference
      * 'a window_partition_column_reference list
      * 'a

and 'a window_partition_column_reference =
  | Window_partition_column_reference of
      'a column_reference * 'a collate_clause option * 'a

and 'a window_order_clause =
  | Window_order_clause of 'a sort_specification_list * 'a

and 'a window_frame_clause =
  | Window_frame_clause of
      'a window_frame_units
      * 'a window_frame_extent
      * 'a window_frame_exclusion option
      * 'a

and 'a window_frame_units = Window_frame_units of [ `rows | `range ] * 'a

and 'a window_frame_extent =
  | Window_frame_extent of
      [ `start of 'a window_frame_start | `between of 'a window_frame_between ]
      * 'a

and 'a window_frame_start =
  | Window_frame_start of
      [ `unbounded | `preceding of 'a window_frame_preceding | `current ] * 'a

and 'a window_frame_preceding =
  | Window_frame_preceding of 'a unsigned_value_specification * 'a

and 'a window_frame_between =
  | Window_frame_between of
      'a window_frame_bound_1 * 'a window_frame_bound_2 * 'a

and 'a window_frame_bound_1 =
  | Window_frame_bound_1 of 'a window_frame_bound * 'a

and 'a window_frame_bound_2 =
  | Window_frame_bound_2 of 'a window_frame_bound * 'a

and 'a window_frame_bound =
  | Window_frame_bound of
      [ `start of 'a window_frame_start
      | `unbounded
      | `following of 'a window_frame_following
      ]
      * 'a

and 'a window_frame_following =
  | Window_frame_following of 'a unsigned_value_specification * 'a

and 'a window_frame_exclusion =
  | Window_frame_exclusion of
      [ `current_row | `group | `ties | `no_others ] * 'a

and 'a sort_specification_list = Sort_specification_list of 'a (* TODO *)

and 'a cross_join = Cross_join of 'a table_reference * 'a table_primary * 'a

and 'a qualified_join =
  | Qualified_join of
      'a table_reference
      * 'a join_type option
      * 'a table_primary
      * 'a join_specification
      * 'a

and 'a natural_join =
  | Natural_join of
      'a table_reference * 'a join_type option * 'a table_primary * 'a

and 'a union_join = Union_join of 'a table_reference * 'a table_primary * 'a

and 'a join_specification =
  | Join_specification of
      [ `cond of 'a join_condition | `named of 'a named_columns_join ] * 'a

and 'a join_condition = Join_condition of 'a search_condition * 'a

and 'a named_columns_join = Named_columns_join of 'a join_column_list * 'a

and 'a join_type = Join_type of [ `inner | `outer of 'a outer_join_type ] * 'a

and 'a outer_join_type = Outer_join_type of [ `left | `right | `full ] * 'a

and 'a join_column_list = Join_column_list of 'a column_name_list * 'a

and 'a scalar_subquery = Scalar_subquery of 'a subquery * 'a

and 'a row_subquery = Row_subquery of 'a subquery * 'a

and 'a table_subquery = Table_subquery of 'a subquery * 'a

and 'a subquery = Subquery of 'a query_expression * 'a

and 'a query_expression =
  | Query_expression of 'a with_clause option * 'a query_expression_body * 'a

and 'a with_clause = With_clause of [ `recursive ] option * 'a with_list * 'a

and 'a with_list =
  | With_list of 'a with_list_element * 'a with_list_element list * 'a

and 'a with_list_element =
  | With_list_element of
      'a identifier
      * 'a column_name_list option
      * 'a query_expression
      * 'a search_or_cycle_clause option
      * 'a

and 'a query_expression_body =
  | Query_expression_body of
      [ `expr of 'a non_join_query_expression | `joined of 'a joined_table ]
      * 'a

and 'a non_join_query_expression =
  | Non_join_query_expression of
      [ `term of 'a non_join_query_term
      | `union of
        'a query_expression_body
        * qualifier option
        * 'a corresponding_spec option
        * 'a query_term
      | `except of
        'a query_expression_body
        * qualifier option
        * 'a corresponding_spec option
        * 'a query_term
      ]
      * 'a

and 'a query_term =
  | Query_term of
      [ `term of 'a non_join_query_term | `joined of 'a joined_table ] * 'a

and 'a non_join_query_term =
  | Non_join_query_term of
      [ `primary of 'a non_join_query_primary
      | `term of
        'a query_term
        * qualifier option
        * 'a corresponding_spec option
        * 'a query_primary
      ]
      * 'a

and 'a query_primary =
  | Query_primary of
      [ `non_join of 'a non_join_query_primary | `joined of 'a joined_table ]
      * 'a

and 'a non_join_query_primary =
  | Non_join_query_primary of
      [ `simple of 'a simple_table | `expr of 'a non_join_query_expression ]
      * 'a

and 'a simple_table =
  | Simple_table of
      [ `query of 'a query_specification
      | `table of 'a table_value_constructor
      | `explicit of 'a explicit_table
      ]
      * 'a

and 'a explicit_table = Explicit_table of 'a table_or_query_name * 'a

and 'a corresponding_spec =
  | Corresponding_spec of 'a corresponding_column_list option * 'a

and 'a corresponding_column_list =
  | Corresponding_column_list of 'a column_name_list * 'a

and 'a search_or_cycle_clause =
  | Search_or_cycle_clause of
      [ `search of 'a search_clause
      | `cycle of 'a cycle_clause
      | `search_and_cycle of 'a search_clause * 'a cycle_clause
      ]
      * 'a

and 'a search_clause =
  | Search_clause of 'a recursive_search_order * 'a sequence_column * 'a

and 'a recursive_search_order =
  | Recursive_search_order of
      [ `depth of 'a sort_specification_list
      | `breadth of 'a sort_specification_list
      ]
      * 'a

and 'a sequence_column = Sequence_column of 'a identifier * 'a

and 'a cycle_clause =
  | Cycle_clause of
      'a cycle_column_list
      * 'a cycle_mark_column
      * 'a cycle_mark_value
      * 'a non_cycle_mark_value
      * 'a path_column
      * 'a

and 'a cycle_column_list =
  | Cycle_column_list of 'a cycle_column * 'a cycle_column list * 'a

and 'a cycle_column = Cycle_column of 'a identifier * 'a

and 'a cycle_mark_column = Cycle_mark_column of 'a identifier * 'a

and 'a path_column = Path_column of 'a identifier * 'a

and 'a cycle_mark_value = Cycle_mark_value of 'a value_expression * 'a

and 'a non_cycle_mark_value = Non_cycle_mark_value of 'a value_expression * 'a

and 'a table_value_constructor =
  | Table_value_constructor of 'a row_value_expression_list * 'a

and 'a row_value_expression_list =
  | Row_value_expression_list of
      'a table_row_value_expression * 'a table_row_value_expression list * 'a

and 'a contextually_typed_table_value_constructor =
  | Contextually_typed_table_value_constructor of
      'a contextually_typed_row_value_expression_list * 'a

and 'a contextually_typed_row_value_expression_list =
  | Contextually_typed_row_value_expression_list of
      'a contextually_typed_row_value_expression
      * 'a contextually_typed_row_value_expression list
      * 'a

and 'a row_value_expression =
  | Row_value_expression of
      [ `special of 'a row_value_special_case
      | `explicit of 'a explicit_row_value_constructor
      ]
      * 'a

and 'a table_row_value_expression =
  | Table_row_value_expression of
      [ `special of 'a row_value_special_case
      | `row of 'a row_value_constructor
      ]
      * 'a

and 'a contextually_typed_row_value_expression =
  | Contextually_typed_row_value_expression of
      [ `special of 'a row_value_special_case
      | `row of 'a contextually_typed_row_value_constructor
      ]
      * 'a

and 'a row_value_predicand =
  | Row_value_predicand of
      [ `special of 'a row_value_special_case
      | `row of 'a row_value_constructor_predicand
      ]
      * 'a

and 'a row_value_special_case =
  | Row_value_special_case of 'a nonparenthesized_value_expression_primary * 'a

and 'a explicit_row_value_constructor =
  | Explicit_row_value_constructor of 'a (* TODO *)

and 'a row_value_constructor = Row_value_constructor of 'a (* TODO *)

and 'a contextually_typed_row_value_constructor =
  | Contextually_typed_row_value_constructor of 'a (* TODO *)

and 'a row_value_constructor_predicand =
  | Row_value_constructor_predicand of 'a (* TODO *)

and 'a numeric_value_expression =
  | Numeric_value_expression of
      [ `single of 'a term
      | `plus of 'a numeric_value_expression * 'a term
      | `minus of 'a numeric_value_expression * 'a term
      ]
      * 'a

and 'a term =
  | Term of
      [ `single of 'a factor
      | `asterisk of 'a factor * 'a factor
      | `solidus of 'a factor * 'a factor
      ]
      * 'a

and 'a factor = Factor of sign option * 'a numeric_primary * 'a

and 'a numeric_primary =
  | Numeric_primary of
      [ `primary of 'a value_expression_primary | `function' of 'a (* TODO *) ]
      * 'a

and 'a value_expression_primary =
  | Value_expression_primary of
      [ `paren of 'a parenthesized_value_expression
      | `non_paren of 'a nonparenthesized_value_expression_primary
      ]
      * 'a

and 'a parenthesized_value_expression =
  | Parenthesized_value_expression of 'a value_expression * 'a

and 'a nonparenthesized_value_expression_primary =
  | Nonparenthesized_value_expression_primary of
      [ (* |  `unsigned of 'a unsigned_value_specification *)
        `column of
        'a column_reference
      | `set_function of 'a set_function_specification
      | `window of 'a window_function
      | `scalar of 'a scalar_subquery
      | (* | `case expression of 'a case_expression *)
        (* | `cast of 'a cast_specification *)
        `field of
        'a field_reference
      | (* | `subtype of 'a subtype treatment *)
        (* | `method' of 'a method_invocation *)
        (* |`static of 'a static_method_invocation *)
        (* | `new' of 'a new_specification *)
        `attribute of
        'a attribute_or_method_reference
      | (* |`reference of 'a reference_resolution *)
        (* | `collection of 'a collection_value_constructor *)
        `array of
        'a array_element_reference
      | `multiset of 'a multiset_element_reference
      | (* | `routine of 'a routine_invocation *)
        `next of
        'a next_value_expression
      ]
      * 'a
(* TODO *)

and 'a sql_parameter_reference =
  | Sql_parameter_reference of 'a identifier_chain * 'a

and 'a window_function =
  | Window_function of
      'a window_function_type * 'a window_name_or_specification * 'a

and 'a window_function_type =
  | Window_function_type of
      [ `rank of 'a rank_function_type
      | `row_number (* TODO | `aggregate of 'a aggregate_function *)
      ]
      * 'a

and 'a rank_function_type =
  | Rank_function_type of
      [ `rank | `dense_rank | `percent_rank | `cume_dist ] * 'a

and 'a window_name_or_specification =
  | Window_name_or_specification of
      [ `name of 'a identifier | `spec of 'a window_specification ] * 'a

and 'a next_value_expression =
  | Next_value_expression of 'a schema_qualified_name * 'a

and 'a field_reference =
  | Field_reference of 'a value_expression_primary * 'a identifier * 'a

and 'a attribute_or_method_reference =
  | Attribute_or_method_reference of
      'a value_expression_primary
      * 'a identifier
      * 'a sql_argument_list option
      * 'a

and 'a sql_argument_list =
  | Sql_argument_list of 'a sql_argument * 'a sql_argument list * 'a

and 'a sql_argument =
  | Sql_argument of
      [ `value of 'a value_expression
      | `generalized of
        'a generalized_expression
        (* TODO | `target of 'a target_specification *)
      ]
      * 'a

and 'a generalized_expression =
  | Generalized_expression of
      'a value_expression * 'a schema_qualified_name * 'a

and 'a array_element_reference =
  | Array_element_reference of
      'a array_value_expression * 'a numeric_value_expression * 'a

and 'a multiset_element_reference =
  | Multiset_element_reference of 'a multiset_value_expression * 'a

and 'a string_value_expression =
  | String_value_expression of 'a character_value_expression * 'a

and 'a character_value_expression =
  | Character_value_expression of
      [ `concat of 'a concatenation | `factor of 'a character_factor ] * 'a

and 'a concatenation =
  | Concatenation of 'a character_value_expression * 'a character_factor * 'a

and 'a character_factor =
  | Character_factor of 'a character_primary * 'a collate_clause option * 'a

and 'a character_primary =
  | Character_primary of
      [ `primary of
        'a value_expression_primary
        (* TODO | `function' of 'a string_value_function *)
      ]
      * 'a

and 'a datetime_value_expression =
  | Datetime_value_expression of
      [ `term of 'a datetime_term
      | `plus_interval of 'a interval_value_expression * 'a datetime_term
      | `plus_datetime of 'a datetime_value_expression * 'a interval_term
      | `minus of 'a datetime_value_expression * 'a interval_term
      ]
      * 'a

and 'a datetime_term = Datetime_term of 'a datetime_factor * 'a

and 'a datetime_factor =
  | Datetime_factor of 'a datetime_primary * 'a time_zone_specifier option * 'a

and 'a datetime_primary =
  | Datetime_primary of
      [ `value of 'a value_expression_primary
      | `function' of 'a datetime_value_function
      ]
      * 'a

and 'a time_zone = Time_zone of 'a time_zone_specifier * 'a

and 'a time_zone_specifier =
  | Time_zone_specifier of [ `local | `time_zone of 'a interval_primary ] * 'a

and 'a interval_value_expression =
  | Interval_value_expression of
      [ `term of 'a interval_term
      | `plus of 'a interval_value_expression_1 * 'a interval_term_1
      | `minus of 'a interval_value_expression_1 * 'a interval_term_1
      | `qualifier of
        'a datetime_value_expression * 'a datetime_term * 'a interval_qualifier
      ]
      * 'a

and 'a interval_term =
  | Interval_term of
      [ `factor of 'a interval_factor
      | `asterisk of 'a interval_term_2 * 'a factor
      | `solidus of 'a interval_term_2 * 'a factor
      | `term of 'a term * 'a interval_factor
      ]
      * 'a

and 'a interval_factor =
  | Interval_factor of sign option * 'a interval_primary * 'a

and 'a interval_primary =
  | Interval_primary of
      [ `value of 'a value_expression_primary * 'a interval_qualifier option
      | `function' of 'a interval_value_function
      ]
      * 'a

and 'a interval_value_expression_1 =
  | Interval_value_expression_1 of 'a interval_value_expression * 'a

and 'a interval_term_1 = Interval_term_1 of 'a interval_term * 'a

and 'a interval_term_2 = Interval_term_2 of 'a interval_term * 'a

and 'a interval_value_function =
  | Interval_value_function of 'a interval_absolute_value_function * 'a

and 'a interval_absolute_value_function =
  | Interval_absolute_value_function of 'a interval_value_expression * 'a

and 'a array_value_expression =
  | Array_value_expression of
      [ `concat of 'a array_concatenation | `factor of 'a array_factor ] * 'a

and 'a array_concatenation =
  | Array_concatenation of 'a array_value_expression_1 * 'a array_factor * 'a

and 'a array_value_expression_1 =
  | Array_value_expression_1 of 'a array_value_expression * 'a

and 'a array_factor = Array_factor of 'a value_expression_primary * 'a

and 'a array_value_constructor =
  | Array_value_constructor of
      [ `enum of 'a array_value_constructor_by_enumeration
      | `query of 'a array_value_constructor_by_query
      ]
      * 'a

and 'a array_value_constructor_by_enumeration =
  | Array_value_constructor_by_enumeration of 'a array_element_list * 'a

and 'a array_element_list =
  | Array_element_list of 'a array_element * 'a array_element list * 'a

and 'a array_element = Array_element of 'a value_expression * 'a

and 'a array_value_constructor_by_query =
  | Array_value_constructor_by_query of
      'a query_expression * 'a order_by_clause option * 'a

and 'a order_by_clause = Order_by_clause of 'a (* TODO *)

and 'a multiset_value_expression =
  | Multiset_value_expression of
      [ `term of 'a multiset_term
      | `union of
        'a multiset_value_expression * 'a multiset_term * qualifier option
      | `except of
        'a multiset_value_expression * 'a multiset_term * qualifier option
      ]
      * 'a

and 'a multiset_term =
  | Multiset_term of
      [ `primary of 'a multiset_primary
      | `term of 'a multiset_term * 'a multiset_primary * qualifier option
      ]
      * 'a

and 'a multiset_primary =
  | Multiset_primary of
      [ `value of 'a value_expression_primary
      | `function' of 'a multiset_value_function
      ]
      * 'a

and 'a multiset_value_function =
  | Multiset_value_function of 'a multiset_set_function * 'a

and 'a multiset_set_function =
  | Multiset_set_function of 'a multiset_value_expression * 'a

and 'a multiset_value_constructor =
  | Multiset_value_constructor of
      [ `enum of 'a multiset_value_constructor_by_enumeration
      | `multi_query of 'a multiset_value_constructor_by_query
      | `table_query of 'a table_value_constructor_by_query
      ]
      * 'a

and 'a multiset_value_constructor_by_enumeration =
  | Multiset_value_constructor_by_enumeration of 'a multiset_element_list * 'a

and 'a multiset_element_list =
  | Multiset_element_list of 'a multiset_element * 'a multiset_element list * 'a

and 'a multiset_element = Multiset_element of 'a value_expression * 'a

and 'a multiset_value_constructor_by_query =
  | Multiset_value_constructor_by_query of 'a query_expression * 'a (* TODO *)

and 'a table_value_constructor_by_query =
  | Table_value_constructor_by_query of 'a query_expression * 'a

and 'a boolean_value_expression =
  | Boolean_value_expression of
      [ `term of 'a boolean_term
      | `or' of 'a boolean_value_expression * 'a boolean_term
      ]
      * 'a

and 'a boolean_term =
  | Boolean_term of
      [ `factor of 'a boolean_factor
      | `and' of 'a boolean_term * 'a boolean_factor
      ]
      * 'a

and 'a boolean_factor =
  | Boolean_factor of [ `not' ] option * 'a boolean_test * 'a

and 'a boolean_test =
  | Boolean_test of
      'a boolean_primary
      * [ `is of 'a truth_value | `is_not of 'a truth_value ] option
      * 'a

and 'a boolean_primary =
  | Boolean_primary of
      [ (* TODO `predicate of 'a predicate | *)
        `predicand of
        'a boolean_predicand
      ]
      * 'a

and 'a truth_value = Truth_value of [ `true' | `false' | `unknown ] * 'a

and 'a boolean_predicand =
  | Boolean_predicand of
      [ `paren of 'a parenthesized_boolean_value_expression
      | `non of 'a nonparenthesized_value_expression_primary
      ]
      * 'a

and 'a parenthesized_boolean_value_expression =
  | Parenthesized_boolean_value_expression of 'a boolean_value_expression * 'a

and 'a datetime_value_function =
  | Datetime_value_function of
      [ `date of 'a current_date_value_function
      | `time of 'a current_time_value_function
      | `local_time of 'a current_local_time_value_function
      | `timestamp of 'a current_timestamp_value_function
      | `local_timestamp of 'a current_local_timestamp_value_function
      ]
      * 'a

and 'a current_date_value_function = Current_date_value_function of 'a

and 'a current_time_value_function =
  | Current_time_value_function of 'a time_precision option * 'a

and 'a current_local_time_value_function =
  | Current_local_time_value_function of 'a time_precision option * 'a

and 'a current_timestamp_value_function =
  | Current_timestamp_value_function of 'a timestamp_precision option * 'a

and 'a current_local_timestamp_value_function =
  | Current_local_timestamp_value_function of 'a timestamp_precision option * 'a

and 'a time_precision =
  | Time_precision of 'a time_fractional_seconds_precision * 'a

and 'a timestamp_precision =
  | Timestamp_precision of 'a time_fractional_seconds_precision * 'a

and 'a time_fractional_seconds_precision =
  | Time_fractional_seconds_precision of 'a unsigned_integer * 'a

and 'a data_type =
  | Data_type of
      [ `predefined of 'a predefined_type
      | `row of 'a row_type
      | `path of 'a path_resolved_user_defined_type_name
      | `ref of 'a reference_type
      | `collection of 'a collection_type
      ]
      * 'a

and 'a predefined_type =
  | Predefined_type of
      [ `character of 'a character_string_type * 'a * 'a collate_clause option
      | `national_character of
        'a national_character_string_type * 'a collate_clause option
      | `blob of 'a binary_large_object_string_type
      | `numeric of 'a numeric_type
      | `boolean of 'a boolean_type
      | `datetime of 'a datetime_type
      | `interval of 'a interval_type
      ]
      * 'a

and 'a character_string_type =
  | Character_string_type of
      [ `character of 'a length option
      | `char of 'a length option
      | `character_varying of 'a length option
      | `char_varying of 'a length option
      | `varchar of 'a length option
      | `character_large_object of 'a large_object_length option
      | `char_large_object of 'a large_object_length option
      | `clob of 'a large_object_length option
      ]
      * 'a

and 'a national_character_string_type =
  | National_character_string_type of
      [ `character of 'a length option
      | `char of 'a length option
      | `nchar of 'a length option
      | `character_varying of 'a length option
      | `char_varying of 'a length option
      | `nchar_varying of 'a length option
      | `character_large_object of 'a large_object_length option
      | `nchar_large_object of 'a large_object_length option
      | `nclob of 'a large_object_length option
      ]
      * 'a

and 'a binary_large_object_string_type =
  | Binary_large_object_string_type of
      [ `long | `short ] * 'a large_object_length option * 'a

and 'a numeric_type =
  | Numeric_type of
      [ `exact of 'a exact_numeric_type
      | `approximate of 'a approximate_numeric_type
      ]
      * 'a

and 'a exact_numeric_type =
  | Exact_numeric_type of
      [ `numeric of ('a precision * 'a scale option) option
      | `decimal of ('a precision * 'a scale option) option
      | `dec of ('a precision * 'a scale option) option
      | `smallint
      | `integer
      | `int
      | `bigint
      ]
      * 'a

and 'a approximate_numeric_type =
  | Approximate_numeric_type of
      [ `float of 'a precision option | `real | `double ] * 'a

and 'a length = Length of 'a unsigned_integer * 'a

and 'a large_object_length =
  | Large_object_length of
      'a unsigned_integer
      * [ `k | `m | `g ] option
      * 'a char_length_units option
      * 'a

and 'a char_length_units =
  | Char_length_units of [ `char | `code | `octets ] * 'a

and 'a precision = Precision of 'a unsigned_integer * 'a

and 'a scale = Scale of 'a unsigned_integer * 'a

and 'a boolean_type = Boolean_type of 'a

and 'a datetime_type =
  | Datetime_type of
      [ `date
      | `time of 'a time_precision option * 'a with_or_without_time_zone option
      | `timestamp of
        'a timestamp_precision option * 'a with_or_without_time_zone option
      ]
      * 'a

and 'a with_or_without_time_zone =
  | With_or_without_time_zone of [ `with' | `without ] * 'a

and 'a interval_type = Interval_type of 'a interval_qualifier * 'a

and 'a row_type = Row_type of 'a row_type_body * 'a

and 'a row_type_body =
  | Row_type_body of 'a field_definition * 'a field_definition list * 'a

and 'a reference_type =
  | Reference_type of 'a referenced_type * 'a scope_clause option * 'a

and 'a scope_clause = Scope_clause of 'a table_name * 'a

and 'a referenced_type =
  | Referenced_type of 'a path_resolved_user_defined_type_name * 'a

and 'a path_resolved_user_defined_type_name =
  | Path_resolved_user_defined_type_name of 'a schema_qualified_name * 'a

and 'a collection_type =
  | Collection_type of
      [ `array of 'a array_type | `multiset of 'a multiset_type ] * 'a

and 'a array_type =
  | Array_type of 'a data_type * 'a unsigned_integer option * 'a

and 'a multiset_type = Multiset_type of 'a data_type * 'a

and 'a field_definition =
  | Field_definition of 'a identifier * 'a data_type * 'a * 'a

and 'a value_specification =
  | Value_specification of
      [ `literal of 'a literal | `general of 'a general_value_specification ]
      * 'a

and 'a unsigned_value_specification =
  | Unsigned_value_specification of
      [ `literal of 'a unsigned_literal
      | `general of 'a general_value_specification
      ]
      * 'a

and 'a general_value_specification =
  | General_value_specification of
      [ `host of 'a host_parameter_specification
      | `sql of 'a sql_parameter_reference
      | `dynamic of 'a dynamic_parameter_specification
      | `current_collation of 'a current_collation_specification
      | `default_transform_group
      | `path
      | `role
      | `transform_group_for_type of 'a path_resolved_user_defined_type_name
      | `current_user
      | `session_user
      | `system_user
      | `user
      | `value
      ]
      * 'a

and 'a simple_value_specification =
  | Simple_value_specification of
      [ `literal of 'a literal
      | `host of 'a host_parameter_name
      | `sql of 'a sql_parameter_reference
      ]
      * 'a

and 'a target_specification =
  | Target_specification of
      [ `host of 'a host_parameter_specification
      | `sql of 'a sql_parameter_reference
      | `col of 'a column_reference
      | `array_element of 'a target_array_element_specification
      | `dynamic of 'a dynamic_parameter_specification
      ]
      * 'a

and 'a simple_target_specification =
  | Simple_target_specification of
      [ `host of 'a host_parameter_specification
      | `sql of 'a sql_parameter_reference
      | `col of 'a column_reference
      ]
      * 'a

and 'a host_parameter_specification =
  | Host_parameter_specification of 'a host_parameter_name * 'a

and 'a dynamic_parameter_specification = Dynamic_parameter_specification of 'a

and 'a target_array_element_specification =
  | Target_array_element_specification of
      'a target_array_reference * 'a simple_value_specification * 'a

and 'a target_array_reference =
  | Target_array_reference of
      [ `sql of 'a sql_parameter_reference | `col of 'a column_reference ] * 'a

and 'a current_collation_specification =
  | Current_collation_specification of 'a string_value_expression * 'a

and 'a host_parameter_name = Host_parameter_name of 'a identifier * 'a

and 'a contextually_typed_value_specification =
  | Contextually_typed_value_specification of
      [ `implicit of 'a implicitly_typed_value_specification
      | `default of 'a default_specification
      ]
      * 'a

and 'a implicitly_typed_value_specification =
  | Implicitly_typed_value_specification of
      [ `null of 'a null_specification | `empty of 'a empty_specification ] * 'a

and 'a null_specification = Null_specification of 'a

and 'a empty_specification =
  | Empty_specification of [ `array | `multiset ] * 'a

and 'a default_specification = Default_specification of 'a

and 'a set_function_specification =
  | Set_function_specification of
      [ `grouping of 'a grouping_operation | `aggregate of 'a ] * 'a

and 'a grouping_operation =
  | Grouping_operation of 'a column_reference * 'a column_reference list * 'a
