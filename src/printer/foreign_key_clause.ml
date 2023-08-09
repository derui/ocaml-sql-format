open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext foreign_key_clause

module Make () : S = struct
  type t = ext foreign_key_clause

  let print f t ~option =
    match t with
    | Foreign_key_clause _ -> ()
end
