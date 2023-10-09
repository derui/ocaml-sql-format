open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext numeric_literal

module Make () : S = struct
  type t = ext numeric_literal

  let print f t ~option:_ =
    match t with
    | Numeric_literal (v, _) -> Fmt.string f v
end
