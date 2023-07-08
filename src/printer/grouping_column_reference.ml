open Types.Ast
open Intf

module type S = PRINTER with type t = ext grouping_column_reference

module Make
    (C : GEN with type t = ext column_reference)
    (Collate : GEN with type t = ext collate_clause) : S = struct
  type t = ext grouping_column_reference

  let print f t ~option =
    match t with
    | Grouping_column_reference (c, collate, _) ->
      let module C = (val C.generate ()) in
      C.print f c ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module Collate = (val Collate.generate ()) in
          Collate.print f v ~option)
        collate
end
