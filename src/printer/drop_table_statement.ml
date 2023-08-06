open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext drop_table_statement

module Make (V : GEN with type t = ext qualified_table_name) : S = struct
  type t = ext drop_table_statement

  let print f t ~option =
    match t with
    | Drop_table_statement (e, n, _) ->
      let kw =
        match e with
        | None -> [ Kw_drop; Kw_table ]
        | Some _ -> [ Kw_drop; Kw_table; Kw_if; Kw_exists ]
      in
      Sfmt.keyword ~option f kw;

      Fmt.string f " ";

      let module V = (val V.generate ()) in
      V.print ~option f n
end
