open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext where_clause

module Make (Cond : GEN with type t = ext condition) : S = struct
  type t = ext where_clause

  let print f t ~option =
    match t with
    | Where_clause (t, _) ->
      let module Cond = (val Cond.generate ()) in
      Printer_token.print f ~option Kw_where;
      Fmt.string f " ";
      Cond.print f ~option t
end
