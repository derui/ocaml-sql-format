open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext having_clause

module Make (Cond : GEN with type t = ext search_condition) : S = struct
  type t = ext having_clause

  let print f t ~option =
    match t with
    | Having_clause (t, _) ->
      Printer_token.print f ~option Kw_having;
      let module Cond = (val Cond.generate ()) in
      let pf f _ = Cond.print f ~option t in
      Sfmt.force_vbox option.indent_size pf f ()
end
