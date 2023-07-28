open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext partition_clause

module Make () : S = struct
  type t = ext partition_clause

  let print f t ~option =
    match t with
    | Partition_clause _ -> ()
end
