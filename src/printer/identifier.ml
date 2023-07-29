open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext identifier

module Make () : S = struct
  type t = ext identifier

  let print f t ~option =
    match t with
    | Identifier (`keyword v, _) -> Token.print ~option f v
    | Identifier (`raw v, _) -> Fmt.string f v
end
