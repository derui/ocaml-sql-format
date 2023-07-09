open Types.Ast
open Intf

module type S = PRINTER with type t = ext query_expression

module Make
    (V : GEN with type t = ext with_clause)
    (B : GEN with type t = ext query_expression_body) : S = struct
  type t = ext query_expression

  let print f t ~option =
    match t with
    | Query_expression (wl, q, _) ->
      Option.iter
        (fun wl ->
          let module V = (val V.generate ()) in
          V.print ~option f wl;
          Fmt.cut f ())
        wl;

      let module B = (val B.generate ()) in
      B.print ~option f q
end
