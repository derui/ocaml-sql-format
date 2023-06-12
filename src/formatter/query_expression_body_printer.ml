open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = query_expression_body

    let print f t ~option =
      match t with
      | Query_expression_body { term; order_by; limit; terms } ->
        Query_term_printer.print f term ~option;

        List.iter
          (fun (joiner, qualifier, term) ->
            Fmt.sp f ();
            let kw =
              match joiner with
              | Union -> Kw_union
              | Except -> Kw_except
            in
            Token_printer.print f kw ~option;

            Option.iter
              (fun v ->
                Fmt.sp f ();
                let kw =
                  match v with
                  | Distinct -> Kw_distinct
                  | All -> Kw_all
                in
                Token_printer.print f kw ~option)
              qualifier;
            Fmt.sp f ();
            Query_term_printer.print f term ~option)
          terms;

        Option.iter
          (fun v ->
            Fmt.sp f ();
            Order_by_clause_printer.print f v ~option)
          order_by;
        Option.iter
          (fun v ->
            Fmt.sp f ();
            Limit_clause_printer.print f v ~option)
          limit
  end :
    S with type t = query_expression_body)
