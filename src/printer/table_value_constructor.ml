open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_value_constructor

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext table_value_constructor

  let print f t ~option =
    match t with
    | Table_value_constructor _ -> failwith "TODO: need implementation"
end
