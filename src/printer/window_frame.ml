open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame

module Make (WFB : GEN with type t = ext window_frame_bound) : S = struct
  type t = ext window_frame

  let print f t ~option =
    match t with
    | Window_frame { typ; bound; _ } -> (
      let kw =
        match typ with
        | `range -> Kw_range
        | `rows -> Kw_rows
      in
      Printer_token.print f kw ~option;
      Fmt.string f " ";

      let module WFB = (val WFB.generate ()) in
      match bound with
      | `between (s, e) ->
        Printer_token.print f Kw_between ~option;
        Fmt.string f " ";
        WFB.print f s ~option;
        Fmt.string f " ";
        Printer_token.print f Kw_and ~option;
        Fmt.string f " ";
        WFB.print f e ~option
      | `raw b -> WFB.print f b ~option)
end
