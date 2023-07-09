open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext explicit_table

module Make (V : GEN with type t = ext table_or_query_name) : S = struct
  type t = ext explicit_table

  let print f t ~option =
    match t with
    | Explicit_table (v, _) ->
      Printer_token.print ~option f Kw_table;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f v
end
