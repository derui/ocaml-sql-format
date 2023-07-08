open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_units

module Make () : S = struct
  type t = ext window_frame_units

  let print f t ~option =
    match t with
    | Window_frame_units (v, _) ->
      let kw =
        match v with
        | `rows -> Kw_rows
        | `range -> Kw_range
      in
      Printer_token.print ~option f kw
end
