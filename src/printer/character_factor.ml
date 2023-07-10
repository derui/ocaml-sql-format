open Types.Ast
open Intf

module type S = PRINTER with type t = ext character_factor

module Make
    (V : GEN with type t = ext character_primary)
    (C : GEN with type t = ext collate_clause) : S = struct
  type t = ext character_factor

  let print f t ~option =
    match t with
    | Character_factor (e, c, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;

      Option.iter
        (fun c ->
          Fmt.string f " ";
          let module C = (val C.generate ()) in
          C.print ~option f c)
        c
end
