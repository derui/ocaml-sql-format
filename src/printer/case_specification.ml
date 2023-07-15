open Types.Ast
open Intf

module type S = PRINTER with type t = ext case_specification

module Make
    (V : GEN with type t = ext simple_case)
    (C : GEN with type t = ext searched_case) : S = struct
  type t = ext case_specification

  let print f t ~option =
    match t with
    | Case_specification (`simple v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Case_specification (`searched v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
end
