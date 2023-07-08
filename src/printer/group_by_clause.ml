open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext group_by_clause

module Make (L : GEN with type t = ext grouping_element_list) : S = struct
  type t = ext group_by_clause

  let print f t ~option =
    match t with
    | Group_by_clause (q, l, _) ->
      Printer_token.print f ~option Kw_group;
      Fmt.string f " ";
      Printer_token.print f ~option Kw_by;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print f ~option
            (match v with
            | `All -> Kw_all
            | `Distinct -> Kw_distinct))
        q;

      let pf f _ =
        let module L = (val L.generate ()) in
        L.print f ~option l
      in
      Sfmt.force_vbox option.indent_size pf f ()
end
