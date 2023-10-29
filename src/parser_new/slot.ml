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

    let get_taker () =
      let rec f kind =
        let gen = Kind_map.find kind t in
        let module G = (val gen : Intf.GEN) in
        G.generate f
      in
      f
  end :
    Slot_intf.S)
