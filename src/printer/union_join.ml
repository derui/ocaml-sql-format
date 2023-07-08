open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext union_join

module Make () : S = struct
  type t = ext union_join

  let print f t ~option =
    match t with
    | Union_join _ -> failwith "TODO: need implementation"
end
