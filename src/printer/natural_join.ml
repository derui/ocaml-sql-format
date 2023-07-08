open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext natural_join

module Make () : S = struct
  type t = ext natural_join

  let print f t ~option =
    match t with
    | Natural_join _ -> failwith "TODO: need implementation"
end
