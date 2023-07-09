open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext non_join_query_expression

module Make
    (V : GEN with type t = ext non_join_query_term)
    (Body : GEN with type t = ext query_expression_body)
    (Spec : GEN with type t = ext corresponding_spec)
    (Term : GEN with type t = ext query_term) : S = struct
  type t = ext non_join_query_expression

  let print_join option f kw body qualifier spec term =
    let module Body = (val Body.generate ()) in
    Body.print ~option f body;
    Fmt.cut f ();
    Printer_token.print ~option f kw;
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
        let module Spec = (val Spec.generate ()) in
        Spec.print ~option f v)
      spec;
    Fmt.cut f ();
    let module Term = (val Term.generate ()) in
    Term.print ~option f term

  let print f t ~option =
    match t with
    | Non_join_query_expression (`term v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Non_join_query_expression (`union (body, qualifier, spec, term), _) ->
      print_join option f Kw_union body qualifier spec term
    | Non_join_query_expression (`except (body, qualifier, spec, term), _) ->
      print_join option f Kw_except body qualifier spec term
end
