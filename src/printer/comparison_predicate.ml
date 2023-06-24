open Types.Ast
open Intf

module type S = PRINTER with type t = ext comparison_predicate

module Make
    (Co : GEN with type t = ext comparison_operator)
    (Cve : GEN with type t = ext common_value_expression) : S = struct
  type t = ext comparison_predicate

  let print f t ~option =
    match t with
    | `Comparison_predicate (op, value, _) ->
      let module Co = (val Co.generate ()) in
      let module Cve = (val Cve.generate ()) in
      Co.print f op ~option;
      Fmt.string f " ";
      Cve.print f value ~option
end
