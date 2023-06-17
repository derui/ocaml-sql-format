open Parser.Ast
open Intf

module type S = PRINTER with type t = ext table_primary

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext table_primary

  let print f t ~option =
    match t with
    | `Table_primary (t, _) -> (
      match t with
      | `table_name (ident, alias) ->
        let module I = (val I.generate ()) in
        I.print f ident ~option;
        Option.iter
          (fun v ->
            Fmt.string f " ";
            Printer_token.print f ~option Kw_as;
            Fmt.string f " ";
            I.print f v ~option)
          alias)
end
