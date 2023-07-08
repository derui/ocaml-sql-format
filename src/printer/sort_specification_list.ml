open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext sort_specification_list

module Make () : S = struct
  type t = ext sort_specification_list

  let print f t ~option =
    match t with
    | Sort_specification_list _ -> failwith "TODO: need implementation"
end
