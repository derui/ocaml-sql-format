open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext query_term

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext query_term

  let print f t ~option =
    match t with
    | Query_term _ -> failwith "TODO: need implementation"
end
