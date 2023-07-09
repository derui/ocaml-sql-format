open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext recursive_search_order

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext recursive_search_order

  let print f t ~option =
    match t with
    | Recursive_search_order _ -> failwith "TODO: need implementation"
end
