open Types.Ast
open Intf

module type S = PRINTER with type t = ext window_partition_column_reference

module Make
    (C : GEN with type t = ext column_reference)
    (Collate : GEN with type t = ext collate_clause) : S = struct
  type t = ext window_partition_column_reference

  let print f t ~option =
    match t with
    | Window_partition_column_reference (c, collate, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f c;

      Option.iter
        (fun c ->
          Fmt.string f " ";
          let module Collate = (val Collate.generate ()) in
          Collate.print ~option f c)
        collate
end
