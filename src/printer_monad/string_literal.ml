open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext string_literal

module Make () : S = struct
  type t = ext string_literal

  let print f t ~option:_ =
    match t with
    | String_literal (v, _) -> Fmt.string f v
end
