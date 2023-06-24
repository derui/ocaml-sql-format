open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext like_regex_predicate

module Make (Cve : GEN with type t = ext common_value_expression) : S = struct
  type t = ext like_regex_predicate

  let print f t ~option =
    match t with
    | `Like_regex_predicate (s, not_op, _) ->
      Option.iter
        (fun _ ->
          Printer_token.print f Kw_not ~option;
          Fmt.string f " ")
        not_op;

      let module Cve = (val Cve.generate ()) in
      Printer_token.print f Kw_like_regex ~option;
      Fmt.string f " ";
      Cve.print f s ~option
end
