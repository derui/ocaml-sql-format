open Types.Ast
open Intf

module type S = PRINTER with type t = ext from_clause

module Make (Table_reference_list : GEN with type t = ext table_reference_list) :
  S = struct
  type t = ext from_clause

  let print f t ~option =
    match t with
    | From_clause (l, _) ->
      Printer_token.print f ~option Types.Token.Kw_from;

      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let module Table_reference_list =
            (val Table_reference_list.generate ())
          in
          Table_reference_list.print f ~option l)
        f ()
end
