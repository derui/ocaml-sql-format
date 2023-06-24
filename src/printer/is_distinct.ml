open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext is_distinct

module Make (Cve : GEN with type t = ext common_value_expression) : S = struct
  type t = ext is_distinct

  let print f t ~option =
    match t with
    | Is_distinct (e, not_op, _) ->
      Printer_token.print f Kw_is ~option;
      Fmt.string f " ";
      Option.iter
        (fun _ ->
          Printer_token.print f Kw_not ~option;
          Fmt.string f " ")
        not_op;
      Printer_token.print f Kw_distinct ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_from ~option;
      Fmt.string f " ";

      let module Cve = (val Cve.generate ()) in
      Cve.print f e ~option
end
