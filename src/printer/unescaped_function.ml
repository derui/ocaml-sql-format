open Types.Ast
open Intf

module type S = PRINTER with type t = ext unescaped_function

module Make
    (TAF : GEN with type t = ext text_aggregate_function)
    (SAF : GEN with type t = ext standard_aggregate_function) : S = struct
  type t = ext unescaped_function

  let print f t ~option =
    match t with
    | Unescaped_function (`text_aggregate_function taf) ->
      let module TAF = (val TAF.generate ()) in
      TAF.print f taf ~option
    | Unescaped_function (`standard_aggregate_function taf) ->
      let module SAF = (val SAF.generate ()) in
      SAF.print f taf ~option
end
