open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext unsigned_value_expression_primary

module Make
    (I : GEN with type t = ext identifier)
    (Subquery : GEN with type t = ext subquery)
    (CE : GEN with type t = ext case_expression)
    (SCE : GEN with type t = ext searched_case_expression)
    (NE : GEN with type t = ext nested_expression)
    (UF : GEN with type t = ext unescaped_function) : S = struct
  type t = ext unsigned_value_expression_primary

  let print f t ~option =
    match t with
    | Unsigned_value_expression_primary (`parameter_qmark, _) ->
      Printer_token.print f Tok_qmark ~option
    | Unsigned_value_expression_primary
        (`parameter_dollar (Unsigned_integer (v, ())), _) -> Fmt.string f v
    | Unsigned_value_expression_primary (`parameter_identifier v, _) ->
      let module I = (val I.generate ()) in
      I.print f v ~option
    | Unsigned_value_expression_primary (`parameter_subquery v, _) ->
      let module Subquery = (val Subquery.generate ()) in
      Subquery.print f v ~option
    | Unsigned_value_expression_primary (`case_expression v, _) ->
      let module CE = (val CE.generate ()) in
      CE.print f v ~option
    | Unsigned_value_expression_primary (`searched_case_expression v, _) ->
      let module SCE = (val SCE.generate ()) in
      SCE.print f v ~option
    | Unsigned_value_expression_primary (`nested_expression v, _) ->
      let module NE = (val NE.generate ()) in
      NE.print f v ~option
    | Unsigned_value_expression_primary (`unescaped_function v, _) ->
      let module UF = (val UF.generate ()) in
      UF.print f v ~option
end
