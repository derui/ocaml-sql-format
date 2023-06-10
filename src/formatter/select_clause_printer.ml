open Parser.Ast
include Printer_intf

include (
  struct
    type t = select_clause

    let print f t ~option =
      let { select_list; _ } = t in
      Token_printer.print f ~option Parser.Token.Kw_select;
      Fmt.string f " ";
      match select_list with
      | `asterisk -> Fmt.string f "*"
      | `select_list [ fst ] -> Select_sublist_printer.print f ~option fst
      | `select_list (fst :: rest) ->
        Select_sublist_printer.print f ~option fst;
        List.iter
          (fun v ->
            Token_printer.print f ~option Parser.Token.Tok_comma;
            Select_sublist_printer.print f ~option v)
          rest
      | `select_list [] -> assert false
  end :
    S with type t = select_clause)
