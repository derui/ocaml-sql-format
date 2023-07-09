module A = Types.Ast
module L = Types.Literal
module Options = Options

let basic_non_reserved () = Basic_non_reserved.((module Make () : S))

let non_reserved_identifier () =
  Non_reserved_identifier.(
    (module Make (struct
      type t = A.ext L.basic_non_reserved

      let generate = basic_non_reserved
    end) : S))

let identifier () = Identifier.((module Make () : S))

let empty_grouping_set () = Empty_grouping_set.((module Make () : S))

let rec asterisked_identifier_chain () =
  Asterisked_identifier_chain.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
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

and unsigned_value_specification () =
  Unsigned_value_specification.((module Make () : S))

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

and boolean_value_expression () =
  Boolean_value_expression.((module Make () : S))

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

and value_expression () = Value_expression.((module Make () : S))

and joined_table () = Joined_table.((module Make () : S))

and cross_join () = Cross_join.((module Make () : S))

and qualified_join () = Qualified_join.((module Make () : S))

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
