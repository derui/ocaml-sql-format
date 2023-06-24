open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext match_predicate

module Make
    (Cve : GEN with type t = ext common_value_expression)
    (Character : GEN with type t = ext character) : S = struct
  type t = ext match_predicate

  let special_kw_print f ~option = function
    | `similar ->
      Printer_token.print f Kw_similar ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_to ~option
    | `like -> Printer_token.print f Kw_like ~option

  let print f t ~option =
    match t with
    | Match_predicate (kw, e, escape, not_op, _) ->
      Option.iter
        (fun _ ->
          Printer_token.print f Kw_not ~option;
          Fmt.string f " ")
        not_op;

      let module Cve = (val Cve.generate ()) in
      special_kw_print f ~option kw;
      Fmt.string f " ";
      Cve.print f e ~option;

      Option.iter
        (fun v ->
          let module Character = (val Character.generate ()) in
          Fmt.string f " ";
          Printer_token.print f Kw_escape ~option;
          Fmt.string f " ";
          Character.print f v ~option)
        escape
end
