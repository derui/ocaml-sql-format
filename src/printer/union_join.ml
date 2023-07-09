open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext union_join

module Make
    (R : GEN with type t = ext table_reference)
    (P : GEN with type t = ext table_primary) =
struct
  type t = ext union_join

  let print f t ~option =
    match t with
    | Union_join (r, tp, _) ->
      let module R = (val R.generate ()) in
      R.print ~option f r;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_union;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_join;
      Fmt.string f " ";
      let module P = (val P.generate ()) in
      P.print ~option f tp
end
