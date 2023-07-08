open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext unsigned_integer

module Make () : S = struct
  type t = ext unsigned_integer

  let print f t ~option:_ =
    match t with
    | Unsigned_integer (v, _) -> Fmt.string f v
end
