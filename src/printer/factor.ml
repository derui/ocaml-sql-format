open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext factor

module Make (V : GEN with type t = ext numeric_primary) : S = struct
  type t = ext factor

  let print f t ~option =
    match t with
    | Factor (sign, e, _) ->
      Option.iter
        (fun v ->
          Printer_token.print ~option f
            (match v with
            | `plus -> Op_plus
            | `minus -> Op_minus))
        sign;

      let module V = (val V.generate ()) in
      V.print ~option f e
end
