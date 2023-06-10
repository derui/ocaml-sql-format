open Parser.Ast
open Parser.Token
include Printer_intf

module rec Value_expression_primary_printer :
  (S with type t = value_expression_primary) = struct
  type t = value_expression_primary

  let print f t ~option =
    match t with
    | Non_numeric_literal l -> Non_numeric_literal_printer.print f l ~option
    | Unsigned_numeric_literal (op, l) ->
      Option.iter
        (function
          | `plus -> Token_printer.print f Op_plus ~option
          | `minus -> Token_printer.print f Op_minus ~option)
        op;
      Unsigned_numeric_literal_printer.print f l ~option
    | Unsigned_value_expression_primary { exp; indices } ->
      Unsigned_value_expression_primary_printer.print f exp ~option;

      List.iter
        (fun exp ->
          Token_printer.print f Tok_lsbrace ~option;
          Numeric_value_expression_printer.print f exp ~option;
          Token_printer.print f Tok_rsbrace ~option)
        indices
end

and Numeric_value_expression_printer :
  (S with type t = numeric_value_expression) = struct
  type t = numeric_value_expression

  let print f t ~option =
    let term, terms = t in
    Term_printer.print f term ~option;

    List.iter
      (fun (op, term) ->
        (match op with
        | `plus -> Token_printer.print f Op_plus ~option
        | `minus -> Token_printer.print f Op_minus ~option);
        Term_printer.print f term ~option)
      terms
end

and Common_value_expression_printer :
  (S with type t = common_value_expression) = struct
  type t = common_value_expression

  let print f t ~option =
    let exp, list = t in

    Numeric_value_expression_printer.print f exp ~option;

    List.iter
      (fun (op, exp) ->
        (match op with
        | `amp -> Token_printer.print f Op_double_amp ~option
        | `concat -> Token_printer.print f Op_concat ~option);
        Numeric_value_expression_printer.print f exp ~option)
      list
end

and Term_printer : (S with type t = term) = struct
  type t = term

  let print f t ~option =
    let primary, primaries = t in
    Value_expression_primary_printer.print f primary ~option;

    List.iter
      (fun (op, primary) ->
        (match op with
        | `star -> Token_printer.print f Op_star ~option
        | `slash -> Token_printer.print f Op_slash ~option);
        Value_expression_primary_printer.print f primary ~option)
      primaries
end
