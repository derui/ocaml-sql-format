open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext generalized_expression

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext generalized_expression

  let print f t ~option =
    match t with
    | Generalized_expression _ -> failwith "TODO: need implementation"
end
