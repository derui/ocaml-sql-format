open Types.Ast
open Intf

module type S = PRINTER with type t = ext time_literal

module Make () : S = struct
  type t = ext time_literal

  let print f t ~option:_ =
    match t with
    | Time_literal (v, _) -> Fmt.string f v
end
