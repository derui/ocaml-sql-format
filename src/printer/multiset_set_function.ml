open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext multiset_set_function

module Make (V : GEN with type t = ext multiset_value_expression) : S = struct
  type t = ext multiset_set_function

  let print f t ~option =
    match t with
    | Multiset_set_function (e, _) ->
      Printer_token.print ~option f Kw_set;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f e)
        f ()
end
