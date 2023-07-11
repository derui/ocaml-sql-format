open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext interval_factor

module Make (V : GEN with type t = ext interval_primary) : S = struct
  type t = ext interval_factor

  let print f t ~option =
    match t with
    | Interval_factor (s, e, _) ->
      Option.iter
        (fun s ->
          Printer_token.print ~option f
            (match s with
            | `plus -> Op_plus
            | `minus -> Op_minus))
        s;

      let module V = (val V.generate ()) in
      V.print ~option f e
end
