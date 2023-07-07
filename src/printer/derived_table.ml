open Types.Ast
open Intf

module type S = PRINTER with type t = ext derived_table

module Make (SQ : GEN with type t = ext table_subquery) : S = struct
  type t = ext derived_table

  let print f t ~option =
    match t with
    | Derived_table (subquery, _) ->
      let module SQ = (val SQ.generate ()) in
      SQ.print ~option f subquery
end
