open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext repeatable_clause

module Make (Expr : GEN with type t = ext numeric_value_expression) : S = struct
  type t = ext repeatable_clause

  let print f t ~option =
    match t with
    | Repeatable_clause (expr, _) ->
      Printer_token.print ~option f Kw_repeatable;
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let module Expr = (val Expr.generate ()) in
          Expr.print ~option f expr)
        f ()
end
