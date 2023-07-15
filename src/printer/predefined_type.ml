open Types.Ast
open Intf

module type S = PRINTER with type t = ext predefined_type

module Make
    (V : GEN with type t = ext character_string_type)
    (NC : GEN with type t = ext national_character_string_type)
    (Blob : GEN with type t = ext binary_large_object_string_type)
    (Numeric : GEN with type t = ext numeric_type)
    (Boolean : GEN with type t = ext boolean_type)
    (Datetime : GEN with type t = ext datetime_type)
    (Interval : GEN with type t = ext interval_type)
    (C : GEN with type t = ext collate_clause) : S = struct
  type t = ext predefined_type

  let print f t ~option =
    match t with
    | Predefined_type (`character (v, _, collate), _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module C = (val C.generate ()) in
          C.print ~option f v)
        collate
    | Predefined_type (`national_character (v, collate), _) ->
      let module NC = (val NC.generate ()) in
      NC.print ~option f v;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module C = (val C.generate ()) in
          C.print ~option f v)
        collate
    | Predefined_type (`blob v, _) ->
      let module Blob = (val Blob.generate ()) in
      Blob.print ~option f v
    | Predefined_type (`numeric v, _) ->
      let module Numeric = (val Numeric.generate ()) in
      Numeric.print ~option f v
    | Predefined_type (`boolean v, _) ->
      let module Boolean = (val Boolean.generate ()) in
      Boolean.print ~option f v
    | Predefined_type (`datetime v, _) ->
      let module Datetime = (val Datetime.generate ()) in
      Datetime.print ~option f v
    | Predefined_type (`interval v, _) ->
      let module Interval = (val Interval.generate ()) in
      Interval.print ~option f v
end
