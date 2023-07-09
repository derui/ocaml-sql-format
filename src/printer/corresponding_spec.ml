open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext corresponding_spec

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext corresponding_spec

  let print f t ~option =
    match t with
    | Corresponding_spec _ -> failwith "TODO: need implementation"
end
