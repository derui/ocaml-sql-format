open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext unsigned_value_specification

module Make () : S = struct
  type t = ext unsigned_value_specification

  let print f t ~option =
    match t with
    | Unsigned_value_specification _ -> failwith "TODO: need implementation"
end
