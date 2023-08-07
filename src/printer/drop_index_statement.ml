open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext drop_index_statement

module Make (R : GEN with type t = ext qualified_table_name) : S = struct
  type t = ext drop_index_statement

  let print f t ~option =
    match t with
    | Drop_index_statement (exists, name, _) ->
      let kw =
        match exists with
        | None -> [ Kw_drop; Kw_index ]
        | Some _ -> [ Kw_drop; Kw_index; Kw_if; Kw_exists ]
      in
      Sfmt.keyword ~option f kw;
      Fmt.string f " ";

      let module R = (val R.generate ()) in
      R.print ~option f name
end
