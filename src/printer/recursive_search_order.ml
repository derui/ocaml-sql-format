open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext recursive_search_order

module Make (V : GEN with type t = ext sort_specification_list) : S = struct
  type t = ext recursive_search_order

  let print f t ~option =
    match t with
    | Recursive_search_order (`depth spec, _) ->
      Printer_token.print ~option f Kw_depth;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_first;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_by;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f spec
    | Recursive_search_order (`breadth spec, _) ->
      Printer_token.print ~option f Kw_breadth;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_first;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_by;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f spec
end
