open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_partition_clause

module Make (L : GEN with type t = ext window_partition_column_reference_list) :
  S = struct
  type t = ext window_partition_clause

  let print f t ~option =
    match t with
    | Window_partition_clause (l, _) ->
      Printer_token.print ~option f Kw_partition;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_by;
      Fmt.string f " ";
      let module L = (val L.generate ()) in
      L.print ~option f l
end
