open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext join_clause

module Make () : S = struct
  type t = ext join_clause

  let print f t ~option =
    match t with
    | Join_clause _ -> ()
end
