open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext outer_join_type

module Make () : S = struct
  type t = ext outer_join_type

  let print f t ~option =
    match t with
    | Outer_join_type _ -> failwith "TODO: need implementation"
end
