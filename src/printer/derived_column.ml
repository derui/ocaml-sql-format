open Types.Ast
open Intf

module type S = PRINTER with type t = ext derived_column

module Make
    (I : GEN with type t = ext identifier)
    (Expr : GEN with type t = ext expression) : S = struct
  type t = ext derived_column

  let print f t ~option =
    match t with
    | `Derived_column (exp, alias, _) ->
      let module Expr = (val Expr.generate ()) in
      Expr.print f exp ~option;
      Option.iter
        (fun ident ->
          let module I = (val I.generate ()) in
          Fmt.string f " ";
          Printer_token.print f Types.Token.Kw_as ~option;
          Fmt.string f " ";
          I.print f ident ~option)
        alias
end
