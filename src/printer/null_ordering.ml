open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext null_ordering

module Make () : S = struct
  type t = ext null_ordering

  let print f t ~option =
    match t with
    | Null_ordering (`first, _) -> Sfmt.keyword ~option f [ Kw_nulls; Kw_first ]
    | Null_ordering (`last, _) -> Sfmt.keyword ~option f [ Kw_nulls; Kw_last ]
end
