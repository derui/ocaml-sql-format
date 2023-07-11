open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext time_zone_specifier

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext time_zone_specifier

  let print f t ~option =
    match t with
    | Time_zone_specifier _ -> failwith "TODO: need implementation"
end
