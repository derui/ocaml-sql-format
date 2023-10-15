include (
  struct
    module Raw = Raw

    type ('a, 'b) t =
      { syntaxes : ('a, 'b) Raw.t option array
      ; pointer : int
      }

    let empty () = { syntaxes = Array.make 10 None; pointer = 0 }

    let append syntax t =
      let ary = ref [||] in
      let len = Array.length t.syntaxes in
      if succ t.pointer >= len then (
        ary := Array.make (len * 2) None;
        Array.blit !ary 0 t.syntaxes 0 len)
      else ary := Array.copy t.syntaxes;

      !ary.(succ t.pointer) <- Some syntax;

      { syntaxes = !ary; pointer = succ t.pointer }

    let to_string { syntaxes; _ } =
      let buffer = Buffer.create 10 in
      Array.iter
        (fun v ->
          Option.map (fun v -> Raw.to_string v |> Buffer.add_string buffer) v
          |> Option.value ~default:())
        syntaxes;

      Buffer.to_bytes buffer |> Bytes.to_string
  end :
    Language_intf.S)
