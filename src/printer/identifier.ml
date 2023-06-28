open Types.Ast
open Intf

module type S = PRINTER with type t = ext identifier

module Make (Non : GEN with type t = ext non_reserved_identifier) : S = struct
  type t = ext identifier

  let print f t ~option =
    match t with
    | Identifier (`literal i, _) -> Fmt.string f i
    | Identifier (`non_reserved v, _) ->
      let module Non = (val Non.generate ()) in
      Non.print f v ~option
end
