open Types.Ast
open Intf

module type S = PRINTER with type t = ext unsigned_integer

module Make () : S = struct
  type t = ext unsigned_integer

  let print f t ~option:_ =
    match t with
    | Unsigned_integer (Literal.Unsigned_integer v, _) -> Fmt.string f v
end
