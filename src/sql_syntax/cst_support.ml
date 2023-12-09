(** [is_keyword kwd raw] returns boolean that raw is [kwd] or not *)
let is_keyword kwd raw =
  let module R = Raw in
  let module T = Types.Token in
  match raw with
  | R.Leaf { kind = L_keyword; token = T.Tok_keyword (_, kwd'); _ } as v when kwd = kwd' -> Some v
  | _ -> None

(** [is_leaf kind raw] returns option with [raw] if kind of [raw] is same as given [kind] *)
let is_leaf kind raw =
  let module R = Raw in
  match raw with
  | R.Leaf { kind = kind'; _ } as v when kind = kind' -> Some v
  | _ -> None

(** [is_node kind raw] returns option with [raw] if kind of [raw] is same as given [kind] *)
let is_node kind raw =
  let module R = Raw in
  match raw with
  | R.Node { kind = kind'; _ } as v when kind = kind' -> Some v
  | _ -> None
