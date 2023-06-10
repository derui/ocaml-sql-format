open Parser.Ast
include Printer_intf

include (
  struct
    type t = select_sublist

    let print f t ~option =
      match t with
      | All_in_group s -> Fmt.string f s
      | Select_derived_column { exp; alias } ->
        Boolean_value_expression_printer.print f exp ~option;
        Option.iter
          (fun (Ident ident) ->
            Fmt.string f " ";
            Token_printer.print f Parser.Token.Kw_as ~option;
            Fmt.string f " ";
            Fmt.string f ident)
          alias
  end :
    S with type t = select_sublist)
