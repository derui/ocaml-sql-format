open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_partition_clause

module Make () : S = struct
  type t = ext window_partition_clause

  let print f t ~option =
    match t with
    | Window_partition_clause _ -> failwith "TODO: need implementation"
end
