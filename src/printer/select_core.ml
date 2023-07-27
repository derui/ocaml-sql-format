open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext select_core

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext select_core

  let print f t ~option =
    match t with
    | Select_core _ -> failwith "TODO: need implementation"
end