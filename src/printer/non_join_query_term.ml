open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext non_join_query_term

module Make
    (V : GEN with type t = ext non_join_query_primary)
    (QT : GEN with type t = ext query_term)
    (CS : GEN with type t = ext corresponding_spec)
    (QP : GEN with type t = ext query_primary) : S = struct
  type t = ext non_join_query_term

  let print f t ~option =
    match t with
    | Non_join_query_term (`primary p, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f p
    | Non_join_query_term (`term (term, qualifier, spec, primary), _) ->
      let module QT = (val QT.generate ()) in
      QT.print ~option f term;
      Fmt.cut f ();
      Printer_token.print ~option f Kw_intersect;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print ~option f
            (match v with
            | `All -> Kw_all
            | `Distinct -> Kw_distinct))
        qualifier;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module CS = (val CS.generate ()) in
          CS.print ~option f v)
        spec;
      Fmt.cut f ();
      let module QP = (val QP.generate ()) in
      QP.print ~option f primary
end
