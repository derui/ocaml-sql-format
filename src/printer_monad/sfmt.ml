(* simple combinators for SQL formatting *)
open Types.Token

(** [newline ?indent ()] insert newline break with indent *)
let newline fmt _ = Format.pp_force_newline fmt ()

(* insert [size] spaces as string. This function do not insert break, only insert spaces *)
let indent size fmt _ = Fmt.string fmt (String.make size ' ')

let comma ~option fmt _ =
  Token.print ~option fmt Tok_comma;
  Fmt.string fmt " "

(** [force_vbox fmt ppf v] wraps box with [ppf]. *)
let force_vbox width ppf fmt v =
  Format.pp_print_break fmt 0 width;
  (Fmt.vbox ~indent:0 ppf) fmt v

(** [term_box fmt pf v] wraps hovbox with [pf]. *)
let term_box pf fmt v = (Fmt.hovbox ~indent:0 pf) fmt v

(** [parens ?need_indent ~option fmt pf v] wraps [()] printer pf. *)
let parens ~option pf fmt v =
  Token.print fmt Tok_lparen ~option;
  pf fmt v;
  Token.print fmt Tok_rparen ~option

(** [ ?need_indent ~option fmt pf v] wraps [()] printer pf. *)
let parens_box ~option pf fmt v =
  Token.print fmt Tok_lparen ~option;
  (force_vbox option.indent_size pf) fmt v;
  Fmt.cut fmt ();
  Token.print fmt Tok_rparen ~option

let keyword ~option fmt = function
  | [] -> failwith "need least one keyword"
  | fl :: rest ->
    Token.print ~option fmt fl;
    List.iter
      (fun k ->
        Fmt.string fmt " ";
        Token.print ~option fmt k)
      rest
