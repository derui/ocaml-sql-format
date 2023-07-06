open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext lateral_derived_table

module Make (SQ : GEN with type t = ext table_subquery) : S = struct
  type t = ext lateral_derived_table

  let print f t ~option =
    match t with
    | Lateral_derived_table (subquery, _) ->
      Printer_token.print ~option f Kw_lateral;
      Fmt.string f " ";
      let module SQ = (val SQ.generate ()) in
      SQ.print ~option f subquery
end
