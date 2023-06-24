open Types.Ast
open Intf

module type S = PRINTER with type t = ext sort_key

module Make (Expr : GEN with type t = ext expression) : S = struct
  type t = ext sort_key

  let print f (`Sort_key (expr, _)) ~option =
    let module Expr = (val Expr.generate ()) in
    Expr.print f expr ~option
end
