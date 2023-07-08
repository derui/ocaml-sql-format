open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext join_specification

module Make () : S = struct
  type t = ext join_specification

  let print f t ~option =
    match t with
    | Join_specification _ -> failwith "TODO: need implementation"
end
