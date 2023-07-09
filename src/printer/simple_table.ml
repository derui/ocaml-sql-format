open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext simple_table

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext simple_table

  let print f t ~option =
    match t with
    | Simple_table _ -> failwith "TODO: need implementation"
end
