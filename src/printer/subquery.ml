open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext subquery

module Make (Q : GEN with type t = ext query_expression) : S = struct
  type t = ext subquery

  let print f t ~option =
    match t with
    | Subquery (`query q, _) ->
      let module Q = (val Q.generate ()) in
      Printer_token.print f Tok_lparen ~option;
      Q.print f q ~option;
      Printer_token.print f Tok_rparen ~option
end
