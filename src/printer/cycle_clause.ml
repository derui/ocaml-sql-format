open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext cycle_clause

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext cycle_clause

  let print f t ~option =
    match t with
    | Cycle_clause _ -> failwith "TODO: need implementation"
end
