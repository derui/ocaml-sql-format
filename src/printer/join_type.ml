open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext join_type

module Make (OJ : GEN with type t = ext outer_join_type) : S = struct
  type t = ext join_type

  let print f t ~option =
    match t with
    | Join_type (`inner, _) -> Printer_token.print ~option f Kw_inner
    | Join_type (`outer o, _) ->
      let module OJ = (val OJ.generate ()) in
      OJ.print ~option f o;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_outer
end
