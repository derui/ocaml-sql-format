open Types.Ast
open Types.Token
open Types.Literal
open Intf

module type S = PRINTER with type t = ext attribute_or_method_reference

module Make
    (V : GEN with type t = ext value_expression_primary)
    (I : GEN with type t = ext identifier)
    (Arg : GEN with type t = ext sql_argument_list) : S = struct
  type t = ext attribute_or_method_reference

  let print f t ~option =
    match t with
    | Attribute_or_method_reference (v, i, args, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v;
      Printer_token.print ~option f Op_dereference;
      let module I = (val I.generate ()) in
      I.print ~option f i;

      Option.iter
        (fun v ->
          let module Arg = (val Arg.generate ()) in
          Arg.print ~option f v)
        args
end
