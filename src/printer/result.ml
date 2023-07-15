open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext result'

module Make (V : GEN with type t = ext result_expression) : S = struct
  type t = ext result'

  let print f t ~option =
    match t with
    | Result (`null, _) -> Printer_token.print ~option f Kw_null
    | Result (`expr v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
