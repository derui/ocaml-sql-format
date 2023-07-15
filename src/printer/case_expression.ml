open Types.Ast
open Intf

module type S = PRINTER with type t = ext case_expression

module Make
    (V : GEN with type t = ext case_abbreviation)
    (Spec : GEN with type t = ext case_specification) : S = struct
  type t = ext case_expression

  let print f t ~option =
    match t with
    | Case_expression (`abbrev v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Case_expression (`spec v, _) ->
      let module Spec = (val Spec.generate ()) in
      Spec.print ~option f v
end
