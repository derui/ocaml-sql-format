open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext datetime_primary

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext datetime_primary

  let print f t ~option =
    match t with
    | Datetime_primary _ -> failwith "TODO: need implementation"
end
