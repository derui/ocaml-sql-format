open Types.Ast
open Intf

module type S = PRINTER with type t = ext data_type

module Make
    (V : GEN with type t = ext predefined_type)
    (R : GEN with type t = ext row_type)
    (P : GEN with type t = ext path_resolved_user_defined_type_name)
    (Ref : GEN with type t = ext reference_type)
    (C : GEN with type t = ext collection_type) : S = struct
  type t = ext data_type

  let print f t ~option =
    match t with
    | Data_type (`predefined v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Data_type (`row v, _) ->
      let module R = (val R.generate ()) in
      R.print ~option f v
    | Data_type (`path v, _) ->
      let module P = (val P.generate ()) in
      P.print ~option f v
    | Data_type (`ref v, _) ->
      let module Ref = (val Ref.generate ()) in
      Ref.print ~option f v
    | Data_type (`collection v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
end
