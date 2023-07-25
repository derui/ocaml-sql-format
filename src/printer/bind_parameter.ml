open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext bind_parameter

module Make () : S = struct
  type t = ext bind_parameter

  let print f t ~option =
    match t with
    | Bind_parameter _ -> Token.print ~option f Tok_qmark
end
