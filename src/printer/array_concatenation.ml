open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext array_concatenation

module Make
    (V : GEN with type t = ext array_value_expression_1)
    (F : GEN with type t = ext array_factor) : S = struct
  type t = ext array_concatenation

  let print f t ~option =
    match t with
    | Array_concatenation (e, factor, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Fmt.sp f ();
      Printer_token.print ~option f Op_concat;
      Fmt.sp f ();
      let module F = (val F.generate ()) in
      F.print ~option f factor
end
