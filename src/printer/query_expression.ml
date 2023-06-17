open Parser.Ast
open Intf

module type S = PRINTER with type t = ext query_expression

module Make (P : GEN with type t = ext query_expression_body) : S = struct
  type t = ext query_expression

  let print f t ~option =
    match t with
    | `Query_expression (bodies, e, ()) ->
      let module P = (val P.generate ()) in
      List.iter (fun v -> P.print f v ~option) bodies;
      P.print f e ~option
end
