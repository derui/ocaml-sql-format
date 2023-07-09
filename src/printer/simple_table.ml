open Types.Ast
open Intf

module type S = PRINTER with type t = ext simple_table

module Make
    (V : GEN with type t = ext query_specification)
    (TV : GEN with type t = ext table_value_constructor)
    (E : GEN with type t = ext explicit_table) : S = struct
  type t = ext simple_table

  let print f t ~option =
    match t with
    | Simple_table (`query q, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f q
    | Simple_table (`table tv, _) ->
      let module TV = (val TV.generate ()) in
      TV.print ~option f tv
    | Simple_table (`explicit e, _) ->
      let module E = (val E.generate ()) in
      E.print ~option f e
end
