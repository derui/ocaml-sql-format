open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext column_reference

module Make
    (I : GEN with type t = ext identifier)
    (IC : GEN with type t = ext identifier_chain) : S = struct
  type t = ext column_reference

  let print f t ~option =
    match t with
    | Column_reference (`chain c, _) ->
      let module IC = (val IC.generate ()) in
      IC.print f c ~option
    | Column_reference (`module' (i, n), _) ->
      Printer_token.print ~option f Kw_module;
      Printer_token.print ~option f Tok_period;
      let module I = (val I.generate ()) in
      I.print f ~option i;
      Printer_token.print ~option f Tok_period;
      I.print f ~option n
end
