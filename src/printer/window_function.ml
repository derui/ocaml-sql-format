open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_function

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext window_function

  let print f t ~option =
    match t with
    | Window_function _ -> failwith "TODO: need implementation"
end
