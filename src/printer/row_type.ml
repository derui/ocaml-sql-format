open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext row_type

module Make (V : GEN with type t = ext row_type_body) : S = struct
  type t = ext row_type

  let print f t ~option =
    match t with
    | Row_type (b, _) ->
      Printer_token.print ~option f Kw_row;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f b
end
