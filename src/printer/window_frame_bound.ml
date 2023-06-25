open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_bound

module Make (UI : GEN with type t = ext unsigned_integer) : S = struct
  type t = ext window_frame_bound

  let print f t ~option =
    match t with
    | Window_frame_bound (t, _) -> (
      match t with
      | `bounding (typ, ceil) -> (
        (match typ with
        | `unbounded -> Printer_token.print f ~option Kw_unbounded
        | `bounded i ->
          let module UI = (val UI.generate ()) in
          UI.print f i ~option);
        Fmt.string f " ";
        match ceil with
        | `following -> Printer_token.print f ~option Kw_following
        | `preceding -> Printer_token.print f ~option Kw_preceding)
      | `current ->
        Printer_token.print f ~option Kw_current;
        Fmt.string f " ";
        Printer_token.print f ~option Kw_row)
end
