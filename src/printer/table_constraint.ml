open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_constraint

module Make () : S = struct
  type t = ext table_constraint

  let print f t ~option =
    match t with
    | Table_constraint _ -> ()
end
