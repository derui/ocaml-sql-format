open Types.Ast
open Intf

module type S = PRINTER with type t = ext parenthesized_value_expression

module Make (V : GEN with type t = ext value_expression) : S = struct
  type t = ext parenthesized_value_expression

  let print f t ~option =
    match t with
    | Parenthesized_value_expression (e, _) ->
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f e)
        f ()
end
