open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext qualified_join

module Make
    (R : GEN with type t = ext table_reference)
    (P : GEN with type t = ext table_primary)
    (JT : GEN with type t = ext join_type)
    (Spec : GEN with type t = ext join_specification) : S = struct
  type t = ext qualified_join

  let print f t ~option =
    match t with
    | Qualified_join (r, jt, tp, spec, _) ->
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
      P.print ~option f tp;
      Fmt.string f " ";
      let module Spec = (val Spec.generate ()) in
      Spec.print ~option f spec
end
