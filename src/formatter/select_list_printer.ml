open Parser.Ast
open Parser.Token
include Printer_intf

module Sublist_printer : S with type t = select_sublist = struct
  type t = select_sublist

  let print f t ~option =
    match t with
    | Ss_qualified_asterisk (Ident ident :: rest) ->
      Fmt.string f ident;

      List.iter
        (fun (Ident i) ->
          Fmt.string f ".";
          Fmt.string f i)
        rest
    | Ss_qualified_asterisk _ -> failwith "Invalid AST"
    | Ss_derived_column { exp; as_clause } ->
      Value_expression_printer.print f exp ~option;
      Option.iter
        (fun (Ident ident) ->
          Token_printer.print f Parser.Token.Kw_as ~option;
          Fmt.string f ident)
        as_clause
end

include (
  struct
    type t = select_list

    let print f t ~option =
      match t with
      | Sl_asterisk -> Fmt.string f "*"
      | Sl_sublists (sublist :: rest) ->
        Sublist_printer.print f sublist ~option;
        List.iter
          (fun sublist ->
            Token_printer.print f Tok_comma ~option;
            Sublist_printer.print f sublist ~option)
          rest
      | Sl_sublists _ -> failwith "Invalid syntax"
  end :
    S with type t = select_list)
