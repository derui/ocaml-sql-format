open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext unsigned_numeric_literal

module Make () : S = struct
  type t = ext unsigned_numeric_literal

  let print f t ~option:_ =
    match t with
    | Unsigned_numeric_literal (v, _) -> Fmt.string f v
end
