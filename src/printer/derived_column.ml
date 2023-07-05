open Types.Ast
open Intf

module type S = PRINTER with type t = ext derived_column

module Make
    (Expr : GEN with type t = ext value_expression)
    (As : GEN with type t = ext as_clause) : S = struct
  type t = ext derived_column

  let print f t ~option =
    match t with
    | Derived_column (exp, alias, _) ->
      let module Expr = (val Expr.generate ()) in
      Expr.print f exp ~option;
      Option.iter
        (fun ident ->
          Fmt.string f " ";
          let module As = (val As.generate ()) in
          As.print f ident ~option)
        alias
end
