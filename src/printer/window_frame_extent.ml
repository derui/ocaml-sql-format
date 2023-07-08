open Types.Ast
open Intf

module type S = PRINTER with type t = ext window_frame_extent

module Make
    (Start : GEN with type t = ext window_frame_start)
    (Between : GEN with type t = ext window_frame_between) : S = struct
  type t = ext window_frame_extent

  let print f t ~option =
    match t with
    | Window_frame_extent (`start s, _) ->
      let module Start = (val Start.generate ()) in
      Start.print ~option f s
    | Window_frame_extent (`between v, _) ->
      let module Between = (val Between.generate ()) in
      Between.print ~option f v
end
