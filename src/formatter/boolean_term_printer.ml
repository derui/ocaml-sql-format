open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = boolean_term

    let print f t ~option =
      let factor, factors = t in
      Boolean_factor_printer.print f factor ~option;

      List.iter
        (fun v ->
          Fmt.string f " ";
          Token_printer.print f Kw_and ~option;
          Fmt.string f " ";
          Boolean_factor_printer.print f v ~option)
        factors
  end :
    S with type t = boolean_term)
