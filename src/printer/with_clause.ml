open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext with_clause

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext with_clause

  let print f t ~option =
    match t with
    | With_clause _ -> failwith "TODO: need implementation"
end
