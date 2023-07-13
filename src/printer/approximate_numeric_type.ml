open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext approximate_numeric_type

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext approximate_numeric_type

  let print f t ~option =
    match t with
    | Approximate_numeric_type _ -> failwith "TODO: need implementation"
end
