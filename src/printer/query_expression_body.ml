open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext query_expression_body

module Make
    (P : GEN with type t = ext query_term)
    (O : GEN with type t = ext order_by_clause)
    (L : GEN with type t = ext limit_clause) : S = struct
  type t = ext query_expression_body

  let print f t ~option =
    match t with
    | Query_expression_body ({ term; order_by; limit; terms }, _) ->
      let module P = (val P.generate ()) in
      P.print f term ~option;

      List.iter
        (fun (joiner, qualifier, term) ->
          Fmt.sp f ();
          let kw =
            match joiner with
            | `Union -> Kw_union
            | `Except -> Kw_except
          in
          Printer_token.print f kw ~option;

          Option.iter
            (fun v ->
              Fmt.sp f ();
              let kw =
                match v with
                | `Distinct -> Kw_distinct
                | `All -> Kw_all
              in
              Printer_token.print f kw ~option)
            qualifier;
          Fmt.sp f ();
          P.print f term ~option)
        terms;

      Option.iter
        (fun v ->
          let module O = (val O.generate ()) in
          Fmt.sp f ();
          O.print f v ~option)
        order_by;
      Option.iter
        (fun v ->
          let module L = (val L.generate ()) in
          Fmt.sp f ();
          L.print f v ~option)
        limit
end
