open Types.Literal
open Types.Ext
open Types.Token
open Intf

module type S = PRINTER with type t = ext signed_numeric_literal

module Make (UN : GEN with type t = ext unsigned_numeric_literal) : S = struct
  type t = ext signed_numeric_literal

  let print f t ~option =
    match t with
    | Signed_numeric_literal (sign, v, _) ->
      Option.iter
        (function
          | `plus -> Printer_token.print ~option f Op_plus
          | `minus -> Printer_token.print ~option f Op_minus)
        sign;
      let module UN = (val UN.generate ()) in
      UN.print ~option f v
end
