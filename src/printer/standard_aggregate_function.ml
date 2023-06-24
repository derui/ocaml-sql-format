open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext standard_aggregate_function

module Make (Expr : GEN with type t = ext expression) : S = struct
  type t = ext standard_aggregate_function

  let fname_to_kw = function
    | `count -> Kw_count
    | `count_big -> Kw_count_big
    | `sum -> Kw_sum
    | `avg -> Kw_avg
    | `min -> Kw_min
    | `max -> Kw_max
    | `every -> Kw_every
    | `stddev_pop -> Kw_stddev_pop
    | `stddev_samp -> Kw_stddev_samp
    | `var_samp -> Kw_var_samp
    | `var_pop -> Kw_var_pop
    | `some -> Kw_some
    | `any -> Kw_any

  let print f t ~option =
    match t with
    | Standard_aggregate_function (`count_star, _) ->
      Printer_token.print f Kw_count ~option;
      Printer_token.print f Tok_lparen ~option;
      Printer_token.print f Op_star ~option;
      Printer_token.print f Tok_rparen ~option
    | Standard_aggregate_function (`count_big_star, _) ->
      Printer_token.print f Kw_count_big ~option;
      Printer_token.print f Tok_lparen ~option;
      Printer_token.print f Op_star ~option;
      Printer_token.print f Tok_rparen ~option
    | Standard_aggregate_function (`call (fname, qualifier, expr), _) ->
      Printer_token.print f (fname_to_kw fname) ~option;
      Printer_token.print f Tok_lparen ~option;
      Option.iter
        (fun v ->
          let kw =
            match v with
            | `All -> Kw_all
            | `Distinct -> Kw_distinct
          in
          Printer_token.print f kw ~option;
          Fmt.string f " ")
        qualifier;

      let module Expr = (val Expr.generate ()) in
      Expr.print f expr ~option;
      Printer_token.print f Tok_rparen ~option
end
