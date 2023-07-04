open Types.Ast
open Intf

module type S = PRINTER with type t = ext binary_string_literal

module Make () : S = struct
  type t = ext binary_string_literal

  let print f t ~option:_ =
    match t with
    | Binary_string_literal (v, _) -> Fmt.string f v
end
