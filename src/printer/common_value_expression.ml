open Types.Ast
open Intf

module type S = PRINTER with type t = ext common_value_expression

module Make
    (V : GEN with type t = ext numeric_value_expression)
    (S : GEN with type t = ext string_value_expression)
    (Datetime : GEN with type t = ext datetime_value_expression)
    (Interval : GEN with type t = ext interval_value_expression)
    (User : GEN with type t = ext user_defined_type_value_expression)
    (Ref : GEN with type t = ext reference_value_expression)
    (C : GEN with type t = ext collection_value_expression) : S = struct
  type t = ext common_value_expression

  let print f t ~option =
    match t with
    | Common_value_expression (`numeric v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Common_value_expression (`string v, _) ->
      let module S = (val S.generate ()) in
      S.print ~option f v
    | Common_value_expression (`datetime v, _) ->
      let module Datetime = (val Datetime.generate ()) in
      Datetime.print ~option f v
    | Common_value_expression (`interval v, _) ->
      let module Interval = (val Interval.generate ()) in
      Interval.print ~option f v
    | Common_value_expression (`user_defined v, _) ->
      let module User = (val User.generate ()) in
      User.print ~option f v
    | Common_value_expression (`reference v, _) ->
      let module Ref = (val Ref.generate ()) in
      Ref.print ~option f v
    | Common_value_expression (`collection v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
end
