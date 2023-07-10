open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext rank_function_type

module Make () : S = struct
  type t = ext rank_function_type

  let print f t ~option =
    match t with
    | Rank_function_type (`rank, _) -> Printer_token.print ~option f Kw_rank
    | Rank_function_type (`dense_rank, _) ->
      Printer_token.print ~option f Kw_dense_rank
    | Rank_function_type (`percent_rank, _) ->
      Printer_token.print ~option f Kw_percent_rank
    | Rank_function_type (`cume_dist, _) ->
      Printer_token.print ~option f Kw_cume_dist
end
