open Parser.Ast
open Parser.Token
include Printer_intf

module Predicate_printer : S with type t = boolean_primary_predicate = struct
  type t = boolean_primary_predicate

  let print f t ~option =
    match t with
    | `is_null ->
      Token_printer.print f Kw_is ~option;
      Fmt.string f " ";
      Token_printer.print f Kw_null ~option
    | `is_not_null ->
      Token_printer.print f Kw_is ~option;
      Fmt.string f " ";
      Token_printer.print f Kw_not ~option;
      Fmt.string f " ";
      Token_printer.print f Kw_null ~option
    | `comparison (op, value) ->
      let op =
        match op with
        | `eq -> Op_eq
        | `ne -> Op_ne
        | `ne2 -> Op_ne2
        | `gt -> Op_gt
        | `ge -> Op_ge
        | `lt -> Op_lt
        | `le -> Op_le
      in
      Token_printer.print f op ~option;
      Fmt.string f " ";
      Value_printers.Common_value_expression_printer.print f value ~option
end

include (
  struct
    type t = boolean_primary

    let print f t ~option =
      match t with
      | Boolean_primary { value; predicate } ->
        Value_printers.Common_value_expression_printer.print f value ~option;

        Option.iter
          (fun v ->
            Fmt.string f " ";
            Predicate_printer.print f v ~option)
          predicate
  end :
    S with type t = boolean_primary)
