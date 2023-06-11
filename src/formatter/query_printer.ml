open Parser.Ast
include Printer_intf

include (
  struct
    type t = query

    let print f t ~option =
      let { clause; from; _ } = t in
      Select_clause_printer.print f clause ~option;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          From_clause_printer.print f ~option v)
        from
  end :
    S with type t = query)
