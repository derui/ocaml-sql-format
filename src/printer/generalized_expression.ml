open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext generalized_expression

module Make
    (V : GEN with type t = ext value_expression)
    (N : GEN with type t = ext schema_qualified_name) : S = struct
  type t = ext generalized_expression

  let print f t ~option =
    match t with
    | Generalized_expression (e, name, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_as;
      Fmt.string f " ";
      let module N = (val N.generate ()) in
      N.print ~option f name
end
