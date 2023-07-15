open Types.Ast
open Intf

module type S =
  PRINTER with type t = ext nonparenthesized_value_expression_primary

module Make
    (V : GEN with type t = ext column_reference)
    (Next : GEN with type t = ext next_value_expression)
    (Field : GEN with type t = ext field_reference)
    (Attr : GEN with type t = ext attribute_or_method_reference)
    (Array' : GEN with type t = ext array_element_reference)
    (Multiset : GEN with type t = ext multiset_element_reference)
    (Window : GEN with type t = ext window_function)
    (Subquery : GEN with type t = ext scalar_subquery)
    (Set_function : GEN with type t = ext set_function_specification)
    (U : GEN with type t = ext unsigned_value_specification) : S = struct
  type t = ext nonparenthesized_value_expression_primary

  let print f t ~option =
    match t with
    | Nonparenthesized_value_expression_primary (`unsigned c, _) ->
      let module U = (val U.generate ()) in
      U.print ~option f c
    | Nonparenthesized_value_expression_primary (`column c, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f c
    | Nonparenthesized_value_expression_primary (`next c, _) ->
      let module Next = (val Next.generate ()) in
      Next.print ~option f c
    | Nonparenthesized_value_expression_primary (`field c, _) ->
      let module Field = (val Field.generate ()) in
      Field.print ~option f c
    | Nonparenthesized_value_expression_primary (`attribute c, _) ->
      let module Attr = (val Attr.generate ()) in
      Attr.print ~option f c
    | Nonparenthesized_value_expression_primary (`array c, _) ->
      let module Array' = (val Array'.generate ()) in
      Array'.print ~option f c
    | Nonparenthesized_value_expression_primary (`multiset c, _) ->
      let module Multiset = (val Multiset.generate ()) in
      Multiset.print ~option f c
    | Nonparenthesized_value_expression_primary (`window c, _) ->
      let module Window = (val Window.generate ()) in
      Window.print ~option f c
    | Nonparenthesized_value_expression_primary (`scalar c, _) ->
      let module Subquery = (val Subquery.generate ()) in
      Subquery.print ~option f c
    | Nonparenthesized_value_expression_primary (`set_function c, _) ->
      let module Set_function = (val Set_function.generate ()) in
      Set_function.print ~option f c
end
