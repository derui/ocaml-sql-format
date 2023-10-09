open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext order_by_clause

module Make (V : GEN with type t = ext ordering_term) : S = struct
  type t = ext order_by_clause

  let print f t ~option =
    match t with
    | Order_by_clause (v, _) ->
      Sfmt.keyword ~option f [ Kw_order; Kw_by ];

      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let v = List.hd v
          and vs = List.tl v in

          let module V = (val V.generate ()) in
          V.print ~option f v;

          List.iter
            (fun v ->
              Token.print ~option f Tok_comma;
              Fmt.cut f ();
              V.print ~option f v)
            vs)
        f ()
end
