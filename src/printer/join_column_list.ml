open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext join_column_list

module Make () : S = struct
  type t = ext join_column_list

  let print f t ~option =
    match t with
    | Join_column_list _ -> failwith "TODO: need implementation"
end
