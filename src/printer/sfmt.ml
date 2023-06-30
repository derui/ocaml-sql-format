(* simple combinators for SQL formatting *)
open Types.Token

(** [newline ?indent ()] insert newline break with indent *)
let newline fmt _ = Format.pp_force_newline fmt ()

(* insert [size] spaces as string. This function do not insert break, only insert spaces *)
let indent size fmt _ = Fmt.string fmt (String.make size ' ')

(** [parens ?need_indent ~option fmt pf v] wraps [()] printer pf. *)
let parens ?indent:need_indent ~option pf fmt v =
  Printer_token.print fmt Tok_lparen ~option;
  match need_indent with
  | Some _ ->
    newline fmt ();
    indent option.indent_size fmt ();
    (Fmt.vbox ~indent:option.indent_size pf) fmt v;
    newline fmt ();
    Printer_token.print fmt Tok_rparen ~option
  | None ->
    pf fmt v;
    Printer_token.print fmt Tok_rparen ~option
