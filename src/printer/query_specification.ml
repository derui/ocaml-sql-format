open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext query_specification

module Make
    (SL : GEN with type t = ext select_list)
    (T : GEN with type t = ext table_expression) : S = struct
  type t = ext query_specification

  let print f t ~option =
    match t with
    | Query_specification (q, sl, te, ()) ->
      Printer_token.print ~option f Kw_select;
      Option.iter
        (fun q ->
          Fmt.string f " ";
          match q with
          | `All -> Printer_token.print ~option f Kw_all
          | `Distinct -> Printer_token.print ~option f Kw_distinct)
        q;
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let module SL = (val SL.generate ()) in
          SL.print ~option f sl)
        f ();
      let module T = (val T.generate ()) in
      T.print ~option f te
end
