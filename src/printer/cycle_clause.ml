open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext cycle_clause

module Make
    (V : GEN with type t = ext cycle_column_list)
    (CMC : GEN with type t = ext cycle_mark_column)
    (CMV : GEN with type t = ext cycle_mark_value)
    (NCMV : GEN with type t = ext non_cycle_mark_value)
    (PC : GEN with type t = ext path_column) : S = struct
  type t = ext cycle_clause

  let print f t ~option =
    match t with
    | Cycle_clause (list, cmc, cmv, ncmv, pc, _) ->
      Printer_token.print ~option f Kw_cycle;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f list;

      Fmt.cut f ();
      Printer_token.print ~option f Kw_set;
      Fmt.string f " ";
      let module CMC = (val CMC.generate ()) in
      CMC.print ~option f cmc;
      Printer_token.print ~option f Kw_to;
      Fmt.string f " ";
      let module CMV = (val CMV.generate ()) in
      CMV.print ~option f cmv;

      Fmt.cut f ();
      Printer_token.print ~option f Kw_default;
      Fmt.string f " ";
      let module NCMV = (val NCMV.generate ()) in
      NCMV.print ~option f ncmv;

      Fmt.cut f ();
      Printer_token.print ~option f Kw_using;
      Fmt.string f " ";
      let module PC = (val PC.generate ()) in
      PC.print ~option f pc
end
