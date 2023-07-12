open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext boolean_term

module Make (V : GEN with type t = ext boolean_factor) : S = struct
  type t = ext boolean_term

  let rec print f t ~option =
    match t with
    | Boolean_term (`factor e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Boolean_term (`and' (e, e'), _) ->
      print ~option f e;
      Fmt.sp f ();
      Printer_token.print ~option f Kw_and;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f e'
end
