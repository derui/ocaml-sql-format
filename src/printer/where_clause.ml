open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext where_clause

module Make (Cond : GEN with type t = ext condition) : S = struct
  type t = ext where_clause

  let print f t ~option =
    match t with
    | Where_clause (t, _) ->
      Printer_token.print f ~option Kw_where;
      let module Cond = (val Cond.generate ()) in
      let pf f _ = Cond.print f ~option t in
      Sfmt.force_vbox option.indent_size pf f ()
end
