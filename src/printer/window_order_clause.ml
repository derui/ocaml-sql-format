open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_order_clause

module Make (S : GEN with type t = ext sort_specification_list) : S = struct
  type t = ext window_order_clause

  let print f t ~option =
    match t with
    | Window_order_clause (v, _) ->
      Printer_token.print ~option f Kw_order;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_by;
      Fmt.string f " ";
      let module S = (val S.generate ()) in
      S.print ~option f v
end
