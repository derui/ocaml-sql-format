open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext exists_predicate

module Make (Q : GEN with type t = ext subquery) : S = struct
  type t = ext exists_predicate

  let print f t ~option =
    match t with
    | `Exists_predicate (q, _) ->
      let module Q = (val Q.generate ()) in
      Printer_token.print f Kw_exists ~option;
      Fmt.string f " ";
      Q.print f q ~option
end
