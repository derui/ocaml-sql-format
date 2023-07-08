open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_start

module Make (C : GEN with type t = ext window_frame_preceding) : S = struct
  type t = ext window_frame_start

  let print f t ~option =
    match t with
    | Window_frame_start (`unbounded, _) ->
      Printer_token.print ~option f Kw_unbounded;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_preceding
    | Window_frame_start (`preceding v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
    | Window_frame_start (`current, _) ->
      Printer_token.print ~option f Kw_current;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_row
end
