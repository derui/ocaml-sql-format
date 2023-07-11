open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext interval_primary

module Make
    (V : GEN with type t = ext value_expression_primary)
    (IQ : GEN with type t = ext interval_qualifier)
    (F : GEN with type t = ext interval_value_function) : S = struct
  type t = ext interval_primary

  let print f t ~option =
    match t with
    | Interval_primary (`value (e, iq), _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;

      Option.iter
        (fun iq ->
          Fmt.string f " ";
          let module IQ = (val IQ.generate ()) in
          IQ.print ~option f iq)
        iq
    | Interval_primary (`function' e, _) ->
      let module F = (val F.generate ()) in
      F.print ~option f e
end
