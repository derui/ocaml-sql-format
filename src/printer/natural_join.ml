open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext natural_join

module Make
    (R : GEN with type t = ext table_reference)
    (P : GEN with type t = ext table_primary)
    (JT : GEN with type t = ext join_type) : S = struct
  type t = ext natural_join

  let print f t ~option =
    match t with
    | Natural_join (r, jt, tp, _) ->
      let module R = (val R.generate ()) in
      R.print ~option f r;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_union;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module JT = (val JT.generate ()) in
          JT.print ~option f v)
        jt;

      Fmt.string f " ";
      Printer_token.print ~option f Kw_join;
      Fmt.string f " ";
      let module P = (val P.generate ()) in
      P.print ~option f tp
end
