open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext parenthesized_value_expression

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext parenthesized_value_expression

  let print f t ~option =
    match t with
    | Parenthesized_value_expression _ -> failwith "TODO: need implementation"
end
