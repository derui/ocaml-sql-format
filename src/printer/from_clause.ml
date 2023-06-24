open Types.Ast
open Intf

module type S = PRINTER with type t = ext from_clause

module Make
    (Table_reference : GEN with type t = ext table_reference)
    (Where : GEN with type t = ext where_clause)
    (Group_by : GEN with type t = ext group_by_clause)
    (Having : GEN with type t = ext having_clause) : S = struct
  type t = ext from_clause

  let print f t ~option =
    match t with
    | `From_clause ({ tables; group_by; having; where }, _) ->
      Fmt.string f " ";
      Printer_token.print f ~option Types.Token.Kw_from;
      Fmt.string f " ";

      (match tables with
      | [] -> assert false
      | fst :: rest ->
        let module Table_reference = (val Table_reference.generate ()) in
        Table_reference.print f ~option fst;
        List.iter
          (fun v ->
            Printer_token.print f ~option Types.Token.Tok_comma;
            Table_reference.print f ~option v)
          rest);
      Option.iter
        (fun v ->
          let module Where = (val Where.generate ()) in
          Fmt.string f " ";
          Where.print f ~option v)
        where;

      Option.iter
        (fun v ->
          let module Group_by = (val Group_by.generate ()) in
          Fmt.string f " ";
          Group_by.print f ~option v)
        group_by;

      Option.iter
        (fun v ->
          let module Having = (val Having.generate ()) in
          Fmt.string f " ";
          Having.print f ~option v)
        having
end
