open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext select_startement

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext select_startement

  let print f t ~option =
    match t with
    | Select_startement _ -> failwith "TODO: need implementation"
end
