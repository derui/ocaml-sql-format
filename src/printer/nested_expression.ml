open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext nested_expression

module Make (Expr : GEN with type t = ext expression) : S = struct
  type t = ext nested_expression

  let print f t ~option =
    match t with
    | Nested_expression (list, _) ->
      Printer_token.print f Tok_lparen ~option;

      Sfmt.parens ~option
        (fun f _ ->
          let module Expr = (val Expr.generate ()) in
          match list with
          | [] -> failwith "invalid syntax"
          | e :: rest ->
            Expr.print f e ~option;

            List.iter
              (fun e ->
                Printer_token.print f Tok_comma ~option;
                Fmt.string f " ";
                Expr.print f e ~option)
              rest)
        f ()
end
