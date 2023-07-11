open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext datetime_factor

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext datetime_factor

  let print f t ~option =
    match t with
    | Datetime_factor _ -> failwith "TODO: need implementation"
end
