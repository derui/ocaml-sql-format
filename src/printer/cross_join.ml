open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext cross_join

module Make () : S = struct
  type t = ext cross_join

  let print f t ~option =
    match t with
    | Cross_join _ -> failwith "TODO: need implementation"
end
