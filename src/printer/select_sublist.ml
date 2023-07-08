open Types.Ast
open Intf

module type S = PRINTER with type t = ext select_sublist

module Make
    (DC : GEN with type t = ext derived_column)
    (Q : GEN with type t = ext qualified_asterisk) : S = struct
  type t = ext select_sublist

  let print f t ~option =
    match t with
    | Select_sublist (`derived d, _) ->
      let module DC = (val DC.generate ()) in
      DC.print ~option f d
    | Select_sublist (`qualified q, _) ->
      let module Q = (val Q.generate ()) in
      Q.print f q ~option
end
