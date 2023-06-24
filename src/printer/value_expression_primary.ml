open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext value_expression_primary

module Make
    (Nnl : GEN with type t = ext non_numeric_literal)
    (Unl : GEN with type t = ext unsigned_numeric_literal)
    (Expr : GEN with type t = ext unsigned_value_expression_primary)
    (Nve : GEN with type t = ext numeric_value_expression) : S = struct
  type t = ext value_expression_primary

  let print f t ~option =
    match t with
    | Value_expression_primary (`non_numeric_literal l, _) ->
      let module Nnl = (val Nnl.generate ()) in
      Nnl.print f l ~option
    | Value_expression_primary (`unsigned_numeric_literal (op, l), _) ->
      Option.iter
        (function
          | `plus -> Printer_token.print f Op_plus ~option
          | `minus -> Printer_token.print f Op_minus ~option)
        op;
      let module Unl = (val Unl.generate ()) in
      Unl.print f l ~option
    | Value_expression_primary
        (`unsigned_value_expression_primary (exp, indices), _) ->
      let module Expr = (val Expr.generate ()) in
      let module Nve = (val Nve.generate ()) in
      Expr.print f exp ~option;

      List.iter
        (fun exp ->
          Printer_token.print f Tok_lsbrace ~option;
          Nve.print f exp ~option;
          Printer_token.print f Tok_rsbrace ~option)
        indices
end
