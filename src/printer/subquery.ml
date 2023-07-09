open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext subquery

module Make () : S = struct
  type t = ext subquery

  let print f t ~option =
    match t with
    | Subquery _ -> failwith "TODO: need implementation"
end
