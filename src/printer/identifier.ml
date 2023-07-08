open Types.Ext
open Types.Literal
open Intf

module type S = PRINTER with type t = ext identifier

module Make () : S = struct
  type t = ext identifier

  let print f t ~option:_ =
    match t with
    | Identifier (i, _) -> Fmt.string f i
end
