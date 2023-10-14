open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext collation_name

module Make (V : GEN with type t = ext identifier) : S = struct
  type t = ext collation_name

  let print f t ~option =
    match t with
    | Collation_name (v, _) ->
      Sfmt.keyword ~option f [ Kw_collate ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f v
end
