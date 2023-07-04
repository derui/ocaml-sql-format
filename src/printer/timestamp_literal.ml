open Types.Ast
open Intf

module type S = PRINTER with type t = ext timestamp_literal

module Make () : S = struct
  type t = ext timestamp_literal

  let print f t ~option:_ =
    match t with
    | Timestamp_literal (v, _) -> Fmt.string f v
end
