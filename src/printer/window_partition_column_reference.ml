open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_partition_column_reference

module Make () : S = struct
  type t = ext window_partition_column_reference

  let print f t ~option =
    match t with
    | Window_partition_column_reference _ ->
      failwith "TODO: need implementation"
end
