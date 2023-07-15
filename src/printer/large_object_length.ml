open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext large_object_length

module Make
    (V : GEN with type t = ext unsigned_integer)
    (C : GEN with type t = ext char_length_units) : S = struct
  type t = ext large_object_length

  let print f t ~option =
    match t with
    | Large_object_length (c, m, u, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f c;

      Option.iter
        (fun v ->
          let str =
            match v with
            | `k -> "K"
            | `m -> "M"
            | `g -> "G"
          in
          Fmt.string f str)
        m;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module C = (val C.generate ()) in
          C.print ~option f v)
        u
end
