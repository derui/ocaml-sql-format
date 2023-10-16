include (
  struct
    module K = Parser_monad.Kind

    module Kind_map = Map.Make (struct
      type t = K.node

      let compare = K.compare_node
    end)

    type t = Type.parser Kind_map.t

    let t : t = Kind_map.empty

    let take kind = Kind_map.find kind t
  end :
    Slot_intf.S)
