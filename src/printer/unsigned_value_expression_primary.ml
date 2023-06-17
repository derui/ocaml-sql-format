open Parser.Ast
open Parser.Token
open Intf

module type S = PRINTER with type t = ext unsigned_value_expression_primary

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext unsigned_value_expression_primary

  let print f t ~option =
    match t with
    | `Unsigned_value_expression_primary (`parameter_qmark, _) ->
      Printer_token.print f Tok_qmark ~option
    | `Unsigned_value_expression_primary
        (`parameter_dollar (Literal.Unsigned_integer v), _) -> Fmt.string f v
    | `Unsigned_value_expression_primary (`parameter_identifier v, _) ->
      let module I = (val I.generate ()) in
      I.print f v ~option
end
