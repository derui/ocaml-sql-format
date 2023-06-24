open Types.Ast
open Intf

module type S = PRINTER with type t = ext character

module Make () : S = struct
  type t = ext character

  let print f (`Character (s, _)) ~option:_ = Fmt.string f s
end
