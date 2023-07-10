open Types.Ast
open Intf

module type S = PRINTER with type t = ext sql_argument_list

module Make (V : GEN with type t = ext sql_argument) : S = struct
  type t = ext sql_argument_list

  let print f t ~option =
    match t with
    | Sql_argument_list (fl, list, _) ->
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f fl;

          List.iter
            (fun v ->
              Sfmt.comma ~option f ();
              V.print ~option f v)
            list)
        f ()
end
