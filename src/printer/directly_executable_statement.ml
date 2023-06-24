open Types.Ast
open Intf

module type S = PRINTER with type t = ext directly_executable_statement

module Make (S : GEN with type t = ext query_expression) : S = struct
  type t = ext directly_executable_statement

  let print f t ~option =
    match t with
    | `Directly_executable_statement (exp, _) ->
      let module S = (val S.generate ()) in
      S.print f exp ~option
end
