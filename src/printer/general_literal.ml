open Types.Literal
open Types.Ext
open Intf

module type S = PRINTER with type t = ext general_literal

module Make
    (C : GEN with type t = ext character_string_literal)
    (N : GEN with type t = ext national_character_string_literal)
    (U : GEN with type t = ext unicode_character_string_literal)
    (B : GEN with type t = ext binary_string_literal)
    (D : GEN with type t = ext datetime_literal)
    (I : GEN with type t = ext interval_literal)
    (Boolean : GEN with type t = ext boolean_literal) : S = struct
  type t = ext general_literal

  let print f t ~option =
    match t with
    | General_literal (`character v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
    | General_literal (`national v, _) ->
      let module N = (val N.generate ()) in
      N.print ~option f v
    | General_literal (`unicode v, _) ->
      let module U = (val U.generate ()) in
      U.print ~option f v
    | General_literal (`binary v, _) ->
      let module B = (val B.generate ()) in
      B.print ~option f v
    | General_literal (`datetime v, _) ->
      let module D = (val D.generate ()) in
      D.print ~option f v
    | General_literal (`interval v, _) ->
      let module I = (val I.generate ()) in
      I.print ~option f v
    | General_literal (`boolean v, _) ->
      let module Boolean = (val Boolean.generate ()) in
      Boolean.print ~option f v
end
