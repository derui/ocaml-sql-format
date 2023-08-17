let default_option = Formatter.Options.default

let parse file =
  let toml = Otoml.Parser.from_file file in
  let keyword =
    Otoml.find_opt toml
      (Otoml.get_string ~strict:true)
      [ "settings"; "keyword" ]
  in
  let indent_size =
    Otoml.find_opt toml
      (Otoml.get_integer ~strict:true)
      [ "settings"; "indent_size" ]
    |> Option.map (fun v -> max 0 v)
    |> Option.value ~default:default_option.indent_size
  in
  let need_newline_between_elements =
    Otoml.find_opt toml
      (Otoml.get_boolean ~strict:true)
      [ "settings"; "need_newline_between_elements" ]
    |> Option.value ~default:true
  in
  let max_line_length =
    Otoml.find_opt toml
      (Otoml.get_integer ~strict:true)
      [ "settings"; "max_line_length" ]
    |> Option.map (fun v -> max 0 v)
    |> Option.value ~default:default_option.max_line_length
  in

  let keyword =
    match keyword with
    | Some "lower" -> `Lower
    | _ -> `Upper
  in

  { Formatter.Options.default with
    keyword
  ; indent_size
  ; need_newline_between_elements
  ; max_line_length
  }
