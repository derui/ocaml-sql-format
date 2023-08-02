open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext compound_operator

module Make () : S = struct
  type t = ext compound_operator

  let print f t ~option =
    match t with
    | Compound_operator (`union, _) -> Sfmt.keyword ~option f [ Kw_union ]
    | Compound_operator (`union_all, _) ->
      Sfmt.keyword ~option f [ Kw_union; Kw_all ]
    | Compound_operator (`intersect, _) ->
      Sfmt.keyword ~option f [ Kw_intersect ]
    | Compound_operator (`except, _) -> Sfmt.keyword ~option f [ Kw_except ]
end
