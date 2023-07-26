(* simple combinators for SQL formatting *)
open Types.Token

(** [newline ?indent ()] insert newline break with indent *)
let newline fmt _ = Format.pp_force_newline fmt ()

(* insert [size] spaces as string. This function do not insert break, only insert spaces *)
let indent size fmt _ = Fmt.string fmt (String.make size ' ')

let comma ~option fmt _ =
  Token.print ~option fmt Tok_comma;
  Fmt.string fmt " "

(** [force_vbox fmt pf v] wraps box with [pf]. *)
let force_vbox width pf fmt v =
  newline fmt ();
  indent width fmt ();
  (Fmt.vbox ~indent:0 pf) fmt v

(** [term_box fmt pf v] wraps hovbox with [pf]. *)
let term_box pf fmt v = (Fmt.hovbox ~indent:0 pf) fmt v

(** [parens ?need_indent ~option fmt pf v] wraps [()] printer pf. *)
let parens ?indent:need_indent ~option pf fmt v =
  Token.print fmt Tok_lparen ~option;
  match need_indent with
  | Some _ ->
    (force_vbox option.indent_size pf) fmt v;
    newline fmt ();
    Token.print fmt Tok_rparen ~option
  | None ->
    pf fmt v;
    Token.print fmt Tok_rparen ~option

let keyword ~option fmt = function
  | [] -> failwith "need least one keyword"
  | fl :: rest ->
    Keyword.print ~option fmt fl;
    List.iter
      (fun k ->
        Fmt.string fmt " ";
        Keyword.print ~option fmt k)
      rest
