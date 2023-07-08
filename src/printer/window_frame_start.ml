open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_start

module Make () : S = struct
  type t = ext window_frame_start

  let print f t ~option =
    match t with
    | Window_frame_start _ -> failwith "TODO: need implementation"
end