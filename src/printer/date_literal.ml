open Types.Literal
open Types.Ext
open Intf

module type S = PRINTER with type t = ext date_literal

module Make () : S = struct
  type t = ext date_literal

  let print f t ~option:_ =
    match t with
    | Date_literal (v, _) -> Fmt.string f v
end
