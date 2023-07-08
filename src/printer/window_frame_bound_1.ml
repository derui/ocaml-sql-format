open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_bound_1

module Make () : S = struct
  type t = ext window_frame_bound_1

  let print f t ~option =
    match t with
    | Window_frame_bound_1 _ -> failwith "TODO: need implementation"
end
