open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_definition

module Make () : S = struct
  type t = ext window_definition

  let print f t ~option =
    match t with
    | Window_definition _ -> failwith "TODO: need implementation"
end
