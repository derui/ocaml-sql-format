open Parser.Ast
include Printer_intf

include (
  struct
    type t = into_clause

    let print f (Into_clause (Ident ident)) ~option =
      Token_printer.print f ~option Parser.Token.Kw_into;
      Fmt.string f " ";
      Fmt.string f ident
  end :
    S with type t = into_clause)
