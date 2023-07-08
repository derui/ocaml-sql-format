open Types.Ast
open Intf

module type S = PRINTER with type t = ext window_frame_bound_1

module Make (C : GEN with type t = ext window_frame_bound) : S = struct
  type t = ext window_frame_bound_1

  let print f t ~option =
    match t with
    | Window_frame_bound_1 (v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v
end
