open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext only_spec

module Make (T : GEN with type t = ext table_or_query_name) : S = struct
  type t = ext only_spec

  let print f t ~option =
    match t with
    | Only_spec (table, _) ->
      Printer_token.print ~option f Kw_only;
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let module T = (val T.generate ()) in
          T.print ~option f table)
        f ()
end
