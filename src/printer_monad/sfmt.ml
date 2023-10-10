(* simple combinators for SQL formatting *)

(** [newline ?indent ()] insert newline break with indent *)
let newline fmt _ = Format.pp_force_newline fmt ()

(* insert [size] spaces as string. This function do not insert break, only insert spaces *)
let indent size fmt _ = Fmt.string fmt (String.make size ' ')

let comma ~option:_ fmt _ = Fmt.string fmt " "

(** [force_vbox fmt ppf v] wraps box with [ppf]. *)
let force_vbox width ppf fmt v =
  Format.pp_print_break fmt 0 width;
  (Fmt.vbox ~indent:0 ppf) fmt v

(** [term_box fmt pf v] wraps hovbox with [pf]. *)
let term_box pf fmt v = (Fmt.hovbox ~indent:0 pf) fmt v

(** [parens ?need_indent ~option fmt pf v] wraps [()] printer pf. *)
let parens ~option:_ pf fmt v = pf fmt v

(** [ ?need_indent ~option fmt pf v] wraps [()] printer pf. *)
let parens_box ~option:_ pf fmt v =
  (force_vbox 4 pf) fmt v;
  Fmt.cut fmt ()

let keyword ~option:_ fmt = function
  | [] -> failwith "need least one keyword"
  | _ :: rest -> List.iter (fun _ -> Fmt.string fmt " ") rest
