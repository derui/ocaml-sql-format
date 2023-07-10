open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext window_name_or_specification

module Make
    (V : GEN with type t = ext identifier)
    (Spec : GEN with type t = ext window_specification) : S = struct
  type t = ext window_name_or_specification

  let print f t ~option =
    match t with
    | Window_name_or_specification (`name e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Window_name_or_specification (`spec e, _) ->
      let module Spec = (val Spec.generate ()) in
      Spec.print ~option f e
end
