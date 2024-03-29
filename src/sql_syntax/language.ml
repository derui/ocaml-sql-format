include (
  struct
    module Raw = Raw

    type t =
      { syntaxes : Raw.t option array
      ; pointer : int
      }

    let empty () = { syntaxes = Array.make 10 None; pointer = 0 }

    let append syntax t =
      let ary = ref [||] in
      let len = Array.length t.syntaxes in
      if t.pointer >= len then (
        ary := Array.make (len * 2) None;
        Array.blit !ary 0 t.syntaxes 0 len)
      else ary := Array.copy t.syntaxes;

      !ary.(t.pointer) <- Some syntax;

      { syntaxes = !ary; pointer = succ t.pointer }

    let to_string { syntaxes; _ } =
      let buffer = Buffer.create 10 in
      Array.iter (fun v -> v |> Option.map (fun v -> v |> Raw.to_string |> Buffer.add_string buffer) |> ignore) syntaxes;

      Buffer.to_bytes buffer |> Bytes.to_string

    let walk ~f t =
      let seq = t.syntaxes |> Array.to_seq in
      Seq.iter
        (fun v ->
          match v with
          | None -> ()
          | Some r -> Raw.walk ~f r)
        seq
  end :
    Language_intf.S)
