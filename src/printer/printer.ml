module A = Types.Ast
module L = Types.Literal
module B = Types.Basic
module Options = Options
open A

let basic_non_reserved () = Basic_non_reserved.((module Make () : S))

let non_reserved_identifier () =
  Non_reserved_identifier.(
    (module Make (struct
      type t = A.ext L.basic_non_reserved

      let generate = basic_non_reserved
    end) : S))

let identifier () = Identifier.((module Make () : S))

let empty_grouping_set () = Empty_grouping_set.((module Make () : S))

let unsigned_integer () = Unsigned_integer.((module Make () : S))

let non_second_primary_datetime_field () =
  Non_second_primary_datetime_field.((module Make () : S))

let character_string_literal () =
  Character_string_literal.((module Make () : S))

let national_character_string_literal () =
  National_character_string_literal.((module Make () : S))

let unicode_character_string_literal () =
  Unicode_character_string_literal.((module Make () : S))

let binary_string_literal () = Binary_string_literal.((module Make () : S))

let date_literal () = Date_literal.((module Make () : S))

let time_literal () = Time_literal.((module Make () : S))

let timestamp_literal () = Timestamp_literal.((module Make () : S))

let datetime_literal () =
  Datetime_literal.(
    (module Make
              (struct
                type t = A.ext L.date_literal

                let generate = date_literal
              end)
              (struct
                type t = A.ext L.time_literal

                let generate = time_literal
              end)
              (struct
                type t = A.ext L.timestamp_literal

                let generate = timestamp_literal
              end) : S))

let interval_qualifier () =
  Interval_qualifier.(
    (module Make
              (struct
                type t = B.non_second_primary_datetime_field

                let generate = non_second_primary_datetime_field
              end)
              (struct
                type t = A.ext L.unsigned_integer

                let generate = unsigned_integer
              end) : S))

let interval_literal () =
  Interval_literal.(
    (module Make (struct
      type t = A.ext L.interval_qualifier

      let generate = interval_qualifier
    end) : S))

let boolean_literal () = Boolean_literal.((module Make () : S))

let general_literal () =
  General_literal.(
    (module Make
              (struct
                type t = A.ext L.character_string_literal

                let generate = character_string_literal
              end)
              (struct
                type t = A.ext L.national_character_string_literal

                let generate = national_character_string_literal
              end)
              (struct
                type t = A.ext L.unicode_character_string_literal

                let generate = unicode_character_string_literal
              end)
              (struct
                type t = A.ext L.binary_string_literal

                let generate = binary_string_literal
              end)
              (struct
                type t = A.ext L.datetime_literal

                let generate = datetime_literal
              end)
              (struct
                type t = A.ext L.interval_literal

                let generate = interval_literal
              end)
              (struct
                type t = A.ext L.boolean_literal

                let generate = boolean_literal
              end) : S))

let unsigned_numeric_literal () =
  Unsigned_numeric_literal.((module Make () : S))

let signed_numeric_literal () =
  Signed_numeric_literal.(
    (module Make (struct
      type t = A.ext L.unsigned_numeric_literal

      let generate = unsigned_numeric_literal
    end) : S))

let unsigned_numeric_literal () =
  Unsigned_numeric_literal.((module Make () : S))

let unsigned_literal () =
  Unsigned_literal.(
    (module Make
              (struct
                type t = A.ext L.general_literal

                let generate = general_literal
              end)
              (struct
                type t = A.ext L.unsigned_numeric_literal

                let generate = unsigned_numeric_literal
              end) : S))

let literal () =
  Literal.(
    (module Make
              (struct
                type t = A.ext L.general_literal

                let generate = general_literal
              end)
              (struct
                type t = A.ext L.signed_numeric_literal

                let generate = signed_numeric_literal
              end) : S))

let rec asterisked_identifier_chain () =
  Asterisked_identifier_chain.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and interval_qualifier () =
  Interval_qualifier.(
    (module Make
              (struct
                type t = B.non_second_primary_datetime_field

                let generate = non_second_primary_datetime_field
              end)
              (struct
                type t = A.ext L.unsigned_integer

                let generate = unsigned_integer
              end) : S))

and derived_column () =
  Derived_column.(
    (module Make
              (struct
                type t = A.ext A.value_expression

                let generate = value_expression
              end)
              (struct
                type t = A.ext A.as_clause

                let generate = as_clause
              end) : S))

and as_clause () =
  As_clause.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and column_name_list () =
  Column_name_list.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and all_field_column_name_list () =
  All_field_column_name_list.(
    (module Make (struct
      type t = A.ext A.column_name_list

      let generate = column_name_list
    end) : S))

and table_name () =
  Table_name.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.schema_name

                let generate = schema_name
              end) : S))

and query_name () =
  Query_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and schema_name () =
  Schema_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and table_or_query_name () =
  Table_or_query_name.(
    (module Make
              (struct
                type t = A.ext A.table_name

                let generate = table_name
              end)
              (struct
                type t = A.ext A.query_name

                let generate = query_name
              end) : S))

and schema_qualified_name () =
  Schema_qualified_name.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.schema_name

                let generate = schema_name
              end) : S))

and collate_name () =
  Collate_name.(
    (module Make (struct
      type t = A.ext A.schema_qualified_name

      let generate = schema_qualified_name
    end) : S))

and collate_clause () =
  Collate_clause.(
    (module Make (struct
      type t = A.ext A.collate_name

      let generate = collate_name
    end) : S))

and column_reference () =
  Column_reference.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.identifier_chain

                let generate = identifier_chain
              end) : S))

and identifier_chain () =
  Identifier_chain.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and derived_column_list () =
  Derived_column_list.(
    (module Make (struct
      type t = A.ext A.column_name_list

      let generate = column_name_list
    end) : S))

and grouping_column_reference () =
  Grouping_column_reference.(
    (module Make
              (struct
                type t = A.ext A.column_reference

                let generate = column_reference
              end)
              (struct
                type t = A.ext A.collate_clause

                let generate = collate_clause
              end) : S))

and grouping_column_reference_list () =
  Grouping_column_reference_list.(
    (module Make (struct
      type t = A.ext A.grouping_column_reference

      let generate = grouping_column_reference
    end) : S))

and ordinary_grouping_set () =
  Ordinary_grouping_set.(
    (module Make
              (struct
                type t = A.ext A.grouping_column_reference

                let generate = grouping_column_reference
              end)
              (struct
                type t = A.ext A.grouping_column_reference_list

                let generate = grouping_column_reference_list
              end) : S))

and ordinary_grouping_set_list () =
  Ordinary_grouping_set_list.(
    (module Make (struct
      type t = A.ext A.ordinary_grouping_set

      let generate = ordinary_grouping_set
    end) : S))

and rollup_list () =
  Rollup_list.(
    (module Make (struct
      type t = A.ext A.ordinary_grouping_set_list

      let generate = ordinary_grouping_set_list
    end) : S))

and cube_list () =
  Cube_list.(
    (module Make (struct
      type t = A.ext A.ordinary_grouping_set_list

      let generate = ordinary_grouping_set_list
    end) : S))

and grouping_sets_specification () =
  Grouping_sets_specification.(
    (module Make (struct
      type t = A.ext A.grouping_set_list

      let generate = grouping_set_list
    end) : S))

and grouping_set_list () =
  Grouping_set_list.(
    (module Make (struct
      type t = A.ext A.grouping_set

      let generate = grouping_set
    end) : S))

and grouping_set () =
  Grouping_set.(
    (module Make
              (struct
                type t = A.ext A.ordinary_grouping_set

                let generate = ordinary_grouping_set
              end)
              (struct
                type t = A.ext A.rollup_list

                let generate = rollup_list
              end)
              (struct
                type t = A.ext A.cube_list

                let generate = cube_list
              end)
              (struct
                type t = A.ext A.grouping_sets_specification

                let generate = grouping_sets_specification
              end)
              (struct
                type t = A.ext A.empty_grouping_set

                let generate = empty_grouping_set
              end) : S))

and grouping_element () =
  Grouping_element.(
    (module Make
              (struct
                type t = A.ext A.ordinary_grouping_set

                let generate = ordinary_grouping_set
              end)
              (struct
                type t = A.ext A.rollup_list

                let generate = rollup_list
              end)
              (struct
                type t = A.ext A.cube_list

                let generate = cube_list
              end)
              (struct
                type t = A.ext A.grouping_sets_specification

                let generate = grouping_sets_specification
              end)
              (struct
                type t = A.ext A.empty_grouping_set

                let generate = empty_grouping_set
              end) : S))

and grouping_element_list () =
  Grouping_element_list.(
    (module Make (struct
      type t = A.ext A.grouping_element

      let generate = grouping_element
    end) : S))

and group_by_clause () =
  Group_by_clause.(
    (module Make (struct
      type t = A.ext A.grouping_element_list

      let generate = grouping_element_list
    end) : S))

and window_clause () =
  Window_clause.(
    (module Make (struct
      type t = A.ext A.window_definition_list

      let generate = window_definition_list
    end) : S))

and window_definition_list () =
  Window_definition_list.(
    (module Make (struct
      type t = A.ext A.window_definition

      let generate = window_definition
    end) : S))

and window_definition () =
  Window_definition.(
    (module Make
              (struct
                type t = A.ext A.new_window_name

                let generate = new_window_name
              end)
              (struct
                type t = A.ext A.window_specification

                let generate = window_specification
              end) : S))

and new_window_name () =
  New_window_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and window_specification () =
  Window_specification.(
    (module Make (struct
      type t = A.ext A.window_specification_detail

      let generate = window_specification_detail
    end) : S))

and window_specification_detail () =
  Window_specification_detail.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.window_partition_clause

                let generate = window_partition_clause
              end)
              (struct
                type t = A.ext A.window_order_clause

                let generate = window_order_clause
              end)
              (struct
                type t = A.ext A.window_frame_clause

                let generate = window_frame_clause
              end) : S))

and existing_window_name () =
  Existing_window_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and window_partition_clause () =
  Window_partition_clause.(
    (module Make (struct
      type t = A.ext A.window_partition_column_reference_list

      let generate = window_partition_column_reference_list
    end) : S))

and window_partition_column_reference_list () =
  Window_partition_column_reference_list.(
    (module Make (struct
      type t = A.ext A.window_partition_column_reference

      let generate = window_partition_column_reference
    end) : S))

and window_partition_column_reference () =
  Window_partition_column_reference.(
    (module Make
              (struct
                type t = A.ext A.column_reference

                let generate = column_reference
              end)
              (struct
                type t = A.ext A.collate_clause

                let generate = collate_clause
              end) : S))

and window_order_clause () =
  Window_order_clause.(
    (module Make (struct
      type t = A.ext A.sort_specification_list

      let generate = sort_specification_list
    end) : S))

and window_frame_clause () =
  Window_frame_clause.(
    (module Make
              (struct
                type t = A.ext A.window_frame_units

                let generate = window_frame_units
              end)
              (struct
                type t = A.ext A.window_frame_extent

                let generate = window_frame_extent
              end)
              (struct
                type t = A.ext A.window_frame_exclusion

                let generate = window_frame_exclusion
              end) : S))

and window_frame_units () = Window_frame_units.((module Make () : S))

and window_frame_extent () =
  Window_frame_extent.(
    (module Make
              (struct
                type t = A.ext A.window_frame_start

                let generate = window_frame_start
              end)
              (struct
                type t = A.ext A.window_frame_between

                let generate = window_frame_between
              end) : S))

and window_frame_start () =
  Window_frame_start.(
    (module Make (struct
      type t = A.ext A.window_frame_preceding

      let generate = window_frame_preceding
    end) : S))

and window_frame_preceding () =
  Window_frame_preceding.(
    (module Make (struct
      type t = A.ext A.unsigned_value_specification

      let generate = unsigned_value_specification
    end) : S))

and window_frame_between () =
  Window_frame_between.(
    (module Make
              (struct
                type t = A.ext A.window_frame_bound_1

                let generate = window_frame_bound_1
              end)
              (struct
                type t = A.ext A.window_frame_bound_2

                let generate = window_frame_bound_2
              end) : S))

and window_frame_bound_1 () =
  Window_frame_bound_1.(
    (module Make (struct
      type t = A.ext A.window_frame_bound

      let generate = window_frame_bound
    end) : S))

and window_frame_bound_2 () =
  Window_frame_bound_2.(
    (module Make (struct
      type t = A.ext A.window_frame_bound

      let generate = window_frame_bound
    end) : S))

and window_frame_bound () =
  Window_frame_bound.(
    (module Make
              (struct
                type t = A.ext A.window_frame_start

                let generate = window_frame_start
              end)
              (struct
                type t = A.ext A.window_frame_following

                let generate = window_frame_following
              end) : S))

and window_frame_following () =
  Window_frame_following.(
    (module Make (struct
      type t = A.ext A.unsigned_value_specification

      let generate = unsigned_value_specification
    end) : S))

and window_frame_exclusion () = Window_frame_exclusion.((module Make () : S))

and sort_specification_list () = Sort_specification_list.((module Make () : S))

and table_expression () =
  Table_expression.(
    (module Make
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

and having_clause () =
  Having_clause.(
    (module Make (struct
      type t = A.ext A.search_condition

      let generate = search_condition
    end) : S))

and where_clause () =
  Where_clause.(
    (module Make (struct
      type t = A.ext A.search_condition

      let generate = search_condition
    end) : S))

and from_clause () =
  From_clause.(
    (module Make (struct
      type t = A.ext A.table_reference_list

      let generate = table_reference_list
    end) : S))

and table_reference_list () =
  Table_reference_list.(
    (module Make (struct
      type t = A.ext A.table_reference

      let generate = table_reference
    end) : S))

and search_condition () =
  Search_condition.(
    (module Make (struct
      type t = A.ext A.boolean_value_expression

      let generate = boolean_value_expression
    end) : S))

and table_reference () =
  Table_reference.(
    (module Make
              (struct
                type t = A.ext A.table_primary

                let generate = table_primary
              end)
              (struct
                type t = A.ext A.joined_table

                let generate = joined_table
              end)
              (struct
                type t = A.ext A.sample_clause

                let generate = sample_clause
              end) : S))

and sample_clause () =
  Sample_clause.(
    (module Make
              (struct
                type t = A.ext A.numeric_value_expression

                let generate = numeric_value_expression
              end)
              (struct
                type t = A.ext A.repeatable_clause

                let generate = repeatable_clause
              end) : S))

and repeatable_clause () =
  Repeatable_clause.(
    (module Make (struct
      type t = A.ext A.numeric_value_expression

      let generate = numeric_value_expression
    end) : S))

and table_primary () =
  Table_primary.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.table_or_query_name

                let generate = table_or_query_name
              end)
              (struct
                type t = A.ext A.derived_table

                let generate = derived_table
              end)
              (struct
                type t = A.ext A.lateral_derived_table

                let generate = lateral_derived_table
              end)
              (struct
                type t = A.ext A.collection_derived_table

                let generate = collection_derived_table
              end)
              (struct
                type t = A.ext A.table_function_derived_table

                let generate = table_function_derived_table
              end)
              (struct
                type t = A.ext A.only_spec

                let generate = only_spec
              end)
              (struct
                type t = A.ext A.joined_table

                let generate = joined_table
              end)
              (struct
                type t = A.ext A.derived_column_list

                let generate = derived_column_list
              end) : S))

and derived_table () =
  Derived_table.(
    (module Make (struct
      type t = A.ext A.table_subquery

      let generate = table_subquery
    end) : S))

and only_spec () =
  Only_spec.(
    (module Make (struct
      type t = A.ext A.table_or_query_name

      let generate = table_or_query_name
    end) : S))

and lateral_derived_table () =
  Lateral_derived_table.(
    (module Make (struct
      type t = A.ext A.table_subquery

      let generate = table_subquery
    end) : S))

and collection_derived_table () =
  Collection_derived_table.(
    (module Make (struct
      type t = A.ext A.collection_value_expression

      let generate = collection_value_expression
    end) : S))

and table_function_derived_table () =
  Table_function_derived_table.(
    (module Make (struct
      type t = A.ext A.collection_value_expression

      let generate = collection_value_expression
    end) : S))

and joined_table () =
  Joined_table.(
    (module Make
              (struct
                type t = A.ext A.cross_join

                let generate = cross_join
              end)
              (struct
                type t = A.ext A.qualified_join

                let generate = qualified_join
              end)
              (struct
                type t = A.ext A.natural_join

                let generate = natural_join
              end)
              (struct
                type t = A.ext A.union_join

                let generate = union_join
              end) : S))

and cross_join () =
  Cross_join.(
    (module Make
              (struct
                type t = A.ext A.table_reference

                let generate = table_reference
              end)
              (struct
                type t = A.ext A.table_primary

                let generate = table_primary
              end) : S))

and qualified_join () =
  Qualified_join.(
    (module Make
              (struct
                type t = A.ext A.table_reference

                let generate = table_reference
              end)
              (struct
                type t = A.ext A.table_primary

                let generate = table_primary
              end)
              (struct
                type t = A.ext A.join_type

                let generate = join_type
              end)
              (struct
                type t = A.ext A.join_specification

                let generate = join_specification
              end) : S))

and natural_join () =
  Natural_join.(
    (module Make
              (struct
                type t = A.ext A.table_reference

                let generate = table_reference
              end)
              (struct
                type t = A.ext A.table_primary

                let generate = table_primary
              end)
              (struct
                type t = A.ext A.join_type

                let generate = join_type
              end) : S))

and union_join () =
  Union_join.(
    (module Make
              (struct
                type t = A.ext A.table_reference

                let generate = table_reference
              end)
              (struct
                type t = A.ext A.table_primary

                let generate = table_primary
              end) : S))

and join_specification () =
  Join_specification.(
    (module Make
              (struct
                type t = A.ext A.join_condition

                let generate = join_condition
              end)
              (struct
                type t = A.ext A.named_columns_join

                let generate = named_columns_join
              end) : S))

and join_condition () =
  Join_condition.(
    (module Make (struct
      type t = A.ext A.search_condition

      let generate = search_condition
    end) : S))

and named_columns_join () =
  Named_columns_join.(
    (module Make (struct
      type t = A.ext A.join_column_list

      let generate = join_column_list
    end) : S))

and join_type () =
  Join_type.(
    (module Make (struct
      type t = A.ext A.outer_join_type

      let generate = outer_join_type
    end) : S))

and outer_join_type () = Outer_join_type.((module Make () : S))

and join_column_list () =
  Join_column_list.(
    (module Make (struct
      type t = A.ext A.column_name_list

      let generate = column_name_list
    end) : S))

and scalar_subquery () =
  Scalar_subquery.(
    (module Make (struct
      type t = A.ext A.subquery

      let generate = subquery
    end) : S))

and row_subquery () =
  Row_subquery.(
    (module Make (struct
      type t = A.ext A.subquery

      let generate = subquery
    end) : S))

and table_subquery () =
  Table_subquery.(
    (module Make (struct
      type t = A.ext A.subquery

      let generate = subquery
    end) : S))

and subquery () =
  Subquery.(
    (module Make (struct
      type t = A.ext A.query_expression

      let generate = query_expression
    end) : S))

and query_expression () =
  Query_expression.(
    (module Make
              (struct
                type t = A.ext A.with_clause

                let generate = with_clause
              end)
              (struct
                type t = A.ext A.query_expression_body

                let generate = query_expression_body
              end) : S))

and with_clause () =
  With_clause.(
    (module Make (struct
      type t = A.ext A.with_list

      let generate = with_list
    end) : S))

and with_list () =
  With_list.(
    (module Make (struct
      type t = A.ext A.with_list_element

      let generate = with_list_element
    end) : S))

and with_list_element () =
  With_list_element.(
    (module Make
              (struct
                type t = A.ext A.column_name_list

                let generate = column_name_list
              end)
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.query_expression

                let generate = query_expression
              end)
              (struct
                type t = A.ext A.search_or_cycle_clause

                let generate = search_or_cycle_clause
              end) : S))

and query_expression_body () =
  Query_expression_body.(
    (module Make
              (struct
                type t = A.ext A.joined_table

                let generate = joined_table
              end)
              (struct
                type t = A.ext A.non_join_query_expression

                let generate = non_join_query_expression
              end) : S))

and non_join_query_expression () =
  Non_join_query_expression.(
    (module Make
              (struct
                type t = A.ext A.non_join_query_term

                let generate = non_join_query_term
              end)
              (struct
                type t = A.ext A.query_expression_body

                let generate = query_expression_body
              end)
              (struct
                type t = A.ext A.corresponding_spec

                let generate = corresponding_spec
              end)
              (struct
                type t = A.ext A.query_term

                let generate = query_term
              end) : S))

and query_term () =
  Query_term.(
    (module Make
              (struct
                type t = A.ext A.non_join_query_term

                let generate = non_join_query_term
              end)
              (struct
                type t = A.ext A.joined_table

                let generate = joined_table
              end) : S))

and non_join_query_term () =
  Non_join_query_term.(
    (module Make
              (struct
                type t = A.ext A.non_join_query_primary

                let generate = non_join_query_primary
              end)
              (struct
                type t = A.ext A.query_term

                let generate = query_term
              end)
              (struct
                type t = A.ext A.corresponding_spec

                let generate = corresponding_spec
              end)
              (struct
                type t = A.ext A.query_primary

                let generate = query_primary
              end) : S))

and query_primary () =
  Query_primary.(
    (module Make
              (struct
                type t = A.ext A.joined_table

                let generate = joined_table
              end)
              (struct
                type t = A.ext A.non_join_query_primary

                let generate = non_join_query_primary
              end) : S))

and non_join_query_primary () =
  Non_join_query_primary.(
    (module Make
              (struct
                type t = A.ext A.simple_table

                let generate = simple_table
              end)
              (struct
                type t = A.ext A.non_join_query_expression

                let generate = non_join_query_expression
              end) : S))

and simple_table () =
  Simple_table.(
    (module Make
              (struct
                type t = A.ext A.query_specification

                let generate = query_specification
              end)
              (struct
                type t = A.ext A.table_value_constructor

                let generate = table_value_constructor
              end)
              (struct
                type t = A.ext A.explicit_table

                let generate = explicit_table
              end) : S))

and explicit_table () =
  Explicit_table.(
    (module Make (struct
      type t = A.ext A.table_or_query_name

      let generate = table_or_query_name
    end) : S))

and corresponding_spec () =
  Corresponding_spec.(
    (module Make (struct
      type t = A.ext A.corresponding_column_list

      let generate = corresponding_column_list
    end) : S))

and corresponding_column_list () =
  Corresponding_column_list.(
    (module Make (struct
      type t = A.ext A.column_name_list

      let generate = column_name_list
    end) : S))

and query_specification () =
  Query_specification.(
    (module Make
              (struct
                type t = A.ext A.select_list

                let generate = select_list
              end)
              (struct
                type t = A.ext A.table_expression

                let generate = table_expression
              end) : S))

and select_list () =
  Select_list.(
    (module Make (struct
      type t = A.ext A.select_sublist

      let generate = select_sublist
    end) : S))

and select_sublist () =
  Select_sublist.(
    (module Make
              (struct
                type t = A.ext A.derived_column

                let generate = derived_column
              end)
              (struct
                type t = A.ext A.qualified_asterisk

                let generate = qualified_asterisk
              end) : S))

and qualified_asterisk () =
  Qualified_asterisk.(
    (module Make
              (struct
                type t = A.ext A.asterisked_identifier_chain

                let generate = asterisked_identifier_chain
              end)
              (struct
                type t = A.ext A.all_fields_reference

                let generate = all_fields_reference
              end) : S))

and all_fields_reference () =
  All_fields_reference.(
    (module Make
              (struct
                type t = A.ext A.value_expression_primary

                let generate = value_expression_primary
              end)
              (struct
                type t = A.ext A.all_field_column_name_list

                let generate = all_field_column_name_list
              end) : S))

and search_or_cycle_clause () =
  Search_or_cycle_clause.(
    (module Make
              (struct
                type t = A.ext A.search_clause

                let generate = search_clause
              end)
              (struct
                type t = A.ext A.cycle_clause

                let generate = cycle_clause
              end) : S))

and search_clause () =
  Search_clause.(
    (module Make
              (struct
                type t = A.ext A.recursive_search_order

                let generate = recursive_search_order
              end)
              (struct
                type t = A.ext A.sequence_column

                let generate = sequence_column
              end) : S))

and recursive_search_order () =
  Recursive_search_order.(
    (module Make (struct
      type t = A.ext A.sort_specification_list

      let generate = sort_specification_list
    end) : S))

and sequence_column () =
  Sequence_column.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and cycle_clause () =
  Cycle_clause.(
    (module Make
              (struct
                type t = A.ext A.cycle_column_list

                let generate = cycle_column_list
              end)
              (struct
                type t = A.ext A.cycle_mark_column

                let generate = cycle_mark_column
              end)
              (struct
                type t = A.ext A.cycle_mark_value

                let generate = cycle_mark_value
              end)
              (struct
                type t = A.ext A.non_cycle_mark_value

                let generate = non_cycle_mark_value
              end)
              (struct
                type t = A.ext A.path_column

                let generate = path_column
              end) : S))

and cycle_column_list () =
  Cycle_column_list.(
    (module Make (struct
      type t = A.ext A.cycle_column

      let generate = cycle_column
    end) : S))

and cycle_column () =
  Cycle_column.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and cycle_mark_column () =
  Cycle_mark_column.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and path_column () =
  Path_column.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and cycle_mark_value () =
  Cycle_mark_value.(
    (module Make (struct
      type t = A.ext A.value_expression

      let generate = value_expression
    end) : S))

and non_cycle_mark_value () =
  Non_cycle_mark_value.(
    (module Make (struct
      type t = A.ext A.value_expression

      let generate = value_expression
    end) : S))

and table_value_constructor () =
  Table_value_constructor.(
    (module Make (struct
      type t = A.ext A.row_value_expression_list

      let generate = row_value_expression_list
    end) : S))

and row_value_expression_list () =
  Row_value_expression_list.(
    (module Make (struct
      type t = A.ext A.table_row_value_expression

      let generate = table_row_value_expression
    end) : S))

and contextually_typed_table_value_constructor () =
  Contextually_typed_table_value_constructor.(
    (module Make (struct
      type t = A.ext A.contextually_typed_row_value_expression_list

      let generate = contextually_typed_row_value_expression_list
    end) : S))

and contextually_typed_row_value_expression_list () =
  Contextually_typed_row_value_expression_list.(
    (module Make (struct
      type t = A.ext A.contextually_typed_row_value_expression

      let generate = contextually_typed_row_value_expression
    end) : S))

and row_value_expression () =
  Row_value_expression.(
    (module Make
              (struct
                type t = A.ext A.row_value_special_case

                let generate = row_value_special_case
              end)
              (struct
                type t = A.ext A.explicit_row_value_constructor

                let generate = explicit_row_value_constructor
              end) : S))

and table_row_value_expression () =
  Table_row_value_expression.(
    (module Make
              (struct
                type t = A.ext A.row_value_special_case

                let generate = row_value_special_case
              end)
              (struct
                type t = A.ext A.row_value_constructor

                let generate = row_value_constructor
              end) : S))

and contextually_typed_row_value_expression () =
  Contextually_typed_row_value_expression.(
    (module Make
              (struct
                type t = A.ext A.row_value_special_case

                let generate = row_value_special_case
              end)
              (struct
                type t = A.ext A.contextually_typed_row_value_constructor

                let generate = contextually_typed_row_value_constructor
              end) : S))

and row_value_predicand () =
  Row_value_predicand.(
    (module Make
              (struct
                type t = A.ext A.row_value_special_case

                let generate = row_value_special_case
              end)
              (struct
                type t = A.ext A.row_value_constructor_predicand

                let generate = row_value_constructor_predicand
              end) : S))

and row_value_special_case () =
  Row_value_special_case.(
    (module Make (struct
      type t = A.ext A.nonparenthesized_value_expression_primary

      let generate = nonparenthesized_value_expression_primary
    end) : S))

and explicit_row_value_constructor () =
  Explicit_row_value_constructor.((module Make () : S))

and row_value_constructor () = Row_value_constructor.((module Make () : S))

and contextually_typed_row_value_constructor () =
  Contextually_typed_row_value_constructor.((module Make () : S))

and row_value_constructor_predicand () =
  Row_value_constructor_predicand.((module Make () : S))

and numeric_value_expression () =
  Numeric_value_expression.(
    (module Make (struct
      type t = A.ext A.term

      let generate = term
    end) : S))

and term () =
  Term.(
    (module Make (struct
      type t = A.ext A.factor

      let generate = factor
    end) : S))

and factor () =
  Factor.(
    (module Make (struct
      type t = A.ext A.numeric_primary

      let generate = numeric_primary
    end) : S))

and numeric_primary () =
  Numeric_primary.(
    (module Make (struct
      type t = A.ext A.value_expression_primary

      let generate = value_expression_primary
    end) : S))

and value_expression_primary () =
  Value_expression_primary.(
    (module Make
              (struct
                type t = A.ext A.parenthesized_value_expression

                let generate = parenthesized_value_expression
              end)
              (struct
                type t = A.ext A.nonparenthesized_value_expression_primary

                let generate = nonparenthesized_value_expression_primary
              end) : S))

and parenthesized_value_expression () =
  Parenthesized_value_expression.(
    (module Make (struct
      type t = A.ext A.value_expression

      let generate = value_expression
    end) : S))

and nonparenthesized_value_expression_primary () =
  Nonparenthesized_value_expression_primary.(
    (module Make
              (struct
                type t = A.ext A.column_reference

                let generate = column_reference
              end)
              (struct
                type t = A.ext A.next_value_expression

                let generate = next_value_expression
              end)
              (struct
                type t = A.ext A.field_reference

                let generate = field_reference
              end)
              (struct
                type t = A.ext A.attribute_or_method_reference

                let generate = attribute_or_method_reference
              end)
              (struct
                type t = A.ext A.array_element_reference

                let generate = array_element_reference
              end)
              (struct
                type t = A.ext A.multiset_element_reference

                let generate = multiset_element_reference
              end)
              (struct
                type t = A.ext A.window_function

                let generate = window_function
              end)
              (struct
                type t = A.ext A.scalar_subquery

                let generate = scalar_subquery
              end)
              (struct
                type t = A.ext set_function_specification

                let generate = set_function_specification
              end)
              (struct
                type t = A.ext A.unsigned_value_specification

                let generate = unsigned_value_specification
              end)
              (struct
                type t = A.ext A.case_expression

                let generate = case_expression
              end)
              (struct
                type t = A.ext A.cast_specification

                let generate = cast_specification
              end) : S))

and sql_parameter_reference () =
  Sql_parameter_reference.(
    (module Make (struct
      type t = A.ext A.identifier_chain

      let generate = identifier_chain
    end) : S))

and window_function () =
  Window_function.(
    (module Make
              (struct
                type t = A.ext A.window_function_type

                let generate = window_function_type
              end)
              (struct
                type t = A.ext A.window_name_or_specification

                let generate = window_name_or_specification
              end) : S))

and window_function_type () =
  Window_function_type.(
    (module Make (struct
      type t = A.ext A.rank_function_type

      let generate = rank_function_type
    end) : S))

and rank_function_type () = Rank_function_type.((module Make () : S))

and window_name_or_specification () =
  Window_name_or_specification.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.window_specification

                let generate = window_specification
              end) : S))

and next_value_expression () =
  Next_value_expression.(
    (module Make (struct
      type t = A.ext A.schema_qualified_name

      let generate = schema_qualified_name
    end) : S))

and field_reference () =
  Field_reference.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.value_expression_primary

                let generate = value_expression_primary
              end) : S))

and attribute_or_method_reference () =
  Attribute_or_method_reference.(
    (module Make
              (struct
                type t = A.ext A.value_expression_primary

                let generate = value_expression_primary
              end)
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.sql_argument_list

                let generate = sql_argument_list
              end) : S))

and sql_argument_list () =
  Sql_argument_list.(
    (module Make (struct
      type t = A.ext A.sql_argument

      let generate = sql_argument
    end) : S))

and sql_argument () =
  Sql_argument.(
    (module Make
              (struct
                type t = A.ext A.value_expression

                let generate = value_expression
              end)
              (struct
                type t = A.ext A.generalized_expression

                let generate = generalized_expression
              end) : S))

and generalized_expression () =
  Generalized_expression.(
    (module Make
              (struct
                type t = A.ext A.value_expression

                let generate = value_expression
              end)
              (struct
                type t = A.ext A.schema_qualified_name

                let generate = schema_qualified_name
              end) : S))

and array_element_reference () =
  Array_element_reference.(
    (module Make
              (struct
                type t = A.ext A.array_value_expression

                let generate = array_value_expression
              end)
              (struct
                type t = A.ext A.numeric_value_expression

                let generate = numeric_value_expression
              end) : S))

and multiset_element_reference () =
  Multiset_element_reference.(
    (module Make (struct
      type t = A.ext A.multiset_value_expression

      let generate = multiset_value_expression
    end) : S))

and string_value_expression () =
  String_value_expression.(
    (module Make (struct
      type t = A.ext A.character_value_expression

      let generate = character_value_expression
    end) : S))

and character_value_expression () =
  Character_value_expression.(
    (module Make
              (struct
                type t = A.ext A.concatenation

                let generate = concatenation
              end)
              (struct
                type t = A.ext A.character_factor

                let generate = character_factor
              end) : S))

and concatenation () =
  Concatenation.(
    (module Make
              (struct
                type t = A.ext A.character_value_expression

                let generate = character_value_expression
              end)
              (struct
                type t = A.ext A.character_factor

                let generate = character_factor
              end) : S))

and character_factor () =
  Character_factor.(
    (module Make
              (struct
                type t = A.ext A.character_primary

                let generate = character_primary
              end)
              (struct
                type t = A.ext A.collate_clause

                let generate = collate_clause
              end) : S))

and character_primary () =
  Character_primary.(
    (module Make (struct
      type t = A.ext A.value_expression_primary

      let generate = value_expression_primary
    end) : S))

and datetime_value_expression () =
  Datetime_value_expression.(
    (module Make
              (struct
                type t = A.ext A.datetime_term

                let generate = datetime_term
              end)
              (struct
                type t = A.ext A.interval_value_expression

                let generate = interval_value_expression
              end)
              (struct
                type t = A.ext A.interval_term

                let generate = interval_term
              end) : S))

and datetime_term () =
  Datetime_term.(
    (module Make (struct
      type t = A.ext A.datetime_factor

      let generate = datetime_factor
    end) : S))

and datetime_factor () =
  Datetime_factor.(
    (module Make
              (struct
                type t = A.ext A.datetime_primary

                let generate = datetime_primary
              end)
              (struct
                type t = A.ext A.time_zone_specifier

                let generate = time_zone_specifier
              end) : S))

and datetime_primary () =
  Datetime_primary.(
    (module Make
              (struct
                type t = A.ext A.value_expression_primary

                let generate = value_expression_primary
              end)
              (struct
                type t = A.ext A.datetime_value_function

                let generate = datetime_value_function
              end) : S))

and time_zone () =
  Time_zone.(
    (module Make (struct
      type t = A.ext A.time_zone_specifier

      let generate = time_zone_specifier
    end) : S))

and time_zone_specifier () =
  Time_zone_specifier.(
    (module Make (struct
      type t = A.ext A.interval_primary

      let generate = interval_primary
    end) : S))

and interval_value_expression () =
  Interval_value_expression.(
    (module Make
              (struct
                type t = A.ext A.interval_term

                let generate = interval_term
              end)
              (struct
                type t = A.ext A.interval_value_expression_1

                let generate = interval_value_expression_1
              end)
              (struct
                type t = A.ext A.interval_term_1

                let generate = interval_term_1
              end)
              (struct
                type t = A.ext A.datetime_value_expression

                let generate = datetime_value_expression
              end)
              (struct
                type t = A.ext A.datetime_term

                let generate = datetime_term
              end)
              (struct
                type t = A.ext L.interval_qualifier

                let generate = interval_qualifier
              end) : S))

and interval_term () =
  Interval_term.(
    (module Make
              (struct
                type t = A.ext A.interval_factor

                let generate = interval_factor
              end)
              (struct
                type t = A.ext A.factor

                let generate = factor
              end)
              (struct
                type t = A.ext A.term

                let generate = term
              end)
              (struct
                type t = A.ext A.interval_term_2

                let generate = interval_term_2
              end) : S))

and interval_factor () =
  Interval_factor.(
    (module Make (struct
      type t = A.ext A.interval_primary

      let generate = interval_primary
    end) : S))

and interval_primary () =
  Interval_primary.(
    (module Make
              (struct
                type t = A.ext A.value_expression_primary

                let generate = value_expression_primary
              end)
              (struct
                type t = A.ext L.interval_qualifier

                let generate = interval_qualifier
              end)
              (struct
                type t = A.ext A.interval_value_function

                let generate = interval_value_function
              end) : S))

and interval_value_expression_1 () =
  Interval_value_expression_1.(
    (module Make (struct
      type t = A.ext A.interval_value_expression

      let generate = interval_value_expression
    end) : S))

and interval_term_1 () =
  Interval_term_1.(
    (module Make (struct
      type t = A.ext A.interval_term

      let generate = interval_term
    end) : S))

and interval_term_2 () =
  Interval_term_2.(
    (module Make (struct
      type t = A.ext A.interval_term

      let generate = interval_term
    end) : S))

and interval_value_function () =
  Interval_value_function.(
    (module Make (struct
      type t = A.ext A.interval_absolute_value_function

      let generate = interval_absolute_value_function
    end) : S))

and interval_absolute_value_function () =
  Interval_absolute_value_function.(
    (module Make (struct
      type t = A.ext A.interval_value_expression

      let generate = interval_value_expression
    end) : S))

and array_value_expression () =
  Array_value_expression.(
    (module Make
              (struct
                type t = A.ext A.array_factor

                let generate = array_factor
              end)
              (struct
                type t = A.ext A.array_concatenation

                let generate = array_concatenation
              end) : S))

and array_concatenation () =
  Array_concatenation.(
    (module Make
              (struct
                type t = A.ext A.array_value_expression_1

                let generate = array_value_expression_1
              end)
              (struct
                type t = A.ext A.array_factor

                let generate = array_factor
              end) : S))

and array_value_expression_1 () =
  Array_value_expression_1.(
    (module Make (struct
      type t = A.ext A.array_value_expression

      let generate = array_value_expression
    end) : S))

and array_factor () =
  Array_factor.(
    (module Make (struct
      type t = A.ext A.value_expression_primary

      let generate = value_expression_primary
    end) : S))

and array_value_constructor () =
  Array_value_constructor.(
    (module Make
              (struct
                type t = A.ext A.array_value_constructor_by_enumeration

                let generate = array_value_constructor_by_enumeration
              end)
              (struct
                type t = A.ext A.array_value_constructor_by_query

                let generate = array_value_constructor_by_query
              end) : S))

and array_value_constructor_by_enumeration () =
  Array_value_constructor_by_enumeration.(
    (module Make (struct
      type t = A.ext A.array_element_list

      let generate = array_element_list
    end) : S))

and array_element_list () =
  Array_element_list.(
    (module Make (struct
      type t = A.ext A.array_element

      let generate = array_element
    end) : S))

and array_element () =
  Array_element.(
    (module Make (struct
      type t = A.ext A.value_expression

      let generate = value_expression
    end) : S))

and array_value_constructor_by_query () =
  Array_value_constructor_by_query.(
    (module Make
              (struct
                type t = A.ext A.query_expression

                let generate = query_expression
              end)
              (struct
                type t = A.ext A.order_by_clause

                let generate = order_by_clause
              end) : S))

and order_by_clause () = Order_by_clause.((module Make () : S))

and multiset_value_expression () =
  Multiset_value_expression.(
    (module Make (struct
      type t = A.ext A.multiset_term

      let generate = multiset_term
    end) : S))

and multiset_term () =
  Multiset_term.(
    (module Make (struct
      type t = A.ext A.multiset_primary

      let generate = multiset_primary
    end) : S))

and multiset_primary () =
  Multiset_primary.(
    (module Make
              (struct
                type t = A.ext A.value_expression_primary

                let generate = value_expression_primary
              end)
              (struct
                type t = A.ext A.multiset_value_function

                let generate = multiset_value_function
              end) : S))

and multiset_value_function () =
  Multiset_value_function.(
    (module Make (struct
      type t = A.ext A.multiset_set_function

      let generate = multiset_set_function
    end) : S))

and multiset_set_function () =
  Multiset_set_function.(
    (module Make (struct
      type t = A.ext A.multiset_value_expression

      let generate = multiset_value_expression
    end) : S))

and multiset_value_constructor () =
  Multiset_value_constructor.(
    (module Make
              (struct
                type t = A.ext A.multiset_value_constructor_by_enumeration

                let generate = multiset_value_constructor_by_enumeration
              end)
              (struct
                type t = A.ext A.multiset_value_constructor_by_query

                let generate = multiset_value_constructor_by_query
              end)
              (struct
                type t = A.ext A.table_value_constructor_by_query

                let generate = table_value_constructor_by_query
              end) : S))

and multiset_value_constructor_by_enumeration () =
  Multiset_value_constructor_by_enumeration.(
    (module Make (struct
      type t = A.ext A.multiset_element_list

      let generate = multiset_element_list
    end) : S))

and multiset_element_list () =
  Multiset_element_list.(
    (module Make (struct
      type t = A.ext A.multiset_element

      let generate = multiset_element
    end) : S))

and multiset_element () =
  Multiset_element.(
    (module Make (struct
      type t = A.ext A.value_expression

      let generate = value_expression
    end) : S))

and multiset_value_constructor_by_query () =
  Multiset_value_constructor_by_query.(
    (module Make (struct
      type t = A.ext A.query_expression

      let generate = query_expression
    end) : S))

and table_value_constructor_by_query () =
  Table_value_constructor_by_query.(
    (module Make (struct
      type t = A.ext A.query_expression

      let generate = query_expression
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
      type t = A.ext A.boolean_test

      let generate = boolean_test
    end) : S))

and boolean_primary () =
  Boolean_primary.(
    (module Make (struct
      type t = A.ext A.boolean_predicand

      let generate = boolean_predicand
    end) : S))

and boolean_test () =
  Boolean_test.(
    (module Make
              (struct
                type t = A.ext A.boolean_primary

                let generate = boolean_primary
              end)
              (struct
                type t = A.ext A.truth_value

                let generate = truth_value
              end) : S))

and truth_value () = Truth_value.((module Make () : S))

and boolean_predicand () =
  Boolean_predicand.(
    (module Make
              (struct
                type t = A.ext A.parenthesized_boolean_value_expression

                let generate = parenthesized_boolean_value_expression
              end)
              (struct
                type t = A.ext A.nonparenthesized_value_expression_primary

                let generate = nonparenthesized_value_expression_primary
              end) : S))

and parenthesized_boolean_value_expression () =
  Parenthesized_boolean_value_expression.(
    (module Make (struct
      type t = A.ext A.boolean_value_expression

      let generate = boolean_value_expression
    end) : S))

and datetime_value_function () =
  Datetime_value_function.(
    (module Make
              (struct
                type t = A.ext A.current_date_value_function

                let generate = current_date_value_function
              end)
              (struct
                type t = A.ext A.current_time_value_function

                let generate = current_time_value_function
              end)
              (struct
                type t = A.ext A.current_local_time_value_function

                let generate = current_local_time_value_function
              end)
              (struct
                type t = A.ext A.current_timestamp_value_function

                let generate = current_timestamp_value_function
              end)
              (struct
                type t = A.ext A.current_local_timestamp_value_function

                let generate = current_local_timestamp_value_function
              end) : S))

and current_date_value_function () =
  Current_date_value_function.((module Make () : S))

and current_time_value_function () =
  Current_time_value_function.(
    (module Make (struct
      type t = A.ext A.time_precision

      let generate = time_precision
    end) : S))

and current_local_time_value_function () =
  Current_local_time_value_function.(
    (module Make (struct
      type t = A.ext A.time_precision

      let generate = time_precision
    end) : S))

and current_timestamp_value_function () =
  Current_timestamp_value_function.(
    (module Make (struct
      type t = A.ext A.timestamp_precision

      let generate = timestamp_precision
    end) : S))

and current_local_timestamp_value_function () =
  Current_local_timestamp_value_function.(
    (module Make (struct
      type t = A.ext A.timestamp_precision

      let generate = timestamp_precision
    end) : S))

and time_precision () =
  Time_precision.(
    (module Make (struct
      type t = A.ext A.time_fractional_seconds_precision

      let generate = time_fractional_seconds_precision
    end) : S))

and timestamp_precision () =
  Timestamp_precision.(
    (module Make (struct
      type t = A.ext A.time_fractional_seconds_precision

      let generate = time_fractional_seconds_precision
    end) : S))

and time_fractional_seconds_precision () =
  Time_fractional_seconds_precision.(
    (module Make (struct
      type t = A.ext L.unsigned_integer

      let generate = unsigned_integer
    end) : S))

and data_type () =
  Data_type.(
    (module Make
              (struct
                type t = A.ext predefined_type

                let generate = predefined_type
              end)
              (struct
                type t = A.ext row_type

                let generate = row_type
              end)
              (struct
                type t = A.ext path_resolved_user_defined_type_name

                let generate = path_resolved_user_defined_type_name
              end)
              (struct
                type t = A.ext reference_type

                let generate = reference_type
              end)
              (struct
                type t = A.ext collection_type

                let generate = collection_type
              end) : S))

and predefined_type () =
  Predefined_type.(
    (module Make
              (struct
                type t = A.ext character_string_type

                let generate = character_string_type
              end)
              (struct
                type t = A.ext national_character_string_type

                let generate = national_character_string_type
              end)
              (struct
                type t = A.ext binary_large_object_string_type

                let generate = binary_large_object_string_type
              end)
              (struct
                type t = A.ext numeric_type

                let generate = numeric_type
              end)
              (struct
                type t = A.ext boolean_type

                let generate = boolean_type
              end)
              (struct
                type t = A.ext datetime_type

                let generate = datetime_type
              end)
              (struct
                type t = A.ext interval_type

                let generate = interval_type
              end)
              (struct
                type t = A.ext collate_clause

                let generate = collate_clause
              end) : S))

and character_string_type () =
  Character_string_type.(
    (module Make
              (struct
                type t = A.ext length

                let generate = length
              end)
              (struct
                type t = A.ext large_object_length

                let generate = large_object_length
              end) : S))

and national_character_string_type () =
  National_character_string_type.(
    (module Make
              (struct
                type t = A.ext length

                let generate = length
              end)
              (struct
                type t = A.ext large_object_length

                let generate = large_object_length
              end) : S))

and binary_large_object_string_type () =
  Binary_large_object_string_type.(
    (module Make (struct
      type t = A.ext large_object_length

      let generate = large_object_length
    end) : S))

and numeric_type () =
  Numeric_type.(
    (module Make
              (struct
                type t = A.ext exact_numeric_type

                let generate = exact_numeric_type
              end)
              (struct
                type t = A.ext approximate_numeric_type

                let generate = approximate_numeric_type
              end) : S))

and exact_numeric_type () =
  Exact_numeric_type.(
    (module Make
              (struct
                type t = A.ext precision

                let generate = precision
              end)
              (struct
                type t = A.ext scale

                let generate = scale
              end) : S))

and approximate_numeric_type () =
  Approximate_numeric_type.(
    (module Make (struct
      type t = A.ext precision

      let generate = precision
    end) : S))

and length () =
  Length.(
    (module Make (struct
      type t = A.ext L.unsigned_integer

      let generate = unsigned_integer
    end) : S))

and large_object_length () =
  Large_object_length.(
    (module Make
              (struct
                type t = A.ext L.unsigned_integer

                let generate = unsigned_integer
              end)
              (struct
                type t = A.ext char_length_units

                let generate = char_length_units
              end) : S))

and char_length_units () = Char_length_units.((module Make () : S))

and precision () =
  Precision.(
    (module Make (struct
      type t = A.ext L.unsigned_integer

      let generate = unsigned_integer
    end) : S))

and scale () =
  Scale.(
    (module Make (struct
      type t = A.ext L.unsigned_integer

      let generate = unsigned_integer
    end) : S))

and boolean_type () = Boolean_type.((module Make () : S))

and datetime_type () =
  Datetime_type.(
    (module Make
              (struct
                type t = A.ext time_precision

                let generate = time_precision
              end)
              (struct
                type t = A.ext timestamp_precision

                let generate = timestamp_precision
              end)
              (struct
                type t = A.ext with_or_without_time_zone

                let generate = with_or_without_time_zone
              end) : S))

and with_or_without_time_zone () =
  With_or_without_time_zone.((module Make () : S))

and interval_type () =
  Interval_type.(
    (module Make (struct
      type t = A.ext L.interval_qualifier

      let generate = interval_qualifier
    end) : S))

and row_type () =
  Row_type.(
    (module Make (struct
      type t = A.ext row_type_body

      let generate = row_type_body
    end) : S))

and row_type_body () =
  Row_type_body.(
    (module Make (struct
      type t = A.ext field_definition

      let generate = field_definition
    end) : S))

and reference_type () =
  Reference_type.(
    (module Make
              (struct
                type t = A.ext referenced_type

                let generate = referenced_type
              end)
              (struct
                type t = A.ext scope_clause

                let generate = scope_clause
              end) : S))

and scope_clause () =
  Scope_clause.(
    (module Make (struct
      type t = A.ext A.table_name

      let generate = table_name
    end) : S))

and referenced_type () =
  Referenced_type.(
    (module Make (struct
      type t = A.ext A.path_resolved_user_defined_type_name

      let generate = path_resolved_user_defined_type_name
    end) : S))

and path_resolved_user_defined_type_name () =
  Path_resolved_user_defined_type_name.(
    (module Make (struct
      type t = A.ext A.schema_qualified_name

      let generate = schema_qualified_name
    end) : S))

and collection_type () =
  Collection_type.(
    (module Make
              (struct
                type t = A.ext array_type

                let generate = array_type
              end)
              (struct
                type t = A.ext multiset_type

                let generate = multiset_type
              end) : S))

and array_type () =
  Array_type.(
    (module Make
              (struct
                type t = A.ext data_type

                let generate = data_type
              end)
              (struct
                type t = A.ext L.unsigned_integer

                let generate = unsigned_integer
              end) : S))

and multiset_type () =
  Multiset_type.(
    (module Make (struct
      type t = A.ext data_type

      let generate = data_type
    end) : S))

and field_definition () =
  Field_definition.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext data_type

                let generate = data_type
              end) : S))

and value_specification () =
  Value_specification.(
    (module Make
              (struct
                type t = A.ext L.literal

                let generate = literal
              end)
              (struct
                type t = A.ext general_value_specification

                let generate = general_value_specification
              end) : S))

and unsigned_value_specification () =
  Unsigned_value_specification.(
    (module Make
              (struct
                type t = A.ext L.unsigned_literal

                let generate = unsigned_literal
              end)
              (struct
                type t = A.ext general_value_specification

                let generate = general_value_specification
              end) : S))

and general_value_specification () =
  General_value_specification.(
    (module Make
              (struct
                type t = A.ext host_parameter_specification

                let generate = host_parameter_specification
              end)
              (struct
                type t = A.ext sql_parameter_reference

                let generate = sql_parameter_reference
              end)
              (struct
                type t = A.ext dynamic_parameter_specification

                let generate = dynamic_parameter_specification
              end)
              (struct
                type t = A.ext current_collation_specification

                let generate = current_collation_specification
              end)
              (struct
                type t = A.ext path_resolved_user_defined_type_name

                let generate = path_resolved_user_defined_type_name
              end) : S))

and simple_value_specification () =
  Simple_value_specification.(
    (module Make
              (struct
                type t = A.ext L.literal

                let generate = literal
              end)
              (struct
                type t = A.ext host_parameter_name

                let generate = host_parameter_name
              end)
              (struct
                type t = A.ext sql_parameter_reference

                let generate = sql_parameter_reference
              end) : S))

and target_specification () =
  Target_specification.(
    (module Make
              (struct
                type t = A.ext host_parameter_specification

                let generate = host_parameter_specification
              end)
              (struct
                type t = A.ext sql_parameter_reference

                let generate = sql_parameter_reference
              end)
              (struct
                type t = A.ext column_reference

                let generate = column_reference
              end)
              (struct
                type t = A.ext target_array_element_specification

                let generate = target_array_element_specification
              end)
              (struct
                type t = A.ext dynamic_parameter_specification

                let generate = dynamic_parameter_specification
              end) : S))

and simple_target_specification () =
  Simple_target_specification.(
    (module Make
              (struct
                type t = A.ext host_parameter_specification

                let generate = host_parameter_specification
              end)
              (struct
                type t = A.ext sql_parameter_reference

                let generate = sql_parameter_reference
              end)
              (struct
                type t = A.ext column_reference

                let generate = column_reference
              end) : S))

and host_parameter_specification () =
  Host_parameter_specification.(
    (module Make (struct
      type t = A.ext host_parameter_name

      let generate = host_parameter_name
    end) : S))

and dynamic_parameter_specification () =
  Dynamic_parameter_specification.((module Make () : S))

and target_array_element_specification () =
  Target_array_element_specification.(
    (module Make
              (struct
                type t = A.ext target_array_reference

                let generate = target_array_reference
              end)
              (struct
                type t = A.ext simple_value_specification

                let generate = simple_value_specification
              end) : S))

and target_array_reference () =
  Target_array_reference.(
    (module Make
              (struct
                type t = A.ext sql_parameter_reference

                let generate = sql_parameter_reference
              end)
              (struct
                type t = A.ext column_reference

                let generate = column_reference
              end) : S))

and current_collation_specification () =
  Current_collation_specification.(
    (module Make (struct
      type t = A.ext string_value_expression

      let generate = string_value_expression
    end) : S))

and host_parameter_name () =
  Host_parameter_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and contextually_typed_value_specification () =
  Contextually_typed_value_specification.(
    (module Make
              (struct
                type t = A.ext implicitly_typed_value_specification

                let generate = implicitly_typed_value_specification
              end)
              (struct
                type t = A.ext default_specification

                let generate = default_specification
              end) : S))

and implicitly_typed_value_specification () =
  Implicitly_typed_value_specification.(
    (module Make
              (struct
                type t = A.ext null_specification

                let generate = null_specification
              end)
              (struct
                type t = A.ext empty_specification

                let generate = empty_specification
              end) : S))

and null_specification () = Null_specification.((module Make () : S))

and empty_specification () = Empty_specification.((module Make () : S))

and default_specification () = Default_specification.((module Make () : S))

and set_function_specification () =
  Set_function_specification.(
    (module Make (struct
      type t = A.ext grouping_operation

      let generate = grouping_operation
    end) : S))

and grouping_operation () =
  Grouping_operation.(
    (module Make (struct
      type t = A.ext column_reference

      let generate = column_reference
    end) : S))

and case_expression () =
  Case_expression.(
    (module Make
              (struct
                type t = A.ext A.case_abbreviation

                let generate = case_abbreviation
              end)
              (struct
                type t = A.ext A.case_specification

                let generate = case_specification
              end) : S))

and case_abbreviation () =
  Case_abbreviation.(
    (module Make (struct
      type t = A.ext A.value_expression

      let generate = value_expression
    end) : S))

and case_specification () =
  Case_specification.(
    (module Make
              (struct
                type t = A.ext A.simple_case

                let generate = simple_case
              end)
              (struct
                type t = A.ext A.searched_case

                let generate = searched_case
              end) : S))

and simple_case () =
  Simple_case.(
    (module Make
              (struct
                type t = A.ext A.case_operand

                let generate = case_operand
              end)
              (struct
                type t = A.ext A.simple_when_clause

                let generate = simple_when_clause
              end)
              (struct
                type t = A.ext A.else_clause

                let generate = else_clause
              end) : S))

and searched_case () =
  Searched_case.(
    (module Make
              (struct
                type t = A.ext A.searched_when_clause

                let generate = searched_when_clause
              end)
              (struct
                type t = A.ext A.else_clause

                let generate = else_clause
              end) : S))

and simple_when_clause () =
  Simple_when_clause.(
    (module Make
              (struct
                type t = A.ext when_operand

                let generate = when_operand
              end)
              (struct
                type t = A.ext result'

                let generate = result
              end) : S))

and searched_when_clause () =
  Searched_when_clause.(
    (module Make
              (struct
                type t = A.ext search_condition

                let generate = search_condition
              end)
              (struct
                type t = A.ext result'

                let generate = result
              end) : S))

and else_clause () =
  Else_clause.(
    (module Make (struct
      type t = A.ext A.result'

      let generate = result
    end) : S))

and case_operand () =
  Case_operand.(
    (module Make (struct
      type t = A.ext A.row_value_predicand

      let generate = row_value_predicand
    end) : S))

and when_operand () =
  When_operand.(
    (module Make (struct
      type t = A.ext A.row_value_predicand

      let generate = row_value_predicand
    end) : S))

and result () =
  Result.(
    (module Make (struct
      type t = A.ext A.result_expression

      let generate = result_expression
    end) : S))

and result_expression () =
  Result_expression.(
    (module Make (struct
      type t = A.ext A.value_expression

      let generate = value_expression
    end) : S))

and cast_specification () =
  Cast_specification.(
    (module Make
              (struct
                type t = A.ext A.cast_operand

                let generate = cast_operand
              end)
              (struct
                type t = A.ext A.cast_target

                let generate = cast_target
              end) : S))

and cast_operand () =
  Cast_operand.(
    (module Make
              (struct
                type t = A.ext A.value_expression

                let generate = value_expression
              end)
              (struct
                type t = A.ext A.implicitly_typed_value_specification

                let generate = implicitly_typed_value_specification
              end) : S))

and cast_target () =
  Cast_target.(
    (module Make
              (struct
                type t = A.ext A.schema_qualified_name

                let generate = schema_qualified_name
              end)
              (struct
                type t = A.ext data_type

                let generate = data_type
              end) : S))

and value_expression () =
  Value_expression.(
    (module Make
              (struct
                type t = A.ext A.common_value_expression

                let generate = common_value_expression
              end)
              (struct
                type t = A.ext A.boolean_value_expression

                let generate = boolean_value_expression
              end)
              (struct
                type t = A.ext A.row_value_expression

                let generate = row_value_expression
              end) : S))

and common_value_expression () =
  Common_value_expression.(
    (module Make
              (struct
                type t = A.ext A.numeric_value_expression

                let generate = numeric_value_expression
              end)
              (struct
                type t = A.ext A.string_value_expression

                let generate = string_value_expression
              end)
              (struct
                type t = A.ext A.datetime_value_expression

                let generate = datetime_value_expression
              end)
              (struct
                type t = A.ext A.interval_value_expression

                let generate = interval_value_expression
              end)
              (struct
                type t = A.ext A.user_defined_type_value_expression

                let generate = user_defined_type_value_expression
              end)
              (struct
                type t = A.ext A.reference_value_expression

                let generate = reference_value_expression
              end)
              (struct
                type t = A.ext A.collection_value_expression

                let generate = collection_value_expression
              end) : S))

and user_defined_type_value_expression () =
  User_defined_type_value_expression.(
    (module Make (struct
      type t = A.ext A.value_expression_primary

      let generate = value_expression_primary
    end) : S))

and reference_value_expression () =
  Reference_value_expression.(
    (module Make (struct
      type t = A.ext A.value_expression_primary

      let generate = value_expression_primary
    end) : S))

and collection_value_expression () =
  Collection_value_expression.(
    (module Make
              (struct
                type t = A.ext A.array_value_expression

                let generate = array_value_expression
              end)
              (struct
                type t = A.ext A.multiset_value_expression

                let generate = multiset_value_expression
              end) : S))

and collection_value_constructor () =
  Collection_value_constructor.(
    (module Make
              (struct
                type t = A.ext A.array_value_constructor

                let generate = array_value_constructor
              end)
              (struct
                type t = A.ext A.multiset_value_constructor

                let generate = multiset_value_constructor
              end) : S))
