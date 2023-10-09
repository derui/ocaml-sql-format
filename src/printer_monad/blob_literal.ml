open Types.Literal
open Types.Ast
open Intf

module type S = PRINTER with type t = ext blob_literal

module Make () : S = struct
  type t = ext blob_literal

  let print f t ~option:_ =
    match t with
    | Blob_literal (v, _) -> Fmt.string f v
end
