(** [is_keyword kwd raw] returns boolean that raw is [kwd] or not *)
let is_keyword kwd raw =
  let module R = Raw in
  let module T = Types.Token in
  match raw with
  | R.Leaf { kind = L_keyword; token = T.Tok_keyword (_, kwd'); _ } as v when kwd = kwd' -> Some v
  | _ -> None
