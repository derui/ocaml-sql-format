open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext sample_clause

module Make
    (Expr : GEN with type t = ext numeric_value_expression)
    (Rep : GEN with type t = ext repeatable_clause) : S = struct
  type t = ext sample_clause

  let print f t ~option =
    match t with
    | Sample_clause (kw, expr, rep, _) ->
      let kw =
        match kw with
        | `bernoulli -> Kw_bernoulli
        | `system -> Kw_system
      in
      Printer_token.print ~option f Kw_tablesample;
      Fmt.string f " ";
      Printer_token.print ~option f kw;
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let module Expr = (val Expr.generate ()) in
          Expr.print ~option f expr)
        f ();

      Option.iter
        (fun rep ->
          Fmt.string f " ";
          let module Rep = (val Rep.generate ()) in
          Rep.print ~option f rep)
        rep
end
