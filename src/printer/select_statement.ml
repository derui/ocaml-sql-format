open Types.Ast
open Intf

module type S = PRINTER with type t = ext select_statement

module Make
    (V : GEN with type t = ext select_core)
    (Limit : GEN with type t = ext limit_clause)
    (Order : GEN with type t = ext order_by_clause) : S = struct
  type t = ext select_statement

  let print f t ~option =
    match t with
    | Select_statement (c, o, l, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f c;

      Option.iter
        (fun o ->
          Sfmt.newline f ();
          let module Order = (val Order.generate ()) in
          Order.print ~option f o)
        o;

      Option.iter
        (fun l ->
          Sfmt.newline f ();
          let module Limit = (val Limit.generate ()) in
          Limit.print ~option f l)
        l
end
