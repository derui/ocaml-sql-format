open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext boolean_value_expression

module Make () : S = struct
  type t = ext boolean_value_expression

  let print f t ~option =
    match t with
    | Boolean_value_expression _ -> failwith "TODO: need implementation"
end
