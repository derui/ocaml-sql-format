open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_bound

module Make () : S = struct
  type t = ext window_frame_bound

  let print f t ~option =
    match t with
    | Window_frame_bound _ -> failwith "TODO: need implementation"
end
