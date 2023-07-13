open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext large_object_length

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext large_object_length

  let print f t ~option =
    match t with
    | Large_object_length _ -> failwith "TODO: need implementation"
end
