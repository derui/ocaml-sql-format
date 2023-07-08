open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext named_columns_join

module Make () : S = struct
  type t = ext named_columns_join

  let print f t ~option =
    match t with
    | Named_columns_join _ -> failwith "TODO: need implementation"
end
