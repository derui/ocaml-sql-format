open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext multiset_value_expression

module Make (V : GEN with type t = ext multiset_term) : S = struct
  type t = ext multiset_value_expression

  let rec print f t ~option =
    match t with
    | Multiset_value_expression (`term v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Multiset_value_expression (`union (e, term, q), _) ->
      print ~option f e;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_multiset;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_union;
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
      V.print ~option f term
    | Multiset_value_expression (`except (e, term, q), _) ->
      print ~option f e;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_multiset;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_except;
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
      V.print ~option f term
end
