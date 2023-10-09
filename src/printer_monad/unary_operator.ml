open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext unary_operator

module Make () : S = struct
  type t = ext unary_operator

  let print f t ~option =
    match t with
    | Unary_operator (`tilda, ()) -> Token.print ~option f Op_tilda
    | Unary_operator (`plus, ()) -> Token.print ~option f Op_plus
    | Unary_operator (`minus, ()) -> Token.print ~option f Op_minus
    | Unary_operator (`not', ()) -> Token.print ~option f Kw_not
end
