open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext limit_clause

module Make (V : GEN with type t = ext expr) : S = struct
  type t = ext limit_clause

  let print f t ~option =
    match t with
    | Limit_clause (e, `no_offset, _) ->
      Sfmt.keyword ~option f [ Kw_limit ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Limit_clause (e, `offset e2, _) ->
      Sfmt.keyword ~option f [ Kw_limit ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_offset ];
      Fmt.string f " ";
      V.print ~option f e2
    | Limit_clause (e, `comma e2, _) ->
      Sfmt.keyword ~option f [ Kw_limit ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Fmt.string f " ";
      Sfmt.comma ~option f ();
      V.print ~option f e2
end
