open Types.Ast
open Intf

module type S = PRINTER with type t = ext select_sublist

module Make
    (I : GEN with type t = ext identifier)
    (Expr : GEN with type t = ext expression) : S = struct
  type t = ext select_sublist

  let print f t ~option =
    match t with
    | `Select_sublist (`All_in_group s, _) -> Fmt.string f s
    | `Select_sublist (`Derived_column (exp, alias), _) ->
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
