open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_definition_list

module Make () : S = struct
  type t = ext window_definition_list

  let print f t ~option =
    match t with
    | Window_definition_list _ -> failwith "TODO: need implementation"
end
