open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext signed_integer

module Make (UI : GEN with type t = ext unsigned_integer) : S = struct
  type t = ext signed_integer

  let print f t ~option =
    match t with
    | Signed_integer (sign, v, _) ->
      Option.iter
        (function
          | `plus -> Printer_token.print ~option f Op_plus
          | `minus -> Printer_token.print ~option f Op_minus)
        sign;
      let module UI = (val UI.generate ()) in
      UI.print ~option f v
end
