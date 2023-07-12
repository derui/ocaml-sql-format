open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext boolean_value_expression

module Make (V : GEN with type t = ext boolean_term) : S = struct
  type t = ext boolean_value_expression

  let rec print f t ~option =
    match t with
    | Boolean_value_expression (`term e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Boolean_value_expression (`or' (e, e'), _) ->
      print ~option f e;
      Fmt.sp f ();
      Printer_token.print ~option f Kw_or;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f e'
end
