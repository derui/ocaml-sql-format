open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_specification_detail

module Make () : S = struct
  type t = ext window_specification_detail

  let print f t ~option =
    match t with
    | Window_specification_detail _ -> failwith "TODO: need implementation"
end
