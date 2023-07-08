open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_bound

module Make
    (S : GEN with type t = ext window_frame_start)
    (F : GEN with type t = ext window_frame_following) : S = struct
  type t = ext window_frame_bound

  let print f t ~option =
    match t with
    | Window_frame_bound (`start s, _) ->
      let module S = (val S.generate ()) in
      S.print ~option f s
    | Window_frame_bound (`unbounded, _) ->
      Printer_token.print ~option f Kw_unbounded;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_following
    | Window_frame_bound (`following s, _) ->
      let module F = (val F.generate ()) in
      F.print ~option f s
end
