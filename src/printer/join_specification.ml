open Types.Ast
open Intf

module type S = PRINTER with type t = ext join_specification

module Make
    (C : GEN with type t = ext join_condition)
    (N : GEN with type t = ext named_columns_join) : S = struct
  type t = ext join_specification

  let print f t ~option =
    match t with
    | Join_specification (`cond v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
    | Join_specification (`named v, _) ->
      let module N = (val N.generate ()) in
      N.print ~option f v
end
