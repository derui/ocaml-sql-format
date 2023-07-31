open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext filter_clause

module Make (V : GEN with type t = ext expr) : S = struct
  type t = ext filter_clause

  let print f t ~option =
    match t with
    | Filter_clause (e, _) ->
      Sfmt.keyword ~option f [ Kw_filter ];
      Sfmt.parens ~option
        (fun f _ ->
          Sfmt.keyword ~option f [ Kw_where ];
          Fmt.string f " ";
          let module V = (val V.generate ()) in
          V.print ~option f e)
        f ()
end
