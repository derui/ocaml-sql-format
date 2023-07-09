open Types.Ast
open Types.Token
open Types.Literal
open Intf

module type S = PRINTER with type t = ext with_list_element

module Make
    (V : GEN with type t = ext column_name_list)
    (I : GEN with type t = ext identifier)
    (Expr : GEN with type t = ext query_expression)
    (SC : GEN with type t = ext search_or_cycle_clause) : S = struct
  type t = ext with_list_element

  let print f t ~option =
    match t with
    | With_list_element (n, c, expr, search, _) ->
      let module I = (val I.generate ()) in
      I.print ~option f n;
      Option.iter
        (fun c ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f c)
            f ())
        c;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_as;
      Fmt.string f " ";
      Sfmt.parens ~indent:() ~option
        (fun f _ ->
          let module Expr = (val Expr.generate ()) in
          Expr.print ~option f expr)
        f ();

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module SC = (val SC.generate ()) in
          SC.print ~option f v)
        search
end
