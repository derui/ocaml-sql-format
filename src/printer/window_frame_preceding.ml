open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_preceding

module Make () : S = struct
  type t = ext window_frame_preceding

  let print f t ~option =
    match t with
    | Window_frame_preceding _ -> failwith "TODO: need implementation"
end
