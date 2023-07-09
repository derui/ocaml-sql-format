open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext factor

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext factor

  let print f t ~option =
    match t with
    | Factor _ -> failwith "TODO: need implementation"
end
