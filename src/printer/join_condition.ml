open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext join_condition

module Make () : S = struct
  type t = ext join_condition

  let print f t ~option =
    match t with
    | Join_condition _ -> failwith "TODO: need implementation"
end
