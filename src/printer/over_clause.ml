open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext over_clause

module Make
    (V : GEN with type t = ext window_defn)
    (I : GEN with type t = ext identifier) : S = struct
  type t = ext over_clause

  let print f t ~option =
    match t with
    | Over_clause (`defn v, _) ->
      Sfmt.keyword ~option f [ Kw_over ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Over_clause (`name v, _) ->
      Sfmt.keyword ~option f [ Kw_over ];
      Fmt.string f " ";
      let module I = (val I.generate ()) in
      I.print ~option f v
end
