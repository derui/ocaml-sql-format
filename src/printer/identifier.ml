open Parser.Ast
open Intf

module type S = PRINTER with type t = ext identifier

module Make () : S = struct
  type t = ext identifier

  let print f (`Identifier (v, _)) ~option:_ = Fmt.string f v
end
