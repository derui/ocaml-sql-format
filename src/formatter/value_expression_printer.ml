open Parser.Ast
include Printer_intf

module Primary_printer : S with type t = value_expression_primary = struct
  type t = value_expression_primary

  let print f t ~option:_ =
    match t with
    | Vep_column (Ident ident :: rest) ->
      Fmt.string f ident;
      List.iter
        (fun (Ident ident) ->
          Fmt.string f ".";
          Fmt.string f ident)
        rest
    | Vep_column _ -> failwith "Invalid syntax"
end

include (
  struct
    type t = value_expression

    let rec print f t ~option =
      match t with
      | Exp_parenthesized exp ->
        Fmt.string f "(";
        print f exp ~option;
        Fmt.string f ")"
      | Exp_nonparenthesized exp -> Primary_printer.print f exp ~option
  end :
    S with type t = value_expression)
