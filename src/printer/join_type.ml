open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext join_type

module Make () : S = struct
  type t = ext join_type

  let print f t ~option =
    match t with
    | Join_type _ -> failwith "TODO: need implementation"
end
