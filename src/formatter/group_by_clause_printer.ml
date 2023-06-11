open Parser.Ast
open Parser.Token
include Printer_intf

include (
  struct
    type t = group_by_clause

    let print_exps f option = function
      | [] -> ()
      | exp :: rest ->
        Boolean_value_expression_printer.print f ~option exp;
        List.iter
          (fun exp ->
            Token_printer.print f ~option Tok_comma;
            Boolean_value_expression_printer.print f ~option exp)
          rest

    let print f (Group_by_clause t) ~option =
      Token_printer.print f ~option Kw_group;
      Fmt.string f " ";
      Token_printer.print f ~option Kw_by;
      Fmt.string f " ";

      match t with
      | `rollup v ->
        Fmt.string f " ";
        Token_printer.print f ~option Kw_rollup;
        Fmt.string f " ";
        Token_printer.print f ~option Tok_lparen;
        print_exps f option v;
        Token_printer.print f ~option Tok_rparen
      | `default v -> print_exps f option v
  end :
    S with type t = group_by_clause)
