open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext grouping_sets_specification

module Make (G : GEN with type t = ext grouping_set_list) : S = struct
  type t = ext grouping_sets_specification

  let print f t ~option =
    match t with
    | Grouping_sets_specification (l, _) ->
      Printer_token.print ~option f Kw_grouping;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_sets;

      Sfmt.parens ~option
        (fun f _ ->
          let module G = (val G.generate ()) in
          G.print f ~option l)
        f ()
end
