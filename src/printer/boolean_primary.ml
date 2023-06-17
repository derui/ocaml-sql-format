open Parser.Ast
open Intf

module type S = PRINTER with type t = ext boolean_primary

module Make
    (Cve : GEN with type t = ext common_value_expression)
    (Bpp : GEN with type t = ext boolean_primary_predicate) : S = struct
  type t = ext boolean_primary

  let print f t ~option =
    match t with
    | `Boolean_primary (value, predicate, _) ->
      let module Cve = (val Cve.generate ()) in
      let module Bpp = (val Bpp.generate ()) in
      Cve.print f value ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Bpp.print f v ~option)
        predicate
end
