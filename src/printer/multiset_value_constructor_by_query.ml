open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext multiset_value_constructor_by_query

module Make (V : GEN with type t = ext query_expression) : S = struct
  type t = ext multiset_value_constructor_by_query

  let print f t ~option =
    match t with
    | Multiset_value_constructor_by_query (e, _) ->
      Printer_token.print ~option f Kw_multiset;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f e)
        f ()
end
