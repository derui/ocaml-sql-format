include (
  struct
    type ('a, 'b) t = { root : ('a, 'b) Raw.t }

    let make root = { root }

    let to_string { root } = Raw.to_string root
  end :
    Syntax_intf.S)
