include (
  struct
    type 'a t = { root : 'a Raw.t }

    let make root = { root }

    let to_string { root } = Raw.to_string root
  end :
    Syntax_intf.S)
