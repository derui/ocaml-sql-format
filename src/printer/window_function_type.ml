open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_function_type

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext window_function_type

  let print f t ~option =
    match t with
    | Window_function_type _ -> failwith "TODO: need implementation"
end
