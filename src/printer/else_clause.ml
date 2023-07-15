open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext else_clause

module Make (V : GEN with type t = ext result') : S = struct
  type t = ext else_clause

  let print f t ~option =
    match t with
    | Else_clause (v, _) ->
      Printer_token.print ~option f Kw_else;
      let module V = (val V.generate ()) in
      V.print ~option f v
end
