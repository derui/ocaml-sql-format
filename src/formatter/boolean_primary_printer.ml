open Parser.Ast
open Parser.Token
include Printer_intf

module Predicate_printer : S with type t = boolean_primary_predicate = struct
  type t = boolean_primary_predicate

  let special_kw_print f ~option = function
    | `similar ->
      Token_printer.print f Kw_similar ~option;
      Fmt.string f " ";
      Token_printer.print f Kw_to ~option
    | `like -> Token_printer.print f Kw_like ~option

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
    | `between (s, e) ->
      Token_printer.print f Kw_between ~option;
      Fmt.string f " ";
      Value_printers.Common_value_expression_printer.print f s ~option;
      Fmt.string f " ";
      Token_printer.print f Kw_and ~option;
      Fmt.string f " ";
      Value_printers.Common_value_expression_printer.print f e ~option
    | `between_not (s, e) ->
      Token_printer.print f Kw_not ~option;
      Fmt.string f " ";
      Token_printer.print f Kw_between ~option;
      Fmt.string f " ";
      Value_printers.Common_value_expression_printer.print f s ~option;
      Fmt.string f " ";
      Token_printer.print f Kw_and ~option;
      Fmt.string f " ";
      Value_printers.Common_value_expression_printer.print f e ~option
    | `like_regex s ->
      Token_printer.print f Kw_like_regex ~option;
      Fmt.string f " ";
      Value_printers.Common_value_expression_printer.print f s ~option
    | `like_regex_not s ->
      Token_printer.print f Kw_not ~option;
      Fmt.string f " ";
      Token_printer.print f Kw_like_regex ~option;
      Fmt.string f " ";
      Value_printers.Common_value_expression_printer.print f s ~option
    | `match' (kw, e, escape) ->
      special_kw_print f ~option kw;
      Fmt.string f " ";
      Value_printers.Common_value_expression_printer.print f e ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Token_printer.print f Kw_escape ~option;
          Fmt.string f " ";
          Fmt.string f v)
        escape
    | `match_not (kw, e, escape) ->
      Token_printer.print f Kw_not ~option;
      Fmt.string f " ";
      special_kw_print f ~option kw;
      Fmt.string f " ";
      Value_printers.Common_value_expression_printer.print f e ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Token_printer.print f Kw_escape ~option;
          Fmt.string f " ";
          Fmt.string f v)
        escape
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
