open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext explicit_row_value_constructor

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext explicit_row_value_constructor

  let print f t ~option =
    match t with
    | Explicit_row_value_constructor _ -> failwith "TODO: need implementation"
end
