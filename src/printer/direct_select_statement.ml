open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext direct_select_statement

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext direct_select_statement

  let print f t ~option =
    match t with
    | Direct_select_statement _ -> failwith "TODO: need implementation"
end
