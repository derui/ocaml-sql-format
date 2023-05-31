let token lexbuf =
  match%sedlex lexbuf with
  | any -> 1
  | _ -> failwith ""
