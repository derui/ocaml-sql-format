open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext search_clause

module Make
    (V : GEN with type t = ext recursive_search_order)
    (S : GEN with type t = ext sequence_column) : S = struct
  type t = ext search_clause

  let print f t ~option =
    match t with
    | Search_clause (order, seq, _) ->
      Printer_token.print ~option f Kw_search;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f order;
      Printer_token.print ~option f Kw_set;
      Fmt.string f " ";
      let module S = (val S.generate ()) in
      S.print ~option f seq
end
