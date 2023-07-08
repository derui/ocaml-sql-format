open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_following

module Make () : S = struct
  type t = ext window_frame_following

  let print f t ~option =
    match t with
    | Window_frame_following _ -> failwith "TODO: need implementation"
end
