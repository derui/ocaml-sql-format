open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext analytic_aggregate_function

module Make () : S = struct
  type t = ext analytic_aggregate_function

  let fname_to_kw = function
    | `row_number -> Kw_row_number
    | `rank -> Kw_rank
    | `dense_rank -> Kw_dense_rank
    | `percent_rank -> Kw_percent_rank
    | `cume_dist -> Kw_cume_dist

  let print f t ~option =
    match t with
    | Analytic_aggregate_function (fname, _) ->
      Printer_token.print f (fname_to_kw fname) ~option;
      Printer_token.print f Tok_lparen ~option;
      Printer_token.print f Tok_rparen ~option
end
