open Types.Ast
open Intf

module type S = PRINTER with type t = ext table_reference

module Make
    (P : GEN with type t = ext table_primary)
    (JT : GEN with type t = ext joined_table)
    (S : GEN with type t = ext sample_clause) : S = struct
  type t = ext table_reference

  let print f t ~option =
    match t with
    | Table_reference (`primary p, s, _) ->
      let module P = (val P.generate ()) in
      P.print f p ~option;

      Option.iter
        (fun s ->
          Fmt.string f " ";
          let module S = (val S.generate ()) in
          S.print f s ~option)
        s
    | Table_reference (`joined p, s, _) ->
      let module JT = (val JT.generate ()) in
      JT.print f p ~option;

      Option.iter
        (fun s ->
          Fmt.string f " ";
          let module S = (val S.generate ()) in
          S.print f s ~option)
        s
end
