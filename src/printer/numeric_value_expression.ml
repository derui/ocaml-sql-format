open Types.Ast
open Intf

module type S = PRINTER with type t = ext numeric_value_expression

module Make (V : GEN with type t = ext term) : S = struct
  type t = ext numeric_value_expression

  let rec print f t ~option =
    match t with
    | Numeric_value_expression (`single v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Numeric_value_expression (`plus (v1, v2), _) ->
      print ~option f v1;
      Fmt.sp f ();
      Printer_token.print ~option f Op_star;
      Fmt.sp f ();
      let module V = (val V.generate ()) in
      V.print ~option f v2
    | Numeric_value_expression (`minus (v1, v2), _) ->
      print ~option f v1;
      Fmt.sp f ();
      Printer_token.print ~option f Op_slash;
      Fmt.sp f ();
      let module V = (val V.generate ()) in
      V.print ~option f v2
end
