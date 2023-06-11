open Parser.Ast
include Printer_intf

include (
  struct
    type t = query

    let print f t ~option =
      let { clause; from; into; group_by } = t in
      Select_clause_printer.print f clause ~option;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          Into_clause_printer.print f ~option v)
        into;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          From_clause_printer.print f ~option v)
        from;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          Group_by_clause_printer.print f ~option v)
        group_by
  end :
    S with type t = query)
