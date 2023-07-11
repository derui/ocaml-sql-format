open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext multiset_term

module Make (V : GEN with type t = ext multiset_primary) : S = struct
  type t = ext multiset_term

  let rec print f t ~option =
    match t with
    | Multiset_term (`primary e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Multiset_term (`term (e, p, q), _) ->
      print ~option f e;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_multiset;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_intersect;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print ~option f
            (match v with
            | `All -> Kw_all
            | `Distinct -> Kw_distinct))
        q;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f p
end
