open Types.Ast
open Intf

module type S = PRINTER with type t = ext character_string_literal

module Make () : S = struct
  type t = ext character_string_literal

  let print f t ~option:_ =
    match t with
    | Character_string_literal (v, _) -> Fmt.string f v
end
