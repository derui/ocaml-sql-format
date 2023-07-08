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

and window_clause () = Window_clause.((module Make () : S))

and window_definition_list () = Window_definition_list.((module Make () : S))

and window_definition () = Window_definition.((module Make () : S))

and new_window_name () =
  New_window_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and window_specification () = Window_specification.((module Make () : S))

and window_specification_detail () =
  Window_specification_detail.((module Make () : S))

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

and window_order_clause () = Window_order_clause.((module Make () : S))

and window_frame_clause () = Window_frame_clause.((module Make () : S))

and window_frame_units () = Window_frame_units.((module Make () : S))

and window_frame_extent () = Window_frame_extent.((module Make () : S))

and window_frame_start () = Window_frame_start.((module Make () : S))

and window_frame_preceding () = Window_frame_preceding.((module Make () : S))

and window_frame_between () = Window_frame_between.((module Make () : S))

and window_frame_bound_1 () = Window_frame_bound_1.((module Make () : S))

and window_frame_bound_2 () = Window_frame_bound_2.((module Make () : S))

and window_frame_bound () = Window_frame_bound.((module Make () : S))

and window_frame_following () =
  Window_frame_following.(
    (module Make (struct
      type t = A.ext A.unsigned_value_specification

      let generate = unsigned_value_specification
    end) : S))

and window_frame_exclusion () = Window_frame_exclusion.((module Make () : S))

and unsigned_value_specification () =
  Unsigned_value_specification.((module Make () : S))
