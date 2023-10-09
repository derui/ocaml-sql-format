open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext signed_number

module Make (V : GEN with type t = ext numeric_literal) : S = struct
  type t = ext signed_number

  let print f t ~option =
    match t with
    | Signed_number (sign, v, _) ->
      Option.iter
        (fun sign ->
          let kw =
            match sign with
            | `plus -> Op_plus
            | `minus -> Op_minus
          in
          Token.print ~option f kw)
        sign;

      let module V = (val V.generate ()) in
      V.print ~option f v
end
