include (
  struct
    module K = Parser_monad.Kind

    module Kind_map = Map.Make (struct
      type t = K.node

      let compare = K.compare_node
    end)

    type t = (module Intf.GEN) Kind_map.t

    let t : t =
      Kind_map.empty
      |> Kind_map.add K.N_expr (module Parser_expr : Intf.GEN)
      |> Kind_map.add K.N_filter_clause (module Parser_filter_clause : Intf.GEN)
      |> Kind_map.add K.N_type_name (module Parser_type_name : Intf.GEN)
      |> Kind_map.add K.N_select_core (module Parser_select_core : Intf.GEN)
      |> Kind_map.add K.N_from_clause (module Parser_from_clause : Intf.GEN)
      |> Kind_map.add K.N_table_or_subquery
           (module Parser_table_or_subquery : Intf.GEN)
      |> Kind_map.add K.N_join_clause (module Parser_join_clause : Intf.GEN)
      |> Kind_map.add K.N_where_clause (module Parser_where_clause : Intf.GEN)
      |> Kind_map.add K.N_group_by_clause
           (module Parser_group_by_clause : Intf.GEN)
      |> Kind_map.add K.N_having_clause (module Parser_having_clause : Intf.GEN)
      |> Kind_map.add K.N_order_by_clause
           (module Parser_order_by_clause : Intf.GEN)
      |> Kind_map.add K.N_ordering_term (module Parser_ordering_term : Intf.GEN)
      |> Kind_map.add K.N_frame_spec (module Parser_frame_spec : Intf.GEN)
      |> Kind_map.add K.N_window_defn (module Parser_window_defn : Intf.GEN)
      |> Kind_map.add K.N_window_clause (module Parser_window_clause : Intf.GEN)
      |> Kind_map.add K.N_result_column (module Parser_result_column : Intf.GEN)
      |> Kind_map.add K.N_select_core (module Parser_select_core : Intf.GEN)
      |> Kind_map.add K.N_over_clause (module Parser_over_clause : Intf.GEN)
      |> Kind_map.add K.N_limit_clause (module Parser_limit_clause : Intf.GEN)
      |> Kind_map.add K.N_common_table_expression
           (module Parser_common_table_expression : Intf.GEN)
      |> Kind_map.add K.N_with_clause (module Parser_with_clause : Intf.GEN)
      |> Kind_map.add K.N_select_stmt (module Parser_select_stmt : Intf.GEN)

    let get_taker () =
      let rec f kind =
        let gen = Kind_map.find kind t in
        let module G = (val gen : Intf.GEN) in
        G.generate f
      in
      f
  end :
    Slot_intf.S)
