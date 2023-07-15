open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext binary_large_object_string_type

module Make (V : GEN with type t = ext large_object_length) : S = struct
  type t = ext binary_large_object_string_type

  let print f t ~option =
    match t with
    | Binary_large_object_string_type (`long, v, _) ->
      Sfmt.keyword ~option f [ Kw_binary; Kw_large; Kw_object ];
      Option.iter
        (fun v ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f v)
            f ())
        v
    | Binary_large_object_string_type (`short, v, _) ->
      Sfmt.keyword ~option f [ Kw_blob ];
      Option.iter
        (fun v ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f v)
            f ())
        v
end
