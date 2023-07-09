open Types.Ast
open Intf

module type S = PRINTER with type t = ext joined_table

module Make
    (Cross : GEN with type t = ext cross_join)
    (Qualified : GEN with type t = ext qualified_join)
    (Natural : GEN with type t = ext natural_join)
    (Union : GEN with type t = ext union_join) : S = struct
  type t = ext joined_table

  let print f t ~option =
    match t with
    | Joined_table (`cross v, _) ->
      let module Cross = (val Cross.generate ()) in
      Cross.print ~option f v
    | Joined_table (`qualified v, _) ->
      let module Qualified = (val Qualified.generate ()) in
      Qualified.print ~option f v
    | Joined_table (`natural v, _) ->
      let module Natural = (val Natural.generate ()) in
      Natural.print ~option f v
    | Joined_table (`union v, _) ->
      let module Union = (val Union.generate ()) in
      Union.print ~option f v
end
