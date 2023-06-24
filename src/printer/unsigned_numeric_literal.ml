open Types.Ast
open Intf

module type S = PRINTER with type t = ext unsigned_numeric_literal

module Make () : S = struct
  type t = ext unsigned_numeric_literal

  let print f t ~option:_ =
    match t with
    | Unsigned_numeric_literal (`unsigned (Literal.Unsigned_integer v), _) ->
      Fmt.string f v
    | Unsigned_numeric_literal (`approximate (Literal.Approximate_numeric v), _)
      -> Fmt.string f v
    | Unsigned_numeric_literal (`decimal (Literal.Decimal_numeric v), _) ->
      Fmt.string f v
end
