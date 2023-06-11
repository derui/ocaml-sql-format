open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = table_reference

    let print f t ~option =
      match t with
      | Joined_table (`table_name (Ident ident, alias)) ->
        Fmt.string f ident;
        Option.iter
          (fun (Ident alias) ->
            Fmt.string f " ";
            Token_printer.print f ~option Kw_as;
            Fmt.string f " ";
            Fmt.string f alias)
          alias
  end :
    S with type t = table_reference)
