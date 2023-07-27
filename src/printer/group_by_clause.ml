open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext group_by_clause

module Make (V : GEN with type t = ext expr) : S = struct
  type t = ext group_by_clause

  let print f t ~option =
    match t with
    | Group_by_clause (es, _) ->
      Sfmt.keyword ~option f [ Kw_group; Kw_by ];
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let e = List.hd es in
          let es = List.tl es in
          let module V = (val V.generate ()) in
          V.print ~option f e;

          List.iter
            (fun e ->
              Token.print ~option f Tok_comma;
              Fmt.cut f ();
              V.print ~option f e)
            es)
        f ()
end
