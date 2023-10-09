open Types.Ast
open Intf

module type S = PRINTER with type t = ext select_statement

module Make
    (V : GEN with type t = ext select_core)
    (Limit : GEN with type t = ext limit_clause)
    (Order : GEN with type t = ext order_by_clause)
    (With : GEN with type t = ext with_clause)
    (Op : GEN with type t = ext compound_operator) : S = struct
  type t = ext select_statement

  let print f t ~option =
    match t with
    | Select_statement (wc, cs, o, l, _) -> (
      Option.iter
        (fun w ->
          let module With = (val With.generate ()) in
          With.print ~option f w)
        wc;

      let c = List.hd cs
      and cs = List.tl cs in

      let module Op = (val Op.generate ()) in
      let module V = (val V.generate ()) in
      match c with
      | None, c -> V.print ~option f c
      | Some op, c ->
        V.print ~option f c;
        Sfmt.newline f ();
        Op.print ~option f op;
        Sfmt.newline f ();

        List.iter
          (fun c ->
            match c with
            | None, c -> V.print ~option f c
            | Some op, c ->
              V.print ~option f c;
              Sfmt.newline f ();
              Op.print ~option f op;
              Sfmt.newline f ())
          cs;

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
          l)
end
