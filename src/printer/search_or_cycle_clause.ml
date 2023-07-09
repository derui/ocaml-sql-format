open Types.Ast
open Intf

module type S = PRINTER with type t = ext search_or_cycle_clause

module Make
    (V : GEN with type t = ext search_clause)
    (C : GEN with type t = ext cycle_clause) : S = struct
  type t = ext search_or_cycle_clause

  let print f t ~option =
    match t with
    | Search_or_cycle_clause (`search v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Search_or_cycle_clause (`cycle v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
    | Search_or_cycle_clause (`search_and_cycle (search, cycle), _) ->
      let module V = (val V.generate ()) in
      V.print ~option f search;
      Fmt.cut f ();
      let module C = (val C.generate ()) in
      C.print ~option f cycle
end
