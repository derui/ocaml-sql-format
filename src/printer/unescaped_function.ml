open Types.Ast
open Intf

module type S = PRINTER with type t = ext unescaped_function

module Make (TAF : GEN with type t = ext text_aggregate_function) : S = struct
  type t = ext unescaped_function

  let print f t ~option =
    match t with
    | Unescaped_function (`text_aggregate_function taf) ->
      let module TAF = (val TAF.generate ()) in
      TAF.print f taf ~option
end
