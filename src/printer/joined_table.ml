open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext joined_table

module Make () : S = struct
  type t = ext joined_table

  let print f t ~option =
    match t with
    | Joined_table _ -> failwith "TODO: need implementation"
end
