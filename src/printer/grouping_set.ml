open Types.Ast
open Intf

module type S = PRINTER with type t = ext grouping_set

module Make
    (Ord : GEN with type t = ext ordinary_grouping_set)
    (Rollup : GEN with type t = ext rollup_list)
    (Cube : GEN with type t = ext cube_list)
    (Spec : GEN with type t = ext grouping_sets_specification)
    (E : GEN with type t = ext empty_grouping_set) : S = struct
  type t = ext grouping_set

  let print f t ~option =
    match t with
    | Grouping_set (`ordinary o, _) ->
      let module Ord = (val Ord.generate ()) in
      Ord.print f ~option o
    | Grouping_set (`rollup o, _) ->
      let module Rollup = (val Rollup.generate ()) in
      Rollup.print f ~option o
    | Grouping_set (`cube o, _) ->
      let module Cube = (val Cube.generate ()) in
      Cube.print f ~option o
    | Grouping_set (`spec o, _) ->
      let module Spec = (val Spec.generate ()) in
      Spec.print f ~option o
    | Grouping_set (`empty o, _) ->
      let module E = (val E.generate ()) in
      E.print f ~option o
end
