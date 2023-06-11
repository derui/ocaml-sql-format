open Parser.Ast
include Printer_intf

include (
  struct
    type t = from_clause

    let print f t ~option =
      let { tables; _ } = t in
      Fmt.string f " ";
      Token_printer.print f ~option Parser.Token.Kw_from;
      Fmt.string f " ";

      match tables with
      | [] -> assert false
      | fst :: rest ->
        Table_reference_printer.print f ~option fst;
        List.iter
          (fun v ->
            Token_printer.print f ~option Parser.Token.Tok_comma;
            Table_reference_printer.print f ~option v)
          rest
  end :
    S with type t = from_clause)
