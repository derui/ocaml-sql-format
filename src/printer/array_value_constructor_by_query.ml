open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext array_value_constructor_by_query

module Make
    (V : GEN with type t = ext query_expression)
    (O : GEN with type t = ext order_by_clause) : S = struct
  type t = ext array_value_constructor_by_query

  let print f t ~option =
    match t with
    | Array_value_constructor_by_query (e, o, _) ->
      Printer_token.print ~option f Kw_array;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f e;

          Option.iter
            (fun e ->
              Fmt.string f " ";
              let module O = (val O.generate ()) in
              O.print ~option f e)
            o)
        f ()
end
