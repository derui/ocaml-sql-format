open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext delete_statement

module Make
    (V : GEN with type t = ext with_clause)
    (Q : GEN with type t = ext qualified_table_name)
    (W : GEN with type t = ext where_clause)
    (R : GEN with type t = ext returning_clause) : S = struct
  type t = ext delete_statement

  let print f t ~option =
    match t with
    | Delete_statement (w, name, where, returning, _) ->
      Option.iter
        (fun v ->
          let module V = (val V.generate ()) in
          V.print ~option f v)
        w;

      Sfmt.keyword ~option f [ Kw_delete; Kw_from ];
      Fmt.string f " ";
      let module Q = (val Q.generate ()) in
      Q.print ~option f name;

      Option.iter
        (fun v ->
          Fmt.cut f ();
          let module W = (val W.generate ()) in
          W.print ~option f v)
        where;

      Option.iter
        (fun v ->
          Fmt.cut f ();
          let module R = (val R.generate ()) in
          R.print ~option f v)
        returning
end
